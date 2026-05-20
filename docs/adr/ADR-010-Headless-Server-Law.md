---
title: "ADR-010: Headless Server Law (No-GUI Mandate)"
status: ACCEPTED
date: 2026-05-20
domain: 10
related:
  guide: docs/guides/30-security-hardening.md
  modules: modules/security/security-assertions.nix
---

<!-- context7: repo_v5/modules/security/security-assertions.nix -->
<!-- context7: repo_v5/modules/services/service-forbidden-tech.nix -->

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