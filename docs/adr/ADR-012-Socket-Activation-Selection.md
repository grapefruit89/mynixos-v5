---
title: "ADR-012: Selection Criteria for Socket Activation (Safety First)"
status: ACCEPTED
date: 2026-05-20
domain: 12
related:
  guide: docs/guides/10-ingress-caddy.md
  modules: modules/core/ssh.nix
---

<!-- context7: repo_v5/modules/core/ssh.nix -->

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