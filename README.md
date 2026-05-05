# NixHome

NixOS-based homelab configuration utilizing a **Horizontal Responsibility (v5.0)** architecture. This repository provides a modular, reproducible, and hardened infrastructure for personal services and data management.

## Key Features

- **Horizontal Responsibility (v5.0):** Strict separation of concerns across hardware, users, and service modules.
- **Impermanence:** Root filesystem reset on every boot using `impermanence` and ZFS snapshots (or Btrfs subvolumes).
- **Hardened Security:** 
  - Restrictive systemd sandboxing for all services.
  - Titanium-hardened kernel configurations and sysctls.
  - OIDC/SSO integration via **Pocket-ID** for unified identity management.
- **Secret Management:** Secure handling of credentials via **sops-nix** with age-based encryption.
- **ABC-Tiering Storage:** Automated data movement across NVMe (Hot), SSD (Warm), and HDD (Cold) tiers with WAL-safe migration scripts.
- **Single Source of Truth (SSoT):** Centralized port registry (`ports.nix`) and domain/hardware configuration (`configs.nix`).

## Repository Structure

```text
.
├── hardware/           # Machine-specific hardware configurations
├── modules/            # Reusable NixOS modules
│   ├── apps/           # High-level applications (Vaultwarden, Linkding, etc.)
│   ├── core/           # SSoT configs (ports, networking, lib-helpers)
│   ├── security/       # Kernel hardening, SOPS, and SSO modules
│   ├── services/       # Infrastructure services (Caddy, Pocket-ID, etc.)
│   └── storage/        # Storage management and mover scripts
├── profiles/           # High-level system profiles (Server, Workstation)
└── users/              # User-specific home-manager and system configurations
```

## Getting Started

### 1. Prerequisites
- A running NixOS system with Flakes enabled.
- `age` or `gpg` keys configured for SOPS.

### 2. Secret Population
Initialize your secrets by creating a `secrets.yaml` file based on the provided template:
```bash
cp secrets.yaml.example secrets/secrets.yaml
sops secrets/secrets.yaml
```

### 3. Deployment
Apply the configuration to your local machine:
```bash
nixos-rebuild switch --flake .#your-hostname
```

## Maintenance

- **Update Modules:** `nix flake update`
- **Storage Management:** The storage mover runs periodically to balance data across tiers while respecting WAL/SHM file locks.
- **Security Audits:** Check `modules/security/security-assertions.nix` for policy compliance reports.
