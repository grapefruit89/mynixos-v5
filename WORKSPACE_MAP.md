# NixHome Workspace Map

## Projektwurzel
`C:\Users\morit\Documents\distiller_project\temp_mynixos`

## Kernmodule (Single Points of Truth)
- `modules/core/configs.nix` – globale Domain, IP-Bereiche, `hardware.profile`
- `modules/core/ports.nix` – zentrale Port-Registry
- `modules/core/defaults.nix` – sysctl-Defaults, Swappiness (Zentralisiert ✅)
- `modules/core/lib-helpers.nix` – Service-Fabriken (`mkService`, `mkHardenedService`)
- `modules/core/secrets.nix` – SOPS-Integration & Hostkey-Sync

## Sicherheit
- `modules/security/hardened-core.nix` – sysctls, Kernel-Blacklist, Mount-Härtung
- `modules/security/security-assertions.nix` – Policy-Modus (warn / strict)
- `modules/services/pocket-id.nix` – OIDC-Provider
- `modules/services/homepage.nix` – Dashboard (enthält SSO-Bypass!)

## Apps (Extra)
- `modules/apps/service-app-linkding.nix` – Bookmark Manager (Aktiviert ✅)
- `modules/apps/service-app-vaultwarden.nix` – Password Manager

## Storage
- `modules/storage/storage-mover.nix` – SSD→HDD Mover (WAL-Safe ✅)
- `modules/storage/deferred-ops.nix` – Deferred Deletion

## Offene kritische Issues
- **SSO-Bypass** → `homepage.nix` (Tailscale-Matcher)
- **OliveTin** → muss deaktiviert oder gehärtet werden
- **Port-Kollisionen** → 8080, 3001 (siehe `ports.nix`)

## Arbeiten ohne Subagenten
Bei jeder Sitzung:
1. `WORKSPACE_MAP.md` lesen.
2. Direkt in die genannten Dateien springen.
3. Keine `find`/`grep`-Orgien mehr.
4. Keine Subagenten starten.
