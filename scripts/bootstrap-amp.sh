#!/usr/bin/env bash
# =============================================================================
# 🚀 AMP BOOTSTRAP SKRIPT (v7.1 gehärtet)
# =============================================================================
# Dieses Skript bereitet die initiale Installation von AMP in der FHS-Sandbox vor.
# =============================================================================

set -euo pipefail

# Prüfen auf Root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Dieses Skript muss als root ausgeführt werden."
  exit 1
fi

echo "📦 Starte AMP Bootstrapping..."

# 1. Sicherstellen, dass das Verzeichnis existiert und dem amp User gehört
mkdir -p /var/lib/amp
chown -R amp:amp /var/lib/amp
chmod 0750 /var/lib/amp

echo "🐚 Wechsle in die FHS-Sandbox als User 'amp'..."
echo "👉 Bitte führe dort folgende Befehle aus:"
echo "   1. wget https://repo.cubecoders.com/ampinstmgr.zip"
echo "   2. unzip ampinstmgr.zip"
echo "   3. ./ampinstmgr QuickStart <DeineLizenzNummer>"
echo ""
echo "Nach der Installation kannst du den Systemd-Service mit 'systemctl start amp' starten."
echo ""

# Starte die FHS Shell als amp User
sudo -u amp amp-fhs
