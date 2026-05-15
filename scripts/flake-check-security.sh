#!/usr/bin/env bash
# Flake Check: Systemd Static Security Audit (v7.0 Strict)
# Dieses Skript prüft die evaluierten systemd-Units auf Einhaltung der Baseline.

set -euo pipefail

# Argument 1: Pfad zum Verzeichnis mit den evaluierten systemd-Units
# (Wird vom Flake-Check übergeben)
UNITS_DIR="${1:-}"

if [[ -z "$UNITS_DIR" ]]; then
    echo "❌ Fehler: Kein Units-Verzeichnis angegeben."
    exit 1
fi

echo "🛡️ Starte statisches Systemd-Security Audit..."
echo "📂 Prüfe Units in: $UNITS_DIR"

FAILED=0

# Liste der kritischen Parameter, die vorhanden sein MÜSSEN
REQUIRED_PARAMS=(
    "ProtectSystem=strict"
    "ProtectHome=true"
    "PrivateTmp=true"
    "NoNewPrivileges=true"
    "RestrictNamespaces=true"
    "MemoryDenyWriteExecute=true"
)

# Wir prüfen alle .service Dateien
for unit in "$UNITS_DIR"/*.service; do
    [ -e "$unit" ] || continue
    UNIT_NAME=$(basename "$unit")
    
    # Überspringe Standard-Systemd Units
    if [[ "$UNIT_NAME" =~ ^(sysinit|basic|multi-user|getty|systemd-|initrd-).* ]]; then
        continue
    fi

    echo "🔍 Prüfe $UNIT_NAME..."
    
    for param in "${REQUIRED_PARAMS[@]}"; do
        if ! grep -q "^$param" "$unit"; then
            echo "  ❌ Fehlender oder falscher Parameter: $param"
            FAILED=1
        fi
    done
done

if [[ $FAILED -eq 1 ]]; then
    echo "--------------------------------------------------"
    echo "❌ Audit fehlgeschlagen! Ein oder mehrere Dienste entsprechen nicht der v7.0 Strict Baseline."
    exit 1
else
    echo "--------------------------------------------------"
    echo "✅ Audit erfolgreich. Alle Dienste sind korrekt 'jailed'."
    exit 0
fi
