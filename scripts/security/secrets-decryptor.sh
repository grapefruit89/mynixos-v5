#!/usr/bin/env bash
# Hardware-Bound Zero-Trust Secrets Decryptor (v7.0 Strict - LH11)
# Dieses Skript entschlüsselt SOPS-Geheimnisse direkt via TPM 2.0 Hardware.

set -euo pipefail

# --- CONFIGURATION ---
SECRETS_DIR="/run/secrets"
ENV_FILE="$SECRETS_DIR/secrets.env"
TEMP_KEY="$SECRETS_DIR/age_key.txt"
# Pfad zum verschlüsselten Repository-Vault
SOPS_FILE="/etc/nixos/secrets/secrets.yaml"
# TPM PCR Policy Datei (wurde bei setup-secrets-tpm.sh erstellt)
POLICY_FILE="/persist/secrets/tpm_sealed_key.bin"

# --- EXECUTION ---
echo "🔐 TPM 2.0: Starte Hardware-Unseal der Geheimnisse..."

# Stelle sicher, dass das Verzeichnis existiert und sicher ist
mkdir -p "$SECRETS_DIR"
chmod 0700 "$SECRETS_DIR"

if [ ! -f "$SOPS_FILE" ]; then
    echo "❌ Fehler: Secrets-Datei nicht gefunden unter $SOPS_FILE"
    exit 1
fi

if [ ! -e "/dev/tpmrm0" ]; then
    echo "❌ Fehler: Kein TPM 2.0 Gerät gefunden. Hardware-Entschlüsselung nicht möglich."
    exit 1
fi

# 1. Hardware-Unseal via TPM 2.0
# Wir nutzen den persistenten Handle 0x81010001 (Hardware Root)
echo "🔗 Rufe Key vom TPM ab (PCR-Validierung)..."

if tpm2_unseal -c 0x81010001 -p pcr:sha256:0,1,2,3,4,5 > "$TEMP_KEY"; then
    export SOPS_AGE_KEY_FILE="$TEMP_KEY"
    
    # 2. Entschlüsselung via sops direkt in ein .env Format
    if sops --decrypt --output-type dotenv "$SOPS_FILE" > "$ENV_FILE"; then
        chmod 0400 "$ENV_FILE"
        echo "✅ Geheimnisse erfolgreich via Hardware-TPM entschlüsselt."
    else
        echo "❌ Fehler bei der SOPS-Entschlüsselung."
        rm -f "$TEMP_KEY"
        exit 1
    fi
    
    # 3. Cleanup: Raw Key sofort aus dem RAM löschen
    rm -f "$TEMP_KEY"
else
    echo "❌ TPM PCR Mismatch! Hardware-Manipulation oder unsicherer Boot erkannt."
    exit 1
fi
