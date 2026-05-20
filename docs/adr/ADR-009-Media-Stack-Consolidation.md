---
title: ADR-009: Media Stack Consolidation (Simplicity over Complexity)
domain: 40
status: [ACCEPTED]
category: architecture/decision
capabilities: [sqlite-reliability, service-bundling, zero-maintenance]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/apps/_arr-factory.nix
  - path: modules/apps/media-stack.nix
sources: [nixarr, user-feedback, Internal SRE Audit]
---

<!-- context7: repo_v5/modules/apps/_arr-factory.nix -->

# 🏛️ ADR-009: Der konsolidierte Media Stack (Simplicity Edition)

**Status:** SUPERSEDED by [ADR-018](./ADR-018-Media-Stack-Architecture.md)  
**Date:** 2026-05-20  
Wir haben die Wahl zwischen PostgreSQL und SQLite für den ARR-Stack analysiert.

## Entscheidung
Wir nutzen **SQLite** als Standard-Datenbank für alle ARR-Dienste (Sonarr, Radarr, Lidarr, Prowlarr).

## Umsetzung in Nix
- **Factory:** `modules/apps/_arr-factory.nix` (konfiguriert Pfade für SQLite `.db` Files).
- **Target:** `modules/apps/media-stack.nix` (bündelt Dienste unter `media-stack.target`).

## Verifizierung
```bash
# Prüfe ob SQLite Files im App-Datenordner liegen
ls -l /var/lib/sonarr/sonarr.db
# Erwartetes Ergebnis: Datei existiert und wird vom Dienst genutzt.
```