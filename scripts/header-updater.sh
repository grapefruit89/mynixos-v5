#!/usr/bin/env bash
# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-099-TOOL-003",
#   "title": "NIXMETA Header Updater",
#   "layer": 90,
#   "category": "tooling/mutation",
#   "lastReviewed": "2026-05-14",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 3,
#   "tags": ["mutation", "metadata", "nixmeta"],
#   "description": "Bash wrapper to automatically update NIXMETA headers with computed metrics (lines, size, hash)."
# }
# ---ENDNIXMETA

set -euo pipefail

# This script updates the NIXMETA header in .nix files.
# It currently focus on updating the 'lastReviewed' and metrics if we had them in JSON.
# The audit suggested adding metrics to the JSON block. 
# Let's adjust the spec to include a 'metrics' field in the JSON if desired, 
# or just ensure the header exists and is valid.

ROOT="${1:-.}"
FILES=$(find "$ROOT" -name "*.nix" -not -path '*/result*' -not -path '*/.direnv/*' | sort)

for f in $FILES; do
    # Check if header exists
    if ! grep -q "# ---NIXMETA" "$f"; then
        continue
    fi

    echo "Processing $f..."

    # Extract current metrics
    LINES=$(wc -l < "$f")
    SIZE=$(stat -c%s "$f")
    SHA256=$(sha256sum "$f" | cut -d' ' -f1)
    DATE=$(date +%Y-%m-%d)

    # Extract JSON block
    RAW_JSON=$(sed -n '/# ---NIXMETA/,/# ---ENDNIXMETA/p' "$f" | sed '1d;$d' | sed 's/^# //' | sed 's/^#//')
    
    # Update JSON with jq
    # We add/update a 'metrics' field and 'lastReviewed'
    NEW_JSON=$(echo "$RAW_JSON" | jq --arg date "$DATE" --arg sha "$SHA256" --arglines lines "$LINES" --arglines size "$SIZE" \
        '.lastReviewed = $date | .metrics = { lines: $lines, size_bytes: $size, sha256: $sha }')

    # Create new header block
    HEADER="# ---NIXMETA\n"
    while IFS= read -r line; do
        HEADER+="# $line\n"
    done <<< "$NEW_JSON"
    HEADER+="# ---ENDNIXMETA"

    # Replace old block with new one
    # Use a temp file for safety
    TMP=$(mktemp)
    
    # This awk script replaces the block between the delimiters
    awk -v header="$HEADER" '
        BEGIN { p=1 }
        /# ---NIXMETA/ { print header; p=0 }
        /# ---ENDNIXMETA/ { p=1; next }
        p { print }
    ' "$f" > "$TMP"

    # Validate Nix syntax before moving
    if nix-instantiate --parse "$TMP" >/dev/null 2>&1; then
        mv "$TMP" "$f"
        echo "Successfully updated $f"
    else
        echo "Error: Syntax check failed for $f after update. Skipping."
        rm "$TMP"
    fi
done
