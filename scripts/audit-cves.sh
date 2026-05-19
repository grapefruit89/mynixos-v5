#!/usr/bin/env bash
# audit-cves.sh - CVE Scanning with vulnix
# Implementation of Security Auditing

# 1. Build the local system (Fujitsu Q958 configuration)
echo "🏗️ Building system for CVE audit..."
nix build .#nixosConfigurations.nixhome.config.system.build.toplevel

if [ ! -L ./result ]; then
    echo "❌ Error: System build failed."
    exit 1
fi

# 2. Run vulnix CVE scan
echo "🔍 Starting CVE Scan with vulnix..."
vulnix \
  --whitelist ./scripts/vulnix-whitelist.txt \
  --cache ~/.cache/vulnix \
  --cvss 7 \
  ./result

# 3. Optional: Export JSON for automated tracking
# vulnix --whitelist ./scripts/vulnix-whitelist.txt --output json ./result > cve-report.json

echo "✅ CVE Audit complete."
