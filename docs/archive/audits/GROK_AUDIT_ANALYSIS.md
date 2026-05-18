# NixHome v6.1: Consolidated Grok Audit & Architectural Analysis

**Date:** 2026-05-11
**Status:** REFERENCE DOCUMENT
**Source:** Grok Audit v2 + AI Assistant Analysis

---

## 1. Executive Summary Table
| Priorität | Bereich | Maßnahme | Risiko bei Nichtumsetzung | Status (NixHome v6.1) |
| --- | --- | --- | --- | --- |
| ⭐⭐⭐ | Firewall | nftables/iptables aktivieren und alle exponierten Ports schützen. | Offene Ports → Angriffsvektor. | **DONE** (Zero-Trust Outbound + GeoIP) |
| ⭐⭐⭐ | Fail2Ban | SSH, Caddy, PostgreSQL konfigurieren. | Brute-Force-Angriffe. | **DONE** (Jails active) |
| ⭐⭐⭐ | SSH-Härtung | PasswordAuth no, ed25519-sk only. | Einfallstor für Angreifer. | **DONE** (YubiKey required) |
| ⭐⭐ | PostgreSQL | Nur 127.0.0.1, SCRAM erzwingen. | DB-Kompromittierung. | **DONE** (Unix Socket Only) |
| ⭐⭐ | Caddy | TLS 1.3, automatische Zertifikate. | MITM-Angriffe. | **DONE** (DNS-01/Let's Encrypt) |
| ⭐⭐ | Kernel | sysctl-Hardening. | Kernel-Exploits. | **DONE** (Titanium Hardening) |
| ⭐ | Secrets | Offline-Backup der age-Keys. | Totalverlust bei HW-Ausfall. | **DONE** (Strategy S-01) |
| ⭐ | Benutzer | Sudo minimieren, SSH-Keys via SOPS. | Privilege Escalation. | **DONE** (NMS Standard) |

---

## 2. Grok Audit: Critical Issues (Historical Context)

### 1. Caddy module corruption (FIXED)
- **Issue:** Duplicate blocks and garbled EOF markers in `caddy.nix`.
- **Resolution:** Replaced with failsafe, truncated configuration.

### 2. Missing /nix persistence (FIXED)
- **Issue:** `impermanence.nix` lacked explicit store handling.
- **Resolution:** Verified `/nix` persistence and added `/home/moritz`.

### 3. Kernel + Hardware mismatch (FIXED)
- **Issue:** Risk of i915 (QuickSync) failure due to aggressive blacklisting.
- **Resolution:** Refined `kernel-hardening.nix` with explicit hardware-driven whitelists.

---

## 3. Architectural Highlights

### Three-Zone Model
- **Zones:** `loopback`, `admin-hangar`, `family-pocketid`, `public`.
- **Enforcement:** Enforced via `services-spec.nix` and Caddy `admin_auth`/`family_auth` snippets.

### Zero-Trust Outbound
- **Mechanism:** `nftables` output default-drop with `skuid` whitelisting per UID registry (2000-2999).
- **Isolation:** Explicit allows only for Caddy, arr-stack, and monitoring.

### SOPS Multi-Key Strategy (Decision S-01)
- **Encryption:** Multi-recipient (Server + Admin + Recovery).
- **Validation:** Weekly `sops-recovery-validation` systemd timer.
- **Runbook:** `docs/BOOTSTRAP_RECOVERY.md` created.

---

## 4. Advanced Defensive Layer (Aviation-Grade)

### Layer 0: nftables
- GeoIP Allowlist (DE, AT, CH, LT).
- Datacenter/Hosting Blocklist (Silent DROP).
- Rate Limiting on Port 443.

### Layer 1: Caddy (Hardened)
- Strict Subdomain Whitelist.
- Catch-All -> Immediate 444 (Connection Closed).
- 10s Tarpit for high-value bad paths (e.g., `/.env`).

### Layer 2: fail2ban
- `bad-subdomain` Jail: 5 hits in 8m -> 6h ban.
- `pocketid-brute` Jail: 8 failed attempts in 10m -> 12h ban.

---

## 5. Remaining Technical Debt
- ~~**Task 10.1:** Downgrade `nixpkgs` to `25.05` for stability.~~ (Note: NixOS 25.11 is the current stable release and the final target.)
- [ ] **Task 10.2:** Add `follows = "nixpkgs"` to `mcp-nixos` input.
- [ ] **Task 10.3:** Parametric `myLib` instantiation in `flake.nix`.
- [ ] **Task 11.1:** EFI Cleanup (`efibootmgr`).
- [ ] **Task 11.2:** TPM2 Enrollment for LUKS.

---
*Note: This document summarizes the transition from NixHome v5.0 to a hardened v6.1 architecture.*
