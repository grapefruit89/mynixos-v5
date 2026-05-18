---
title: 70-knowledge-automation
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
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

- **Automatisierung**: Über den `consumptionDir` werden Dokumente automatisch eingelesen, verarbeitet und nach Tier C verschoben.
- **Konfiguration**: `modules/apps/service-app-paperless.nix`.
- **Technik**: Nutzt PostgreSQL als Datenbank und Valkey als Message-Broker/Cache.

---

## 🔗 Workflow Automation: n8n (anchor: n8n-workflows)

n8n fungiert als die "zentrale Logik" zwischen verschiedenen Diensten.

- **Einsatzbereiche**:
  - Webhook-Handling (z.B. GitHub-Alerts an Matrix).
  - Automatisierte Backups-Trigger.
  - Daten-Synchronisation zwischen Cloud-Diensten.
- **Sicherheit**: Läuft in einer isolierten Systemd-Unit mit striktem `PrivateDevices` Schutz.
- **Konfiguration**: `modules/apps/service-app-n8n.nix`.

---

## 🔐 Secrets & Passwords: Vaultwarden (anchor: vaultwarden-secrets)

Vaultwarden (Bitwarden-kompatibel) ist der Standard für die sichere Aufbewahrung von Anmeldedaten.

- **Härtung**: Nutzt "Wake-on-Access" (Socket Activation) via Caddy, um Ressourcen zu sparen, wenn der Tresor nicht genutzt wird.
- **Backup**: Die verschlüsselte SQLite-Datenbank wird täglich via Restic gesichert.
- **Konfiguration**: `modules/apps/service-app-vaultwarden.nix`.

---

## 🏠 Home Automation: Home Assistant (anchor: home-assistant-iot)

Zentraler Hub für alle IoT-Geräte im Haushalt.

- **Hardware-Anbindung**: Direkter Zugriff auf Zigbee/Bluetooth-Adapter via `DeviceAllow`.
- **Zero-Trust**: Home Assistant ist via Caddy und Pocket-ID SSO geschützt (siehe Cluster 50).
- **Integration**: Nutzt MQTT (Mosquitto) als primäres Kommunikationsprotokoll.
- **Konfiguration**: `modules/apps/service-app-home-assistant.nix`.

---

## 📚 Knowledge Archive: Readeck (anchor: readeck-knowledge)

Hocheffizienter "Read-it-later" Dienst zur Archivierung von Web-Inhalten.

- **Vorteil**: In Go geschrieben, minimaler RAM-Verbrauch, keine externen Abhängigkeiten.
- **Persistenz**: Speichert Daten in `/persist/var/lib/readeck`.
- **Konfiguration**: `modules/apps/service-app-readeck.nix`.

---

## ☁️ Cloud Sync & Storage (Planned: OCIS)

Aktuell wird ownCloud OCIS als moderne Cloud-Speicher-Lösung evaluiert. OCIS besticht durch seine Datenbank-lose Architektur (Metadata-on-Disk) und Go-Performance.

---

## ✅ Verifizierung

```bash
# 1. Prüfe Paperless OCR Status
systemctl status paperless-worker
journalctl -u paperless-consumer -f # Beobachte Dokumenten-Import

# 2. Teste n8n Erreichbarkeit
curl -I https://n8n.m7c5.de

# 3. Prüfe Home Assistant Hardware-Zugriff
systemctl status home-assistant
ls -l /dev/serial/by-id/ # Prüfe ob Zigbee-Stick erkannt wurde

# 4. Verifiziere Vaultwarden Socket-Aktivierung
ls -l /run/vaultwarden/vaultwarden.sock
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)
- [n8n-io/n8n](https://github.com/n8n-io/n8n)
- [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [home-assistant/core](https://github.com/home-assistant/core)

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-paperless.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-n8n.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-home-assistant.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/apps/service-app-paperless.nix -->
<!-- mcp: repo_v5/modules/apps/service-app-n8n.nix -->
<!-- mcp: repo_v5/modules/apps/service-app-vaultwarden.nix -->
<!-- mcp: repo_v5/modules/apps/service-app-home-assistant.nix -->
<!-- mcp: repo_v5/modules/apps/service-app-readeck.nix -->
