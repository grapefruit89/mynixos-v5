#!/bin/bash
# 🔐 NIXHOME: NUCLEAR-GRADE LUKS + TPM2 ENROLLMENT & BACKUP
# Host: Fujitsu Esprimo Q958
# Target Device: cryptroot (/dev/nvme0n1p3)
# Protocol Version: 6.0 (Hardware-Bound)

set -e

# --- CONFIGURATION ---
DEVICE="/dev/nvme0n1p3"  # Standard-Pfad für Q958 NVMe
BACKUP_DIR="/root/luks_backup"
DATE=$(date +%Y-%m-%d)
HOSTNAME=$(hostname)

echo "--- 🛡️ NIXHOME: NUCLEAR LUKS HARDENING ---"

# 1. PRÜFUNG: BINARIES VORHANDEN?
command -v systemd-cryptenroll >/dev/null 2>&1 || { echo "❌ systemd-cryptenroll fehlt! Bitte boot.initrd.systemd.enable aktivieren."; exit 1; }
command -v cryptsetup >/dev/null 2>&1 || { echo "❌ cryptsetup fehlt!"; exit 1; }

# 2. SCHRITT: HEADER-BACKUP (DER LEBENSRETTER)
echo "📦 Schritt 1: Erstelle LUKS Header Backup..."
mkdir -p "$BACKUP_DIR"
cryptsetup luksHeaderBackup "$DEVICE" --header-backup-file "$BACKUP_DIR/luks_header_$HOSTNAME_$DATE.bin"
echo "✅ Header Backup erstellt unter: $BACKUP_DIR"
echo "⚠️  WICHTIG: Kopiere diese Datei auf einen externen USB-Stick!"

# 3. SCHRITT: RECOVERY-KEY (DEIN NOTSCHLÜSSEL)
echo ""
echo "🔑 Schritt 2: Generiere Recovery-Key (Notfall-Passphrase)..."
echo "   Dieser Key funktioniert IMMER, auch wenn das Mainboard stirbt."
systemd-cryptenroll --recovery-key "$DEVICE"
echo "✅ Recovery-Key generiert."
echo "⚠️  WICHTIG: Schreibe diesen Key auf Papier oder speichere ihn in Bitwarden!"

# 4. SCHRITT: TPM2 ENROLLMENT (DIE HARDWARE-BINDUNG)
echo ""
echo "🔒 Schritt 3: Binde Festplatte an TPM 2.0 (PCR 0,1,2,3)..."
echo "   PCR 0-3: Bindung an BIOS, Mainboard, CPU und Firmware-Konfiguration."
echo "   PCR 7 (Secure Boot) wird weggelassen, da du es deaktiviert hast."
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+1+2+3 "$DEVICE"

echo ""
echo "🎉 ERFOLG: Dein Fujitsu Q958 ist jetzt Hardware-verschlüsselt."
echo "---------------------------------------------------------"
echo "FINALER CHECKLISTE:"
echo "1. [ ] Recovery-Key in Bitwarden gesichert?"
echo "2. [ ] Header-Backup (.bin Datei) auf USB-Stick kopiert?"
echo "3. [ ] configuration.nix angepasst? (boot.initrd.systemd.enable = true)"
echo "---------------------------------------------------------"
