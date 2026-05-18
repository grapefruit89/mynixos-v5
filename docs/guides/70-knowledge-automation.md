# 🧠 Cluster 70: Knowledge & Automation

Dieses Dokument konsolidiert alle Informationen zu Wissensmanagement, Cloud-Speicher und Automatisierung in mynixos, einschließlich n8n, ownCloud OCIS, Paperless-ngx und Readeck sowie automatisierter Dokumentation.

### Inhalt aus `GUIDE-Automated-Documentation-Mastery.md`

---
title: 📊 Automated Documentation & Visualization (Layer 50-knowledge)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [diagram-as-code, telemetry-plotting, qr-barcode-processing]
sources: [nixpkgs/pkgs/tools/graphics, graphviz docs, mermaid-cli]
---

# 📊 Visualisierung: Wissen sichtbar machen

In mynixos nutzen wir hocheffiziente Headless-Tools, um die System-Architektur und Telemetrie automatisch zu visualisieren.

## 🏛️ 1. Infrastructure-as-Code (Mermaid & Graphviz)
Wir nutzen textbasierte Beschreibungen für unsere Netzwerk-Pläne.
- **Dienst:** `pkgs.graphviz` und `pkgs.mermaid-cli`.
- **Anwendung:** Automatisches Rendering deiner `ADRs` in der Knowledge-Pipeline.

## 📈 2. Telemetrie-Plotting (Gnuplot)
Für die Langzeit-Überwachung der Hardware (Fuji Q958).
- **Nugget:** Gnuplot erzeugt statische Bilder aus CSV-Daten deiner Monitoring-Dienste (Layer 80).
- **Vorteil:** Keine riesige InfluxDB/Grafana-Instanz für einfache Hardware-Historien nötig. ✅

## 🏷️ 3. Dokumenten-Automation (Zbar)
Integration in den Dokumenten-Workflow (Layer 50).
- **Dienst:** `pkgs.zbar`.
- **Anwendung:** Automatisches Auslesen von QR-Codes auf gescannten Dokumenten zur Verschlagwortung in Paperless-ngx.

## 🚀 SRE-Vorteil
Diese Tools folgen dem **Headless-Gesetz (ADR-010)**. Sie benötigen keinen Desktop und belasten das System nur während des Generierungsvorgangs.

### Inhalt aus `GUIDE-Cloud-Storage-OCIS.md`

---
title: ☁️ ownCloud Infinite Scale (OCIS) Master-Config
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [cloud-storage, go-performance, oidc-ready, database-less]
sources: [https://github.com/owncloud/ocis, NixOS Manual]
---

# ☁️ ownCloud OCIS: Deine Cloud in Go

In mynixos setzen wir auf ownCloud Infinite Scale (OCIS) als modernen Cloud-Speicher (Layer 50-knowledge).

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Sprache:** Go (Binary-Mandat erfüllt).
2.  **Datenbank-los:** OCIS nutzt ein Metadaten-System auf dem Dateisystem. Keine MySQL/PostgreSQL für die Cloud-Struktur nötig (RAM-Ersparnis).
3.  **Identity:** Nativer OIDC-Support (perfekt für PocketID).

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/50-knowledge/cloud.nix`):

```nix
services.ocis = {
  enable = true;
  url = "https://cloud.m7c5.de";
  port = 9200;
  address = "127.0.0.1";
  environment = {
    OCIS_LOG_LEVEL = "info";
    # Weitere Variablen für Storage-Backends
  };
  # Secrets via Sops
  environmentFile = config.sops.secrets."ocis/env".path;
};
```

## 🛡️ SRE-Hardening
- **Isolation:** OCIS läuft als dedizierter User und nutzt systemd-Härtung.
- **Ingress:** Caddy (Layer 20) übernimmt das TLS-Termination und mTLS-Sicherung.
- **Storage-Mapping:** Die Cloud-Daten liegen in `/persist/var/lib/ocis` (Impermanence Standard).

### Inhalt aus `GUIDE-Knowledge-Mastery-Readeck.md`

---
title: 📚 Readeck: Knowledge Mastery (Layer 50-knowledge)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [bookmark-management, read-later, full-text-archiving, go-performance]
sources: [https://readeck.org/, NixOS Search]
---

# 📚 Readeck: Dein externes Gehirn

In mynixos nutzen wir Readeck als zentralen Dienst für Bookmarks und das Archivieren von Web-Inhalten.

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Wahl:** Readeck gewinnt gegen Linkding durch native Nixpkgs-Integration und Go-Binary Performance.
2.  **Datenbank:** Nutzt SQLite (Standard). ✅
3.  **Self-Contained:** Keine externen Abhängigkeiten wie Redis nötig.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/50-knowledge/readeck.nix`):

```nix
# Readeck hat momentan kein fertiges Services-Modul, wir bauen es als systemd-unit
systemd.services.readeck = {
  description = "Readeck Web Archiver";
  after = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];
  serviceConfig = {
    ExecStart = "${pkgs.readeck}/bin/readeck serve";
    User = "readeck";
    Group = "readeck";
    StateDirectory = "readeck";
    Environment = [ "READECK_LOG_LEVEL=info" ];
  };
};
```

## 🛡️ SRE-Hardening
- **Ingress:** Sicherung via Caddy über `read.m7c5.de`.
- **Storage:** Persistierung des SQLite-Files in `/persist/var/lib/readeck`.

### Inhalt aus `GUIDE-Paperless-Master-Config.md`

---
title: 📄 Paperless-ngx Master-Config (Layer 50-knowledge)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [declarative-configuration, ocr-optimization, lightweight-db]
sources: [https://github.com/paperless-ngx/paperless-ngx, NixOS Manual]
---

# 📄 Paperless-ngx: Dein digitales Archiv

In mynixos nutzen wir Paperless-ngx nativ für maximale Performance und totale deklarative Kontrolle.

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Datenbank:** Wir nutzen **SQLite**. Für den Heimgebrauch (Tower) ist SQLite hocheffizient und benötigt keinen extra Datenbank-Daemon (RAM-Ersparnis).
2.  **Storage:** Alle Dokumente liegen in `/persist/var/lib/paperless/media` (Impermanence Standard).
3.  **OCR:** Wir nutzen `PAPERLESS_OCR_LANGUAGE = "deu+eng"`.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/50-knowledge/paperless.nix`):

```nix
services.paperless = {
  enable = true;
  address = "0.0.0.0";
  port = 28981;
  settings = {
    # Hier kommen alle App-Variablen rein!
    PAPERLESS_TIME_ZONE = "Europe/Berlin";
    PAPERLESS_OCR_LANGUAGE = "deu+eng";
    PAPERLESS_OCR_MODE = "clean";
    PAPERLESS_AUTO_LOGIN_USERNAME = "admin"; # Nur lokal sicher!
    PAPERLESS_FILENAME_FORMAT = "{{created_year}}/{{correspondent}}/{{title}}";
  };
  # Secrets (API-Keys etc.) kommen hier rein:
  environmentFile = config.sops.secrets."paperless/env".path;
};
```

## 🛡️ SRE-Hardening
- Der Dienst wird via Caddy (Layer 20) über `paperless.m7c5.de` mit mTLS abgesichert.
- Der Konsum-Ordner (`consumptionDir`) wird für den Scanner im Netzwerk freigegeben.

### Inhalt aus `GUIDE-Webhook-Automation-n8n.md`

---
title: 🔗 Webhook Orchestrierung (n8n & Caddy)
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [instant-deployment, real-time-alerting, event-driven-sre]
sources: [GitHub Webhook Documentation, n8n Docs]
---

# 🔗 Webhooks: Die Nervenbahnen deines Systems

Webhooks verbinden deinen externen Code (GitHub) mit der physischen Realität deines Towers.

## 🏛️ 1. Der Workflow (GitHub -> n8n)
Wir nutzen n8n als zentralen Event-Handler.
1. **GitHub:** Sendet POST-Paket bei Push-Event.
2. **Caddy (Layer 10):** Reicht die Anfrage sicher an n8n weiter (`hooks.m7c5.de`).
3. **n8n (Layer 30):** Verarbeitet die Daten und triggert Aktionen (Matrix-Nachricht, System-Update).

## 🚀 2. Aviation-Grade Anwendungen
- **Auto-Rebuild:** Trigger für `nixos-rebuild` bei Änderungen am Master-Branch. ✅
- **Emergency-Shutdown:** Ein Webhook, der von einer externen Monitoring-Instanz kommt, falls der Tower überhitzt.
- **Sync-Kickstart:** Startet den Offsite-Backup-Sync manuell via externem Signal.

## 🛡️ 3. Security (HMAC-Validation)
Webhooks sind nur sicher, wenn wir die Herkunft prüfen.
- **Geheimnis:** Wir hinterlegen ein Webhook-Secret in GitHub.
- **Prüfung:** n8n validiert die `X-Hub-Signature-256` mithilfe unseres Sops-Secrets. Unbefugte können keine Aktionen triggern. ✅

## 🚀 SRE-Anwendung
Webhooks machen deine Infrastruktur "Event-Driven". Dein Tower reagiert in Millisekunden auf Änderungen in der Cloud.

### Inhalt aus `MASTER-CONFIG-N8N.md`

---
title: 📚 n8n MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [https://github.com/n8n-io/n8n]
---

# 📚 n8n: Automatisierungs-Referenz

... (Gekürzt für Übersicht, enthält hunderte n8n-Variablen) ...

### Inhalt aus `MASTER-CONFIG-OCIS.md`

---
title: 📚 ownCloud OCIS MASTER-REFERENCE (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
capabilities: [configuration-audit, api-endpoints, go-performance, cloud-mastery]
sources: [https://github.com/owncloud/ocis (Source Code Extraction)]
---

# 📚 ownCloud OCIS: Vollständige Referenz

... (Gekürzt für Übersicht, enthält OCIS-Variablen) ...

### Inhalt aus `MASTER-CONFIG-PAPERLESS-NGX.md`

---
title: 📚 Paperless-ngx MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
capabilities: [configuration-audit, env-vars, total-declarative-control]
sources: [https://github.com/paperless-ngx/paperless-ngx (Source Code Extraction)]
---

# 📚 Paperless-ngx: Vollständige Variablen-Referenz

... (Gekürzt für Übersicht, enthält Paperless-Variablen) ...
