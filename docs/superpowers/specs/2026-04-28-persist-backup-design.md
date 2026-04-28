# Design Doc: Backblaze B2 Cloud Backup (P2)

## Status
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Approved

## 1. Goal
Implement a direct-to-cloud backup for the `/persist` directory (Tier A) using Restic and Backblaze B2 (S3 API). This provides offsite redundancy for the system's most critical data.

## 2. Architecture Details

### 2.1 Secret Management (`modules/core/secrets.nix`)
- **New Secrets:**
    - `restic_password`: Master encryption key.
    - `backblaze_access_key`: B2 Key ID.
    - `backblaze_secret_key`: B2 Application Key.
- **New Template:** `backblaze-restic.env` providing `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for Restic.

### 2.2 Backup Configuration (`modules/core/backup.nix`)
- **New Job:** `services.restic.backups.persist`.
- **Target:** S3 endpoint (Backblaze B2).
- **Retention:**
    - Daily: 7 snapshots.
    - Weekly: 4 snapshots.
    - Monthly: 6 snapshots.
- **Timer:** Daily at 03:00.

## 3. Implementation Steps
1. Update `modules/core/secrets.nix` to include new secrets and the environment template.
2. Update `modules/core/backup.nix` to include the `persist` Restic job.
3. Verify syntax and dependencies.
