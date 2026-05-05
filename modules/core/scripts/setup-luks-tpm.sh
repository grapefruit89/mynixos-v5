#!/bin/bash
# 🔐 NIXHOME: LUKS + TPM2 ENROLLMENT GUIDE
# Dieses Skript führt die Befehle nicht direkt aus (Sicherheitsrisiko), 
# sondern dient als interaktive Anleitung für den Host.

echo "--- 🛡️ LUKS TPM2 ENROLLMENT GUIDE ---"
echo "1. Partition verschlüsseln (falls noch nicht geschehen):"
echo "   cryptsetup luksFormat /dev/nvme0n1p3"
echo ""
echo "2. TPM2 Einschreiben (PCR 0,1,2,3,7):"
echo "   systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+1+2+3+7 /dev/nvme0n1p3"
echo ""
echo "3. Recovery-Key für BITWARDEN generieren (ESSENZIELL!):"
echo "   systemd-cryptenroll --recovery-key /dev/nvme0n1p3"
echo ""
echo "HINWEIS: Ohne Secure Boot (dein Wunsch) ist die Bindung an PCR 7 (Boot State)"
echo "schwächer, aber PCR 0-3 schützen trotzdem vor Manipulation der Firmware/CPU."
