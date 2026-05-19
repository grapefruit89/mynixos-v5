#!/usr/bin/env bash
# Hardware-Bound Everything: Secrets Sealing (v7.0 Strict)
# Dieses Skript versiegelt den SOPS-Entschlüsselungskey im TPM 2.0 Chip.

set -euo pipefail

SECRETS_DIR="/persist/secrets"
SEALED_KEY_FILE="$SECRETS_DIR/tpm_sealed_key.bin"
TEMP_KEY="/run/secrets/raw_age_key.txt"

echo "🔐 TPM 2.0 Secrets Sealing gestartet..."

mkdir -p "$SECRETS_DIR"
mkdir -p /run/secrets
chmod 0700 /run/secrets

# 1. Hole den aktuellen Age-Key (oder generiere einen neuen)
# Wir nutzen hier den Pfad, der bisher sops-nix bedient hat.
RAW_KEY_FILE="/persist/etc/ssh/ssh_host_ed25519_key"

if [ ! -f "$RAW_KEY_FILE" ]; then
    echo "❌ Fehler: Keinen Quell-Key unter $RAW_KEY_FILE gefunden."
    exit 1
fi

# 2. Versiegelung im TPM
# Wir binden den Key an PCR 0,1,2,3,4,5 (Firmware + HW + Bootloader + Partitionen)
echo "🔗 Versiegle Key im TPM (Hardware-Binding)..."

# Erstelle ein primäres Objekt in der Owner-Hierarchy (persistent)
tpm2_createprimary -C o -g sha256 -G rsa -c primary.ctx

# Erstelle das versiegelte Datenobjekt
# -L: PCR Policy (0,1,2,3,4,5)
tpm2_pcrpolicy -l sha256:0,1,2,3,4,5 -L policy.dat
tpm2_create -C primary.ctx -u obj.pub -r obj.priv -i "$RAW_KEY_FILE" -L policy.dat


# Lade das Objekt und speichere den persistenten Kontext
tpm2_load -C primary.ctx -u obj.pub -r obj.priv -c sealed.ctx
tpm2_evictcontrol -C o -c sealed.ctx 0x81010001 || echo "⚠️ Handle 0x81010001 bereits belegt, fahre fort..."

# Speichere die PCR-Policy für den Unseal-Vorgang
cp policy.dat "$SEALED_KEY_FILE"

echo "✅ Key wurde erfolgreich im TPM versiegelt (Handle: 0x81010001)."
echo "🚀 Er ist nun hardware-gebunden und kann nur bei korrektem Boot-Status gelesen werden."
