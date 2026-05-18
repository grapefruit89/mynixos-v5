---
title: ADR-016: Sops-Nix Boot Timing Fix
status: [ACCEPTED]
category: architecture/decision
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/core/secrets.nix
---

<!-- context7: repo_v5/modules/core/secrets.nix -->

# 🏛️ ADR-016: Sops-Nix Boot-Reihenfolge

## Kontext
Bei Nutzung von Impermanence besteht ein Race-Condition-Risiko beim Entschlüsseln von Secrets während des Bootvorgangs.

## Entscheidung
Wir erzwingen die Abhängigkeit der Secrets vom persistenten Speicher.

## Umsetzung in Nix
- **Dependency:** `modules/core/secrets.nix` (setzt `sops.age.sshKeyPaths` auf den persistenten Pfad).
- **Boot:** Sicherstellung, dass `/persist` gemountet ist, bevor `sops-install-secrets` startet.

## Verifizierung
```bash
# Prüfe ob Secrets erfolgreich geladen wurden
ls -l /run/secrets/
# Erwartetes Ergebnis: Secrets sind nach dem Boot vorhanden und lesbar.
```