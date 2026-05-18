⚠️ ARCHIVAL DOCUMENT – This file contains architectural decisions that were later revised or reversed. Refer to docs\adr\ for the current state. DO NOT use this for implementation decisions.

# Architectural Analysis Report - Part 2 (Distiller/NixHome v6.0)

## PHASE 1 — DISTILLATION

### 1. Zone Model (Loopback / Admin-mTLS / Family-PocketID)
*   **Key Decisions:**
    *   **Three-Tier Ingress:**
        1.  **Loopback (UID-Filtering):** Local services talk via Unix sockets or loopback aliases (127.0.0.2) with nftables UID-based restrictions.
        2.  **Admin-mTLS:** Administrative interfaces (Cockpit, Proxmox-like UI, terminal) require mTLS with TPM-bound client certificates.
        3.  **Family-PocketID:** User-facing services (Jellyfin, Nextcloud) use Pocket-ID (OIDC) behind Caddy.
    *   **Isolation:** Public services are physically and logically separated from admin zones via Caddy snippets and nftables.
*   **Open Questions:** 
    *   How to handle mTLS in mobile browsers without complex manual certificate imports (UX vs. Security).
*   **Risks:**
    *   High complexity in debugging nftables UID-filtering for multi-user services.

### 2. mTLS & Client Certificate Lifecycle (TPM-bound keys, CSR flow)
*   **Key Decisions:**
    *   **Hardware Binding:** Administrative client certificates MUST be bound to hardware (TPM 2.0 or YubiKey).
    *   **CSR Flow:** Adoption of a "Provisioning Portal" where clients generate a CSR locally (using `tpm2-tss` or `openssl-fido`), upload it, and receive a signed certificate.
    *   **Short-Lived Certs:** Preference for short-lived certificates with automated renewal via the CA portal.
*   **Open Questions:** 
    *   Integration of `step-ca` vs. a custom Flask-based CA portal for better "one-click" UX.
*   **Risks:**
    *   TPM PCR drift causing lockout of administrative access.

### 3. CA Infrastructure
*   **Key Decisions:**
    *   **Private CA:** A standalone, non-networked (or strictly isolated) root CA.
    *   **Secrets:** CA private keys stored in SOPS-nix, encrypted with hardware-bound age keys.
    *   **Issuance:** Intermediate CA runs on the host to handle automated CSR signing for the local zone.
*   **Open Questions:** 
    *   Should the root CA live on a dedicated "Vault" machine or remain a logical partition on the main host?

### 4. Service Specification & Code Generation (services-spec.nix)
*   **Key Decisions:**
    *   **SSoT:** `services-spec.nix` is the definitive source for all service definitions, ports, and access policies.
    *   **Generators:** Nix functions automatically generate Caddy virtual hosts and nftables rules from the spec.
    *   **Template-Based:** Use of "Titanium Templates" for systemd hardening (ProtectSystem=strict, etc.) applied globally via the spec.
*   **Risks:**
    *   Over-abstraction making it hard to troubleshoot individual service failures.

### 5. Network Segmentation & East-West Isolation
*   **Key Decisions:**
    *   **Unix Sockets:** Priority for Unix Sockets for all database connections (Postgres, Valkey) to eliminate TCP overhead and attack surface.
    *   **Loopback Aliases:** Use 127.0.0.2 for administrative "internal" services to distinguish them from standard loopback traffic.
    *   **UID Filtering:** nftables prevents non-admin users/services from reaching administrative loopback ports.

### 6. Disk Encryption (LUKS + TPM/FIDO2)
*   **Key Decisions:**
    *   **Primary Unlock:** TPM 2.0 (PCR 0, 1, 4, 7) for unattended boot.
    *   **Secondary Unlock:** FIDO2 (YubiKey) for physical presence verification on sensitive volumes (/persist).
    *   **No Secure Boot:** Decision to stay with LUKS + TPM2 without Secure Boot to avoid complexity with custom NixOS kernels, relying on PCR 7 (Firmware/Secure Boot state) to detect tampering.

### 7. SOPS & Secret Recovery
*   **Key Decisions:**
    *   **Hardware PGP:** Use GPG on YubiKey for SOPS-nix encryption/decryption.
    *   **Recovery:** Physical USB backup of age keys and Bitwarden-stored emergency codes.
*   **Risks:**
    *   Loss of both YubiKeys could result in total data loss if the recovery age key is not accessible.

### 8. Operational Resilience
*   **Key Decisions:**
    *   **Boot Watchdog:** A systemd service that checks health (Caddy Port 80, Postgres) and triggers `nixos-rebuild boot --rollback` if the system is unhealthy for 120s.
    *   **Silence Protocol:** Stricter HDD spin-down rules. All system/state data must live on NVMe/SSD to allow HDDs to stay in standby 99% of the time.

### 9. Architectural Critique & v6.0 Review
*   **Key Decisions:**
    *   **Abandon Tailscale for Admin:** Transition to mTLS over WAN/LAN for admin access, removing Tailscale dependency for core management.
    *   **Stateless Root:** Implementation of `impermanence` with `/` on tmpfs (RAM) to ensure a clean state on every boot.

### 10. Storage Strategy (ABC-Tiering)
*   **Key Decisions:**
    *   **Tier A (NVMe):** Root, OS, Active Databases, Docker Images.
    *   **Tier B (SSD):** /home, App Data, Metadata (Jellyfin).
    *   **Tier C (HDD):** Large Media, Archives.
    *   **Mover Logic:** Automated scripts to move stale data from B to C.

---

## PHASE 2 — MASTER TODO LIST

| ID | PRIORITY | CATEGORY | DESCRIPTION | SOURCE | DEPENDS ON | EFFORT | ACCEPTANCE CRITERIA |
|:---|:---|:---|:---|:---|:---|:---|:---|
| T2.1 | P0 | Security | Implement TPM 2.0 LUKS unlocking with PCR 0,1,4,7 | Export 2 | - | M | System boots without password if hardware is untampered. |
| T2.2 | P0 | Infrastructure | Configure `impermanence` with `/` on tmpfs | Export 2 | T2.1 | L | System resets to clean state on reboot; `/persist` holds DBs. |
| T2.3 | P1 | Networking | Implement mTLS in Caddy for `/admin` paths | Export 2 | T2.2 | M | Access to admin UI fails without valid client cert. |
| T2.4 | P1 | Security | Configure Sudo with U2F (Touch-to-Sudo) | Export 2 | - | S | Sudo prompts for YubiKey touch. |
| T2.5 | P1 | Automation | Create `services-spec.nix` generator for nftables | Export 2 | - | L | nftables rules are auto-generated from service spec. |
| T2.6 | P2 | Hardening | Migrate Postgres/Valkey to Unix Sockets only | Export 2 | T2.5 | M | Databases no longer listen on TCP 5432/6379. |
| T2.7 | P2 | Resilience | Implement 120s Boot Watchdog with Auto-Rollback | Export 2 | - | M | Faulty update triggers automatic rollback and reboot. |
| T2.8 | P2 | Storage | Implement HDD Silence Protocol (No-Log zones) | Export 2 | T2.2 | M | HDDs spin down when not playing media. |
| T2.9 | P3 | UX | Build Flask-based CSR Provisioning Portal | Export 2 | T2.3 | L | Web-based cert issuance for authorized hardware keys. |

---

## PHASE 3 — BINDING DECISIONS

1.  **Admin service authentication?** **mTLS only.** Passwords are deprecated for administrative zones.
2.  **Admin private key location?** **TPM 2.0 (Laptop/Desktop) & YubiKey (Emergency/Mobile).**
3.  **Client cert issuance?** **Web portal (automated CSR signing) + CLI fallback.**
4.  **CA portal protection?** **mTLS-shielded.** You need an initial bootstrap cert (issued manually) to access the portal.
5.  **Zone isolation method at OS level?** **nftables UID-filtering + Loopback Aliases (127.0.0.2).**
6.  **Secure Boot status and reasoning?** **Disabled.** Complexity of custom signing outweighs benefits if PCR 7 is monitored via TPM.
7.  **LUKS unlock method and PCRs?** **TPM2 (PCR 0,1,4,7).**
8.  **SOPS recovery path?** **Offline Age keys on physical USB + Bitwarden Vault.**
9.  **Service definition method?** **Spec-driven (services-spec.nix).** Manual definitions are prohibited for standard services.
10. **Relationship between knowledge-base and repos?** **Isomorphic.** The knowledge base structure mirrors the NixOS layer structure (00, 10, 20...).

---
*Report Generated: 2026-05-07 | Status: FINALIZED*
