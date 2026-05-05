# 🚀 NixHome v5.0 "Horizontal Responsibility"

NixOS-basierte Homelab-Konfiguration (v5.0/v6 Standard) mit horizontaler Modulstruktur, fokussiert auf Daten-Tiering, Identitätsmanagement und **Aviation-Grade Hardening**.

## 📖 Key Documentation
- **Core Hardening:** [modules/core/HARDENING.md](./modules/core/HARDENING.md) (Networking, IPC, East-West Isolation)
- **Database & Sockets:** [modules/services/SOCKET_HARDENING.md](./modules/services/SOCKET_HARDENING.md) (Unix Sockets, TCP-Zero)
- **Services Registry:** [modules/core/SERVICES_GUIDE.md](./modules/core/SERVICES_GUIDE.md) (SSoT Logic & Trust Zones)
- **Security Blueprint:** [docs/V6_BLUEPRINT.md](./docs/V6_BLUEPRINT.md) (Trust Zones, mTLS, TPM)

## 🏗️ Architektur: Das Three-Zone Trust Modell
Das System erzwingt eine strikte Trennung zwischen Frontend, Backend und internen Daten:

1. **Zone 1: Loopback (Unix-IPC)**
   - Datenbanken (PostgreSQL, Valkey) kommunizieren **ausschließlich** via Unix Sockets.
   - TCP ist deaktiviert (`port = 0`).
   - `PrivateNetwork = true` isoliert die DBs vom Netzwerkstack.

2. **Zone 2: Admin-mTLS (Loopback Alias `127.0.0.2`)**
   - Backend-Dienste (Portainer, Netdata, *arr Suite) binden an den isolierten Alias.
   - Zugriff **nur** via Caddy mit hardwaregebundenem mTLS (Laptop TPM2.0).
   - `nftables` blockiert jeden Zugriff auf `127.0.0.2`, der nicht von Caddy (UID 978) stammt.

3. **Zone 3: Family-PocketID (`127.0.0.1`)**
   - Frontend-Dienste (Jellyfin, Nextcloud, Immich) binden an Standard-Loopback.
   - Zugriff via PocketID SSO (OIDC) / Forward-Auth.

## 💾 Storage-Architektur (ABC-Tiering)

| Tier | Hardware | Mountpoint | Nutzung | Besonderheiten |
| :--- | :--- | :--- | :--- | :--- |
| **A** | NVMe | `/persist` | OS, DBs, `/data/state` | Persistent via Impermanence |
| **B** | SATA SSD | `/mnt/cache` | Incomplete Downloads, Transcodes | Schonung der NVMe-Zyklen |
| **C** | HDD Mirror | `/mnt/hdd_pool` | Bulk Media, Backups | Spindown nach 10 Min. |

### Smart Mover
Ein systemd-Service überwacht Tier B und verschiebt Daten nach Tier C, sobald der Platz knapp wird oder die HDDs bereits aktiv sind. Datenbanken sind via Exception-List geschützt.

## 🔐 Sicherheit & Compliance

- **Impermanence:** Root-Dateisystem auf `tmpfs`.
- **SRE-Factories:** Dienste werden über gehärtete Nix-Funktionen (`mkService`, `mkDocumentApp`) erstellt.
- **Kernel Hardening:** Titanium-Hardened Kernel & Systemd Sandboxing für alle Apps.

## 🛠️ Quick Start
```bash
# Konfiguration anwenden
sudo nixos-rebuild switch --flake .#default

# Dienst-Status prüfen
systemctl list-units "app-*"
```
