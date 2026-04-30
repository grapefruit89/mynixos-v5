# 🚀 NixHome Project Status (Hardened Edition)

## 📌 Status
- **Architecture:** Horizontal Responsibility (v5.0)
- **Security:** Hardened Kernel & Systemd Sandboxing active.
- **SSO:** Pocket-ID enforced for all services (no IP-bypasses).
- **Storage:** ABC-Tiering (NVMe/SSD/HDD) with WAL-safe mover.
- **Polish:** Marketing fluff (Aviation-Grade/Titanium) removed for professional clarity.

## 🛠️ Key SSoT Files
- `modules/core/ports.nix` – Central Port Registry
- `modules/core/configs.nix` – Domain & Hardware Profile
- `modules/core/lib-helpers.nix` – Hardened Service Factories (`mkService`, `mkHardenedService`)
- `modules/core/defaults.nix` – Centralized sysctls and swappiness
- `modules/security/hardened-core.nix` – Kernel hardening & sandboxing

## ✅ Recently Completed
- [x] **SSO Enforcement:** Removed Tailscale bypass in Homepage.
- [x] **Registration Lock:** Disabled public registration in Pocket-ID.
- [x] **Port Collision Resolution:** Pocket-ID (8089), AdGuard (3004), etc.
- [x] **Storage Safety:** Hardened Storage-Mover with WAL/SHM exclusions.
- [x] **Jellyfin Optimization:** 2GB RAM-transcode disk (tmpfs).
- [x] **Fluff Removal:** Systematic elimination of "Aviation-Grade" terminology.

## 🛤️ Next Steps
- [ ] Fill `secrets.yaml` using `secrets.yaml.example` as a template.
- [ ] Verify backup integrity on `/persist`.
- [ ] Fine-tune IPv6 geoblocking sets.
