# 🛡️ Guide 99: Recovery & Disaster Management

---
title: 🛡️ Recovery & Disaster Management
category: core/security
status: [ACTIVE-SSoT]
capabilities: [bare-metal-restore, emergency-keys, qr-unlock, restic-recovery]
sources: [NMS v4.2 Architecture, NixOS Wiki]
last_reviewed: 2026-05-19
adr: [ADR-015, ADR-016]
test: tests/security.nix
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
- **Inhalt:** Enthält den `age` Master-Key, der vom `secrets.nix` Modul automatisch eingelesen wird. ✅

### Pfad B: Remote QR-Unlock (Disaster Path)
Falls der Server an einem unbekannten Ort startet (DNA-Check schlägt fehl), wird ein QR-Code auf dem TTY1 ausgegeben.
- **Vorgehensweise:** Scan mit dem Smartphone -> SSH-Verbindung auf Port 2222 -> Eingabe der LUKS-Passphrase via Handy-Tastatur.
- **Anker**: `qr-unlock`

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

## ✅ Verifizierung

```bash
# 1. Prüfe Restic Backup Status (SSoT)
restic -r /mnt/archive/.restic-vault snapshots
# Positiv-Test: Snapshots vorhanden
[ $(restic -r /mnt/archive/.restic-vault snapshots --json | jq '. | length') -gt 0 ] && echo "Backups healthy"

# 2. Simuliere Recovery-Stick Mount
udevadm trigger --action=add --subsystem-match=block
# Prüfe ob MountPoint existiert
[ -d /mnt/recovery ] && echo "Mount logic active"

# 3. Teste LUKS-Header Integrität
cryptsetup luksDump /dev/disk/by-label/persist | grep "TPM2"

# 4. Negativ-Test: Recovery-Stick darf NICHT beschreibbar sein
touch /mnt/recovery/test.tmp && echo "FAIL: Stick writable" || echo "OK: Stick RO"
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [restic/restic](https://github.com/restic/restic) - Backups
- [FiloSottile/age](https://github.com/FiloSottile/age) - Encryption

### Context7 Observability
<!-- context7: nixpkgs/nixos/modules/services/backup/restic.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/backup.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/recovery-usb.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/modules/core/backup.nix -->
<!-- mcp: nixos:repo_v5/modules/core/recovery-usb.nix -->

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
