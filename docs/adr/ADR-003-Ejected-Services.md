---
title: ADR-003: Ejected Services & Efficiency Cleanup
status: [ACCEPTED]
category: architecture/decision
capabilities: [resource-efficiency, binary-mandate, no-legacy]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/services/service-forbidden-tech.nix
  - path: modules/core/architecture-rules.nix
    anchor: architecture-violations
sources: [User Rauswurf-Liste, GEMINI.md V2026]
---

<!-- context7: repo_v5/modules/services/service-forbidden-tech.nix -->
<!-- context7: repo_v5/modules/core/architecture-rules.nix -->

# 🏛️ ADR-003: Exkommunikation ineffizienter Dienste

## Kontext
Zur Wahrung des Binary-Effizienz-Mandats und der System-Purity müssen Dienste entfernt werden, die dem Aviation-Grade Standard widersprechen.

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
