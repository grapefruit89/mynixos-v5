---
title: ADR-015: Distance Over Local Parity (The anti-RAID Mandate)
status: [ACCEPTED]
category: architecture/decision
capabilities: [offsite-recovery, 3-2-1-rule, state-minimization]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/core/storage-policy.nix
  - path: modules/core/backup.nix
---

<!-- context7: repo_v5/modules/core/storage-policy.nix -->

# 🏛️ ADR-015: Distanz ist die bessere Parität

## Kontext
Lokale Redundanz (RAID) schützt nicht gegen Katastrophen und verhindert HDD-Spindown.

## Entscheidung
Wir verzichten auf RAID und investieren in **geografische Distanz** (Restic zu S3/Offsite).

## Umsetzung in Nix
- **Policy:** `modules/core/storage-policy.nix` (Definition der Tiers A, B, C).
- **Backup:** `modules/core/backup.nix` (Automatisierte Restic-Backups für Tier A/A++).

## 📦 ABC-Tiering & Smart Mover
Anstatt auf RAID-Parität zu setzen, nutzen wir ein hybrides Speichermodell:
- **HDD-Silence-Protokoll:** Festplatten bleiben im Spindown, solange keine Archiv-Daten benötigt werden. Ein **Inode Warmer** (`modules/core/storage.nix`) hält die Verzeichnisstruktur im RAM.
- **Kapazitätsbasierter Mover:** Der `smart-mover` (`modules/services/service-storage-mover.nix`) verschiebt Daten von der SSD (Tier B) auf die HDD (Tier C) erst dann, wenn der Platz knapp wird UND die HDDs bereits für andere Aufgaben aktiv sind.
- **WAL-Schutz:** Datenbanken und Write-Ahead-Logs verbleiben zwingend auf Tier A (NVMe), um Korruption bei HDD-Latenzen zu vermeiden.

## Verifizierung
```bash
# Prüfe den Status der Backup-Timer
systemctl list-timers | grep restic
# Erwartetes Ergebnis: Aktive Timer für die tägliche Sicherung nach S3.
```