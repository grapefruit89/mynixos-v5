⚠️ ARCHIVAL DOCUMENT – This file contains architectural decisions that were later revised or reversed. Refer to docs\adr\ for the current state. DO NOT use this for implementation decisions.

# 📂 Architectural Analysis Report (Part 3) — Foundational Deep Dive
**Project:** NixHome v6.0 (Distiller)  
**Source Document:** `deepseek_export.txt` (Earliest Architectural Logs)  
**Status:** FINAL DISTILLATION  

---

## PHASE 1 — DISTILLATION

### 1. The "Horizontal Responsibility" Model (v5.0/v6.0)
- **Key Decisions:**
    - Transition from a "Layered/Dendritic" design to **Horizontal Responsibility**.
    - Decentralization of service logic: One `.nix` file per service, containing its own Caddy rules, backup logic, and ports.
    - Use of the `mkService` factory (found in `00-core/lib-helpers.nix`) to automate boilerplate (Sandboxing, Proxy, SSoT integration).
- **Risks:**
    - Inconsistency during transition (identified "Three-Class Society": High-End mediaLib services, Mid-Range mkService, and Legacy manual services like Vaultwarden).

### 2. Identity & Access (The "No-Trust" Paradigm)
- **Key Decisions:**
    - **Identity:** Absolute transition to hardware-bound keys. **Hermetic** (TPM-bound SSH) and **YubiKey** (FIDO2/LUKS) are the primary anchors.
    - **Rejection of Tailscale:** Decided against Tailscale due to platform dependency and stability issues. LAN-only access + Native VPN/WireGuard preferred.
    - **Rejection of mTLS for Admin:** mTLS deemed too complex for initial admin access (Chicken-and-Egg problem). Shift to **LAN-only + BasicAuth (bcrypt)** for Admin zone.
    - **Auth SSoT:** **Pocket ID** selected as the native, Passkey-only OIDC provider for the Family zone.
- **Risks:**
    - Single Point of Failure (IdP). If Pocket ID fails, all apps are inaccessible. Mitigation: Native fail-safe response in Caddy.

### 3. Storage & ABC-Tiering
- **Key Decisions:**
    - **ABC-Tiering:** NVMe (Tier A - DB/State), SSD (Tier B - Cache), HDD (Tier C - Bulk/Archive).
    - **HDD Silence:** Metadata caching via MergerFS (`cache.entry=3600`) and the "Ghost-Tree" protocol to keep HDDs spun down.
- **Risks:**
    - Incomplete implementation of the "Real" storage foundation in early logs (transition from Dummy to real MergerFS/Bcachefs).

### 4. System Härtung (The "Atomic Bomb" Standard)
- **Key Decisions:**
    - **Root-on-RAM:** Permanent use of `tmpfs` for `/` with `impermanence` for `/persist`.
    - **fapolicyd:** Strict application whitelisting. Only `/nix/store` and `/run/current-system` are trusted.
    - **nftables:** Zero-Trust network isolation per service UID (`meta skuid`).
    - **Kernel Härtung:** Use of `linuxPackages_hardened`, `security.lockKernelModules`, and blacklisting of old filesystems.
- **Risks:**
    - Development friction. Mitigation: Isolated "Development VMs" (libvirt) that are not hardened.

---

## PHASE 2 — MASTER TODO LIST

| ID | PRIORITY | CATEGORY | TASK DESCRIPTION | SOURCE | EFFORT |
|:---|:---:|:---|:---|:---|:---:|
| **CA-01** | **P0** | **SECURITY** | Fix Path Traversal in `/delete` endpoint of `ca-server.py`. | deepseek_export.txt | S |
| **CA-02** | **P0** | **SECURITY** | Implement strict Name Sanitization for CSR imports in `ca-server.py`. | deepseek_export.txt | S |
| **ST-01** | **P1** | **STORAGE** | Finalize `20-infrastructure/storage.nix` (Real MergerFS/ABC-Tiering). | deepseek_export.txt | M |
| **ID-01** | **P1** | **IDENTITY** | Deploy `Pocket ID` as a native NixOS service (no Docker). | deepseek_export.txt | M |
| **ID-02** | **P1** | **IDENTITY** | Setup `Hermetic` for hardware-bound SSH keys. | deepseek_export.txt | S |
| **FW-01** | **P2** | **NETWORK** | Implement UID-based nftables rules for all services. | deepseek_export.txt | L |
| **HP-01** | **P2** | **ACCESS** | Deploy Honeypot Port 22 (Cowrie) — *DEFERRED*. | deepseek_export.txt | S |
| **KM-01** | **P2** | **KERNEL** | Activate `security.lockKernelModules` after verifying all boots. | deepseek_export.txt | M |
| **BC-01** | **P3** | **BACKUP** | Implement S3/Cloud-based encrypted logging (rclone + S3). | deepseek_export.txt | M |

---

## PHASE 3 — BINDING DECISIONS

1.  **Admin service authentication?** → LAN-only + BasicAuth (bcrypt).
2.  **Admin private key location?** → TPM (Hardware-bound via Hermetic).
3.  **Client cert issuance?** → TPM-attested CSRs signed by internal CA (fix RCEs first).
4.  **CA portal protection?** → LAN-only + BasicAuth (unifying with Admin zone).
5.  **Zone isolation method at OS level?** → nftables (`meta skuid`) + systemd namespaces.
6.  **Secure Boot status and reasoning?** → **ENABLED** (via Lanzaboote/UKI) for "Aviation-Grade" chain of trust.
7.  **LUKS unlock method and PCRs?** → TPM 2.0 (systemd-cryptenroll). PCRs 0, 2, 7, 9 (including UKI).
8.  **SOPS recovery path?** → Master-Key on YubiKey (offline).
9.  **Service definition method?** → **Spec-driven** via `mkService` factory in `00-core`.
10. **Docker Status?** → **REJECTED.** All services must be NixOS-native.

---
**Report compiled by Senior NixOS SRE Auditor.**
*End of Part 3.*
