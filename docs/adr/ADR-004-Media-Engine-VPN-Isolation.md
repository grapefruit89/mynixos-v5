---
title: "ADR-004: Media Engine & VPN Isolation Standard"
status: ACCEPTED
date: 2026-05-20
domain: 04
related:
  guide: docs/guides/40-media-stack.md
  modules: modules/services/vpn-confinement.nix
---

<!-- context7: repo_v5/modules/services/vpn-confinement.nix -->

# 🏛️ ADR-004: Die mynixos Media Engine

## Kontext
Wir implementieren den Medien-Stack (Layer 40). Wir wollen die Sicherheit von `nixarr` und die Performance von `nixflix`, aber ohne deren architektonische Altlasten.

## Entscheidung
Wir implementieren eine "Hybrid-Engine":
1.  **VPN-Isolation:** Wir nutzen das Namespace-Pattern via `vpn-confinement.nix` (Native NixOS netns).
2.  **Hardware:** Wir nutzen QuickSync Optimierungen (iHD Driver) via `hardware-configuration.nix`.
3.  **Struktur:** Wir nutzen das **mynixos v7.1 Flat-Dendritic Pattern** in `_arr-factory.nix`.

## Umsetzung in Nix
- **Netzwerk:** `modules/services/vpn-confinement.nix` (Erstellung der netns).
- **Services:** `modules/apps/_arr-factory.nix` (Factory-Pattern für isolierte Dienste).
- **GPU:** `modules/core/hardware-configuration.nix` (VA-API/QuickSync).

## Verifizierung
```bash
# Prüfe ob der Download-Client im VPN-Namespace läuft
ip netns exec vpn curl ifconfig.me
# Sollte die IP des VPN-Providers zurückgeben, nicht die lokale ISP-IP.
```