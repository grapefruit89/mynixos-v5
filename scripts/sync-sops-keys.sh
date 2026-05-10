#!/usr/bin/env bash
# Sops Key Backup Script
# Backs up the SSH host key to Tier B for emergency decryption.

SOURCE="/persist/etc/ssh/ssh_host_ed25519_key"
TARGET="/mnt/ssd/secrets/emergency_age_key.txt" # Assuming Tier B is /mnt/ssd

if [ -f "$SOURCE" ]; then
 mkdir -p "$(dirname "$TARGET")"
 cp "$SOURCE" "$TARGET"
 chmod 600 "$TARGET"
 echo "Sops emergency key synced to $TARGET"
else
 echo "Source key $SOURCE not found!"
fi
