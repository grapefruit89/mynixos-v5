#!/usr/bin/env bash
# Hardware-Bound Everything: LUKS TPM Enrollment (v7.0 Strict)
# Dieses Skript bindet die LUKS-Verschlüsselung an den TPM 2.0 Chip.

set -euo pipefail

echo "🔐 TPM 2.0 LUKS Enrollment gestartet..."

# 1. Identifiziere die LUKS-Partition
# Wir suchen nach der Partition, die als LUKS-Container markiert ist.
LUKS_DEV=$(blkid -t TYPE=crypto_LUKS -o device | head -n 1)

if [ -z "$LUKS_DEV" ]; then
    echo "❌ Fehler: Keine LUKS-Partition gefunden."
    exit 1
fi

echo "📦 Gefundene LUKS-Partition: $LUKS_DEV"

# 2. Prüfe auf TPM 2.0 Hardware
if [ ! -e "/dev/tpmrm0" ]; then
    echo "❌ Fehler: Kein TPM 2.0 Device (/dev/tpmrm0) gefunden."
    exit 1
fi

# 3. Enrollment via systemd-cryptenroll
# Wir binden an PCRs:
# 0: BIOS / Core Root of Trust
# 1: Mainboard / Host Platform Configuration
# 2: Option ROM Code
# 3: Option ROM Configuration
# 4: Boot Loader
# 5: Partition Table
echo "🔗 Binde Partition an TPM 2.0 (PCR 0,1,2,3,4,5)..."
echo "⚠️ Du wirst nach deinem aktuellen LUKS-Passwort gefragt."

# Wir nutzen systemd-cryptenroll für die native Integration
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+1+2+3+4+5 "$LUKS_DEV"

echo "✅ LUKS-Partition erfolgreich an den TPM 2.0 Chip gebunden."
echo "🚀 Beim nächsten Boot sollte das System automatisch ohne Passwort entsperren."
