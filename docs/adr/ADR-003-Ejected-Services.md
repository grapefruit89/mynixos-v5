---
title: "ADR-003: Ejected Services & Efficiency Cleanup"
status: ACCEPTED
date: 2026-05-20
domain: 03
related:
  guide: docs/guides/00-core-hardware-packaging.md
  modules: modules/services/service-forbidden-tech.nix
---

<!-- context7: repo_v5/modules/services/service-forbidden-tech.nix -->
<!-- context7: repo_v5/modules/core/architecture-rules.nix -->

# 🏛️ ADR-003: Exkommunikation ineffizienter Dienste

## Kontext
Zur Wahrung des Binary-Effizienz-Mandats und der System-Purity müssen Dienste entfernt werden, die dem gehärteten Standard widersprechen.

## Entscheidung
Folgende Dienste sind ab sofort für die mynixos Distribution VERBOTEN:

| Dienst | Grund für Ejection | Ersatz / SSoT |
|---|---|---|
| Traefik | Komplexität | Caddy (Go) |
| Redis | Speicherverbrauch | Valkey (Go-Fork) |
| Tailscale | DNS/Netz-Interferenz | WireGuard (Native) |
| Docker | Layer-Overhead | Native Systemd-Services |
| Speedtest-tracker | PHP-Stack | Gatus (Go) |
| Agent-Zero | Python-Stack | Gemini-CLI / Native Tools |

## Umsetzung in Nix
Die Durchsetzung erfolgt über harte Build-Time Assertions in:
- `modules/services/service-forbidden-tech.nix`
- `modules/core/architecture-rules.nix`

## Verifizierung
```bash
# Versuche einen verbotenen Dienst zu aktivieren (nur Dry-Run, kein echter Build)
nix eval .#nixosConfigurations.nixhome.config.assertions --apply 'builtins.map (a: a.message)' --override-input nixpkgs github:NixOS/nixpkgs/nixos-unstable || true
```
