---
title: "Media Stack (Domain 40)"
domain: 40
related:
  adr: docs/adr/ADR-018-Media-Stack-Architecture.md
  modules: modules/40-media/
---

# 🎬 Media Stack (Domain 40)

> Siehe auch [ADR-018](../adr/ADR-018-Media-Stack-Architecture.md) für die Architekturentscheidungen und [modules/40-media/](../../modules/40-media/) für die Umsetzung.

## 🚫 Protocol Constraints (Anti-Patterns)
- **Verboten:** Die SceneNZBs REST v1 API (`/api/v1/...`) für Prowlarr verwenden.
- **Erlaubt:** Nur die Newznab-API (`?t=search&cat=...`) für Prowlarr.
- **Begründung:** Prowlarr spricht ausschließlich Newznab/Torznab. REST v1 ist inkompatibel.

## Architektur
Der Stack ist in vier Layer unterteilt:
1. **Discovery** (Jellyseerr)
2. **Arr-Stack** (Radarr, Sonarr, Prowlarr, Lidarr, Readarr)
3. **Downloads** (SABnzbd, Recyclarr)
4. **Streaming** (Jellyfin, Navidrome, Audiobookshelf)
