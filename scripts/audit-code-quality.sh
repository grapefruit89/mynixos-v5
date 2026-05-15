#!/usr/bin/env bash
# Audit: Zero-Trust Code Quality (v7.0 Strict - LH12)
# Dieses Skript führt Statix, Deadnix und nixpkgs-fmt via transienten nix-shell aus.

set -euo pipefail

# Sicherstellen, dass wir im Repo-Root sind
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

FIX_MODE=false
if [[ "${1:-}" == "--fix" ]]; then
    FIX_MODE=true
    echo "🛠️ Fix-Modus aktiviert."
fi

echo "🧪 Starte Zero-Trust Code Quality Audit..."
echo "--------------------------------------------------"

# 1. Statix (Linting)
echo "🔍 Führe Statix (Linting) aus..."
nix-shell -p statix --run "statix check modules/ configuration.nix" || echo "⚠️ Statix hat Warnungen gefunden."

# 2. Deadnix (Unused Code)
echo "🔍 Führe Deadnix (Ungenutzter Code) aus..."
if [ "$FIX_MODE" = true ]; then
    nix-shell -p deadnix --run "deadnix -e modules/ configuration.nix"
else
    nix-shell -p deadnix --run "deadnix modules/ configuration.nix"
fi

# 3. nixpkgs-fmt (Formatting)
if [ "$FIX_MODE" = true ]; then
    echo "🎨 Formatiere Code mit nixpkgs-fmt..."
    nix-shell -p nixpkgs-fmt --run "nixpkgs-fmt modules/ configuration.nix"
else
    echo "🔍 Prüfe Formatierung mit nixpkgs-fmt..."
    nix-shell -p nixpkgs-fmt --run "nixpkgs-fmt --check modules/ configuration.nix"
fi

echo "--------------------------------------------------"
echo "✅ Audit abgeschlossen."
