# 💬 Cluster 80: Matrix Sovereign

Dieses Dokument konsolidiert alle Informationen zur souveränen Kommunikation via Matrix in mynixos, einschließlich Conduit, Matrix-Orchestrierung und allgemeiner Matrix-Standards.

### Inhalt aus `GUIDE-Conduit-Master-Config.md`

---
title: 🦀 Conduit Master-Config (Aviation-Grade Matrix)
category: architecture/communications
status: [ACTIVE-SSoT]
capabilities: [rust-performance, embedded-db, matrix-federation]
sources: [https://github.com/girlbossceo/conduit, NixOS Manual]
---

# 🦀 Conduit: Dein Matrix-Server in Rust

In mynixos ist Conduit der SSoT-Kommunikations-Server. Er ist hocheffizient und wartungsfrei.

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Sprache:** Rust (Binary-Mandat erfüllt).
2.  **Datenbank:** Eingebettet (Sled). Keine externe PostgreSQL nötig (RAM-Ersparnis).
3.  **Sicherheit:** Läuft als `DynamicUser` mit minimalen Berechtigungen.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/30-services/matrix.nix`):

```nix
services.matrix-conduit = {
  enable = true;
  settings.global = {
    server_name = "m7c5.de";
    port = 6167;
    allow_registration = false; # Sicherheit geht vor!
    allow_federation = true;
    database_backend = "rocksdb"; # Oder standard sled
  };
};
```

## 🛡️ SRE-Hardening
- **Port-Isolation:** Der Dienst hört nur auf `127.0.0.1`.
- **Ingress:** Caddy (Layer 20) übernimmt das TLS-Offloading und die `/_matrix/` Routen.
- **Secrets:** Das JWT-Secret wird via `services.matrix-conduit.secretFile` aus Sops eingebunden.

### Inhalt aus `GUIDE-Matrix-Orchestration-CLI.md`

---
title: 🤖 Matrix Orchestration & Alerting (Layer 30-automation)
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [e2ee-alerting, system-voice, automated-logs, cli-matrix]
sources: [nixpkgs/pkgs/applications/networking/instant-messengers/matrix-commander, matrix-hook]
---

# 🤖 System-Kommunikation: Der Tower spricht

In mynixos ist der Matrix-Homeserver (Conduit) nicht nur zum Chatten da. Er ist die zentrale Pipeline für alle SRE-Warnungen und System-Statusberichte.

## 🏛️ 1. Das Alerting-Konzept (Aviation-Grade)
Wir trennen zwischen zwei Workflows:
- **Matrix-Hook (High-Speed):** Für einfache Status-Messages via `curl`.
- **Matrix-Commander (Secure):** Für verschlüsselte (E2EE) Berichte und Datei-Uploads (z.B. Backup-Logs).

## ⚙️ 2. Matrix-Commander (The Secure Voice)
- **Tool:** `pkgs.matrix-commander`.
- **Anwendung:**
```bash
matrix-commander --message "🚨 SRE Alert: SMART Check auf Tier-C HDD fehlgeschlagen!"
```
- **SRE-Vorteil:** Unterstützt native Verschlüsselung. Deine kritischen System-Interna verlassen den Tower niemals im Klartext. ✅

## 🏷️ 3. Integration in Layer 80 (Monitoring)
Wir binden den Commander in unsere systemd-Timer ein:
- **Backup-Success:** Sendet eine grüne Nachricht nach jedem erfolgreichen Restic-Run.
- **Fail2ban-Alert:** Sendet die IP-Adresse bei einer permanenten Sperrung.
- **Update-Check:** Informiert über neue NixOS-Releases.

## 🚀 SRE-Anwendung
Der Matrix-Commander folgt dem **Headless-Gesetz (ADR-010)**. Er benötigt keinen Desktop und ist die stabilste Schnittstelle zwischen deinem Server und deinem Smartphone.

### Inhalt aus `GUIDE-Sovereign-Communication-Matrix.md`

---
title: 💬 Sovereign Communication (Matrix Standard)
category: architecture/communications
status: [ACTIVE-SSoT]
capabilities: [matrix-protocol, decentralized-chat, sre-alerting]
sources: [https://github.com/matrix-org/matrix-spec, https://github.com/matrix-org/dendrite]
---

# 💬 Sovereign Communication: Der Matrix Standard

In mynixos ist Matrix nicht nur ein Chat, sondern die zentrale Nervenbahn für System-Events, Alerts und sichere Kommunikation.

## 🚀 Warum Matrix?
- **Souveränität:** Du besitzt deine Daten und deine Identität.
- **Interoperabilität:** Föderation erlaubt Kommunikation mit anderen Servern.
- **SRE-Ready:** Native Webhooks (`matrix-hook`) erlauben einfaches Alerting.

## 🏛️ Architektur-Wahl (Efficiency Gate)
Wir nutzen **Dendrite (Go)** oder **Conduit (Rust)**.
- **Vorteil:** Bruchteil des Ressourcenverbrauchs von Synapse (Python).
- **Hardening:** Die Datenbank wird via Sops-Secrets angebunden.

## 🧩 Modul-Integration (Layer 30-services)
Der Matrix-Dienst wird als Dendrit in `modules/30-services/matrix.nix` deklariert und injiziert seinen eigenen Caddy-Proxy (Ingress).
