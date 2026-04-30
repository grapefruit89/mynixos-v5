# Design Doc: Persistent Logging with Vector (P1)

## Status
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Draft

## 1. Goal
Implement a persistent logging pipeline that survives reboots (surmounting the current `volatile` journald restriction) while maintaining high system performance.

## 2. Context & Constraints
- **Architecture:** Horizontal Responsibility (v5.0).
- **Hardening:** hardened (Sensitive data masking).
- **Storage:** Tier B (SSD) for log archives to avoid NVMe wear and RAM usage.
- **Framework:** Vector (Lightweight, Go/Rust-based).

## 3. Architecture Details

### 3.1 New Module: `modules/logging/vector-tier-b.nix`
- **Source:** Pulls from `journald`.
- **Transform:** 
 - Masking of `/mnt/media`, `/mnt/hdd_pool`, `/mnt/tierC`.
 - Masking of filenames (mkv, mp4, etc.).
 - Masking of API keys (32+ chars).
- **Sink:** 
 - Local file on Tier B (`${srePaths.tierB}/logs/vector/journal-%Y-%m-%d.log.gz`).
 - Format: NDJSON.
 - Compression: GZIP.
- **Rotation:** 14-day retention via `find` script and `systemd.timer`.

### 3.2 Profile Integration
- **Profile:** `profiles/base-server.nix`.
- **Action:** Replace `modules/core/logging.nix` import with `modules/logging/vector-tier-b.nix`.
- **Toggle:** `my.logging.vector.enable = true;`.

## 4. Implementation Steps
1. Create `modules/logging` directory.
2. Create `vector-tier-b.nix` with the approved code.
3. Update `profiles/base-server.nix` imports.
4. Enable the service in `profiles/base-server.nix`.
5. Run `nix-instantiate` to verify.

## 5. Future Extensions
- S3 Sink for long-term offsite archiving.
- Gatus integration for log-based health alerts.
