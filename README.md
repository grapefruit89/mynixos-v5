# NixHome v6.0 (Aviation-Grade)

NixOS-based homelab configuration utilizing a **Horizontal Responsibility (v6.0)** architecture. This repository provides a modular, reproducible, and titanium-hardened infrastructure for personal services, AI-workloads, and data management.

## 🚀 Key Features

- **Horizontal Responsibility (v6.0):** Strict separation of concerns across hardware, users, and service modules.
- **Deep SRE Audit (v6.0):** Entire core audited and optimized with Nix MCP and Context7 for maximum stability.
- **Impermanence:** Stateless root-on-RAM (tmpfs) setup. Root filesystem is wiped on every boot.
- **Titanium Security:** 
  - **Hermetic Identity:** Mandatory hardware binding via TPM 2.0 (`sk-ssh-ed25519`).
  - **nftables Shield:** Geo-IP fencing (DE, AT, LT) and Token-Bucket rate limiting on kernel level.
  - **DDoS Protection:** 3-Stage Caddy shield with JS-Challenges and SSO-Ingress.
  - **Immutable Secrets:** Schema-driven, read-only secret mapping via `sops-nix`.
- **Resilient Logging:** RAM-buffered logs with SSD flushing and hourly S3 synchronization to Backblaze B2.
- **ABC-Tiering Storage:** Automated data movement across NVMe (Hot), SSD (Warm), and HDD (Cold) tiers with transactional safety.

## 📂 Repository Structure

```text
.
├── modules/            # Reusable NixOS modules
│   ├── apps/           # High-level applications (Vaultwarden, Paperless, etc.)
│   ├── core/           # SSoT configs (ports, networking, lib-helpers, registry)
│   ├── security/       # TPM, Geo-IP, and Hardening modules
│   ├── services/       # Infrastructure (Caddy, Postgres, Pocket-ID, etc.)
│   ├── logging/        # Vector and S3-Sync modules
│   └── storage/        # Storage management and mover scripts
├── profiles/           # High-level system profiles (Base-Server, Media-Beast)
├── users/              # Pilot (User) system and home-manager configurations
└── secrets/            # SOPS-Nix encrypted secrets and injection guides
```

## 🛠️ Getting Started

### 1. Prerequisites
- A Fujitsu Q958 (or compatible x86_64 hardware) with TPM 2.0 enabled.
- NixOS installer with Flakes support.

### 2. Secret Population (CRITICAL)
You MUST populate the secrets before deployment. Follow the **[INJECTION_GUIDE.md](secrets/INJECTION_GUIDE.md)**:
1. `cp secrets/secrets.yaml.example secrets/secrets.yaml`
2. Fill in your hashed passwords and API keys.
3. `sops --encrypt --in-place secrets/secrets.yaml`

### 3. Deployment
Apply the configuration to your machine:
```bash
# Workflow Aliases (defined in shell-premium.nix):
nsw   # sudo nixos-rebuild switch --flake .#nixhome
ntest # sudo nixos-rebuild test --flake .#nixhome
```

## 📊 Post-Deployment Validation
After the first successful rebuild, verify the following:
- [ ] **SSH:** Login works with TPM-bound hardware key.
- [ ] **Firewall:** Geo-IP block is active (`journalctl -u nftables`).
- [ ] **Logs:** Check Backblaze bucket for synced logs after 1 hour.
- [ ] **Services:** Verify `check-services` (Shell-Alias) shows all critical units as active.

---
*Status: v6.0-stable | Audit-Grade: Aviation | Security: Hardened*
