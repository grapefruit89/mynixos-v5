#!/usr/bin/env bash
# Audit: Systemd Service Security (v7.0 Strict - Audit Topic 4)
# Dieses Skript analysiert die Härtung aller systemd-Dienste.

set -euo pipefail

echo "🛡️ Starte Systemd Security Audit..."
echo "--------------------------------------------------"

# Führe systemd-analyze security für alle Dienste aus
# Wir sortieren nach dem Security-Score (niedriger ist besser/sicherer)
systemd-analyze security --no-pager | sort -k2 -n

echo "--------------------------------------------------"
echo "💡 Ein Score > 5.0 gilt als 'EXPOSED'. Prüfe mkService Konfiguration."
echo "✅ Audit abgeschlossen."
