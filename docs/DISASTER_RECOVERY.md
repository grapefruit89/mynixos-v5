# 🚨 Disaster Recovery Runbook (NixHome v6.0)

This guide provides step-by-step instructions for recovering the system from a total hardware failure or catastrophic data loss.

## 📦 Backup Sources
1.  **Local Archive:** `/mnt/archive/.restic-vault` (SSD/HDD)
2.  **Remote Cloud:** Backblaze B2 (Bucket: `nixhome-backup`)

## 🛠️ Recovery Scenarios

### Scenario 1: Reinstalling on New Hardware
1.  **Flash NixOS:** Use a standard NixOS Flake installer.
2.  **Clone Repo:** `git clone https://github.com/grapefruit89/mynixos-v5.git`
3.  **Restore Secrets:**
    -   You need your `age` master key or the original `secrets.yaml` source.
    -   If the `age` key is lost, you MUST use your emergency backup key from Tier B (if accessible).
4.  **Initial Build:** `nixos-rebuild switch --flake .#nixhome`

### Scenario 2: Restoring Persistent Data (/persist)
If the NVMe drive failed but the backup is safe:
1.  **Install Restic:** `nix-shell -p restic`
2.  **Configure B2 Credentials:**
    ```bash
    export B2_ACCOUNT_ID="<your-id>"
    export B2_ACCOUNT_KEY="<your-key>"
    export RESTIC_REPOSITORY="s3:s3.eu-central-003.backblazeb2.com/nixhome-backup"
    export RESTIC_PASSWORD_FILE="/path/to/restic-password"
    ```
3.  **Restore Files:**
    ```bash
    restic restore latest --target /
    ```
4.  **Reboot:** Since the root is stateless, the restored `/persist` will be picked up automatically.

### Scenario 3: Restoring Pocket-ID Database
Pocket-ID state is stored in `/var/lib/pocket-id` (persisted).
1.  Stop the service: `systemctl stop pocket-id`
2.  Restore the directory from restic (see Scenario 2).
3.  Fix permissions: `chown -R pocket-id:pocket-id /var/lib/pocket-id`
4.  Start the service: `systemctl start pocket-id`

## 🛡️ Verification
-   Check logs: `journalctl -u restic-backups-daily`
-   Verify Gatus dashboard for service health.
