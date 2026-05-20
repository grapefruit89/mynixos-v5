---
title: "Storage Strategy & HDD Lifecycle Management"
status: ACCEPTED
date: 2026-05-20
domain: 40
related:
  guide: docs/guides/40-storage-strategy.md
  modules: modules/core/storage-policy.nix
---

# ADR-040: Storage Strategy & HDD Lifecycle Management

## Entscheidungen

### HDD-Spindown (TLP)
- Die Festplatten im Tier C (Media) werden nach 30 Minuten Inaktivität heruntergefahren.
- Dies reduziert Verschleiß und Stromverbrauch.
- Umsetzung: `DISK_SPINDOWN_TIMEOUT_ON_AC = "30m"` in `hardware/q958/hardware-profile.nix`.
- Referenz: [TLP Disk Settings](https://linrunner.de/tlp/settings/disk.html)

### Jellyfin-Library-Scan
- Der tägliche Scan findet **nachts um 02:00** statt, um die HDDs nicht tagsüber unnötig aufzuwecken.
- Da die NixOS-Option `services.jellyfin` keinen `ScanSchedule` direkt unterstützt, wird dieser manuell im Web-UI konfiguriert.
- Hinweis dazu ist in `modules/40-media/44-streaming.nix` als Kommentar hinterlegt.

### Verifikation
- Siehe Guide `40-storage-strategy.md` für Befehle wie `tlp-stat --disk` und `hdparm -C`.
