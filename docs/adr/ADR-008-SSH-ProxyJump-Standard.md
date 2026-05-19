---
title: ADR-008: Admin Access Standard (SSH & ProxyJump)
status: [ACCEPTED]
category: architecture/administration
capabilities: [ed25519-keys, bastion-host, proxyjump, ssh-abstraction]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/core/ssh.nix
  - path: modules/core/firewall.nix
sources: [https://blog.ktz.me/ssh-tips-and-why-proxyjump-is-awesome/]
---

<!-- context7: repo_v5/modules/core/ssh.nix -->

# 🏛️ ADR-008: gehärtetes SSH Management

## Kontext
Wir benötigen einen sicheren und bequemen Administrationszugang zum Tower, der dem Zero-Trust Prinzip folgt.

## Entscheidung
Wir implementieren den **SSH Abstraktions-Standard**:
1.  **Key-Type:** Ausschließlich **ED25519** Keys (YubiKey hardware-gebunden bevorzugt).
2.  **Custom Port:** SSH läuft auf Port **53844** (registriert in `modules/core/ports.nix`).
3.  **Hardening:** Password-Auth ist global deaktiviert.

## Umsetzung in Nix
- **Daemon-Config:** `modules/core/ssh.nix` (Port, PermitRootLogin=no).
- **Firewall:** `modules/core/firewall.nix` (Öffnung von Port 53844).
- **Policy:** `modules/security/security-assertions.nix` (Prüfung auf RootLogin=no).

## Verifizierung
```bash
# Teste Zugriff über den Custom Port
ssh moritz@tower -p 53844 -o PreferredAuthentications=publickey
# Erwartetes Ergebnis: Login erfolgreich (sofern Key hinterlegt).
```
