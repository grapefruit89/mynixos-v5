# NixHome v7.1 — gehärtet

[![NixOS Stable](https://img.shields.io/badge/NixOS-25.11-blue.svg?style=flat-square&logo=nixos)](https://nixos.org)
[![Security](https://img.shields.io/badge/Security-Hardened-brightgreen.svg?style=flat-square)](./docs/adr/README.md)
[![Status](https://img.shields.io/badge/Status-Hardened-blue.svg?style=flat-square)](./docs CURRENT_STATUS.md)
[![TOS-Compliant](https://img.shields.io/badge/Cloudflare-DNS--Only-orange.svg?style=flat-square)](./docs/adr/ADR-017-Cloudflare-DNS-Only.md)

## 📖 Key Documentation (SSoT)
- **Architecture Manifesto:** [GEMINI.md](./GEMINI.md) (The project's primary map and developer guide)
- **Current Status:** [docs/CURRENT_STATUS.md](./docs/CURRENT_STATUS.md) (Live roadmap and task tracking)
- **Provenance:** [SOURCES.md](./SOURCES.md) (Zero-Trust origin tracking for all code/concepts)
- **Anti-Patterns:** [docs/ANTIPATTERN.md](./docs/ANTIPATTERN.md) (Rejected technologies and patterns)

---

## 🏛️ Architecture Decisions (ADRs)
- **ADR-017:** [Cloudflare DNS-Only Mandate](./docs/adr/ADR-017-Cloudflare-DNS-Only.md) (TOS compliance for media streaming)
- **ADR-010:** [Headless Server Law](./docs/adr/ADR-010-Headless-Server-Law.md) (Strict No-GUI policy)
- **ADR-014:** [Systemic Governance](./docs/adr/ADR-014-Systemic-Governance.md) (Purity & Purity Mandate)
- **Complete Index:** [docs/adr/README.md](./docs/adr/README.md)

---

## 🚀 Deployment (Fujitsu Q958)

### 1. Pre-flight Checks
- **TPM 2.0:** Ensure TPM is enabled in BIOS.
- **Boot:** UEFI Only. Secure Boot disabled.
- **Partitioning:** Follow [hardware/q958/PROVISIONING.md](./hardware/q958/PROVISIONING.md) for ABC-tiering setup.

### 2. Installation
```bash
# Verify disk labels (NIXBOOT, NIXSTORE, NIXPERSIST)
nixos-install --flake .#nixhome
```

### 3. Post-Install Security
```bash
# Enroll LUKS keys into TPM
./scripts/setup-luks-tpm.sh

# Run CVE Audit
./scripts/audit-cves.sh
```

---

## ✨ Key Features (v7.1)

### 💎 Impermanence (Stateless Root)
The system operates on a **tmpfs-on-root** manifesto. The `/` partition is a RAM-disk that is wiped on every boot. Only explicitly declared paths are persisted to the NVMe via the `impermanence` module, preventing configuration drift and ensuring a "factory-reset" state at every start.

### 💾 ABC-Tiering Storage
Data is distributed across three physical tiers with automated movement:
- **Tier A (Hot):** NVMe for databases and active configs (`/persist`).
- **Tier B (Warm):** SSD for apps and active downloads (`/mnt/data`).
- **Tier C (Cold):** HDD pool for the bulk media archive (`/mnt/media`).

### 🌐 Cloudflare DNS-Only
To ensure compliance with Cloudflare's Terms of Service for media streaming, this project uses Cloudflare **exclusively as a DNS resolver** (Gray Cloud). All Geo-blocking and Rate-limiting are implemented at the kernel level (nftables) and application gateway (Caddy).

### 🔒 Hardening
- **Kernel:** Extensive module blacklisting and sysctl hardening inspired by `nix-mineral` and `security_harden_linux`.
- **Ingress:** Caddy gateway with automated vHost generation, Forward-Auth (Pocket-ID), and bot-mitigation rate limits.
- **Outbound:** Strict nftables output filtering (KRIT-01) allowing only whitelisted service UIDs.

---

## 📂 Repository Structure (Flattened)
```text
.
├── configuration.nix       # Horizontal entrypoint
├── flake.nix               # Primary Flake definition
├── GEMINI.md               # SSoT Map & Developer Guide
├── hardware/               # Hardware profiles (Q958)
├── modules/                # Flattened functional modules
├── profiles/               # Mission profiles (Hardened, Media, etc.)
├── scripts/                # Consolidated maintenance & audit tools
├── secrets/                # SOPS vault & Injection guides
└── users/                  # Pilot (User) definitions
```

---

*Status: gehärtet | Letzte Aktualisierung: 19. Mai 2026*
