# NixHome v6.0 Implementation State (Strict Audit Mode)

## Phase 0 — Make It Build and Boot
- [x] Task 0.1 — Eliminate the flat-layout boot blocker (Verified)
- [x] Task 0.2 — Resolve the dual mkForce on fileSystems."/" (Verified)
- [x] Task 0.3 — Fix the nvme initrd boot-blocker (Verified)
- [x] Task 0.4 — Fix the ca-server.nix syntax error (Verified)

## Phase 1 — Eradicate Rejected Concepts
- [x] Task 1.1 — Complete Tailscale eradication (Verified)
- [x] Task 1.2 — OliveTin eradication (Verified)
- [x] Task 1.3 — CA server eradication (Verified)
- [x] Task 1.4 — mTLS reference cleanup (Verified)
- [x] Task 1.5 — Cloudflared tunnel deletion (Verified)
- [x] Task 1.6 — Auto-locale simplification (Verified)

## Phase 2 — Fix the Persistence Model
- [x] Task 2.1 — Audit and complete the persistence list (Verified)
- [x] Task 2.2 — Resolve the stateDir path problem (Verified)
- [x] Task 2.3 — SOPS key path validation (Verified)
- [x] Task 2.4 — Add /home/moritz to persistence (Verified)

## Phase 3 — Three-Zone Gateway Implementation
- [x] Task 3.1 — Resolve Pocket-ID TCP configuration (Verified: TCP port 8089 in pocket-id.nix)
- [x] Task 3.2 — Create the `admin_only` Caddy snippet (Verified: admin_auth snippet in caddy.nix)
- [x] Task 3.3 — Create the `family_auth` snippet (Verified: family_auth snippet in caddy.nix)
- [x] Task 3.4 — Apply zone assignments to all virtualHosts (Verified: genVHost logic in caddy.nix)
- [x] Task 3.5 — Pocket-ID special virtualHost configuration (Verified: admin path splitting implemented)
- [x] Task 3.6 — Move Caddy admin API to Unix socket (Verified: admin unix//run/caddy/admin.sock)
- [x] Task 3.7 — Apply explicit Caddy systemd hardening (Verified: caddy.nix L201 explicit serviceConfig)
- [x] Task 3.8 — Fix Caddy JSON logging for fail2ban (Verified: global log block in caddy.nix)
- [x] Task 3.9 — Document SSH tunnel remote admin procedure (Verified: docs/remote-admin-procedure.md created)

## Phase 4 — Blocky DNS
- [x] Task 4.1 — Create `modules/services/blocky.nix` (Verified)
- [x] Task 4.2 — Reconfigure `systemd-resolved` to use Blocky (Verified in blocky.nix)
- [x] Task 4.3 — Remove AdGuard Home default (Verified in registry.nix)
- [x] Task 4.4 — Add Blocky-specific allowlist for nftables outbound (Verified in firewall.nix)

## Phase 5 — Kernel Hardening Module
- [x] Task 5.1 — Delete `kernel-slim.nix` (Verified)
- [x] Task 5.2 — Modify `hardened-core.nix` (Verified: package conflict removed)
- [x] Task 5.3 — Create `modules/core/kernel-hardening.nix` (REPAIRED: categories 1-9, userns restriction, ASLR bits, AppArmor enable)
- [x] Task 5.4 — Validate thunderbolt and IPMI (Verified: IPMI retained)
- [x] Task 5.5 — Kernel Hardening v6.1 Implementation (Verified: Static whitelisting, sysctls, hardware separation, audit service)

## Phase 6 — mkService Factory and UID Registry Repair
- [x] Task 6.1 — Create the UID registry (Verified: 2000-2999 range)
- [x] Task 6.2 — Fix factory PostgreSQL socket bind-mount (Verified: conditional on requiresPostgres)
- [x] Task 6.3 — Fix factory socket directory creation (Verified in lib-helpers.nix)
- [x] Task 6.4 — Fix MemoryHigh in mkStreamer (Verified: absolute values)

## Phase 7 — Zero-Trust Outbound
- [x] Task 7.1 — Phase 6A: Logging Mode (Enabled as fallback log rule in firewall.nix)
- [x] Task 7.2 — Phase 6C: Enforcement Mode (Verified: policy drop active for 2000-2999 range with granular allowlist)

## Phase 8 — SOPS Multi-Key
- [x] Task 8.1 — Multi-Key Setup (Configuration complete, Strategy S-01 documented)
- [x] Task 8.2 — Recovery Validation (Service and Timer active in secrets.nix)
- [x] Task 8.3 — Bootstrap Runbook (Created docs/BOOTSTRAP_RECOVERY.md)
- [x] Task 8.4 — Multi-Key Docs (Comment header in .sops.yaml)

## Phase 9 — Security Assertions and Boot Watchdog
- [x] Task 9.1 — Harden security assertion module (REPAIRED: All assertions converted to warnings per user mandate)
- [x] Task 9.2 — Add port 8080 assertion (REPAIRED: Added as warning in ports.nix)
- [x] Task 9.3 — Implement boot-time health check (Verified: boot-watchdog.nix active)

## Phase 10 — Hardening & Registry (v6.1)
- [x] Task 10.1 — Execute blocked parametrizations (WireGuard IPs, Homepage Domain, Matrix Path, Caddy Zones, RestartSec) (Verified)
- [x] Task 10.2 — Design Central String Registry (Created docs/specs/CENTRAL_REGISTRY.md)
- [x] Task 10.3 — Verification of hardcoded IP 192.168.2.46 (Confirmed zero occurrences)
- [x] Task 10.4 — Verification of zone string "admin-hangar" (Confirmed zero occurrences in code)

## 🛠️ REMAINING WORK / NEXT STEPS

### 1. Stability & Supply Chain (flake.nix)
- [x] **Task 11.1 — NixOS Version Management:** Set `nixpkgs` and `home-manager` to `25.11` (Current Stable). (Verified via endoflife.date)
- [x] **Task 11.2 — Input Tracking:** Add `follows = "nixpkgs"` to `mcp-nixos` input. (Verified)
- [x] **Task 11.3 — Parametric myLib:** Refactor `flake.nix` to instantiate `myLib` without hardcoded `x86_64-linux`. (Verified)

### 2. Manual Hardware Finalization (USER ACTION REQUIRED)
- [ ] **Task 12.1 — EFI Cleanup:** Use `efibootmgr` to remove obsolete Lanzaboote/UKI entries.
- [ ] **Task 12.2 — TPM2 Enrollment:** Run `systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7` for LUKS binding.
- [ ] **Task 12.3 — Final Boot Test:** Verify watchdog health check post-rebuild.

### 3. Maintenance & Documentation
- [x] **Task 13.1 — Git Hygiene:** Add `__temp_*` and `*.bat` to `.gitignore`. (Verified)
- [ ] **Task 13.2 — Service Inventory:** Script automated generation of `docs/service-inventory.md` from `services-spec.nix`.
- [ ] **Task 13.3 — Central Registry Implementation:** Move constants to `repo_v5/modules/core/registry.nix`.
- [ ] **Task 13.4 — NIXMETA Rollout:** Annotate all modules with machine-readable headers.


## BLOCKERS
None.