# 🏗️ ADR: Architektur-Destillat (Forensic Audit)

> **STATUS: HISTORISCH / REFERENCE**  
> Dieses Dokument dient als historische Sammlung von Konzepten und theoretischen Entwürfen.  
> **WICHTIG:** Nicht alle hier beschriebenen Konzepte (z.B. Tailscale, Lanzaboote, ZFS) wurden in der finalen `repo_v5` umgesetzt oder sind mit den aktuellen Sicherheitsrichtlinien (`ANTIPATTERN.md`) vereinbar.

Dieses Dokument ist das Ergebnis einer hochpräzisen Destillation von 61 Chat-Logs. Es enthält die finalen, theoretisch am weitesten entwickelten Lösungen und Paradigmen.

---

## 16. Boot-Watchdog & Auto-Rollback

### THE BEST VERSION
Ein spezialisierter Systemd-Dienst, der die Systemintegrität nach dem Boot validiert.

### DOs
*   **Health-Check**: Prüfe 120s nach Boot: Netzwerk-Ping, Caddy-Port 80/443 und Postgres-Socket.
*   **Hard Rollback**: Bei Fehlschlag automatisiert `nixos-rebuild --rollback` ausführen und neu starten.

---

## 17. Jellyfin Metadaten & Storage-Tiering

### THE BEST VERSION
Trennung von flüchtigen und permanenten Media-Daten.

### DOs
*   **Metadaten-Persistenz**: `/var/lib/jellyfin` muss auf **Tier A (NVMe)** persistiert werden, um Scraping-Loops zu vermeiden.
*   **Transcode-Cache**: `/var/cache/jellyfin` (Transcodes) kann auf `tmpfs` oder Tier B bleiben.

---

## 01. Impermanence & State-Isolation (Root-on-RAM)

### THE BEST VERSION
Root-Dateisystem auf `tmpfs` (RAM), Persistenz ausschließlich über das `impermanence` Modul auf eine dedizierte `/persist` Partition (**zwingend ZFS** für Snapshot-Rollbacks).

### MANDATORY PERSISTENCE LIST
| Pfad | Grund |
| :--- | :--- |
| `/etc/machine-id` | System-Identität |
| `/etc/ssh/ssh_host_*_key*` | SSH-Fingerprints |
| `/var/lib/caddy` | Let's Encrypt Zertifikate |
| `/var/lib/postgresql` | Datenbank-Integrität |
| `/var/lib/tailscale` | VPN-Identität |
| `/var/lib/jellyfin` | Mediathek-Metadaten |
| `/home` | Benutzerdaten |

---

## 18. Gemini-CLI Lockdown (Security)

### THE BEST VERSION
KI-Agenten erhalten minimale Rechte ohne Zugriff auf die Systemkonfiguration.

### DOs
*   **Sudo-Wrapper**: Nur `docker start/stop` via Sudo erlauben. User darf NICHT in der Gruppe `docker` sein.
*   **Namespace-Isolation**: Der Agent-Dienst nutzt `BindReadOnlyPaths = [ "/etc/nixos" ]`, um Dateimanipulationen zu verhindern.

---

## 07. Zero-Trust Networking (Outbound)

### THE BEST VERSION
Jeder Dienst erhält eine eigene nftables-Chain, die ausgehende Verbindungen basierend auf der Benutzer-ID (**skuid**) filtert.

```nftables
chain jellyfin_out {
  meta skuid jellyfin ip daddr { 18.165.1.12, 54.74.31.43 } tcp dport 443 accept
  meta skuid jellyfin reject
}
```

### DOs
*   **DNS-Logging**: Alle Anfragen mit `log prefix "ZT-DNS: "` protokollieren, um Whitelists zu erstellen.
*   **UID-Bindung**: Regeln zwingend an UIDs knüpfen (statische UIDs in `auto-users.nix` erforderlich).

### DON'Ts (DISCARDED)
*   ❌ **Caddy als Outbound-Proxy**: Abgelehnt. Zu komplex und performancelastig. nftables ist der effizientere Weg.

---

## 08. Application Whitelisting (fapolicyd)

### THE BEST VERSION
Nur Binaries aus vertrauenswürdigen Quellen dürfen ausgeführt werden.

### DOs
*   **Trusted Sources**: `/nix/store` und `/run/current-system/sw/bin` sind Standard.
*   **nix-shell Escape**: Erlaube `/run/user/*/nix-shell-*`, um interaktive Arbeit zu ermöglichen.

### DON'Ts (DISCARDED)
*   ❌ **Ausführung aus /home**: Absolut verboten. Eigene Skripte gehören in den Store (via Nix-Paket) oder in eine isolierte Dev-VM.

---

## 09. Isolation der Entwicklungsumgebung

### THE BEST VERSION
Strikte Trennung zwischen **gehärteter Appliance (Host)** und **Entwicklung (VM)**.

### DOs
*   **Dev-VM**: Nutze libvirt/QEMU für eine ungehärtete NixOS-VM. Dort sind `nix-shell` und ad-hoc Skripte erlaubt.
*   **Host-Sicherheit**: Das Wirtssystem führt niemals ungetesteten Code oder Skripte außerhalb des Stores aus.


---

## 04. Proactive Detection (Detective Controls)

### THE BEST VERSION
Einsatz von **Falco** oder **auditd** zur Echtzeit-Überwachung von Prozess-Spawn-Events und Dateisystem-Canarys.

### DOs
*   **Auditd-Rules**: Überwachung von `execve` Systemcalls, um "Living-off-the-Land" (LotL) Angriffe zu erkennen.
*   **Canary Files**: Erstellung von "Honey-Files" in `/persist`, die via `systemd.path` bei Zugriff einen sofortigen Lockdown auslösen.

### DON'Ts (DISCARDED)
*   ❌ **Russian Language Trick**: Abgelehnt als "Paranoia-Lärm". Bietet keinen echten Schutz für Aviation-Grade Systeme.

---

## 13. Horizontal Responsibility (Layer 00-90)

### THE BEST VERSION
Strikte Trennung des Systems in funktionale Schichten, die isomorph zur Repository-Struktur sind.

*   **00-core**: Fundament (Hardware, SSH, Security-Basics).
*   **10-gateway**: Ingress (Caddy, DNS, PocketID).
*   **20-infrastructure**: Ressourcen (Postgres, Storage, VPN-Vault).
*   **40-media**: Media-Stack (*arr, Jellyfin).
*   **90-policy**: Systemweite Leitplanken (Assertions, Binary-Only).

### DOs
*   **Self-Contained Files**: Jeder Dienst deklariert seinen Port, seinen Proxy-Host und seinen State in einer einzigen Datei.
*   **Flat-Layout**: Keine Unterordner innerhalb der Layer erlaubt (erzwungen durch Assertion in Layer 90).

---

## 14. Zentrales Port-Register (SSOT)

### THE BEST VERSION
Alle Ports werden zentral in `00-core/ports.nix` definiert und via `config.my.ports` in die Module injiziert.

### DOs
*   **Port-Schema**: 10xxx für Infrastruktur, 20xxx für Anwendungen.
*   **Kollisionsprüfung**: Automatisierte Warnung im Build-Prozess, falls ein Port mehrfach vergeben wurde.

---

## 19. SSO Identity vs. Network Trust (C-01)

### THE BEST VERSION
Strikte Trennung von Netzwerk-Zugang (IP-Ebene) und Authentifizierung (Identitäts-Ebene).

### DOs
*   **No IP Bypasses**: Keine `remote_ip`-Ausnahmen für SSO. Jeder Dienst (außer Public-Frontends) erfordert `import sso_auth`.
*   **Tailscale Roles**: Tailscale dient nur als sicherer Tunnel, ersetzt aber niemals die Benutzeranmeldung am OIDC-Provider (Pocket-ID).

---

## 20. Disaster Recovery & SOPS-Zertifikate (Henne-Ei)

### THE BEST VERSION
Secrets müssen auch bei einem Totalverlust der Hardware (NVMe/Host-Key) wiederherstellbar sein.

### DOs
*   **Multi-Key Encryption**: Jedes Secret wird für den Server-Key UND einen externen Admin-Key (Laptop/YubiKey) verschlüsselt.
*   **Offsite Age-Key**: Der private Teil des Admin-Keys liegt sicher im Passwort-Manager oder auf einem physischen Medium außerhalb des Servers.

### DON'Ts (DISCARDED)
*   ❌ **Einfache Verschlüsselung**: Secrets nur für den Host-Key zu verschlüsseln ist verboten (Disaster-Gefahr).

---

## 21. Sicherer CLI-Input (OliveTin/Shell)

### THE BEST VERSION
Verhinderung von Shell-Injection durch strikte Variablen-Trennung.

### DOs
*   **Env-Transition**: Variablen aus Web-UIs (OliveTin) niemals direkt in Shell-Strings interpolieren (`'{{ input }}'`).
*   **Wrapper**: Nutzung von `systemd.LoadCredential` oder Übergabe via `Environment` im Service-Context.

---

## 28. Die Hardening-Factory (mkHardenedService)

### THE BEST VERSION
Zentralisierung aller Systemd-Härtungsparameter in einer erweiterbaren Factory-Funktion innerhalb der `lib-helpers.nix`.

### DOs
*   **Strikte Defaults**: Jeder Service nutzt standardmäßig `ProtectSystem=strict`, `PrivateTmp=true`, `NoNewPrivileges=true` und einen restriktiven `SystemCallFilter`.
*   **Capabilty-Whitelisting**: Explizite Schalter für `gpuAccess` (Jellyfin) und `serialAccess` (Zigbee2MQTT), um `PrivateDevices` gezielt zu lockern.
*   **Score-Garantie**: Ziel ist ein `systemd-analyze security` Score von > 8.0 für jeden Dienst.

---

## 29. Low-Hanging Fruits (System-Härtung)

### THE BEST VERSION
Schrittweise Übernahme bewährter Härtungs-Parameter ohne Abhängigkeit von instabilen Alpha-Modulen.

### DOs
*   **Kernel-Schutz**: `kernel.unprivileged_userns_clone = 0` und `vm.unprivileged_userfaultfd = 0` zur Unterbindung von Container-Eskalationsvektoren.
*   **Dateisystem**: `/proc` mit `hidepid=2` mounten, `/tmp` mit `noexec,nosuid,nodev`.
*   **Core-Dumps**: Vollständige Deaktivierung via `systemd.coredump.enable = false` und `kernel.core_pattern = |/bin/false`.

---

## 31. Foto-Management Strategie

### THE BEST VERSION
Zweistufiger Ansatz basierend auf Hardware-Ressourcen und Nutzungsbedarf.

### DOs
*   **piGallery2 (Einstieg)**: Directory-first, extrem schlank (<200MB RAM). Ideal für bestehende Sammlungen auf Tier C.
*   **Immich (High-End)**: Native NixOS-Integration nutzen. Bietet Mobile-Apps und ML (Gesichtserkennung), benötigt aber Postgres + Redis + 2-4GB RAM.

---

## 32. SSH-Hardening (No-Password Policy)

### THE BEST VERSION
Vollständige Eliminierung des Passwort-Vektors für SSH-Zugriffe.

### DOs
*   **Nuke Passwords**: `PasswordAuthentication = false` und `ChallengeResponseAuthentication = false`.
*   **Key-Only**: Nur Hardware-gebundene Keys oder Passkeys erlauben. 
*   **Fail2ban-Reduktion**: Deaktivierung von Fail2ban für SSH (da kein Brute-Force möglich), stattdessen Fokus auf Caddy-Logs.

---

## 33. Resilience Roadmap 2026 (Final)

### PHASE 1: HARDENING BY DEFAULT (Wochenende)
*   Implementierung `mkHardenedService` in `lib-helpers.nix`.
*   Bereinigung aller `mkForce`-Kollisionen bei der Swappiness.
*   Fix der Port 8080 Kollision via `ports.nix` Registry.

### PHASE 2: LIFECYCLE AUTOMATION
*   Finalisierung des `onboarding.sh` Bootstrap-Skripts.
*   Einrichtung der Multi-Key SOPS Verschlüsselung (Server + Laptop + USB).
*   Aktivierung des Boot-Watchdogs mit Auto-Rollback.

### PHASE 3: FOOTPRINT OPTIMIZATION
*   Migration kleiner Dienste von Postgres zu SQLite + Litestream.
*   Ersetze Netdata durch node_exporter + Gatus.
*   Aktivierung des Q958 Hardware-Profils (`cfg.profile = "q958"`).

---

# 🏁 ENDE DER DESTILLATION
*61 von 61 Chunks verarbeitet. Alle Nuggets extrahiert. Status: READY FOR IMPLEMENTATION.*

---

## 23. Zero-Touch SSH-Registrierung

### THE BEST VERSION
Sichere Übernahme des Admin-SSH-Keys via Einmalpasswort-Anzeige auf der physischen Konsole (TTY1).

---

## 25. Storage Mover Data Integrity (Blacklist)

### THE BEST VERSION
Strikte Dateityp-Prüfung vor jedem Verschiebevorgang zwischen SSD (Tier B) und HDD (Tier C).

### DOs
*   **WAL-Schutz**: Dateien mit `.wal`, `.db-journal`, `.lock` oder `.pid` werden niemals verschoben.
*   **Path-Exclusion**: Verzeichnisse wie `db/`, `cache/` oder `metadata/` (Jellyfin/SQLite) bleiben auf Tier B/A.

---

## 26. Resilience-Audit (Status April 2026)

### AKTUELLER SCORE: 5.8 / 10
Die Architektur ist "Aviation Grade", die Implementierung aktuell noch "Experimental".

### OPEN CRITICAL GAPS
| Gap | Severity | Status |
| :--- | :--- | :--- |
| **Port 8080 Collision** | CRITICAL | Offen (Pocket-ID, SABnzbd, Monica) |
| **SSO Bypass (Homepage)** | CRITICAL | Offen (Tailscale-IP Ausnahme) |
| **OliveTin Injection** | CRITICAL | Offen (CVE-Risiko durch Shell-Actions) |
| **Dead Hardware Profile** | HIGH | Offen (Option `cfg.profile` nicht definiert) |
| **Missing Secrets** | HIGH | Offen (Passwords & Cloud-Keys fehlen in YAML) |

---

## 27. Domain Naming Standard (Isolation)

### THE BEST VERSION
Nutzung einer dedizierten Subdomain-Ebene für alle lokalen Dienste.

### DOs
*   **Nix-Namespace**: Alle Dienste nutzen `service.nix.domain.de` (z. B. `jellyfin.nix.m7c5.de`).
*   **Wildcard-DNS**: In Cloudflare wird nur ein A-Record für `*.nix.domain.de` auf die Server-IP gesetzt.


---

## 24. Cloudflare API Token Spec

### THE BEST VERSION
Minimale Berechtigungen für automatisierte DNS-01-Challenges.

### DOs
*   **Scoped Permissions**: Nur `Zone:Read` und `DNS:Edit` für die spezifische Zone (z. B. m7c5.de).
*   **Environment Injection**: Übergabe an Caddy ausschließlich via sops-verschlüsselte Environment-Variables.

---

## 15. Storage ABC-Tiering & Smart Mover

### THE BEST VERSION
Dynamische Datenverschiebung zwischen drei Geschwindigkeitsklassen (A/B/C).

### DOs
*   **Hot-to-Cold Transition**: Downloads und aktive Transcodes landen auf Tier B (SSD).
*   **Mover-Trigger**: Verschiebung nach Tier C (HDD) erfolgt erst bei Unterschreitung eines Schwellwerts (z. B. <20GB frei auf SSD).
*   **Immutability**: Dokumente (Paperless) und Fotos bleiben permanent auf Tier A (NVMe).

### DON'Ts (DISCARDED)
*   ❌ **ZFS Snapshots**: Abgelehnt für Media-Bulk-Daten. Restic-Backups von `/persist` sind die primäre Sicherungsstrategie.

---

## 05. API-Centric Configuration

### THE BEST VERSION
Konfiguration von Web-Diensten via REST-API durch Idempotente Oneshot-Services.

### DOs
*   **mk-secure-curl**: Nutze einen Wrapper für API-Calls, der Keys via `systemd-LoadCredential` einbindet.
*   **mTLS Lifecycle**: Automatisierte Zertifikatserstellung via OliveTin + `openssl` Generator-Skript.

---

## 06. Network & DNS

### THE BEST VERSION
**Blocky** als primärer DNS-Filter aufgrund der 100% deklarativen YAML-Konfiguration.

### DOs
*   **Split-Horizon**: Trennung von Public (Caddy WAN) und Admin (LAN/Tailscale only) Zonen.

---

## 02. Hardware-Key "Root of Trust"

### THE BEST VERSION
Physischer Hardware-Key (YubiKey) für interaktive Aktionen UND **TPM 2.0** für den automatisierten Bootvorgang. LUKS-Entschlüsselung via `systemd-cryptenroll` gebunden an TPM-PCRs (Measured Boot).

### DOs
*   **Lanzaboote**: Zwingender Einsatz für Secure Boot und UKIs (Unified Kernel Images).
*   **TPM-Bindung**: Festplatte nur entschlüsseln, wenn PCR 0, 1, 5 und 7 (Hardware & Firmware State) unverändert sind.

### DON'Ts (DISCARDED)
*   ❌ **MAC-Check in Initrd**: Abgelehnt als "Geofencing zweiter Klasse". Bietet keine kryptografische Sicherheit gegen Spoofing.

---

## 10. Active Deception (Honeypots)

### THE BEST VERSION
Verschiebung des echten SSH-Dienstes auf einen Non-Standard Port (z. B. 2222) und Betrieb von **Cowrie** auf Port 22.

### DOs
*   **Isolation**: Honeypots müssen in einem eigenen Netzwerk-Namespace und mit `PrivateNetwork=false` (nur eingehend) isoliert werden.
*   **Logging**: Alle Interaktionen in Cowrie müssen an ein persistentes Log-System gesendet werden.

---

## 11. Lightweight Observability

### THE BEST VERSION
**Gatus** für Service-Health und **Netdata** für Echtzeit-Systemmetriken. Zugriff ausschließlich über das Admin-Overlay (Tailscale).

### DOs
*   **OliveTin**: Einsatz als "Service-Kiosk" für riskante oder repetitive Shell-Tasks via Web-UI.
*   **Journal-Remote**: Logs von impermanenten Systemen zwingend an einen persistenten Host via `systemd-journal-upload` senden.

---

## 12. Kernel Security (Runtime)

### THE BEST VERSION
Strikte Laufzeit-Härtung des Kernels durch Sperren der Modulschnittstelle.

### DOs
*   **LockKernelModules**: `security.lockKernelModules = true` aktivieren, sobald alle physischen Module (Grafik, Storage, Netzwerk) geladen sind.
*   **Module Blacklisting**: Deaktivierung aller obsoleten Protokolle (Firewire, Bluetooth, Floppy) und Dateisysteme (HFS, JFS).

### DON'Ts (DISCARDED)
*   ❌ **Dauerhafter Bastelmodus**: `networking.firewall.enable = false` ist nur für initiale Setups erlaubt und muss via Assertion im Main-Build blockiert werden.

---

## 03. Titanium Sandboxing (Systemd)

### THE BEST VERSION
Native Isolation via Systemd-Namespaces anstelle von Docker. Jede App erhält ein gehärtetes Template.

```nix
serviceConfig = {
  ProtectSystem = "strict";
  ProtectHome = true;
  PrivateTmp = true;
  NoNewPrivileges = true;
  DynamicUser = true;
  CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
  SystemCallFilter = [ "@system-service" "~@privileged" ];
};
```

### DOs
*   **Socket-Activation**: Dienste nur bei Bedarf starten (Wake-on-Access).
*   **LoadCredential**: Secrets via systemd sicher an den Prozess übergeben, niemals via Environment-Variables.

### DON'Ts (DISCARDED)
*   ❌ **Docker-Sockets**: Abgelehnt für Gemini-CLI. Der Zugriff auf `docker.sock` ist gleichbedeutend mit Root-Zugriff auf den Host.
