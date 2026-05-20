---
title: "ADR-013: Resource Priority & Throttling"
status: ACCEPTED
date: 2026-05-20
domain: 13
related:
  guide: docs/guides/40-media-stack.md
  modules: modules/40-media/
---

<!-- context7: repo_v5/modules/apps/service-media-sabnzbd.nix -->
<!-- context7: repo_v5/modules/apps/service-media-jellyfin.nix -->

# 🏛️ ADR-013: Ressourcen-Hierarchie (Revision v2.0)

## Kontext
Wir benötigen eine Priorisierung, damit Hintergrundprozesse (Downloads/Entpacken) die Benutzererfahrung (Streaming) nicht beeinträchtigen.

## Entscheidung
Wir implementieren eine "Zwei-Klassen-Gesellschaft" auf dem Tower:
1. **First Class (A/V):** Jellyfin, Navidrome erhalten erhöhte Priorität (`Nice -10`) und direkten GPU-Zugriff.
2. **Second Class (Downloader):** SABnzbd wird gedrosselt (`CPUQuota=50%`, `Nice 19`, `IOSchedulingClass=idle`).

## Umsetzung in Nix
- **Streaming:** `modules/apps/service-media-jellyfin.nix` (systemd priority).
- **Downloads:** `modules/apps/service-media-sabnzbd.nix` (CPUQuota und IO Throttling).

## Verifizierung
```bash
# Überprüfe die CPU-Drosselung von SABnzbd
systemctl show sabnzbd.service -p CPUQuota
# Erwartetes Ergebnis: CPUQuota=50%
```