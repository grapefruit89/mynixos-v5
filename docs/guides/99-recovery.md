# NixHome v6.1 Bare-Metal Recovery (Hardened)

1. Boot NixOS minimal from USB (ISO).
2. Install tools: `nix-env -iA nixos.git nixos.age nixos.sops nixos.restic nixos.rclone nixos.yq`.
3. Clone repository: `git clone https://github.com/grapefruit89/mynixos-v5.git`.
4. Setup SOPS Key:
   - If using YubiKey: `age-plugin-yubikey --identity` to get the identity path.
   - Or export your age key: `export SOPS_AGE_KEY_FILE=/path/to/key.txt`.
5. Decrypt & Extract Secrets (Automated):
   - `export RESTIC_PASSWORD=$(sops --decrypt --extract '["restic_password"]' secrets/infra.yaml)`
   - `export B2_ACCOUNT_ID=$(sops --decrypt --extract '["backblaze_access_key"]' secrets/infra.yaml)`
   - `export B2_ACCOUNT_KEY=$(sops --decrypt --extract '["backblaze_secret_key"]' secrets/infra.yaml)`
6. Mount & Restore Filesystem (ext4):
   - `mount /dev/sdX /mnt` (Target Drive)
   - `restic -r s3:s3.eu-central-003.backblazeb2.com/nixhome-backup restore latest --target /mnt`
   - *Note: This restores to /mnt/persist correctly assuming the backup stores absolute paths.*
7. Rebuild System:
   - `nixos-rebuild switch --flake .#default --root /mnt`
8. Verify SSH host key from `/mnt/persist/etc/ssh` matches expectation.

---
**⚠️ SECURITY NOTE (C-03):** The USB recovery key (containing the emergency age key) MUST be stored physically separate from the server (e.g., in a safe, at a different location, or with a trusted person) to prevent local physical access from compromising all secrets.
