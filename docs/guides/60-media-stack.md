# 🎬 Cluster 60: Media Stack

Dieses Dokument konsolidiert alle Informationen zum Media-Stack in mynixos, einschließlich Audio-Streaming (Navidrome, Audiobookshelf), Video-Streaming (Jellyfin) und Download-Management (SABnzbd, ARR-Stack).

### Inhalt aus `GUIDE-Audio-Mastery-Navidrome.md`

---
title: 🎵 Navidrome Audio Mastery (Layer 40-media)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [music-streaming, go-performance, subsonic-api, lightweight-audio]
sources: [https://www.navidrome.org/, official nixpkgs modules]
---

# 🎵 Navidrome: Deine private Musik-Cloud

In mynixos nutzen wir Navidrome als hochperformanten Musik-Server. Er schlägt Jellyfin im Bereich Audio durch minimalen Ressourcenverbrauch.

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Sprache:** Go (Binary-Mandat erfüllt). ✅
2.  **Datenbank:** SQLite (Eingebettet). ✅
3.  **Transcoding:** On-the-fly Umwandlung via ffmpeg (QuickSync ready).

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/40-media/navidrome.nix`):

```nix
services.navidrome = {
  enable = true;
  settings = {
    Address = "127.0.0.1";
    Port = 4533;
    MusicFolder = "/mnt/storage/media/music";
    DataFolder = "/persist/var/lib/navidrome";
    LogLevel = "info";
    ScanSchedule = "@every 1h";
  };
};
```

## 🛡️ SRE-Hardening
- **Ingress:** Sicherung via Caddy über `music.m7c5.de`.
- **Identity:** Navidrome unterstützt zwar kein direktes OIDC, wir sichern den Zugang jedoch via Tailscale-Auth oder Caddy-Forward-Auth.

### Inhalt aus `GUIDE-Audiobookshelf-Mastery.md`

---
title: 📚 Audiobookshelf Mastery (Layer 40-media)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [audiobook-streaming, podcast-management, oidc-identity, mobile-sync]
sources: [https://github.com/advplyr/audiobookshelf, official nixpkgs modules]
---

# 📚 Audiobookshelf: Deine private Bibliothek

In mynixos ist Audiobookshelf der Standard für Hörbücher und Podcasts. Wir nutzen die native NixOS-Integration für maximale Stabilität.

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Datenbank:** Nutzt eine interne Datenbank (SQLite-basiert für Metadaten). ✅
2.  **Transcoding:** Greift auf systemweite ffmpeg-Binaries zu.
3.  **Identity:** Volle **PocketID** Integration via OIDC.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/40-media/audiobookshelf.nix`):

```nix
services.audiobookshelf = {
  enable = true;
  port = 8000;
  # host = "127.0.0.1"; # Nur Lokal + Caddy
};

# Wir injizieren die Secrets via systemd
systemd.services.audiobookshelf.serviceConfig = {
  EnvironmentFile = config.sops.secrets."abs/env".path;
};
```

## 🛡️ SRE-Hardening
- **Ingress:** Sicherung via Caddy über `books.m7c5.de` mit mTLS.
- **Backups:** Nutzung von `BACKUP_PATH`, der direkt vom Restic-Dienst (Layer 80) erfasst wird.

### Inhalt aus `GUIDE-Media-Mastery-Jellyfin.md`

---
title: 🎬 Jellyfin Media Mastery (The 2% Standard)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [ultra-efficient-transcoding, quicksync-mastery, low-load-streaming]
sources: [Internal Performance Audit, User Feedback]
---

# 🎬 Jellyfin: Aviation-Grade Streaming

Mit der korrekten Intel QuickSync (iHD) Integration erreichen wir eine beispiellose Effizienz auf dem Fujitsu Q958.

## ⚡ Der 2% Performance-Standard
Durch das Hardware-Mapping (`/dev/dri/renderD128`) wird die CPU fast vollständig entlastet.
- **Benchmark:** 4K-Transcoding verursacht lediglich ~2% CPU-Last.
- **Kapazität:** Der Tower kann problemlos >10 parallele Hardware-Transcodes bewältigen.

## ⚙️ SRE-Konfiguration
Wir erzwingen die Nutzung des `intel-media-driver` in der NixOS-Config (Kapitel 25), um diesen Standard zu garantieren.

## 🛡️ SRE-Monitoring
Die iGPU-Last wird separat via `intel_gpu_top` überwacht, da die klassische CPU-Last-Anzeige (btop/htop) die tatsächliche Transcoding-Leistung nicht widerspiegelt.

### Inhalt aus `GUIDE-SABnzbd-Master-Config.md`

---
title: 📥 SABnzbd Master-Config (Layer 40-media)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [usenet-downloader, secrets-integration, declarative-config]
sources: [https://github.com/sabnzbd/sabnzbd, official nixpkgs modules]
---

# 📥 SABnzbd: Der hocheffiziente Usenet-Motor

In mynixos nutzen wir SABnzbd als primären Downloader für den ARR-Stack.

## 🏛️ Architektur-Entscheidungen (SRE Standard)
1.  **Total Control:** Wir setzen `allowConfigWrite = false`. Einstellungen im Web-UI werden beim Neustart durch den Nix-Code überschrieben.
2.  **Sops-Secrets:** Server-Passwörter und API-Keys kommen aus `secrets/secrets.yaml`.
3.  **Efficiency:** Wir begrenzen den RAM-Cache via `settings.misc.cache_limit`.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/40-media/sabnzbd.nix`):

```nix
services.sabnzbd = {
  enable = true;
  user = "sabnzbd";
  group = "media"; # Zugriff auf Medien-Shares
  secretFiles = [ config.sops.secrets."sabnzbd/config".path ];
  settings = {
    misc = {
      host = "127.0.0.1";
      port = 8080;
      cache_limit = "256M";
    };
  };
};
```

## 🛡️ SRE-Hardening
- **Ingress:** Sicherung via Caddy über `sab.m7c5.de` mit mTLS.
- **VPN:** SABnzbd wird zwingend in den VPN-Namespace (Kapitel 19) gezwungen.

### Inhalt aus `MASTER-CONFIG-ARR-STACK.md`

---
title: 📚 ARR-Stack MASTER-CONFIG-REFERENCE (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [Sonarr, Lidarr, Prowlarr GitHub Orgs]
---

# 📚 ARR-Stack: Gemeinsame Steuer-Variablen

Alle .NET-basierten ARR-Apps folgen demselben Schema für die Initialisierung.

## 🎵 Lidarr
LIDARR_CONSOLE_PROCESS_NAME
LIDARR__LOG__CONSOLEFORMAT
LIDARR_PROCESS_NAME
LIDARR_TESTS_LOG_OUTPUT

## 📺 Sonarr
SONARR_CONSOLE_PROCESS_NAME
SONARR__LOG__CONSOLEFORMAT
SONARR_MAJOR_VERSION
SONARR_PROCESS_NAME
SONARR_TESTS_LOG_OUTPUT
SONARR_VERSION

## 🔍 Prowlarr
PROWLARR_CONSOLE_PROCESS_NAME
PROWLARR__LOG__CONSOLEFORMAT
PROWLARR_PROCESS_NAME
PROWLARR_TESTS_LOG_OUTPUT

### Inhalt aus `MASTER-CONFIG-SABNZBD.md`

---
title: 📚 SABnzbd MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [https://github.com/sabnzbd/sabnzbd (Code Extraction)]
---

# 📚 SABnzbd: Konfigurations-Referenz

AUTOMATION_GITHUB_TOKEN
CI
DISPLAY
GITHUB_REF
GITHUB_REF_NAME
HOME
MACOSX_DEPLOYMENT_TARGET
NOTARIZATION_PASS
NOTARIZATION_USER
PATHEXT
REDDIT_TOKEN
SIGNING_AUTH

## 🚀 SRE-Anwendung
SABnzbd wird in NixOS primär über `services.sabnzbd` gesteuert.

### Inhalt aus `MASTER-CONFIG-AUDIOBOOKSHELF.md`

---
title: 📚 Audiobookshelf MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [https://github.com/advplyr/audiobookshelf (Code Extraction)]
---

# 📚 Audiobookshelf: Konfigurations-Referenz

ACCESS_TOKEN_EXPIRY
ALLOW_CORS
ALLOW_IFRAME
BACKUP_PATH
CONFIG_PATH
DISABLE_SSRF_REQUEST_FILTER
EXP_PROXY_SUPPORT
FFMPEG_PATH
FFPROBE_PATH
FLVMETA_PATH
FLVTOOL2_PATH
HOST
JWT_SECRET_KEY
MAX_FAILED_EPISODE_CHECKS
METADATA_PATH
NODE_DEBUG
NODE_ENV
NUSQLITE3_PATH
OSTYPE
PATH
PATHEXT
PODCAST_DOWNLOAD_TIMEOUT
PORT
QUERY_LOGGING
QUERY_PROFILING
RATE_LIMIT_AUTH_MAX
RATE_LIMIT_AUTH_MESSAGE
RATE_LIMIT_AUTH_WINDOW
REACT_CLIENT_PATH
READABLE_STREAM
REFRESH_TOKEN_EXPIRY
ROUTER_BASE_PATH
SKIP_BINARIES_CHECK
SOURCE
SSRF_REQUEST_FILTER_WHITELIST
USE_X_ACCEL

## 🚀 SRE-Anwendung
In NixOS steuern wir ABS via `services.audiobookshelf`. Diese Variablen können via `systemd.services.audiobookshelf.environment` injiziert werden.

### Inhalt aus `MASTER-CONFIG-RADARR.md`

---
title: 📚 Radarr MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [https://github.com/Radarr/Radarr]
---

# 📚 Radarr: Konfigurations-Referenz

RADARR_CONSOLE_PROCESS_NAME
RADARR__LOG__CONSOLEFORMAT
RADARR_PROCESS_NAME
RADARR_TESTS_LOG_OUTPUT

## 🚀 SRE-Anwendung
Radarr wird in NixOS primär über `services.radarr` gesteuert.
- **Port:** Standard 7878.
- **DataDir:** Standard `/var/lib/radarr`.

### Inhalt aus `MASTER-CONFIG-SEERR.md`

---
title: 📚 Jellyseerr MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [https://github.com/seerr-team/seerr]
---

# 📚 Jellyseerr: Konfigurations-Referenz

API_KEY
CONFIG_DIRECTORY
DB_HOST
DB_NAME
DB_PASS
DB_PORT
DB_SOCKET_PATH
DB_TYPE
DB_USER
DB_USE_SSL
HOST
JELLYFIN_TYPE
LOG_LEVEL
NODE_ENV
PORT
PRESERVE_DB
TZ
WITH_MIGRATIONS

## 🚀 SRE-Anwendung
In NixOS nutzen wir für Jellyseerr oft `services.jellyseerr`. Die Variablen können wir via `systemd.services.jellyseerr.environment` injizieren.
