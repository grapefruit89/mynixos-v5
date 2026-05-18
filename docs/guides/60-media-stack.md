---
title: 60-media-stack
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/apps/service-media-jellyfin.nix
    anchor: quicksync-mastery
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-media-jellyfin.nix
  - path: modules/apps/service-media-jellyfin.nix
    anchor: jellyfin-transcode
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-media-jellyfin.nix
  - path: modules/apps/service-app-navidrome.nix
    anchor: navidrome-streaming
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-navidrome.nix
  - path: modules/apps/service-app-audiobookshelf.nix
    anchor: abs-library
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-audiobookshelf.nix
  - path: modules/apps/_arr-factory.nix
    anchor: arr-tiering
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/_arr-factory.nix
---

# Cluster 60: Media Stack

Dieses Dokument beschreibt die hochperformante Medien-Architektur von mynixos. Wir nutzen Hardware-Beschleunigung und intelligentes Tiering, um ein "Aviation-Grade" Streaming-Erlebnis zu gewährleisten.

---

## 🎬 Video: Jellyfin (anchor: quicksync-mastery)

Jellyfin ist unser primärer Video-Streaming-Server. Auf dem Fujitsu Q958 nutzen wir Intel QuickSync (iHD), um 4K-Transcoding mit minimaler CPU-Last (~2%) zu ermöglichen.

- **Hardware-Zugriff**: Erfolgt über `/dev/dri/renderD128`.
- **Transcoding-Cache** (anchor: jellyfin-transcode): Wir nutzen eine 2GB RAM-Disk (`tmpfs`), um HDD-Spinups während des Streamings zu vermeiden und die Latenz zu minimieren.
- **Konfiguration**: `modules/apps/service-media-jellyfin.nix`.

---

## 🎵 Audio: Navidrome & Audiobookshelf

### 🎶 Navidrome (anchor: navidrome-streaming)
Hocheffizienter Musik-Server mit Subsonic-API Support.
- **Vorteil**: Extrem niedriger RAM-Footprint im Vergleich zu Jellyfin.
- **Konfiguration**: `modules/apps/service-app-navidrome.nix`.

### 📚 Audiobookshelf (anchor: abs-library)
Spezialisierter Server für Hörbücher und Podcasts.
- **Identity**: Volle Pocket-ID Integration via OIDC (siehe Cluster 50).
- **Pfad-Strategie**: Nutzt Tier A für Metadaten und Tier C für die Medien-Bibliothek.

---

## 🤖 Automation: Der Arr-Stack (anchor: arr-tiering)

Die Automatisierung (Sonarr, Radarr, Prowlarr) basiert auf einer zentralen Factory (`modules/apps/_arr-factory.nix`).

- **ABC-Tiering**: Datenbanken liegen auf Tier A (NVMe), während der Cover-Cache auf Tier B (SSD) ausgelagert wird.
- **Sandboxing**: Alle Dienste laufen in isolierten Systemd-Units mit eingeschränktem Dateisystem-Zugriff.
- **Downloader**: SABnzbd agiert als hocheffizienter Usenet-Motor, geschützt durch VPN-Namespacing.

---

## ✅ Verifizierung

```bash
# 1. Prüfe Hardware-Beschleunigung (Jellyfin)
intel_gpu_top # Erwartet Aktivität im Video-Engine während des Transcodings

# 2. Prüfe RAM-Disk Mount für Transcoding
df -h | grep jellyfin-transcode

# 3. Teste Navidrome Ping-API (Subsonic)
curl -s "http://127.0.0.1:4533/rest/ping.view?u=user&p=pass&v=1.12.0&c=test"

# 4. Prüfe Status des Arr-Stacks
systemctl status sonarr radarr prowlarr sabnzbd
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [jellyfin/jellyfin](https://github.com/jellyfin/jellyfin) - Video Streaming
- [navidrome/navidrome](https://github.com/navidrome/navidrome) - Music Server
- [advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf) - Audiobooks

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-media-jellyfin.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-navidrome.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/_arr-factory.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/apps/service-media-jellyfin.nix -->
<!-- mcp: repo_v5/modules/apps/service-app-navidrome.nix -->
<!-- mcp: repo_v5/modules/apps/service-app-audiobookshelf.nix -->
<!-- mcp: repo_v5/modules/apps/_arr-factory.nix -->
