# Comprehensive Storage Subsystem Research Report

## Executive Summary

The storage subsystem in **NixHome (repo_v5)** follows a highly structured **ABC-Tiering model** built around a stateless root philosophy. By utilizing `tmpfs` for the root partition and binding persistent state via `impermanence`, the system remains pure and robust against bit rot and configuration drift. 

**Main Findings:**
- The concept of **ZFS and SnapRAID has been explicitly rejected** in favor of simpler, more robust native `ext4` configurations on consumer hardware, combined with MergerFS for pooling. This adheres strictly to the "KISS" principle documented in `ANTIPATTERN.md`.
- **Idempotency** is highly mature. Restic backup definitions are declarative, idempotent (`initialize = true`), and the root filesystem resets on every reboot.
- **HDD Spindown** is successfully configured at `30m` via TLP. To support this, an "Inode Warmer" script acts as a ghost tree in RAM, preventing unnecessary spin-ups from metadata lookups.
- **Monitoring** exists (`hdd-spinup-monitor.sh`) via `smartctl -n standby` polling, but lacks proactive alerting.

**Critical Issues:**
1.  **Isomorphy Breaking:** `ADR-015` (Distance Over Local Parity / Anti-RAID Mandate) is incorrectly placed in Domain 15 instead of Storage Domain 40.
2.  **Missing Mount Declarations:** The physical underlying block devices (`/dev/disk/by-uuid/...` for `/mnt/cache`, `/mnt/hdd_pool`) are absent from the central configuration outside of `hardware-configuration.nix` (which only mounts `/` and `/boot` currently in the generic template).
3.  **Silent Monitoring:** Spin-up monitoring logs locally but does not alert the admin.

---

## Inventory List

| File Path | Domain | Category | Purpose | Status |
| :--- | :---: | :--- | :--- | :--- |
| `hardware/q958/hardware-profile.nix` | 00 | hardware | Sets TLP `DISK_SPINDOWN_TIMEOUT_ON_AC = "30m"` | Active |
| `modules/core/storage.nix` | 40 | core/storage | MergerFS pools (`/storage`, `/mnt/app-data-synergy`), Inode Warmer, Spinup Monitor. | Active |
| `modules/core/storage-policy.nix` | 40 | auto/gen | Enforces strict path assertions and Tier C access exclusions. | Active |
| `modules/core/backup.nix` | 40 | core/security | Defines Restic backups (Local & B2), pre-flight size limits, weekly audit. | Active |
| `modules/core/impermanence.nix` | 40 | core/persistence | Configures `/persist` and `tmpfs` root, defines standard state dirs. | Active |
| `modules/services/service-storage-mover.nix` | 40 | auto/gen | Smart bash script moving data from Tier B to Tier C based on capacity. | Active |
| `scripts/hdd-spinup-monitor.sh` | 40 | script | Polls SMART status safely (`-n standby`) and logs spin-ups. | Active |
| `docs/adr/ADR-015-Distance-Parity-Mandate.md` | **15** | ADR | Architectural decision against RAID, favoring Restic/B2. | Misaligned |
| `docs/adr/ADR-040-Storage-Strategy.md` | 40 | ADR | HDD Spindown & Jellyfin scan schedule decisions. | Active |
| `docs/guides/40-storage-strategy.md` | 40 | Guide | Implementation guide, DR strategies, manual verification steps. | Active |
| `docs/ANTIPATTERN.md` | 90 | Rules | Explicitly rejects ZFS and SnapRAID on consumer hardware. | Active |

---

## Current State vs. Desired Isomorphic Structure

### Correct / Aligned
- **Storage Strategy Guide:** `docs/guides/40-storage-strategy.md` correctly aligns with Domain 40.
- **HDD Lifecycle ADR:** `ADR-040-Storage-Strategy.md` successfully establishes Domain 40 for hardware power management.
- **Capabilities & Policies:** The `ANTIPATTERN.md` serves as a solid gatekeeper, successfully eliminating complex RAID/ZFS logic that would interfere with spindown constraints.

### Misaligned / Isomorphy Gaps
- **ADR-015 belongs in Domain 40:** "Distance Over Local Parity" defines the backup and disk array strategy. Domain 15 is typically IoT/Networking. This breaks structural isomorphism.
- **Broken Cross-links:** Because of `ADR-015`'s domain mismatch, `Guide 15` (IoT) incorrectly links to `ADR-015-IoT-Services.md` (which doesn't exist, as 15 was hijacked by the Parity Mandate).

---

## Idempotency & Impermanence Check

### Overall Architecture
- **Root Filesystem:** Bound to `tmpfs`. Inherently idempotent.
- **Backup Strategy:** Restic services use `initialize = true`. The system creates missing repositories automatically without manual intervention.

### State Declarations (Impermanence)
Stateful services map correctly to `/persist` through `my.impermanence.directories`.

| Service | Declared via Impermanence? | Path | Tier |
| :--- | :---: | :--- | :---: |
| **Jellyfin** | ✅ Yes (`modules/40-media/44-streaming.nix`) | `/var/lib/jellyfin`, `/var/cache/jellyfin` | B |
| **SABnzbd** | ✅ Yes (`modules/40-media/43-download.nix`) | `/var/lib/sabnzbd` | B |
| **Arr Suite** | ✅ Yes (`modules/40-media/42-arr-stack.nix`) | `/var/lib/*arr` | B |
| **Pocket-ID** | ✅ Yes (`modules/core/impermanence.nix`) | `/var/lib/pocket-id` | A |
| **PostgreSQL**| ✅ Yes (`modules/core/impermanence.nix`) | `/var/lib/postgresql` | A |
| **Caddy** | ✅ Yes (`modules/core/impermanence.nix`) | `/var/lib/caddy` | A |

**Conclusion:** All critical data paths are correctly shielded from the `tmpfs` wipe and are covered by Restic (which backs up `/persist`).

---

## Gaps and Technical Debt

1. **Undocumented Physical Mounts:** `fileSystems` declarations for `/persist` (Tier A), `/mnt/cache` (Tier B), and `/mnt/hdd_pool` (Tier C) are commented out or missing from `hardware-configuration.nix` (or `hardware-profile.nix`). If the host reboots, NixOS will not know how to mount the backing block devices unless they exist purely in an un-versioned `/etc/nixos/hardware-configuration.nix` file (which breaks declarative GitOps).
2. **Missing Alerting (HDD Monitor):** The script `scripts/hdd-spinup-monitor.sh` logs cleanly to `logger` but does not trigger an `ntfy` curl request. Admin visibility relies on manual `journalctl` checks.
3. **ZFS Artifacts:** Although rejected in `ANTIPATTERN.md`, `ADR-018` mandates `zfs` as a core kernel module (`AP-008`). This is technical debt and a contradiction.
4. **SMART Monitoring:** Missing automated SMART long-tests and alert mechanisms. `smartd` is generally active on NixOS but is not explicitly configured to push alerts to `ntfy`.

---

## Action Plan

### 🔴 Critical Priority
1. **Fix Isomorphism (ADR-015):** 
   - Rename `docs/adr/ADR-015-Distance-Parity-Mandate.md` to `docs/adr/ADR-041-Distance-Parity.md` (or merge into `ADR-040`).
   - Update frontmatter `domain: 40`.
   - Correct the link inside `docs/guides/15-iot-services.md` to point to a new IoT ADR, or remove the broken link.
2. **Physical Mount Declarations:** 
   - Declare the UUIDs or Labels for Tier A, Tier B, and Tier C in `hardware/q958/hardware-profile.nix`. Ensure NixOS mounts them prior to `local-fs.target` so MergerFS doesn't fail.

### 🟡 High Priority
3. **Clean Technical Debt in ADR-018:** 
   - Remove the `zfs` kernel module requirement from `AP-008` in `ADR-018-Media-Stack-Architecture.md`, since `ext4` is the official standard.
4. **Push Alerts for HDD Spinups:**
   - Modify `scripts/hdd-spinup-monitor.sh` to trigger a `curl` request to `config.my.configs.identity.ntfyUrl` whenever the `CURRENT_COUNT` increases.

### 🟢 Medium/Low Priority
5. **SMART Alerts:** 
   - Add a module for `services.smartd` configuring notifications via `ntfy` on device degradation.
6. **Disaster Recovery Readme Expansion:** 
   - Expand `docs/guides/40-storage-strategy.md` with the exact commands needed to clone the repo on a blank machine, mount the LUKS volumes, and execute `restic restore`.

---

## Open Questions
1. **Physical Mounts:** How are your physical drives currently mounted? Should we define them declaratively in `repo_v5/hardware/q958/hardware-profile.nix`, or are you using a `disko` setup outside this repository?
2. **ADR-015 Consolidation:** Should we simply merge the content of `ADR-015` directly into the newly created `ADR-040-Storage-Strategy.md` to have a single, unified Storage SSoT, or do you prefer keeping them as separate ADRs (`ADR-040` for lifecycle, `ADR-041` for parity)?
3. **SMART Alerting:** Do you want me to plan the implementation of `smartd` notifications to your local `ntfy` instance?