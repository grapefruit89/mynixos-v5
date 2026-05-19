#!/bin/bash
# 🧹 NIXHOME: EFI BOOT ENTRY CLEANUP
# Host: Fujitsu Esprimo Q958
# Danger Level: HIGH (Direct UEFI Firmware Modification)

set -e

echo "--- 🛡️ NIXHOME: EFI CLEANUP ---"

# 1. PRÜFUNG: BINARIES VORHANDEN?
command -v efibootmgr >/dev/null 2>&1 || { echo "❌ efibootmgr fehlt! Bitte installiere es via nix-shell -p efibootmgr."; exit 1; }

# 2. SCHRITT: AKTUELLE ENTRIES ANZEIGEN
echo "🔍 Schritt 1: Aktuelle Boot-Einträge..."
efibootmgr --verbose

echo ""
echo "⚠️  VORSICHT: Lösche NIEMALS den aktuellen Boot-Eintrag (gekennzeichnet mit BootOrder oder BootCurrent)."
echo "Stale Einträge aus alten 'Horizontal Repo' Iterationen oder Windows-Überreste können entfernt werden."
echo ""
echo "Beispiel zum Löschen: efibootmgr -b 000X -B"
echo ""
echo "Möchtest du eine interaktive Lösch-Session starten? (y/N)"
read -r -n 1 start_cleanup
echo ""

if [[ "$start_cleanup" =~ ^[Yy]$ ]]; then
    echo "Gib die Boot-Nummer ein (z.B. 0001), die gelöscht werden soll (oder 'q' zum Beenden):"
    while true; do
        read -p "BootNum: " bootnum
        if [[ "$bootnum" == "q" ]]; then break; fi
        if [[ "$bootnum" =~ ^[0-9A-Fa-f]{4}$ ]]; then
            echo "🔥 Lösche Boot$bootnum..."
            # efibootmgr -b "$bootnum" -B  # Auskommentiert für Sicherheit, User muss es scharf schalten oder bestätigen
            echo "Befehl wäre: efibootmgr -b $bootnum -B"
            echo "Soll ich diesen Befehl JETZT ausführen? (y/N)"
            read -r -n 1 confirm
            echo ""
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                sudo efibootmgr -b "$bootnum" -B
                echo "✅ Boot$bootnum entfernt."
            else
                echo "⏭️ Übersprungen."
            fi
        else
            echo "❌ Ungültiges Format. Erwartet wird 4-stellige Hex-Zahl (z.B. 000A)."
        fi
    done
fi

echo ""
echo "🎉 EFI-Cleanup abgeschlossen."
