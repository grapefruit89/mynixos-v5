---
title: 40-storage-strategy
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-19
nix_modules:
  - path: modules/core/storage.nix
    anchor: mergerfs-pool
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/storage.nix
  - path: modules/core/backup.nix
    anchor: restic-backup
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/backup.nix
  - path: modules/core/backup.nix
    anchor: rclone-sync
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/backup.nix
  - path: modules/services/service-storage-mover.nix
    anchor: storage-tiering
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-storage-mover.nix
  - path: modules/core/impermanence.nix
    anchor: persistence-core
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/impermanence.nix
  - path: modules/core/recovery-usb.nix
    anchor: recovery-usb
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/recovery-usb.nix
---

# Cluster 40: Storage Strategy & Disaster Recovery

Dieses Dokument beschreibt die Speicher-Architektur von mynixos, basierend auf dem ABC-Tiering-Modell, sowie die Prozesse für den Wiederaufbau nach Hardware-Totalausfall (Disaster Recovery).

---

## 🏗️ ABC-Storage-Tiering (anchor: storage-tiering)

Wir nutzen ein hybrides Modell, um Geschwindigkeit (NVMe), Kapazität (HDD) und Kosten zu optimieren. Die Steuerung erfolgt über `modules/services/service-storage-mover.nix`.

### 🏛️ Die Tiers
- **Tier A (Critical / NVMe)**: Datenbanken, Sops-Secrets, App-States. Maximale IOPS.
- **Tier B (Hot / SSD)**: Aktuelle Downloads, aktives Media-Streaming.
- **Tier C (Cold / HDD)**: Archiv-Medien, Langzeit-Backups.

### 📦 Smart Mover (anchor: storage-tiering)
Ein intelligenter Hintergrunddienst überwacht den Füllstand von Tier A/B und verschiebt Daten automatisch nach Tier C, wenn der Platz knapp wird (Standard: < 10GB frei).

---

## 🏎️ Unified Storage Pool (MergerFS) (anchor: mergerfs-pool)

Um alle physischen Festplatten als einen logischen Pfad (`/storage`) anzusprechen, nutzen wir MergerFS. Dies ermöglicht es, Festplatten unterschiedlicher Größe flexibel zu kombinieren.

- **Konfiguration**: `modules/core/storage.nix`.
- **Vorteil**: Jede Festplatte bleibt einzeln lesbar (kein RAID-Proprietary-Lock-in).
- **HDD-Silence**: Ein Inode-Warmer hält Metadaten im RAM, um unnötige HDD-Spinups zu vermeiden.

---

## 🛡️ Restic Backup (anchor: restic-backup)

Backups sind das Sicherheitsnetz für Tier A und Tier B. Wir nutzen Restic für verschlüsselte, deduplizierte Backups.

- **Lokales Repository**: `/mnt/archive/.restic-vault`.
- **Umfang**: `/persist`, `/var/lib/pocket-id`, `/etc/nixos` und alle App-Daten.
- **Pre-Flight Check**: Backups werden abgebrochen, wenn die Datenmenge ein definiertes Limit (z.B. 20GB) überschreitet, um Speicher-Exhaustion zu vermeiden.

### ☁️ Cloud Sync (anchor: rclone-sync)
Nach jedem erfolgreichen lokalen Backup synchronisiert `rclone` (via SOPS geschützt) das Repository verschlüsselt in die Cloud (Backblaze B2).

---

## 💾 Stateless Persistence (anchor: persistence-core)

NixHome v7.1 nutzt ein Stateless-Root (RAM). Nur explizit definierte Pfade werden über das `impermanence` Modul (`modules/core/impermanence.nix`) auf der NVMe persistent gespeichert.

- **Vorteil**: Ein sauberer Systemzustand bei jedem Reboot.
- **SRE-Vorteil**: Malware kann sich nicht im Root-Dateisystem festsetzen.

---

## 🚨 Disaster Recovery (anchor: disaster-recovery)

Im Falle eines Totalausfalls folgen wir dem Runbook für den Wiederaufbau des Systems.

### 🏛️ Master-Key Management (Hierarchie)
| Ebene | Typ | Aufbewahrung | Nutzung |
|-------|-----|--------------|---------|
| **Primary** | TPM 2.0 / YubiKey | Hardware-gebunden | Täglicher Betrieb. |
| **Emergency** | Age Master Key | Physischer USB-Stick (Safe) | Entsperren von SOPS bei Hardware-Defekt. |
| **Backup** | Restic Password | SOPS-verschlüsselt | Daten-Wiederherstellung. |
| **Recovery** | LUKS Passphrase | QR-Unlock / Physisch | Manueller Boot-Eingriff. |

### 🛠️ Recovery Pfade

#### Pfad A: Der "Ignition" USB-Stick (`recovery-usb.nix`)
Wenn das System startet, aber die SOPS-Keys fehlen (z.B. nach Neuinstallation), kann ein physischer Stick mit dem Label `RECOVERY_STICK` eingesteckt werden.
- **Inhalt**: Enthält den `age` Master-Key, der vom `secrets.nix` Modul automatisch eingelesen wird.

#### Pfad B: Remote QR-Unlock (Disaster Path)
Falls der Server an einem unbekannten Ort startet (DNA-Check schlägt fehl), wird ein QR-Code auf dem TTY1 ausgegeben. Scan mit dem Smartphone -> SSH auf Port 2222 -> LUKS-Eingabe.

#### Pfad C: Bare-Metal Restore (Totalverlust)
Vorgehensweise bei neuer Hardware:
1.  **Boot**: NixOS Minimal ISO (USB).
2.  **Git**: Repository clonen: `git clone https://github.com/m7c5/repo_v5.git`.
3.  **Secrets**: Emergency Age-Key vom Recovery-Stick exportieren: `export SOPS_AGE_KEY_FILE=/mnt/recovery/keys.txt`.
4.  **Restic**: Daten von Backblaze B2 ziehen:
    ```bash
    restic -r s3:s3.eu-central-003.backblazeb2.com/nixhome-backup restore latest --target /mnt/persist
    ```
5.  **Install**: `nixos-rebuild switch --flake .#default --root /mnt`.

---

## ✅ Verifizierung

```bash
# 1. Prüfe Status des Storage Movers
systemctl status storage-mover.timer

# 2. Prüfe MergerFS Mounts
mount | grep mergerfs

# 3. Führe ein manuelles Backup-Check durch
restic -r /mnt/archive/.restic-vault check

# 4. Simuliere rclone Cloud-Sync (Dry-Run)
rclone --dry-run sync /mnt/archive/.restic-vault cloud-backup:nixhome-vault

# 5. Prüfe Inode Warmer (Ghost-Tree für HDD Silence)
systemctl status hdd-inode-warmer.service

# 6. Prüfe Log-Sync Status (Backblaze B2)
systemctl status log-s3-sync.service
journalctl -u log-s3-sync.service -n 20 --no-pager

# 7. Prüfe HDD Spindown Status & Timer
tlp-stat --disk

# 8. Prüfe Restic Backup Snapshots
restic -r /mnt/archive/.restic-vault snapshots

# 9. Simuliere Recovery-Stick Mount
udevadm trigger --action=add --subsystem-match=block
[ -d /mnt/recovery ] && echo "Recovery Mount logic active"
```

---

## 💤 HDD Spindown & Wartung

Um die HDDs zu schonen, haben wir den Spindown-Timer auf **30 Minuten** erhöht. Dies verhindert das "Flattern" (ständiges An/Aus), wenn kurze Zugriffe erfolgen.

Zusätzlich werden **Jellyfin-Bibliotheks-Scans** nur nachts um **02:00 Uhr** durchgeführt. Dies stellt sicher, dass die Platten tagsüber im Tiefschlaf bleiben können, sofern keine Medien aktiv gestreamt werden. Die manuelle Konfiguration erfolgt in der Jellyfin Web-UI unter *Einstellungen -> Dashboard -> Bibliotheken -> Geplanter Aufgaben-Trigger*.

---

## 🔗 Quellen & Verweise

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/backup.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/storage.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-storage-mover.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/recovery-usb.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/core/storage.nix -->
<!-- mcp: repo_v5/modules/core/backup.nix -->
<!-- mcp: repo_v5/modules/services/service-storage-mover.nix -->
<!-- mcp: repo_v5/modules/core/impermanence.nix -->
<!-- mcp: repo_v5/modules/core/recovery-usb.nix -->
