# 📊 Cluster 50: Monitoring Stack

Dieses Dokument konsolidiert alle Informationen zum Monitoring-Stack in mynixos, einschließlich Gatus, Netdata, InfluxDB und allgemeiner System-Telemetrie.

### Inhalt aus `GUIDE-Monitoring-Hub-Gatus.md`

---
title: 📊 Monitoring Hub: Gatus vs. Uptime Kuma (Layer 80)
category: architecture/monitoring
status: [ACTIVE-SSoT]
capabilities: [health-checks, status-pages, go-efficiency, declarative-monitoring]
sources: [Official Gatus NixOS Module, Reddit Trends 2026]
---

# 📊 Monitoring Hub: Dein System-Wächter

In mynixos priorisieren wir hocheffiziente Monitoring-Lösungen. Hier ist unser Standard für die Dienst-Verfügbarkeit.

## 🏆 1. Gatus (Der SRE-Standard)
Gatus ist unser primäres Tool für Health-Checks und Status-Seiten.
- **Warum:** In Go geschrieben (Binary-Effizienz), rein deklarativ via YAML/Nix steuerbar. ✅
- **NixOS-Modul:** `services.gatus.enable = true;`
- **SRE-Vorteil:** Keine Datenbank-Wartung nötig, minimale CPU-Last. Perfekt für den i3-9100. ✅

## 🐢 2. Uptime Kuma (Legacy Alternative)
Wir behalten Uptime Kuma nur als Option, falls eine grafische Konfiguration via Browser zwingend erforderlich ist.
- **Kritik:** Node.js-basiert (höherer RAM-Verbrauch), benötigt SQLite/MariaDB.
- **Status:** In mynixos als "Deprioritized" markiert. ❌

## ⚙️ Deklarative Gatus-Konfiguration
```nix
services.gatus = {
  enable = true;
  settings = {
    endpoints = [
      {
        name = "Caddy Ingress";
        url = "https://m7c5.de";
        interval = "1m";
        conditions = [ "[STATUS] == 200" ];
      }
    ];
  };
};
```

## 🚀 SRE-Anwendung
Das Monitoring-Dashboard wird via Caddy (Kapitel 58) unter `status.m7c5.de` exponiert und via mTLS gesichert.

### Inhalt aus `GUIDE-System-Monitoring-Telemetry.md`

---
title: 📈 System Monitoring & Telemetry (Layer 80-monitoring)
category: architecture/monitoring
status: [ACTIVE-SSoT]
capabilities: [real-time-metrics, igpu-monitoring, data-recovery, log-externalization]
sources: [nixpkgs/pkgs/tools/system, netdata docs, nvtop intel support]
---

# 📈 Monitoring: Die Augen des SRE

In mynixos lassen wir keine Komponente unbeobachtet. Wir nutzen hocheffiziente Werkzeuge, um die Gesundheit des Towers (Fuji Q958) zu garantieren.

## 🏛️ 1. Echtzeit-Performance via Netdata
Wir nutzen Netdata für die totale Transparenz ohne merkliche CPU-Last.
- **Dienst:** `services.netdata.enable = true;`
- **SRE-Vorteil:** Visualisiert Hardware-Metriken (CPU C-States, ZFS-ARC, Disk-Latency) im Web-UI auf Port 19999. ✅

## 📽️ 2. iGPU Monitoring (`nvtop`)
Um den Erfolg von Kapitel 51 (QuickSync) zu überwachen.
- **Tool:** `pkgs.nvtopPackages.intel`.
- **Befehl:** `nvtop` zeigt die Auslastung des Video-Engines und des Grafik-RAMs in einer htop-ähnlichen Ansicht. ✅

## 🛡️ 3. Disaster Recovery (`testdisk`)
Unsere Lebensversicherung für den Storage-Layer (ADR-006).
- **Anwendung:** Wird nicht als Dienst gestartet, ist aber im SRE-Profil (`environment.systemPackages`) vorinstalliert.
- **Zweck:** Wiederherstellung von gelöschten Partitionen oder Dateien auf Tier-C.

## 🚀 SRE-Anwendung
Das Monitoring ist via Caddy (Kapitel 58) unter `stats.m7c5.de` erreichbar und durch mTLS sowie Pocket-ID geschützt.

### Inhalt aus `MASTER-CONFIG-GATUS.md`

---
title: 📚 Gatus MASTER-CONFIG-REFERENCE (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
capabilities: [declarative-monitoring, health-api, matrix-alerting, prometheus-export]
sources: [https://github.com/TwiN/gatus (Source Audit)]
---

# 📚 Gatus: Die hocheffiziente Monitoring-Referenz

Dieses Dokument dient als technischer Schaltplan für die Implementierung von Gatus in mynixos.

## 🏛️ 1. Kern-Schnittstellen (SRE Ingress)
Diese Endpunkte werden via Caddy (Layer 10) exponiert:
- `/health`: Selbstüberwachung von Gatus.
- `/metrics`: Exportiert Daten im Prometheus-Format (Layer 80).
- `/api/v1/statuses`: JSON-Feed für externe Dashboards (z.B. Homepage).

## 🛡️ 2. Alerting-Konfiguration (Aviation-Grade)
Wir binden Matrix als primären Alarm-Kanal ein:
```yaml
alerting:
  matrix:
    homeserver: "https://matrix.m7c5.de"
    room-id: "!roomid:m7c5.de"
    access-token: "${MATRIX_TOKEN}" # Via Sops injiziert
```

## ⚙️ 3. Deklarative Strategie (NixOS)
In mynixos nutzen wir `services.gatus.settings`. Jede neue App (Dendrit) registriert sich automatisch in dieser Liste.
- **Speicherung:** Gatus kann SQLite nutzen, wir bevorzugen aber den **In-Memory-Modus** für maximale Effizienz auf dem Tower (Fuji Q958). ✅

## 🚀 SRE-Anwendung
Gatus ist das "Frühwarnsystem". Es informiert uns via Matrix, bevor ein User merkt, dass Jellyfin oder Nextcloud hängen.

### Inhalt aus `GUIDE-Modern-Monitoring-Influx3.md`

---
title: 📊 InfluxDB 3: High-Performance Telemetry (Layer 80-monitoring)
category: architecture/monitoring
status: [PROPOSED]
capabilities: [time-series-database, high-granularity, netdata-backend, long-term-retention]
sources: [ipv64.net (Dennis Schröder), Influxdata Docs]
---

# 📊 InfluxDB 3: Das Gedächtnis deiner Hardware

In mynixos nutzen wir InfluxDB 3 als hocheffizienten Speicher für Telemetrie-Daten des Fujitsu Q958.

## 🏛️ 1. Warum InfluxDB 3?
- **Speed:** Massive Performance-Steigerung gegenüber Version 2. ✅
- **Storage:** Optimierte Kompression für Zeitreihen-Daten.
- **Nix-Native:** Integration via `services.influxdb` Modul.

## ⚙️ 2. Architektur-Integration
InfluxDB fungiert als Senke für:
1. **Netdata Metriken:** Sekündliche CPU/RAM/Disk-Daten (Kapitel 63).
2. **Gatus Health-Logs:** Historie der Dienst-Verfügbarkeit (Kapitel 76).
3. **Smartd Events:** Langzeit-Trend der HDD-Gesundheit.

## 🚀 SRE-Anwendung
Die Datenbank liegt auf **Tier A (ZFS NVMe)**, um maximale Schreib-Performance zu garantieren. Durch die Kompression bleibt der State dennoch klein (< 5GB), was unser **Offsite-Backup Mandat (ADR-015)** unterstützt.

### Inhalt aus `GUIDE-Next-Gen-Monitoring-Gatus.md`

---
title: 📊 Gatus: Next-Gen Monitoring (Layer 80-monitoring)
category: architecture/monitoring
status: [PROPOSED]
capabilities: [single-binary, yaml-config, health-checks, status-page]
sources: [r/selfhosted Trends 2026, Gatus GitHub]
---

# 📊 Gatus: Der hocheffiziente Watchtower

In mynixos evaluieren wir Gatus als hocheffiziente Alternative zu Uptime Kuma. Es folgt dem **Binary-Efficiency-Mandat** und dem **No-UI-Config Standard**.

## 🏛️ 1. Warum Gatus?
- **Technologie:** In Go geschrieben. ✅
- **Konfiguration:** Rein deklarativ via YAML (kein Herumklicken in einer UI nötig).
- **Ressourcen:** Minimaler RAM-Footprint im Vergleich zu Node.js-basierten Lösungen.

## ⚙️ 2. Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/80-monitoring/gatus.nix`):

```nix
services.gatus = {
  enable = true;
  settings = {
    endpoints = [
      {
        name = "Caddy Gateway";
        url = "https://m7c5.de";
        interval = "1m";
        conditions = [ "[STATUS] == 200" ];
      }
      {
        name = "Jellyfin";
        url = "http://localhost:8096/health";
        interval = "1m";
        conditions = [ "[STATUS] == 200" ];
      }
    ];
  };
};
```

## 🛡️ 3. SRE-Vorteil
Da Gatus seine gesamte Konfiguration aus einer Datei liest, ist es zu 100% reproduzierbar. Ein Rollback deines NixOS-Flakes stellt auch sofort alle deine Health-Checks wieder her. ✅

## 🚀 SRE-Anwendung
Gatus wird via Caddy unter `status.m7c5.de` öffentlich (oder via VPN) zugänglich gemacht. Es dient als SSoT für die Verfügbarkeit deiner Dienste.
