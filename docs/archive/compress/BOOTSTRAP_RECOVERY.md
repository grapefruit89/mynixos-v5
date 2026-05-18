# NixHome v6.1 Bare-Metal Recovery (Hardened)

1. Boot NixOS minimal from USB (ISO).
2. Install tools: `nix-env -iA nixos.git nixos.age nixos.sops nixos.restic nixos.yq`.
3. Clone repository: `git clone https://github.com/grapefruit89/mynixos-v5.git`.
4. Setup SOPS Key:
   - If using YubiKey: `age-plugin-yubikey --identity` to get the identity path.
   - Or export your age key: `export SOPS_AGE_KEY_FILE=/path/to/key.txt`.
5. Decrypt & Extract Secrets (Automated):
   - `sops --decrypt secrets/secrets.yaml | yq -r '.restic' > /tmp/restic-creds.json`
   - `export RESTIC_PASSWORD=$(jq -r .password /tmp/restic-creds.json)`
   - `export B2_ACCOUNT_ID=$(jq -r .b2_id /tmp/restic-creds.json)`
   - `export B2_ACCOUNT_KEY=$(jq -r .b2_key /tmp/restic-creds.json)`
6. Mount & Restore Filesystem (ext4):
   - `mount /dev/sdX /mnt` (Target Drive)
   - `restic -r b2:your-bucket restore latest --target /mnt`
   - *Note: This restores to /mnt/persist correctly assuming the backup stores absolute paths.*
7. Rebuild System:
   - `nixos-rebuild switch --flake .#default --root /mnt`
8. Verify SSH host key from `/mnt/persist/etc/ssh` matches expectation.
