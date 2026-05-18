---
title: ADR-010: Headless Server Law (No-GUI Mandate)
status: [ACCEPTED]
category: architecture/decision
capabilities: [resource-efficiency, security-hardening, headless-operations]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/security/security-assertions.nix
  - path: modules/services/service-forbidden-tech.nix
sources: [User Mandate, Manifest v7.1]
---

# 🏛️ ADR-010: Das Headless-Gesetz

## Kontext
Wir bauen eine hocheffiziente mynixos Distribution für den Fujitsu Q958 Tower. Ressourcen müssen für Dienste und Daten reserviert bleiben.

## Entscheidung
Die Installation von grafischen Oberflächen (GUIs) und deren Abhängigkeiten ist **STRIKT VERBOTEN**.

## Umsetzung in Nix
- **Assertion:** `modules/security/security-assertions.nix` (prüft auf X11/Wayland Komponenten).
- **Forbidden Tech:** `modules/services/service-forbidden-tech.nix` (blockiert Desktop-spezifische Services).

## Verifizierung
```bash
# Prüfe ob X-Server im System aktiv ist
nix-shell -p pciutils --command "lspci -k" | grep -i vga
# Erwartetes Ergebnis: Nur der iHD Treiber für QuickSync sollte aktiv sein, kein aktiver Display-Server.
```