#!/usr/bin/env bash
# =============================================================================
# 🛡️ SECURITY & QUALITY AUDITOR
# =============================================================================
# This script enforces the project's v7.1 security mandates.
# It scans for forbidden technologies, missing metadata, and invalid patterns.
# =============================================================================

set -euo pipefail

# Configuration
MODULES_DIR="modules"
FORBIDDEN_PATTERNS=(
    "services.tailscale.enable\s*=\s*true"
    "virtualisation.docker.enable\s*=\s*true"
    "services.cron.enable\s*=\s*true"
    "services.sftpgo.enable\s*=\s*true"
    "services.openssh.settings.PasswordAuthentication\s*=\s*true"
    "boot.lanzaboote.enable\s*=\s*true"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

EXIT_CODE=0

echo -e "${YELLOW}🚀 Starting Security & Quality Audit...${NC}"

# 1. FORBIDDEN TECHNOLOGY CHECK
echo -e "\n${YELLOW}[1/3] Checking for Forbidden Technologies...${NC}"
for pattern in "${FORBIDDEN_PATTERNS[@]}"; do
    if grep -rEi "$pattern" "$MODULES_DIR" --exclude-dir=.git; then
        echo -e "${RED}❌ ERROR: Forbidden pattern detected: '$pattern'${NC}"
        EXIT_CODE=1
    fi
done

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✅ No forbidden technologies detected.${NC}"
fi

# 2. NIXMETA HEADER CHECK
echo -e "\n${YELLOW}[2/3] Validating NIXMETA Headers...${NC}"
MISSING_META=0
# Find all .nix files in modules, excluding hidden files, default.nix, and templates
while IFS= read -r file; do
    if ! grep -q "---NIXMETA" "$file"; then
        echo -e "${RED}❌ ERROR: Missing NIXMETA header in: $file${NC}"
        MISSING_META=1
        EXIT_CODE=1
    fi
done < <(find "$MODULES_DIR" -name "*.nix" -not -name "default.nix" -not -path "*/_*" -not -name "SERVICE_TEMPLATE.nix")

if [ $MISSING_META -eq 0 ]; then
    echo -e "${GREEN}✅ All modules have NIXMETA headers.${NC}"
fi

# 3. FORMATTING CHECK
echo -e "\n${YELLOW}[3/3] Checking Nix Formatting (nixfmt)...${NC}"
if ! nix fmt --check . 2>/dev/null; then
    echo -e "${RED}❌ ERROR: Code is not formatted. Please run 'nix fmt'.${NC}"
    EXIT_CODE=1
else
    echo -e "${GREEN}✅ Code formatting is valid.${NC}"
fi

# FINAL RESULT
echo -e "\n============================================================================="
if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}🏆 AUDIT PASSED: Repository is compliant with v7.1 standards.${NC}"
else
    echo -e "${RED}💀 AUDIT FAILED: Please fix the errors above before committing.${NC}"
fi
echo -e "=============================================================================\n"

exit $EXIT_CODE
