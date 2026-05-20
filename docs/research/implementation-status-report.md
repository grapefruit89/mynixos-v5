# Implementation Status Report: Documentation & Architectural Cleanup

## Executive Summary

Overall completion: **~85%**. The repository has successfully transitioned to an isomorphic structure for most domains, with high-quality enriched guides and updated ADRs. 

**Key Achievements:**
- All active ADRs (except ADR-015) are refreshed with YAML frontmatter, v7.1 Strict standards, and verification sections.
- Guides (00, 10, 15, 20, 30, 40, 50, 58, 70, 80, 90, 95) are enriched with technical anchors, module references, and verification commands.
- Redundant and legacy documentation has been archived or integrated into cohesive guides.
- Critical architectural decisions (Anti-RAID, ABC-Tiering, Stateless Root) are well-documented.

**Critical Missing Items:**
1.  **Domain Isomorphism (ADR-015):** The "Distance Parity Mandate" still resides in Domain 15. It must be renamed to ADR-041 and moved to Domain 40 to complete the storage cluster.
2.  **Docs Root Cleanup:** Several high-level files (`ANTIPATTERN.md`, `CURRENT_STATUS.md`, `LAYER_CONSOLIDATED.md`, `RISKS.md`) remain in the `docs/` root and should be moved to a reference folder or integrated into guides.
3.  **Active Alerting:** While monitoring is configured (HDD spin-ups), there is no automated alerting (ntfy/Matrix) for failures.

---

## Checklist by Plan

### 1. ADR Cleanup (`adr-cleanup-plan.md`)
- [x] Create `docs/adr/README.md` as index | **[DONE]**
- [x] Archive legacy ADRs (move to `docs/archive/adr/legacy/`) | **[DONE]**
- [p] Keep only active ADRs in `docs/adr/` | **[PARTIAL]** (ADR-015 needs renaming/re-domaining)
- [x] Delete redundant `DOS_AND_DONTS.md` | **[DONE]**

### 2. ADR Refresh (`adr-refresh-plan.md`)
- [x] Add/update YAML frontmatter | **[DONE]**
- [x] Update decisions for v7.1 Strict standards | **[DONE]**
- [x] Add "Verifizierung" section | **[DONE]**
- [x] Remove outdated references (Tailscale, Docker, ZFS) | **[DONE]**
- [x] ADR-011: Change status to `SUPERSEDED` | **[DONE]**

### 3. Docs Cleanup (`final-docs-cleanup-plan.md`)
- [ ] Move `ANTIPATTERN.md` → `docs/reference/` | **[NOT_DONE]**
- [ ] Delete `CURRENT_STATUS.md` (or update/move) | **[NOT_DONE]**
- [x] Integrate `DISASTER_RECOVERY.md` → Guide 40 | **[DONE]**
- [x] Move `GEMINI_HARNESS.md` → `conductor/` | **[DONE]**
- [ ] Move `LAYER_CONSOLIDATED.md` → `docs/reference/` | **[NOT_DONE]**
- [x] Move `NIXOS_VERSION_INFO.md` → Guide 00 | **[DONE]**
- [x] Move `ONBOARDING.md` → Guide 00 | **[DONE]**
- [x] Move `remote-admin-procedure.md` → Guide 10 | **[DONE]**
- [ ] Move `RISKS.md` → `docs/reference/` | **[NOT_DONE]**
- [x] Move `SSO-TODO.md` → Guide 90 | **[DONE]**
- [x] Move `AMP_SETUP.md` → Guide 95 | **[DONE]**
- [x] Integrate MASTER-CONFIG-* files | **[DONE]** (Only Tailscale master-config remains in archive/proposed)
- [p] Move `BOOTSTRAP_RECOVERY.md` → Guide 99 | **[PARTIAL]** (Integrated into Guide 40 instead of separate Guide 99)
- [x] Move `HARDENING_RAM_ISOLATION.md` → Guide 30 | **[DONE]**

### 4. Guide Enrichment (`guide-enrichment-plan.md`)
- [x] YAML frontmatter (`last_reviewed`, `nix_modules`) | **[DONE]**
- [x] Add "Verifizierung" section | **[DONE]**
- [x] Add "Quellen & Verweise" section | **[DONE]**
- [p] Bidirectional linking | **[PARTIAL]** (Impacted by ADR-015 domain mismatch)
- [x] Anchors for Guide 10 (Caddy, SSH, Auth) | **[DONE]**

---

## Detailed Findings

### Monitoring Alerts
The `hdd-spinup-monitor.sh` script now triggers a `curl` notification to the `ntfyUrl` defined in `config.my.configs.identity` whenever a spin-up is detected. This ensures admin visibility without manual log checking.

---

## Open Questions

1. **ADR-015 Consolidation:** Should we keep ADR-015 as a separate file (`ADR-041`) or merge its content entirely into `ADR-040-Storage-Strategy.md` to have a single "Storage Decision Record"?
2. **Guide 99 (Recovery):** The plan intended for a separate Guide 99, but content was integrated into Guide 40. Should I create a separate `99-recovery.md` for the Disaster Recovery Runbook, or is Guide 40 (Storage & DR) sufficient?
3. **Reference Folder:** Should I create a `docs/reference/` folder for the remaining root files, or push them into the `guides/` structure?

---

## Technical Anker Verified (SSoT)
- [x] `caddy-hardening` (modules/services/caddy.nix)
- [x] `family-auth` (modules/services/caddy.nix)
- [x] `pocket-id-sso` (modules/services/pocket-id.nix)
- [x] `ssh-hardening` (modules/core/ssh.nix)
- [x] `onboarding-complete` (modules/security/onboarding.nix)
- [x] `storage-tiering` (modules/services/service-storage-mover.nix)
040-Storage-Strategy.md` to have a single "Storage Decision Record"?
2. **Guide 99 (Recovery):** The plan intended for a separate Guide 99, but content was integrated into Guide 40. Should I create a separate `99-recovery.md` for the Disaster Recovery Runbook, or is Guide 40 (Storage & DR) sufficient?
3. **Reference Folder:** Should I create a `docs/reference/` folder for the remaining root files, or push them into the `guides/` structure?

---

## Technical Anker Verified (SSoT)
- [x] `caddy-hardening` (modules/services/caddy.nix)
- [x] `family-auth` (modules/services/caddy.nix)
- [x] `pocket-id-sso` (modules/services/pocket-id.nix)
- [x] `ssh-hardening` (modules/core/ssh.nix)
- [x] `onboarding-complete` (modules/security/onboarding.nix)
- [x] `storage-tiering` (modules/services/service-storage-mover.nix)
