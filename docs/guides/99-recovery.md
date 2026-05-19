# 🛡️ Guide 99: Recovery & Disaster Management

---
title: 🛡️ Recovery & Disaster Management
category: core/security
status: [ACTIVE-SSoT]
capabilities: [bare-metal-restore, emergency-keys, qr-unlock, restic-recovery]
sources: [NMS v4.2 Architecture, NixOS Wiki]
last_reviewed: 2026-05-19
adr: [ADR-015, ADR-016]
---

Dieses Dokument beschreibt das ultimative Sicherheitsnetz für den NixHome Tower. Es definiert die Prozesse für den Wiederaufbau nach Hardware-Totalausfall, Datenverlust oder gesperrten Keys.

## 🏛️ 1. Master-Key Management (Hierarchie)

Wir nutzen eine mehrstufige Key-Hierarchie, um Sicherheit und Wiederherstellbarkeit zu balancieren.

| Ebene | Typ | Aufbewahrung | Nutzung |
|-------|-----|--------------|---------|
| **Primary** | TPM 2.0 / YubiKey | Hardware-gebunden | Täglicher Betrieb, automatisches Entsperren. |
| **Emergency** | Age Master Key | Physischer USB-Stick (Safe) | Entsperren von SOPS, falls Hardware defekt. |
| **Backup** | Restic Password | SOPS-verschlüsselt | Wiederherstellung der Daten von Backblaze/Lokal. |
| **Recovery** | LUKS Passphrase | QR-Unlock / Physisch | Manueller Boot-Eingriff. |

---

## 🛠️ 2. Disaster Recovery Pfade

### Pfad A: Der "Ignition" USB-Stick (`recovery-usb.nix`)
Wenn das System startet, aber die SOPS-Keys fehlen (z.B. nach Neuinstallation), kann ein physischer Stick mit dem Label `RECOVERY_STICK` eingesteckt werden.
- **Automatismus:** UDEV erkennt den Stick und mountet ihn RO unter `/mnt/recovery`.
- **Inhalt:** Enthält den `age` Master-Key, der vom `secret-ingest.nix` Modul automatisch eingelesen wird. ✅

### Pfad B: Remote QR-Unlock (Disaster Path)
Falls der Server an einem unbekannten Ort startet (DNA-Check schlägt fehl), wird ein QR-Code auf dem TTY1 ausgegeben.
- **Vorgehensweise:** Scan mit dem Smartphone -> SSH-Verbindung auf Port 2222 -> Eingabe der LUKS-Passphrase via Handy-Tastatur.
- **Anker:** `# anchor: qr-unlock`

### Pfad C: Bare-Metal Restore (Totalverlust)
Vorgehensweise bei neuer Hardware:
1. **Boot:** NixOS Minimal ISO (USB).
2. **Git:** Repository clonen: `git clone https://github.com/m7c5/repo_v5.git`.
3. **Secrets:** Emergency Age-Key vom Recovery-Stick exportieren: `export SOPS_AGE_KEY_FILE=/mnt/recovery/keys.txt`.
4. **Restic:** Daten von Backblaze B2 ziehen:
   ```bash
   restic -r s3:s3.eu-central-003.backblazeb2.com/nixhome-backup restore latest --target /mnt/persist
   ```
5. **Install:** `nixos-rebuild switch --flake .#default --root /mnt`.

---

## 🚀 3. Bootstrap-Prozess (Neugerät)

1. **Partitionierung:** Erstellen der Partitionen (BOOT, PERSIST).
2. **Mounting:** 
   - `mount /dev/disk/by-label/persist /mnt/persist`
   - `mkdir -p /mnt/persist/etc/nixos`
3. **Keys:** Einlegen des Recovery-Sticks zur initialen Entschlüsselung.
4. **Installation:** `nixos-install --flake .#default`.

---

## 📝 Nächste Schritte (Offene Punkte)

- [ ] **TODO-016:** Physischen USB-Key mit Age-Fallback final erstellen (Hardware-Task).
- [ ] **TODO-027:** Automatisches Backup des Recovery-Sticks auf einen zweiten, verschlüsselten Offline-Datenträger.
- [ ] **Audit:** Jährliche "Wiederherstellungs-Übung" (Simulation eines Totalausfalls).

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
