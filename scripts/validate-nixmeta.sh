#!/usr/bin/env bash
# repo_v5/scripts/validate-nixmeta.sh
# NIXMETA v2.0 Schema-Aware Validator (Pure Bash + jq)
# (Copy for Flake integration)

set -euo pipefail

# --- CONFIGURATION ---
# When running inside a flake, the root is the flake root.
REPO_ROOT="."
SCHEMA_FILE="docs/specs/NIXMETA_SCHEMA.json"
REQUIRED_FIELDS=("specVersion" "id" "title" "layer" "category" "lastReviewed" "reviewedBy" "status" "complexity" "description")

# --- COLORS ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- PREREQUISITES ---
if ! command -v jq &> /dev/null; then
    echo -e "${RED}❌ Error: jq is not installed.${NC}"
    exit 1
fi

echo -e "🚀 ${GREEN}Starting NIXMETA Audit & Validation...${NC}"
echo "Scanning directory: $REPO_ROOT"

# --- STATE ---
TOTAL_FILES=0
VALID_FILES=0
MISSING_HEADER=0
INVALID_JSON=0
SCHEMA_ERRORS=0
WARNINGS=0

# Summary Maps (using temporary files for portability)
TAGS_TMP=$(mktemp)
CATEGORIES_TMP=$(mktemp)
STATUS_TMP=$(mktemp)

# --- VALIDATION LOOP ---
while IFS= read -r file; do
    TOTAL_FILES=$((TOTAL_FILES + 1))
    
    # Extraction
    # Matches everything between delimiters and removes the "# " or "#" prefix
    json_block=$(sed -n '/^# ---NIXMETA/,/^# ---ENDNIXMETA/p' "$file" | sed '1d;$d;s/^# //;s/^#//' || true)
    
    if [[ -z "$json_block" ]]; then
        MISSING_HEADER=$((MISSING_HEADER + 1))
        continue
    fi
    
    # Syntax Check
    if ! echo "$json_block" | jq . > /dev/null 2>&1; then
        echo -e "${RED}❌ INVALID JSON:${NC} $file"
        INVALID_JSON=$((INVALID_JSON + 1))
        continue
    fi
    
    # JSON Schema Validation (Robust JQ check)
    ERRORS=$(echo "$json_block" | jq --argfile schema "$SCHEMA_FILE" -r '
      . as $in |
      (
        # Check required fields
        ($schema.required[] | select($in | has(.) | not) | "Missing required field: \(.)"),
        # Check Enum: status
        (if $in.status and ([$schema.properties.status.enum[]] | contains([$in.status]) | not) then "Invalid status: \($in.status) (Must be one of: \($schema.properties.status.enum | join(", ")))" else empty end),
        # Check Type/Range: layer
        (if $in.layer != null and ($in.layer | type != "number" or . < 0 or . > 99) then "Invalid layer: \($in.layer) (Must be integer 0-99)" else empty end),
        # Check Type/Range: complexity
        (if $in.complexity != null and ($in.complexity | type != "number" or . < 1 or . > 5) then "Invalid complexity: \($in.complexity) (Must be integer 1-5)" else empty end),
        # Check SpecVersion
        (if $in.specVersion != $schema.properties.specVersion.const then "Invalid specVersion: \($in.specVersion) (Expected: \($schema.properties.specVersion.const))" else empty end)
      )
    ' 2>/dev/null)

    if [[ -n "$ERRORS" ]]; then
        echo -e "${RED}❌ SCHEMA VIOLATION:${NC} $file"
        echo "$ERRORS" | sed 's/^/   → /'
        SCHEMA_ERRORS=$((SCHEMA_ERRORS + 1))
        continue
    fi
    
    # Success & Statistics
    VALID_FILES=$((VALID_FILES + 1))
    
    # Harvest Stats
    echo "$json_block" | jq -r ".status" >> "$STATUS_TMP"
    echo "$json_block" | jq -r ".category" >> "$CATEGORIES_TMP"
    echo "$json_block" | jq -r ".tags[]?" >> "$TAGS_TMP"

done < <(find "$REPO_ROOT" -name "*.nix" -type f -not -path "*/.*")

# --- SUMMARY REPORT ---
echo -e "\n--- ${GREEN}AUDIT SUMMARY${NC} ---"
echo "Total .nix files: $TOTAL_FILES"
echo "Valid Headers:    $VALID_FILES"
echo "Missing Headers:  $MISSING_HEADER"
echo "Invalid JSON:     $INVALID_JSON"
echo "Schema Errors:    $SCHEMA_ERRORS"
echo "Warnings:         $WARNINGS"

if [ "$VALID_FILES" -gt 0 ]; then
    echo -e "\n--- ${GREEN}DISTRIBUTION${NC} ---"
    echo "Statuses:"
    sort "$STATUS_TMP" | uniq -c | sort -rn
    echo "Categories:"
    sort "$CATEGORIES_TMP" | uniq -c | sort -rn
    echo "Top Tags:"
    sort "$TAGS_TMP" | uniq -c | sort -rn | head -n 5
fi

# Cleanup
rm "$TAGS_TMP" "$CATEGORIES_TMP" "$STATUS_TMP"

# Exit Logic
if [ "$INVALID_JSON" -gt 0 ] || [ "$SCHEMA_ERRORS" -gt 0 ]; then
    echo -e "\n${RED}❌ Audit FAILED.${NC} Found critical errors."
    exit 1
elif [ "$MISSING_HEADER" -gt 0 ]; then
    echo -e "\n${YELLOW}⚠️  Audit PASSED with Warnings.${NC} ($MISSING_HEADER files missing headers)"
    exit 0
else
    echo -e "\n${GREEN}✅ Audit PASSED.${NC}"
    exit 0
fi
