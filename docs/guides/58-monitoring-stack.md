---
title: 58-monitoring-stack
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/services/service-gatus.nix
    anchor: gatus-health
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-gatus.nix
  - path: modules/services/service-gatus.nix
    anchor: health-endpoints
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-gatus.nix
  - path: modules/services/service-netdata.nix
    anchor: netdata-telemetry
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-netdata.nix
---

# Cluster 58: Monitoring Stack

Dieses Dokument beschreibt die Observability-Architektur von mynixos, die auf maximaler Transparenz bei minimalem Ressourcenverbrauch basiert.

---

## 🏆 Gatus: Health Dashboard (anchor: gatus-health)

Gatus ist unser primärer "Watchtower". Es führt kontinuierlich Health-Checks gegen alle Dienste aus und stellt den Status auf einem übersichtlichen Dashboard dar.

- **Konfiguration**: `modules/services/service-gatus.nix`.
- **Technik**: In Go geschrieben, hocheffizient, nutzt SQLite für die Historie.
- **SRE-Vorteil**: Rein deklarative Definition von Endpunkten über Nix.

### 🔍 Health Endpoints (anchor: health-endpoints)
Gatus überwacht kritische Systemkomponenten bevorzugt über **Unix-Sockets**, um Netzwerklast zu vermeiden und die Sicherheit zu erhöhen:
- **Caddy**: `/run/caddy/admin.sock`
- **Jellyfin**: `/run/jellyfin/jellyfin.sock`
- **PostgreSQL**: `/run/postgresql/.s.PGSQL.5432`

---

## 📈 Netdata: Echtzeit-Telemetrie (anchor: netdata-telemetry)

Netdata liefert hochauflösende Metriken (pro Sekunde) für Hardware und Betriebssystem.

- **Konfiguration**: `modules/services/service-netdata.nix`.
- **Speicherung**: Nutzt die `dbengine` für Langzeit-Retention (Standard: 30 Tage).
- **Härtung**: Das Web-Interface ist via Unix-Socket an Caddy gebunden und durch `admin_auth` (LAN-only) geschützt.

---

## 📽️ iGPU Monitoring

Für die Überwachung der Hardware-Beschleunigung (QuickSync) nutzen wir `nvtop` (intel-spezifisch).
- **Tool**: `pkgs.nvtopPackages.intel`.
- **Visualisierung**: Zeigt Video-Engine-Auslastung und iGPU-RAM-Verbrauch.

---

## 🔔 Alerting (Matrix & ntfy)

Fehler werden proaktiv gemeldet, bevor sie den User beeinträchtigen.
- **ntfy**: Gatus sendet kritische Alarme direkt an den lokalen ntfy-Server (Cluster 15).
- **Matrix**: Administrative Alerts werden über Conduit (Cluster 80) in dedizierte SRE-Räume gepusht.

---

## ✅ Verifizierung

```bash
# 1. Prüfe Gatus Status & Endpunkte
systemctl status gatus
curl -s http://127.0.0.1:8080/api/v1/health | jq

# 2. Prüfe Netdata Socket-Verbindung
ss -lx | grep netdata.sock

# 3. Starte iGPU Monitoring (Interaktiv)
nvtop

# 4. Teste ntfy Alerting (Manueller Trigger)
curl -d "TEST: Gatus Alert Simulation" https://ntfy.m7c5.de/gatus-alerts
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [TwiN/gatus](https://github.com/TwiN/gatus) - Health Dashboard
- [netdata/netdata](https://github.com/netdata/netdata) - Real-time monitoring

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-gatus.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/service-netdata.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/services/service-gatus.nix -->
<!-- mcp: repo_v5/modules/services/service-netdata.nix -->
