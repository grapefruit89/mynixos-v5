---
title: 70-knowledge-automation
domain: 70
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-19
adr: [ADR-010, ADR-012, ADR-014]
test: tests/apps.nix
nix_modules:
  - path: modules/apps/service-app-paperless.nix
    anchor: paperless-automation
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-paperless.nix
  - path: modules/apps/service-app-n8n.nix
    anchor: n8n-workflows
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-n8n.nix
  - path: modules/apps/service-app-vaultwarden.nix
    anchor: vaultwarden-secrets
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-vaultwarden.nix
  - path: modules/apps/service-app-home-assistant.nix
    anchor: home-assistant-iot
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-home-assistant.nix
  - path: modules/apps/service-app-readeck.nix
    anchor: readeck-knowledge
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-readeck.nix
---

# Cluster 70: Knowledge & Automation

Dieses Dokument beschreibt das "Digitale Gehirn" von mynixos. Wir bündeln Wissensmanagement, Cloud-Dienste und Workflow-Automatisierung in einer hochintegrierten Architektur.

---

## 📑 Document Management: Paperless-ngx (anchor: paperless-automation)

Paperless-ngx ist unser zentrales Archiv für Dokumente. Es nutzt OCR (Optical Character Recognition), um Scans durchsuchbar zu machen.

### 🛠️ Konfiguration
```nix
my.apps.paperless.enable = true;
```

- **Automatisierung**: Über den `consumptionDir` werden Dokumente automatisch eingelesen, verarbeitet und nach Tier C verschoben.
- **Technik**: Nutzt PostgreSQL als Datenbank und Valkey als Message-Broker/Cache.

---

## 🔗 Workflow Automation: n8n (anchor: n8n-workflows)

n8n fungiert als die "zentrale Logik" zwischen verschiedenen Diensten.

### 🛠️ Konfiguration
```nix
my.apps.n8n.enable = true;
```

- **Einsatzbereiche**:
  - Webhook-Handling (z.B. GitHub-Alerts an Matrix).
  - Automatisierte Backups-Trigger.
- **Sicherheit**: Läuft in einer isolierten Systemd-Unit mit striktem `PrivateDevices` Schutz.

---

## 🔐 Secrets & Passwords: Vaultwarden (anchor: vaultwarden-secrets)

Vaultwarden (Bitwarden-kompatibel) ist der Standard für die sichere Aufbewahrung von Anmeldedaten.

### 🛠️ Konfiguration
```nix
my.services.vaultwarden.enable = true;
```

- **Härtung**: Nutzt "Wake-on-Access" (Socket Activation) via Caddy, um Ressourcen zu sparen, wenn der Tresor nicht genutzt wird.
- **Backup**: Die verschlüsselte SQLite-Datenbank wird täglich via Restic gesichert.

---

## 🏠 Home Automation: Home Assistant (anchor: home-assistant-iot)

Zentraler Hub für alle IoT-Geräte im Haushalt.

### 🛠️ Konfiguration
```nix
my.apps.home-assistant = {
  enable = true;
  bluetooth = true;
  zigbeeDevice = "/dev/serial/by-id/usb-itead_sonoff_zigbee_3.0_usb_dongle_plus_v2-if00-port0";
};
```

- **Hardware-Anbindung**: Direkter Zugriff auf Zigbee/Bluetooth-Adapter via `DeviceAllow`.
- **Zero-Trust**: Home Assistant ist via Caddy und Pocket-ID SSO geschützt.

---

## 📚 Knowledge Archive: Readeck (anchor: readeck-knowledge)

Hocheffizienter "Read-it-later" Dienst zur Archivierung von Web-Inhalten.

### 🛠️ Konfiguration
```nix
my.services.readeck.enable = true;
```

- **Vorteil**: In Go geschrieben, minimaler RAM-Verbrauch.
- **Persistenz**: Speichert Daten in `/persist/var/lib/readeck`.

---

## ✅ Verifizierung

```bash
# 1. Prüfe Paperless OCR Status
systemctl status paperless-worker --no-pager
# Positiv-Test: Web-UI erreichbar
curl -f -s http://127.0.0.1:20981 | grep "Paperless-ngx"
# Negativ-Test: Keine Bindung auf 0.0.0.0
! ss -tulpn | grep ":20981" | grep "0.0.0.0"

# 2. Teste n8n Erreichbarkeit
systemctl status n8n --no-pager
curl -f -I http://127.0.0.1:20203 # Erwartet 200/302

# 3. Prüfe Home Assistant Hardware-Zugriff
systemctl status home-assistant --no-pager
# Prüfe ob Device-Node vorhanden
[ -e /dev/serial/by-id/ ] && echo "Zigbee Stick detected" || echo "Hardware missing"

# 4. Verifiziere Vaultwarden Socket-Aktivierung
ls -l /run/vaultwarden/vaultwarden.sock
# Positiv-Test: Socket muss Caddy-Gruppe gehören
stat -c "%G" /run/vaultwarden/vaultwarden.sock | grep "caddy"
# Negativ-Test: Dienst darf nach Boot noch nicht laufen (Socket Activation)
! systemctl is-active vaultwarden
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)
- [n8n-io/n8n](https://github.com/n8n-io/n8n)
- [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [home-assistant/core](https://github.com/home-assistant/core)

### Context7 Observability
<!-- context7: nixpkgs/nixos/modules/services/misc/paperless.nix -->
<!-- context7: nixpkgs/nixos/modules/services/misc/n8n.nix -->
<!-- context7: nixpkgs/nixos/modules/services/security/vaultwarden.nix -->
<!-- context7: nixpkgs/nixos/modules/services/home-automation/home-assistant.nix -->
<!-- context7: nixpkgs/nixos/modules/services/web-apps/readeck.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-paperless.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-n8n.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-home-assistant.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/modules/apps/service-app-paperless.nix -->
<!-- mcp: nixos:repo_v5/modules/apps/service-app-n8n.nix -->
<!-- mcp: nixos:repo_v5/modules/apps/service-app-vaultwarden.nix -->
<!-- mcp: nixos:repo_v5/modules/apps/service-app-home-assistant.nix -->
<!-- mcp: nixos:repo_v5/modules/apps/service-app-readeck.nix -->

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
