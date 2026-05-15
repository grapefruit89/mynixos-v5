# NixHome v6.0 Implementation State (Strict Audit Mode)

## Phase 0 — Make It Build and Boot
- [ ] Task 0.1 — Eliminate the flat-layout boot blocker
- [ ] Task 0.2 — Resolve the dual mkForce on fileSystems."/"
- [ ] Task 0.3 — Fix the nvme initrd boot-blocker
- [ ] Task 0.4 — Fix the ca-server.nix syntax error

## Phase 1 — Eradicate Rejected Concepts
- [ ] Task 1.1 — Complete Tailscale eradication
- [ ] Task 1.2 — OliveTin eradication
- [ ] Task 1.3 — CA server eradication
- [ ] Task 1.4 — mTLS reference cleanup
- [ ] Task 1.5 — Cloudflared tunnel deletion
- [ ] Task 1.6 — Auto-locale simplification

## Phase 2 — Fix the Persistence Model
- [ ] Task 2.1 — Audit and complete the persistence list
- [ ] Task 2.2 — Resolve the stateDir path problem
- [ ] Task 2.3 — SOPS key path validation
- [ ] Task 2.4 — Add /home/moritz to persistence

## Phase 3 — Three-Zone Gateway Implementation
- [ ] Task 3.1 — Resolve Pocket-ID TCP configuration
- [ ] Task 3.2 — Create the `admin_only` Caddy snippet
- [ ] Task 3.3 — Create the `family_auth` snippet
- [ ] Task 3.4 — Apply zone assignments to all virtualHosts
- [ ] Task 3.5 — Pocket-ID special virtualHost configuration
- [ ] Task 3.6 — Move Caddy admin API to Unix socket
- [ ] Task 3.7 — Apply explicit Caddy systemd hardening
- [ ] Task 3.8 — Fix Caddy JSON logging for fail2ban
- [ ] Task 3.9 — Document SSH tunnel remote admin procedure

## Phase 4 — Blocky DNS
- [ ] Task 4.1 — Create `modules/services/blocky.nix`
- [ ] Task 4.2 — Reconfigure `systemd-resolved` to use Blocky
- [ ] Task 4.3 — Remove AdGuard Home default
- [ ] Task 4.4 — Add Blocky-specific allowlist for nftables outbound

## Phase 5 — Kernel Hardening Module
- [ ] Task 5.1 — Delete `kernel-slim.nix`
- [ ] Task 5.2 — Modify `hardened-core.nix`
- [ ] Task 5.3 — Create `modules/core/kernel-hardening.nix`
- [ ] Task 5.4 — Validate thunderbolt and IPMI

## Phase 6 — mkService Factory and UID Registry Repair
- [ ] Task 6.1 — Create the UID registry
- [ ] Task 6.2 — Fix factory PostgreSQL socket bind-mount
- [ ] Task 6.3 — Fix factory socket directory creation
- [ ] Task 6.4 — Fix MemoryHigh in mkStreamer

## Phase 7 — Zero-Trust Outbound
- [ ] Task 7.1 — Phase 6A: Logging Mode
- [ ] Task 7.2 — Phase 6C: Enforcement Mode

## Phase 8 — SOPS Multi-Key
- [ ] Task 8.1 — Multi-Key Setup

## Phase 9 — Security Assertions and Boot Watchdog
- [ ] Task 9.1 — Harden security assertion module
- [ ] Task 9.2 — Add port 8080 assertion
- [ ] Task 9.3 — Implement boot-time health check

## BLOCKERS
None.