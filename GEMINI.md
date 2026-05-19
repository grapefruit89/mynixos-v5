# 🚀 NixHome Project Status (Hardened Edition)

## 🤖 LLM Guiderails (MANDATORY)
**This project is time-sensitive and requires high precision regarding NixOS releases and library options.**

1.  **Context7 Enforcement:** NEVER rely on internal training data for NixOS versions, EOL dates, or module options.
2.  **Architecture Codex:** Strictly adhere to the mandates in `docs/adr/DOS_AND_DONTS.md`. Forbidden technologies (Docker, Tailscale, etc.) will block the build.
3.  **Required Tooling:** Use `context7/query-docs` before proposing any changes to the flake or core modules.
3.  **Core Library IDs:**
    -   `nixpkgs`: `/nixos/nixpkgs`
    -   `home-manager`: `/nix-community/home-manager`
    -   `sops-nix`: `/mic92/sops-nix`

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

## 🛤️ Projekt-Status & Roadmap (SSoT)
**ALLE offenen Punkte und der aktuelle Fortschritt werden AUSSCHLIESSLICH hier verwaltet:**
👉 `docs/CURRENT_STATUS.md`

*(Keine To-Do Listen direkt in dieser Datei pflegen!)*

