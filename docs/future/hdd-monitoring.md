# Analyse: HDD-Spinup-Überwachung

Um die Theorie zu verifizieren, dass die HDDs nur durch den Notfall-Mover oder aktives Medien-Streaming geweckt werden, ist eine lückenlose Protokollierung der Spin-ups unerlässlich.

## Technische Optionen im Vergleich

1. **`smartctl` Polling (Empfehlung):**
   Mit dem Befehl `smartctl -A -n standby /dev/sdX` können SMART-Attribute (insbesondere der `Load_Cycle_Count` oder `Power_Cycle_Count`) ausgelesen werden.
   - *Der Clou:* Der Parameter `-n standby` sorgt dafür, dass der Befehl sofort mit Exit-Code 2 abbricht, falls die Festplatte schläft. Sie wird **nicht** aufgeweckt!
   - *Vorteil:* Da der interne Zähler der Festplatte inkrementiert wird, erkennen wir auch Spin-ups, die komplett zwischen zwei Polling-Intervallen (z.B. 5 Minuten) stattfanden und bereits wieder im Standby endeten.
2. **`udev` Change-Events:**
   - *Vorteil:* Echtzeit-Erkennung.
   - *Nachteil:* Hardware-abhängig. Viele SATA/AHCI-Controller triggern bei einem APM-Zustandswechsel (Standby -> Active) kein `change`-Event für udev. Oft unzuverlässig.
3. **`hdparm -C` Polling:**
   - *Nachteil:* Fragt nur den aktuellen Ist-Zustand (Active/Standby) ab. Kurze Spin-ups zwischen den Polls werden komplett übersehen.

**Fazit:** Variante 1 (`smartctl` Polling) ist mit Abstand die zuverlässigste und sicherste Methode, um Spin-ups lückenlos und ohne False-Positives (durch das Polling selbst) zu erfassen.

---

## Konkreter Umsetzungsplan (Keine Code-Änderungen in dieser Phase)

### 1. Das Überwachungs-Skript (`scripts/hdd-spinup-monitor.sh`)
Ein neues, robustes Bash-Skript wird erstellt:
- Es iteriert über definierte HDD-Pfade (z.B. alle Block-Devices in `/mnt/hdd_pool`).
- Führt `smartctl -A -n standby $DISK` aus.
- Ist der Exit-Code `0` (Platte wach), wird der `Load_Cycle_Count` extrahiert.
- Der Wert wird mit dem vorherigen Stand (gespeichert in `/run/hdd-monitor/`) verglichen.
- Ist der Wert gestiegen, liegt ein Spin-up vor:
  - Ein Eintrag wird via `logger` ins System-Journal geschrieben: `[hdd-spinup-monitor] HDD /dev/sda aufgewacht. Neuer Cycle Count: X. Zuwachs: Y`.
  - *(Optional)* Wenn konfiguriert, wird ein Webhook (Matrix/ntfy) via `curl` aufgerufen.
- Der neue Wert wird in der `/run`-Datei gespeichert.

### 2. Systemd-Integration (`modules/core/storage.nix`)
Anstatt ein komplett neues Modul zu bauen, fügen wir die Logik nahtlos in das bestehende Speicher-Modul ein:
- **Service:** `systemd.services.hdd-spinup-monitor`, der das Skript ausführt und `smartmontools` im Pfad hat. Über SOPS kann ein `EnvironmentFile` injiziert werden, falls Push-Benachrichtigungen gewünscht sind.
- **Timer:** `systemd.timers.hdd-spinup-monitor`, der alle 5 Minuten (`OnCalendar = "*:0/5"`) feuert.

### 3. Dokumentation aktualisieren
- **`docs/guides/40-storage-strategy.md`**: Im Abschnitt "💤 HDD Spindown & Wartung" wird erklärt, dass das System jeden Spin-up überwacht. Der Verifikationsbefehl `journalctl -u hdd-spinup-monitor.service` wird hinzugefügt.
- **`docs/adr/ADR-015-Distance-Parity-Mandate.md`**: Unter "Verifizierung" wird die Metrik "Lückenlose Spin-up-Protokollierung" als Instrument zur Beweisführung des Anti-RAID/Silence-Protokolls aufgenommen.

### 4. Ursachenanalyse (Der nächste Schritt)
Im ersten Wurf wissen wir *dass* und *wann* die Platte aufwachte. Die Ursache lässt sich dann im Nachgang durch zeitliches Korrelieren der Logs herausfinden:
- `journalctl -u storage-mover.service` (Lief der Mover?)
- `journalctl -u jellyfin.service` (Wurde gestreamt?)
- `journalctl -u caddy.service` (Gab es API-Zugriffe?)