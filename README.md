# NixHome v6.0 — Aviation-Grade Homelab

[![NixOS Stable](https://img.shields.io/badge/NixOS-25.11-blue.svg?style=flat-square&logo=nixos)](https://nixos.org)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-blue.svg?style=flat-square&logo=nixos)](https://nixos.wiki/wiki/Flakes)
[![sops-nix](https://img.shields.io/badge/Secrets-sops--nix-red.svg?style=flat-square)](https://github.com/Mic92/sops-nix)
[![TPM 2.0](https://img.shields.io/badge/Security-TPM%202.0-green.svg?style=flat-square)](https://en.wikipedia.org/wiki/Trusted_Platform_Module)
[![nftables](https://img.shields.io/badge/Firewall-nftables-orange.svg?style=flat-square)](https://nftables.org/)
[![Impermanence](https://img.shields.io/badge/Storage-Impermanence-blueviolet.svg?style=flat-square)](https://github.com/nix-community/impermanence)
[![Hardened](https://img.shields.io/badge/Audit-Hardened-brightgreen.svg?style=flat-square)](https://github.com/grapefruit89/mynixos-v5)

## 📖 Key Documentation
- **Core Hardening:** [modules/core/HARDENING.md](./modules/core/HARDENING.md) (Networking, IPC, East-West Isolation)
- **Database & Sockets:** [modules/services/SOCKET_HARDENING.md](./modules/services/SOCKET_HARDENING.md) (Unix Sockets, TCP-Zero)
- **Services Registry:** [modules/core/SERVICES_GUIDE.md](./modules/core/SERVICES_GUIDE.md) (SSoT Logic & Trust Zones)
- **Security Blueprint:** [docs/V6_BLUEPRINT.md](./docs/V6_BLUEPRINT.md) (Trust Zones, TPM)

---

## 📖 Overview

2. **Zone 2: Admin-Hangar (Loopback Alias `127.0.0.2`)**
   - Backend-Dienste (Netdata, *arr Suite, Blocky) binden an den isolierten Alias.
   - Zugriff **nur** via Caddy von vertrauenswürdigen LAN-Quellen (Kein SSO erforderlich).
   - `nftables` blockiert jeden Zugriff auf `127.0.0.2`, der nicht von Caddy (UID 2000) stammt.

3. **Zone 3: Family-PocketID (`127.0.0.1`)**
   - Frontend-Dienste (Jellyfin, Home Assistant) binden an Standard-Loopback.
   - Zugriff via PocketID SSO (OIDC) / Forward-Auth für ALLE (LAN/WAN).

### Target Hardware
- **Model:** Fujitsu Esprimo Q958
- **Security:** TPM 2.0 (Mandatory for identity)
- **Acceleration:** Intel QuickSync (QuickSync-optimized transcoding)
- **Watchdog:** `iTCO_wdt` enabled for high availability.

---

## ✨ Key Features

### 💎 Impermanence (Stateless Root)
The system operates on a **tmpfs-on-root** manifesto. The `/` partition is a RAM-disk that is wiped on every boot. Only explicitly declared paths are persisted to the NVMe via the `impermanence` module, preventing configuration drift and ensuring a "factory-reset" state at every start.

### 💾 ABC-Tiering Storage
Data is distributed across three physical tiers with automated movement:
- **Tier A (Hot):** NVMe for databases and active configs (`/persist`).
- **Tier B (Warm):** SSD for transcode caches and active downloads (`/mnt/cache`).
- **Tier C (Cold):** HDD pool (MergerFS) for the bulk media archive (`/mnt/hdd_pool`).

### 🔑 Hermetic Identity (TPM 2.0)
Administrative SSH access is anchored to the physical **TPM 2.0** chip using `sk-ssh-ed25519`. This eliminates the need for software-based private keys and ensures that access is only possible from authorized, physical hardware.

### 🛡️ nftables Shield
A kernel-level firewall utilizing **nftables** provides:
- **Geo-IP Fencing:** Native blocking of all traffic outside DE, AT, and LT.
- **Token-Bucket Rate Limiting:** Aggressive protection against brute-force and DDoS attacks on public ports.
- **No Port 22:** Administrative access is restricted to a non-standard high port.

### 👤 Pocket-ID SSO
Centralized identity management via **Pocket-ID (OIDC)**. Supports Passkey-only authentication for a passwordless, secure login experience across the entire web-suite via Caddy's `forward_auth`.

### 📺 Media Stack Segmentation
High-risk media services (Sonarr, Radarr, etc.) are isolated within a dedicated **Network Namespace (`media-ns`)**. Lateral movement to the LAN or host loopback is blocked at the nftables level, ensuring that a compromise in the media stack cannot reach the system core.

### 🔒 Immutable Secrets
Secrets are managed via **sops-nix** with a strict, read-only schema. This prevents accidental mutation of secret keys and ensures that all sensitive data is injected into service environments without ever touching the Nix Store in plaintext.

### 📈 Resilient Logging & Monitoring
Logs are buffered in RAM, flushed to SSD hourly, and synchronized to **Backblaze B2** S3 storage. System health is continuously monitored by **Gatus**, with instant alerts delivered via **ntfy**.

---

## 📂 Repository Structure

```text
.
├── configuration.nix       # Primary entrypoint & imports
├── flake.nix               # Flake definition & inputs
├── services-spec.nix       # High-level service metadata
├── modules/                # Core logic & factory components
│   ├── apps/               # Application modules (Hardened Tool Stack)
│   ├── core/               # SSoT (configs, ports, registry, lib-helpers)
│   ├── security/           # TPM, Geo-IP, and nftables hardening
│   ├── services/           # Infrastructure (Caddy, Postgres, Pocket-ID)
│   ├── logging/            # Vector & S3-Sync automation
│   └── storage/            # ABC-Tiering & smart mover scripts
├── profiles/               # Mission-specific bundles (Media-Beast, etc.)
├── users/                  # Pilot (User) system & home-manager
├── hardware/               # Hardware-specific profiles (Q958)
└── secrets/                # SOPS-Nix encrypted vault & injection guide
```

---

## 🚀 Getting Started

### 1. Prerequisites
- **Hardware:** Fujitsu Q958 (or compatible x86_64) with TPM 2.0 enabled.
- **Installer:** NixOS 25.11 (or latest stable) with Flakes enabled.

### 2. Secret Population
You **MUST** populate the encrypted vault before the first rebuild.
1. `cp secrets/secrets.yaml.example secrets/secrets.yaml`
2. Fill in your credentials (API keys, hashed passwords) in `secrets.yaml`.
3. Encrypt the file: `sops --encrypt --in-place secrets/secrets.yaml`
4. For detailed instructions, see **[INJECTION_GUIDE.md](secrets/INJECTION_GUIDE.md)**.

### 3. First Deployment
Execute the rebuild from the repository root:
```bash
# Using system-native aliases:
nsw    # sudo nixos-rebuild switch --flake .#nixhome
ntest  # sudo nixos-rebuild test --flake .#nixhome
```

---

## 📊 Post-Deployment Validation

1. **Identity:** Verify SSH login requires the TPM-bound hardware key.
2. **Ingress:** Confirm Caddy serves `https://auth.nix.m7c5.de` with a valid cert.
3. **SSO:** Test login into the dashboard via Pocket-ID.
4. **Firewall:** Check `journalctl -u nftables-geoip-update` for active blocks.
5. **Isolation:** Run `ip netns exec media-ns ping 1.1.1.1` to verify namespace routing.
6. **Logs:** Verify S3 sync completion in `journalctl -u s3-log-sync`.
7. **Health:** Check the Gatus dashboard at `https://status.nix.m7c5.de`.

---

## 🛠️ Maintenance & Operations

| Task | Command | Description |
| :--- | :--- | :--- |
| **Apply Changes** | `nsw` | Rebuild and switch to the new configuration. |
| **Dry Run** | `ntest` | Build and test without switching boot entries. |
| **Update System** | `nup` | Run `nix flake update` and rebuild. |
| **Cleanup** | `nclean` | Garbage collect and optimize the Nix store. |
| **Logs** | `nlog <service>` | Follow logs for a specific systemd unit. |
| **Rollback** | `sudo nixos-rebuild switch --rollback` | Revert to the previous generation. |

---

## 🏛️ Architecture Decision Records (ADRs)

| ADR | Decision | Context / Motivation |
| :--- | :--- | :--- |
| **001** | **Impermanence** | Use tmpfs-on-root for absolute reproducibility. |
| **852** | **ABC-Tiering** | Optimize NVMe lifespan and HDD power states. |
| **044** | **No Docker** | Prefer native NixOS services for better sandboxing. |
| **220** | **Socket-First** | Disable TCP for databases; use Unix sockets only. |
| **NET** | **Segmentation** | Air-gap high-risk services via network namespaces. |
| **ID** | **TPM-Bound** | Mandatory physical hardware binding for admin access. |

---

## 📓 Technical Debt & Known Risks

- **[C-03] SOPS-Deadlock:** Tier A failure risk. *Status: Fallback prepared on Tier B.*
- **[H-07] IPv6 Parity:** Some nftables rules are IPv4-only. *Status: Migration in progress.*
- **[M-09] API Rate-Limits:** Intensive sync apps (arr-suite) may hit Caddy limits. *Status: Whitelist pending.*
- **[M-10] File Access:**SFTP is currently the only remote access. *Status: WebDAV/SMB evaluation.*

---

## 🛤️ Status & Roadmap

- **Current Version:** `v6.0-stable`
- **Audit-Status:** Deep-Audit complete (May 2026).
- **Next Milestones:**
  - [ ] Automated PCR policy updates for Secure Boot.
  - [ ] Implementation of short-lived administrative certificates.
  - [ ] Full HDD silence protocol (Spin-down optimization).

---

## ⚖️ License
Distributed under the MIT License. See `LICENSE` for more information.

*“Aviation-Grade Homelab: Because your data deserves a flight-rated infrastructure.”*
