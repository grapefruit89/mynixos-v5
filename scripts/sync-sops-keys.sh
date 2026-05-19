#!/usr/bin/env bash
# =============================================================================
# 🛡️ SOPS KEY BACKUP (Titan-Hardened)
# =============================================================================
# Encrypts the SSH host key for emergency recovery on Tier B.
# Logic: SSH Key -> Age Recipient -> Encrypted file on Tier B
# =============================================================================

set -euo pipefail

KEY="/persist/etc/ssh/ssh_host_ed25519_key"
DEST="/mnt/ssd/secrets/emergency_age_key.age" # Tier B

if [ -f "$KEY" ]; then
    mkdir -p "$(dirname "$DEST")"
    
    # 1. Derive Age Recipient from SSH Public Key
    RECIPIENT=$(ssh-keygen -y -f "$KEY" | ssh-to-age)
    
    # 2. Encrypt Key via Age (Self-Encrypted)
    # Note: Only the server host key itself can decrypt this backup.
    age -r "$RECIPIENT" -o "$DEST" < "$KEY"
    
    chmod 600 "$DEST"
    echo "✅ Sops emergency key encrypted and synced to $DEST"
else
    echo "❌ Error: Source key $KEY not found!"
    exit 1
fi
