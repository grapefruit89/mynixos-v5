# NixHome

NixOS-basierte Homelab-Konfiguration (v5.0) mit horizontaler Modulstruktur, fokussiert auf Daten-Tiering und Identitätsmanagement.

## 💾 Storage-Architektur (ABC-Tiering)

Das System verteilt Daten basierend auf Latenz- und Haltbarkeitsanforderungen über drei Ebenen:

| Tier | Hardware | Mountpoint | Nutzung | Besonderheiten |
| :--- | :--- | :--- | :--- | :--- |
| **A** | NVMe | `/persist` | OS, DBs, `/data/state` | Persistent via Impermanence |
| **B** | SATA SSD | `/mnt/cache` | Incomplete Downloads, Transcodes | Schonung der NVMe-Zyklen |
| **C** | HDD Mirror | `/mnt/hdd_pool` | Bulk Media, Backups | Spindown nach 10 Min. |

### Smart Mover
Ein systemd-Service überwacht Tier B. Bei Unterschreitung von 20GB freiem Speicher werden die ältesten Dateien via `rsync --remove-source-files` nach Tier C verschoben. 
- **Sicherheitsregeln:** Datenbank-Dateien (`.wal`, `.db`, `.sqlite`) sind von der Verschiebung ausgeschlossen.
- **Zustandsprüfung:** Verschiebung erfolgt primär, wenn die HDDs bereits aktiv sind, um unnötige Spin-ups zu vermeiden.

## 🌐 Dienste & Netzwerkzugriff

Die Dienste sind in zwei Zonen unterteilt. Der Zugriff erfolgt über Caddy als Edge-Proxy.

### Frontend (Öffentlich via Cloudflare/Caddy)
- **Media:** Jellyfin, Audiobookshelf, Navidrome
- **Requests:** Jellyseerr
- **Smart Home:** Home Assistant

### Backend (Nur Tailscale / Lokales LAN)
- **Download:** Radarr, Sonarr, Prowlarr, Lidarr, Readarr, SABnzbd
- **Automation:** n8n, Semaphore
- **Produktivität:** Paperless-ngx, Vaultwarden, Linkding, Monica, Readeck
- **Infrastruktur:** AdGuard Home, Netdata, Scrutiny, Cockpit, Filebrowser

## 🔐 Authentifizierung & Sicherheit

- **SSO:** Pocket-ID (OIDC) ist für alle Web-Dienste verpflichtend.
- **Keine Bypässe:** IP-basierte Ausnahmen für LAN oder Tailscale wurden entfernt; jeder Zugriff erfordert einen gültigen Token.
- **Impermanence:** Das Root-Dateisystem ist ein `tmpfs`. Nur explizit unter `/persist` gelistete Pfade überdauern einen Neustart.
- **Runtime Guard:** Ein Watchdog prüft periodisch den Status der nftables-Regelsätze und des Kernel-Lockdowns.
- **Fail2ban:** Schützt SSH (Port 22) und die SSH-Rescue-Instanz (Port 2222).

## 🛠️ Entwicklung & Installation

### Struktur
- `modules/core/`: Systemgrundlagen (Netzwerk, Dateisysteme, Sops).
- `modules/security/`: Security-Policies und Runtime-Monitoring.
- `modules/apps/`: Applikations-Module (nutzen zentrale Service-Factories).
- `modules/services/`: Infrastruktur-Dienste (Caddy, Tailscale, SSO).

### Container-Management
Das System verzichtet auf die automatische Erstellung von Docker-Containern. Sofern Docker genutzt wird, erfolgt die Pflege der Container manuell außerhalb der Nix-Konfiguration.

## ⚠️ Bekannte Einschränkungen

- **Transcoding:** Jellyfin nutzt Tier B (SSD) für temporäre Daten, um RAM-Überläufe (`/dev/shm`) bei hochbitratigen 4K-Streams zu verhindern.
- **MergerFS:** `cache.files` ist auf `off` gesetzt, um Inkonsistenzen bei parallelen Schreibvorgängen durch den Mover zu vermeiden.
- **Sops-Deadlock:** Bei Totalausfall von Tier A (NVMe) fehlen die SSH-Hostkeys zur Entschlüsselung der Secrets. Ein physischer Emergency-Key (USB) wird als Fallback empfohlen.
