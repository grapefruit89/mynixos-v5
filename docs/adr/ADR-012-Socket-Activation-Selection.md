---
title: ADR-012: Selection Criteria for Socket Activation (Safety First)
status: [ACCEPTED]
category: architecture/decision
capabilities: [pragmatic-efficiency, connectivity-guarantee, security-hardening]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/core/ssh.nix
sources: [User Feedback, Connectivity Audit]
---

# 🏛️ ADR-012: Pragmatische Socket-Activation (v2.0)

## Kontext
Wir haben SSH fälschlicherweise für Socket-Activation vorgesehen (siehe ADR-011). 

## Entscheidung
**SSH wird STRIKT von der Socket-Activation ausgeschlossen.** Es bleibt permanent aktiv.

## Umsetzung in Nix
- **SSH:** `modules/core/ssh.nix` (systemd.services.sshd.enable = true).
- **Hardening:** `modules/core/ssh.nix` (systemd hardening ohne Socket-Activation).

## Verifizierung
```bash
# Prüfe ob SSHD permanent läuft
systemctl is-active sshd
# Erwartetes Ergebnis: "active" (nicht "waiting for socket").
```