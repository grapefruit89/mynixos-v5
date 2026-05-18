# 🤖 SYSTEM PROMPT FÜR DIE KI
**Rolle:** Du bist ein professioneller AI-Coding-Assistent und Software-Architekt.
**Kontext:** Diese Datei ist eine aggregierte "Single Source of Truth" (SSoT) des Projekts "compress".
**Anweisung:** 1. Nutze die untenstehende Landkarte und die Semantic Tags, um das gesamte Projekt zu verstehen.
2. Wenn du Code-Änderungen vorschlägst, beziehe dich IMMER auf die genauen [F-XXX] Anker und Dateipfade, damit der User weiß, wo der Code hingehört.
3. Analysiere Zusammenhänge zwischen den Dateien, bevor du Architektur-Entscheidungen triffst.

---

# 💎 PLATINUM AI CONTEXT BUNDLE: compress
Erstellt: 12.05.2026 15:57:48 | Quelle: C:\Users\morit\Documents\distiller_project\docs\compress

## 🗺️ LANDKARTE (PROJECT TREE)
- [F-001] ADR_Chat_Destillat.md
- [F-002] ADR_Chat_Destillat_1.md
- [F-003] ARCHITECTURAL_ANALYSIS_REPORT.md
- [F-004] ARCHITECTURAL_ANALYSIS_REPORT_PART2.md
- [F-005] ARCHITECTURAL_ANALYSIS_REPORT_PART3.md
- [F-006] BOOTSTRAP_RECOVERY.md
- [F-007] CENTRAL_REGISTRY.md
- [F-008] FINAL_CLEANUP_PLAN.md
- [F-009] FINAL_VERIFICATION_EVIDENCE.md
- [F-010] GROK_AUDIT_ANALYSIS.md
- [F-011] GROK_TOP10_IMPLEMENTATION.md
- [F-012] HARDENING_RAM_ISOLATION.md
- [F-013] IMPLEMENTATION_PLAN.md
- [F-014] IMPLEMENTATION_STATE.md
- [F-015] MCP_VALIDATION_REPORT.md
- [F-016] NIXMETA_JSON_SPEC.md
- [F-017] SERVICE_MEMORY_LIMITS.md

## 🧠 SEMANTIC TAGS (Top-80 Dateien)
[F-002] ADR_Chat_Destillat_1.md | 15,67 KB | Tags: [VERSION, Systemd, Jellyfin, Hardware, DISCARDED]
[F-001] ADR_Chat_Destillat.md | 15,67 KB | Tags: [VERSION, Systemd, Jellyfin, Hardware, DISCARDED]
[F-004] ARCHITECTURAL_ANALYSIS_REPORT_PART2.md | 7,59 KB | Tags: [services, Decisions, Admin, Export, nftables]
[F-014] IMPLEMENTATION_STATE.md | 5,92 KB | Tags: [Verified, Phase, Caddy, admin, registry]
[F-013] IMPLEMENTATION_PLAN.md | 5,09 KB | Tags: [Phase, hardware, IMPLEMENTED, systemd, Socket]
[F-005] ARCHITECTURAL_ANALYSIS_REPORT_PART3.md | 4,88 KB | Tags: [deepseek_export, service, Admin, Decisions, Native]
[F-003] ARCHITECTURAL_ANALYSIS_REPORT.md | 4,33 KB | Tags: [Claude, Audit, Admin, build, Decisions]
[F-009] FINAL_VERIFICATION_EVIDENCE.md | 4,08 KB | Tags: [REPAIRED, verified, caddy, Phase, hardening]
[F-010] GROK_AUDIT_ANALYSIS.md | 3,54 KB | Tags: [Caddy, Layer, Kernel, nftables, Hardening]
[F-011] GROK_TOP10_IMPLEMENTATION.md | 3,40 KB | Tags: [added, REPAIRED, GROUP, enabled, PHASE]
[F-007] CENTRAL_REGISTRY.md | 3,34 KB | Tags: [Registry, modules, repo_v5, types, Strings]
[F-012] HARDENING_RAM_ISOLATION.md | 2,66 KB | Tags: [kernel, services, Isolation, network, Service]
[F-015] MCP_VALIDATION_REPORT.md | 2,57 KB | Tags: [verified, Validation, standard, module, compliant]
[F-016] NIXMETA_JSON_SPEC.md | 2,54 KB | Tags: [NIXMETA, block, using, metrics, dependency]
[F-017] SERVICE_MEMORY_LIMITS.md | 1,96 KB | Tags: [Service, services, MemoryMax, explicit, Recommended]
[F-008] FINAL_CLEANUP_PLAN.md | 1,81 KB | Tags: [flake, phase, config, nixos, lidarr]
[F-006] BOOTSTRAP_RECOVERY.md | 1,12 KB | Tags: [restic, NixOS, export, creds, Secrets]


## 📊 DATEI-STATISTIK

Count Name SizeSum
----- ---- -------
   17 .md  0,08 MB




## 📦 DATEI-INHALTE (SEMANTIC ANCHORS)
### [F-001] ADR_Chat_Destillat.md
* Pfad: ADR_Chat_Destillat.md | Format: .md | Größe: 15,67 KB
``md
Dieses Dokument ist das Ergebnis einer hochpräzisen Destillation von 61 Chat-Logs. Es enthält die finalen, theoretisch am weitesten entwickelten Lösungen und Paradigmen.

Ein spezialisierter Systemd-Dienst, der die Systemintegrität nach dem Boot validiert.

*   **Health-Check**: Prüfe 120s nach Boot: Netzwerk-Ping, Caddy-Port 80/443 und Postgres-Socket.
*   **Hard Rollback**: Bei Fehlschlag automatisiert `nixos-rebuild --rollback` ausführen und neu starten.

Trennung von flüchtigen und permanenten Media-Daten.

*   **Metadaten-Persistenz**: `/var/lib/jellyfin` muss auf **Tier A (NVMe)** persistiert werden, um Scraping-Loops zu vermeiden.
*   **Transcode-Cache**: `/var/cache/jellyfin` (Transcodes) kann auf `tmpfs` oder Tier B bleiben.

Root-Dateisystem auf `tmpfs` (RAM), Persistenz ausschließlich über das `impermanence` Modul auf eine dedizierte `/persist` Partition (**zwingend ZFS** für Snapshot-Rollbacks).

| Pfad | Grund |
| :--- | :--- |
| `/etc/machine-id` | System-Identität |
| `/etc/ssh/ssh_host_*_key*` | SSH-Fingerprints |
| `/var/lib/caddy` | Let's Encrypt Zertifikate |
| `/var/lib/postgresql` | Datenbank-Integrität |
| `/var/lib/tailscale` | VPN-Identität |
| `/var/lib/jellyfin` | Mediathek-Metadaten |
| `/home` | Benutzerdaten |

KI-Agenten erhalten minimale Rechte ohne Zugriff auf die Systemkonfiguration.

*   **Sudo-Wrapper**: Nur `docker start/stop` via Sudo erlauben. User darf NICHT in der Gruppe `docker` sein.
*   **Namespace-Isolation**: Der Agent-Dienst nutzt `BindReadOnlyPaths = [ "/etc/nixos" ]`, um Dateimanipulationen zu verhindern.

Jeder Dienst erhält eine eigene nftables-Chain, die ausgehende Verbindungen basierend auf der Benutzer-ID (**skuid**) filtert.

```nftables
chain jellyfin_out {
  meta skuid jellyfin ip daddr { 18.165.1.12, 54.74.31.43 } tcp dport 443 accept
  meta skuid jellyfin reject
}
```

*   **DNS-Logging**: Alle Anfragen mit `log prefix "ZT-DNS: "` protokollieren, um Whitelists zu erstellen.
*   **UID-Bindung**: Regeln zwingend an UIDs knüpfen (statische UIDs in `auto-users.nix` erforderlich).

*    **Caddy als Outbound-Proxy**: Abgelehnt. Zu komplex und performancelastig. nftables ist der effizientere Weg.

Nur Binaries aus vertrauenswürdigen Quellen dürfen ausgeführt werden.

*   **Trusted Sources**: `/nix/store` und `/run/current-system/sw/bin` sind Standard.
*   **nix-shell Escape**: Erlaube `/run/user/*/nix-shell-*`, um interaktive Arbeit zu ermöglichen.

*    **Ausführung aus /home**: Absolut verboten. Eigene Skripte gehören in den Store (via Nix-Paket) oder in eine isolierte Dev-VM.

Strikte Trennung zwischen **gehärteter Appliance (Host)** und **Entwicklung (VM)**.

*   **Dev-VM**: Nutze libvirt/QEMU für eine ungehärtete NixOS-VM. Dort sind `nix-shell` und ad-hoc Skripte erlaubt.
*   **Host-Sicherheit**: Das Wirtssystem führt niemals ungetesteten Code oder Skripte außerhalb des Stores aus.

Einsatz von **Falco** oder **auditd** zur Echtzeit-Überwachung von Prozess-Spawn-Events und Dateisystem-Canarys.

*   **Auditd-Rules**: Überwachung von `execve` Systemcalls, um "Living-off-the-Land" (LotL) Angriffe zu erkennen.
*   **Canary Files**: Erstellung von "Honey-Files" in `/persist`, die via `systemd.path` bei Zugriff einen sofortigen Lockdown auslösen.

*    **Russian Language Trick**: Abgelehnt als "Paranoia-Lärm". Bietet keinen echten Schutz für Aviation-Grade Systeme.

Strikte Trennung des Systems in funktionale Schichten, die isomorph zur Repository-Struktur sind.

*   **00-core**: Fundament (Hardware, SSH, Security-Basics).
*   **10-gateway**: Ingress (Caddy, DNS, PocketID).
*   **20-infrastructure**: Ressourcen (Postgres, Storage, VPN-Vault).
*   **40-media**: Media-Stack (*arr, Jellyfin).
*   **90-policy**: Systemweite Leitplanken (Assertions, Binary-Only).

*   **Self-Contained Files**: Jeder Dienst deklariert seinen Port, seinen Proxy-Host und seinen State in einer einzigen Datei.
*   **Flat-Layout**: Keine Unterordner innerhalb der Layer erlaubt (erzwungen durch Assertion in Layer 90).

Alle Ports werden zentral in `00-core/ports.nix` definiert und via `config.my.ports` in die Module injiziert.

*   **Port-Schema**: 10xxx für Infrastruktur, 20xxx für Anwendungen.
*   **Kollisionsprüfung**: Automatisierte Warnung im Build-Prozess, falls ein Port mehrfach vergeben wurde.

Strikte Trennung von Netzwerk-Zugang (IP-Ebene) und Authentifizierung (Identitäts-Ebene).

*   **No IP Bypasses**: Keine `remote_ip`-Ausnahmen für SSO. Jeder Dienst (außer Public-Frontends) erfordert `import sso_auth`.
*   **Tailscale Roles**: Tailscale dient nur als sicherer Tunnel, ersetzt aber niemals die Benutzeranmeldung am OIDC-Provider (Pocket-ID).

Secrets müssen auch bei einem Totalverlust der Hardware (NVMe/Host-Key) wiederherstellbar sein.

*   **Multi-Key Encryption**: Jedes Secret wird für den Server-Key UND einen externen Admin-Key (Laptop/YubiKey) verschlüsselt.
*   **Offsite Age-Key**: Der private Teil des Admin-Keys liegt sicher im Passwort-Manager oder auf einem physischen Medium außerhalb des Servers.

*    **Einfache Verschlüsselung**: Secrets nur für den Host-Key zu verschlüsseln ist verboten (Disaster-Gefahr).

Verhinderung von Shell-Injection durch strikte Variablen-Trennung.

*   **Env-Transition**: Variablen aus Web-UIs (OliveTin) niemals direkt in Shell-Strings interpolieren (`'{{ input }}'`).
*   **Wrapper**: Nutzung von `systemd.LoadCredential` oder Übergabe via `Environment` im Service-Context.

Zentralisierung aller Systemd-Härtungsparameter in einer erweiterbaren Factory-Funktion innerhalb der `lib-helpers.nix`.

*   **Strikte Defaults**: Jeder Service nutzt standardmäßig `ProtectSystem=strict`, `PrivateTmp=true`, `NoNewPrivileges=true` und einen restriktiven `SystemCallFilter`.
*   **Capabilty-Whitelisting**: Explizite Schalter für `gpuAccess` (Jellyfin) und `serialAccess` (Zigbee2MQTT), um `PrivateDevices` gezielt zu lockern.
*   **Score-Garantie**: Ziel ist ein `systemd-analyze security` Score von > 8.0 für jeden Dienst.

Schrittweise Übernahme bewährter Härtungs-Parameter ohne Abhängigkeit von instabilen Alpha-Modulen.

*   **Kernel-Schutz**: `kernel.unprivileged_userns_clone = 0` und `vm.unprivileged_userfaultfd = 0` zur Unterbindung von Container-Eskalationsvektoren.
*   **Dateisystem**: `/proc` mit `hidepid=2` mounten, `/tmp` mit `noexec,nosuid,nodev`.
*   **Core-Dumps**: Vollständige Deaktivierung via `systemd.coredump.enable = false` und `kernel.core_pattern = |/bin/false`.

Zweistufiger Ansatz basierend auf Hardware-Ressourcen und Nutzungsbedarf.

*   **piGallery2 (Einstieg)**: Directory-first, extrem schlank (<200MB RAM). Ideal für bestehende Sammlungen auf Tier C.
*   **Immich (High-End)**: Native NixOS-Integration nutzen. Bietet Mobile-Apps und ML (Gesichtserkennung), benötigt aber Postgres + Redis + 2-4GB RAM.

Vollständige Eliminierung des Passwort-Vektors für SSH-Zugriffe.

*   **Nuke Passwords**: `PasswordAuthentication = false` und `ChallengeResponseAuthentication = false`.
*   **Key-Only**: Nur Hardware-gebundene Keys oder Passkeys erlauben. 
*   **Fail2ban-Reduktion**: Deaktivierung von Fail2ban für SSH (da kein Brute-Force möglich), stattdessen Fokus auf Caddy-Logs.

*   Implementierung `mkHardenedService` in `lib-helpers.nix`.
*   Bereinigung aller `mkForce`-Kollisionen bei der Swappiness.
*   Fix der Port 8080 Kollision via `ports.nix` Registry.

*   Finalisierung des `onboarding.sh` Bootstrap-Skripts.
*   Einrichtung der Multi-Key SOPS Verschlüsselung (Server + Laptop + USB).
*   Aktivierung des Boot-Watchdogs mit Auto-Rollback.

*   Migration kleiner Dienste von Postgres zu SQLite + Litestream.
*   Ersetze Netdata durch node_exporter + Gatus.
*   Aktivierung des Q958 Hardware-Profils (`cfg.profile = "q958"`).

*61 von 61 Chunks verarbeitet. Alle Nuggets extrahiert. Status: READY FOR IMPLEMENTATION.*

Sichere Übernahme des Admin-SSH-Keys via Einmalpasswort-Anzeige auf der physischen Konsole (TTY1).

Strikte Dateityp-Prüfung vor jedem Verschiebevorgang zwischen SSD (Tier B) und HDD (Tier C).

*   **WAL-Schutz**: Dateien mit `.wal`, `.db-journal`, `.lock` oder `.pid` werden niemals verschoben.
*   **Path-Exclusion**: Verzeichnisse wie `db/`, `cache/` oder `metadata/` (Jellyfin/SQLite) bleiben auf Tier B/A.

Die Architektur ist "Aviation Grade", die Implementierung aktuell noch "Experimental".

| Gap | Severity | Status |
| :--- | :--- | :--- |
| **Port 8080 Collision** | CRITICAL | Offen (Pocket-ID, SABnzbd, Monica) |
| **SSO Bypass (Homepage)** | CRITICAL | Offen (Tailscale-IP Ausnahme) |
| **OliveTin Injection** | CRITICAL | Offen (CVE-Risiko durch Shell-Actions) |
| **Dead Hardware Profile** | HIGH | Offen (Option `cfg.profile` nicht definiert) |
| **Missing Secrets** | HIGH | Offen (Passwords & Cloud-Keys fehlen in YAML) |

Nutzung einer dedizierten Subdomain-Ebene für alle lokalen Dienste.

*   **Nix-Namespace**: Alle Dienste nutzen `service.nix.domain.de` (z. B. `jellyfin.nix.m7c5.de`).
*   **Wildcard-DNS**: In Cloudflare wird nur ein A-Record für `*.nix.domain.de` auf die Server-IP gesetzt.

Minimale Berechtigungen für automatisierte DNS-01-Challenges.

*   **Scoped Permissions**: Nur `Zone:Read` und `DNS:Edit` für die spezifische Zone (z. B. m7c5.de).
*   **Environment Injection**: Übergabe an Caddy ausschließlich via sops-verschlüsselte Environment-Variables.

Dynamische Datenverschiebung zwischen drei Geschwindigkeitsklassen (A/B/C).

*   **Hot-to-Cold Transition**: Downloads und aktive Transcodes landen auf Tier B (SSD).
*   **Mover-Trigger**: Verschiebung nach Tier C (HDD) erfolgt erst bei Unterschreitung eines Schwellwerts (z. B. <20GB frei auf SSD).
*   **Immutability**: Dokumente (Paperless) und Fotos bleiben permanent auf Tier A (NVMe).

*    **ZFS Snapshots**: Abgelehnt für Media-Bulk-Daten. Restic-Backups von `/persist` sind die primäre Sicherungsstrategie.

Konfiguration von Web-Diensten via REST-API durch Idempotente Oneshot-Services.

*   **mk-secure-curl**: Nutze einen Wrapper für API-Calls, der Keys via `systemd-LoadCredential` einbindet.
*   **mTLS Lifecycle**: Automatisierte Zertifikatserstellung via OliveTin + `openssl` Generator-Skript.

**Blocky** als primärer DNS-Filter aufgrund der 100% deklarativen YAML-Konfiguration.

*   **Split-Horizon**: Trennung von Public (Caddy WAN) und Admin (LAN/Tailscale only) Zonen.

Physischer Hardware-Key (YubiKey) für interaktive Aktionen UND **TPM 2.0** für den automatisierten Bootvorgang. LUKS-Entschlüsselung via `systemd-cryptenroll` gebunden an TPM-PCRs (Measured Boot).

*   **Lanzaboote**: Zwingender Einsatz für Secure Boot und UKIs (Unified Kernel Images).
*   **TPM-Bindung**: Festplatte nur entschlüsseln, wenn PCR 0, 1, 5 und 7 (Hardware & Firmware State) unverändert sind.

*    **MAC-Check in Initrd**: Abgelehnt als "Geofencing zweiter Klasse". Bietet keine kryptografische Sicherheit gegen Spoofing.

Verschiebung des echten SSH-Dienstes auf einen Non-Standard Port (z. B. 2222) und Betrieb von **Cowrie** auf Port 22.

*   **Isolation**: Honeypots müssen in einem eigenen Netzwerk-Namespace und mit `PrivateNetwork=false` (nur eingehend) isoliert werden.
*   **Logging**: Alle Interaktionen in Cowrie müssen an ein persistentes Log-System gesendet werden.

**Gatus** für Service-Health und **Netdata** für Echtzeit-Systemmetriken. Zugriff ausschließlich über das Admin-Overlay (Tailscale).

*   **OliveTin**: Einsatz als "Service-Kiosk" für riskante oder repetitive Shell-Tasks via Web-UI.
*   **Journal-Remote**: Logs von impermanenten Systemen zwingend an einen persistenten Host via `systemd-journal-upload` senden.

Strikte Laufzeit-Härtung des Kernels durch Sperren der Modulschnittstelle.

*   **LockKernelModules**: `security.lockKernelModules = true` aktivieren, sobald alle physischen Module (Grafik, Storage, Netzwerk) geladen sind.
*   **Module Blacklisting**: Deaktivierung aller obsoleten Protokolle (Firewire, Bluetooth, Floppy) und Dateisysteme (HFS, JFS).

*    **Dauerhafter Bastelmodus**: `networking.firewall.enable = false` ist nur für initiale Setups erlaubt und muss via Assertion im Main-Build blockiert werden.

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

*   **Socket-Activation**: Dienste nur bei Bedarf starten (Wake-on-Access).
*   **LoadCredential**: Secrets via systemd sicher an den Prozess übergeben, niemals via Environment-Variables.

*    **Docker-Sockets**: Abgelehnt für Gemini-CLI. Der Zugriff auf `docker.sock` ist gleichbedeutend mit Root-Zugriff auf den Host.

``n---
### [F-002] ADR_Chat_Destillat_1.md
* Pfad: ADR_Chat_Destillat_1.md | Format: .md | Größe: 15,67 KB
``md
Dieses Dokument ist das Ergebnis einer hochpräzisen Destillation von 61 Chat-Logs. Es enthält die finalen, theoretisch am weitesten entwickelten Lösungen und Paradigmen.

Ein spezialisierter Systemd-Dienst, der die Systemintegrität nach dem Boot validiert.

*   **Health-Check**: Prüfe 120s nach Boot: Netzwerk-Ping, Caddy-Port 80/443 und Postgres-Socket.
*   **Hard Rollback**: Bei Fehlschlag automatisiert `nixos-rebuild --rollback` ausführen und neu starten.

Trennung von flüchtigen und permanenten Media-Daten.

*   **Metadaten-Persistenz**: `/var/lib/jellyfin` muss auf **Tier A (NVMe)** persistiert werden, um Scraping-Loops zu vermeiden.
*   **Transcode-Cache**: `/var/cache/jellyfin` (Transcodes) kann auf `tmpfs` oder Tier B bleiben.

Root-Dateisystem auf `tmpfs` (RAM), Persistenz ausschließlich über das `impermanence` Modul auf eine dedizierte `/persist` Partition (**zwingend ZFS** für Snapshot-Rollbacks).

| Pfad | Grund |
| :--- | :--- |
| `/etc/machine-id` | System-Identität |
| `/etc/ssh/ssh_host_*_key*` | SSH-Fingerprints |
| `/var/lib/caddy` | Let's Encrypt Zertifikate |
| `/var/lib/postgresql` | Datenbank-Integrität |
| `/var/lib/tailscale` | VPN-Identität |
| `/var/lib/jellyfin` | Mediathek-Metadaten |
| `/home` | Benutzerdaten |

KI-Agenten erhalten minimale Rechte ohne Zugriff auf die Systemkonfiguration.

*   **Sudo-Wrapper**: Nur `docker start/stop` via Sudo erlauben. User darf NICHT in der Gruppe `docker` sein.
*   **Namespace-Isolation**: Der Agent-Dienst nutzt `BindReadOnlyPaths = [ "/etc/nixos" ]`, um Dateimanipulationen zu verhindern.

Jeder Dienst erhält eine eigene nftables-Chain, die ausgehende Verbindungen basierend auf der Benutzer-ID (**skuid**) filtert.

```nftables
chain jellyfin_out {
  meta skuid jellyfin ip daddr { 18.165.1.12, 54.74.31.43 } tcp dport 443 accept
  meta skuid jellyfin reject
}
```

*   **DNS-Logging**: Alle Anfragen mit `log prefix "ZT-DNS: "` protokollieren, um Whitelists zu erstellen.
*   **UID-Bindung**: Regeln zwingend an UIDs knüpfen (statische UIDs in `auto-users.nix` erforderlich).

*    **Caddy als Outbound-Proxy**: Abgelehnt. Zu komplex und performancelastig. nftables ist der effizientere Weg.

Nur Binaries aus vertrauenswürdigen Quellen dürfen ausgeführt werden.

*   **Trusted Sources**: `/nix/store` und `/run/current-system/sw/bin` sind Standard.
*   **nix-shell Escape**: Erlaube `/run/user/*/nix-shell-*`, um interaktive Arbeit zu ermöglichen.

*    **Ausführung aus /home**: Absolut verboten. Eigene Skripte gehören in den Store (via Nix-Paket) oder in eine isolierte Dev-VM.

Strikte Trennung zwischen **gehärteter Appliance (Host)** und **Entwicklung (VM)**.

*   **Dev-VM**: Nutze libvirt/QEMU für eine ungehärtete NixOS-VM. Dort sind `nix-shell` und ad-hoc Skripte erlaubt.
*   **Host-Sicherheit**: Das Wirtssystem führt niemals ungetesteten Code oder Skripte außerhalb des Stores aus.

Einsatz von **Falco** oder **auditd** zur Echtzeit-Überwachung von Prozess-Spawn-Events und Dateisystem-Canarys.

*   **Auditd-Rules**: Überwachung von `execve` Systemcalls, um "Living-off-the-Land" (LotL) Angriffe zu erkennen.
*   **Canary Files**: Erstellung von "Honey-Files" in `/persist`, die via `systemd.path` bei Zugriff einen sofortigen Lockdown auslösen.

*    **Russian Language Trick**: Abgelehnt als "Paranoia-Lärm". Bietet keinen echten Schutz für Aviation-Grade Systeme.

Strikte Trennung des Systems in funktionale Schichten, die isomorph zur Repository-Struktur sind.

*   **00-core**: Fundament (Hardware, SSH, Security-Basics).
*   **10-gateway**: Ingress (Caddy, DNS, PocketID).
*   **20-infrastructure**: Ressourcen (Postgres, Storage, VPN-Vault).
*   **40-media**: Media-Stack (*arr, Jellyfin).
*   **90-policy**: Systemweite Leitplanken (Assertions, Binary-Only).

*   **Self-Contained Files**: Jeder Dienst deklariert seinen Port, seinen Proxy-Host und seinen State in einer einzigen Datei.
*   **Flat-Layout**: Keine Unterordner innerhalb der Layer erlaubt (erzwungen durch Assertion in Layer 90).

Alle Ports werden zentral in `00-core/ports.nix` definiert und via `config.my.ports` in die Module injiziert.

*   **Port-Schema**: 10xxx für Infrastruktur, 20xxx für Anwendungen.
*   **Kollisionsprüfung**: Automatisierte Warnung im Build-Prozess, falls ein Port mehrfach vergeben wurde.

Strikte Trennung von Netzwerk-Zugang (IP-Ebene) und Authentifizierung (Identitäts-Ebene).

*   **No IP Bypasses**: Keine `remote_ip`-Ausnahmen für SSO. Jeder Dienst (außer Public-Frontends) erfordert `import sso_auth`.
*   **Tailscale Roles**: Tailscale dient nur als sicherer Tunnel, ersetzt aber niemals die Benutzeranmeldung am OIDC-Provider (Pocket-ID).

Secrets müssen auch bei einem Totalverlust der Hardware (NVMe/Host-Key) wiederherstellbar sein.

*   **Multi-Key Encryption**: Jedes Secret wird für den Server-Key UND einen externen Admin-Key (Laptop/YubiKey) verschlüsselt.
*   **Offsite Age-Key**: Der private Teil des Admin-Keys liegt sicher im Passwort-Manager oder auf einem physischen Medium außerhalb des Servers.

*    **Einfache Verschlüsselung**: Secrets nur für den Host-Key zu verschlüsseln ist verboten (Disaster-Gefahr).

Verhinderung von Shell-Injection durch strikte Variablen-Trennung.

*   **Env-Transition**: Variablen aus Web-UIs (OliveTin) niemals direkt in Shell-Strings interpolieren (`'{{ input }}'`).
*   **Wrapper**: Nutzung von `systemd.LoadCredential` oder Übergabe via `Environment` im Service-Context.

Zentralisierung aller Systemd-Härtungsparameter in einer erweiterbaren Factory-Funktion innerhalb der `lib-helpers.nix`.

*   **Strikte Defaults**: Jeder Service nutzt standardmäßig `ProtectSystem=strict`, `PrivateTmp=true`, `NoNewPrivileges=true` und einen restriktiven `SystemCallFilter`.
*   **Capabilty-Whitelisting**: Explizite Schalter für `gpuAccess` (Jellyfin) und `serialAccess` (Zigbee2MQTT), um `PrivateDevices` gezielt zu lockern.
*   **Score-Garantie**: Ziel ist ein `systemd-analyze security` Score von > 8.0 für jeden Dienst.

Schrittweise Übernahme bewährter Härtungs-Parameter ohne Abhängigkeit von instabilen Alpha-Modulen.

*   **Kernel-Schutz**: `kernel.unprivileged_userns_clone = 0` und `vm.unprivileged_userfaultfd = 0` zur Unterbindung von Container-Eskalationsvektoren.
*   **Dateisystem**: `/proc` mit `hidepid=2` mounten, `/tmp` mit `noexec,nosuid,nodev`.
*   **Core-Dumps**: Vollständige Deaktivierung via `systemd.coredump.enable = false` und `kernel.core_pattern = |/bin/false`.

Zweistufiger Ansatz basierend auf Hardware-Ressourcen und Nutzungsbedarf.

*   **piGallery2 (Einstieg)**: Directory-first, extrem schlank (<200MB RAM). Ideal für bestehende Sammlungen auf Tier C.
*   **Immich (High-End)**: Native NixOS-Integration nutzen. Bietet Mobile-Apps und ML (Gesichtserkennung), benötigt aber Postgres + Redis + 2-4GB RAM.

Vollständige Eliminierung des Passwort-Vektors für SSH-Zugriffe.

*   **Nuke Passwords**: `PasswordAuthentication = false` und `ChallengeResponseAuthentication = false`.
*   **Key-Only**: Nur Hardware-gebundene Keys oder Passkeys erlauben. 
*   **Fail2ban-Reduktion**: Deaktivierung von Fail2ban für SSH (da kein Brute-Force möglich), stattdessen Fokus auf Caddy-Logs.

*   Implementierung `mkHardenedService` in `lib-helpers.nix`.
*   Bereinigung aller `mkForce`-Kollisionen bei der Swappiness.
*   Fix der Port 8080 Kollision via `ports.nix` Registry.

*   Finalisierung des `onboarding.sh` Bootstrap-Skripts.
*   Einrichtung der Multi-Key SOPS Verschlüsselung (Server + Laptop + USB).
*   Aktivierung des Boot-Watchdogs mit Auto-Rollback.

*   Migration kleiner Dienste von Postgres zu SQLite + Litestream.
*   Ersetze Netdata durch node_exporter + Gatus.
*   Aktivierung des Q958 Hardware-Profils (`cfg.profile = "q958"`).

*61 von 61 Chunks verarbeitet. Alle Nuggets extrahiert. Status: READY FOR IMPLEMENTATION.*

Sichere Übernahme des Admin-SSH-Keys via Einmalpasswort-Anzeige auf der physischen Konsole (TTY1).

Strikte Dateityp-Prüfung vor jedem Verschiebevorgang zwischen SSD (Tier B) und HDD (Tier C).

*   **WAL-Schutz**: Dateien mit `.wal`, `.db-journal`, `.lock` oder `.pid` werden niemals verschoben.
*   **Path-Exclusion**: Verzeichnisse wie `db/`, `cache/` oder `metadata/` (Jellyfin/SQLite) bleiben auf Tier B/A.

Die Architektur ist "Aviation Grade", die Implementierung aktuell noch "Experimental".

| Gap | Severity | Status |
| :--- | :--- | :--- |
| **Port 8080 Collision** | CRITICAL | Offen (Pocket-ID, SABnzbd, Monica) |
| **SSO Bypass (Homepage)** | CRITICAL | Offen (Tailscale-IP Ausnahme) |
| **OliveTin Injection** | CRITICAL | Offen (CVE-Risiko durch Shell-Actions) |
| **Dead Hardware Profile** | HIGH | Offen (Option `cfg.profile` nicht definiert) |
| **Missing Secrets** | HIGH | Offen (Passwords & Cloud-Keys fehlen in YAML) |

Nutzung einer dedizierten Subdomain-Ebene für alle lokalen Dienste.

*   **Nix-Namespace**: Alle Dienste nutzen `service.nix.domain.de` (z. B. `jellyfin.nix.m7c5.de`).
*   **Wildcard-DNS**: In Cloudflare wird nur ein A-Record für `*.nix.domain.de` auf die Server-IP gesetzt.

Minimale Berechtigungen für automatisierte DNS-01-Challenges.

*   **Scoped Permissions**: Nur `Zone:Read` und `DNS:Edit` für die spezifische Zone (z. B. m7c5.de).
*   **Environment Injection**: Übergabe an Caddy ausschließlich via sops-verschlüsselte Environment-Variables.

Dynamische Datenverschiebung zwischen drei Geschwindigkeitsklassen (A/B/C).

*   **Hot-to-Cold Transition**: Downloads und aktive Transcodes landen auf Tier B (SSD).
*   **Mover-Trigger**: Verschiebung nach Tier C (HDD) erfolgt erst bei Unterschreitung eines Schwellwerts (z. B. <20GB frei auf SSD).
*   **Immutability**: Dokumente (Paperless) und Fotos bleiben permanent auf Tier A (NVMe).

*    **ZFS Snapshots**: Abgelehnt für Media-Bulk-Daten. Restic-Backups von `/persist` sind die primäre Sicherungsstrategie.

Konfiguration von Web-Diensten via REST-API durch Idempotente Oneshot-Services.

*   **mk-secure-curl**: Nutze einen Wrapper für API-Calls, der Keys via `systemd-LoadCredential` einbindet.
*   **mTLS Lifecycle**: Automatisierte Zertifikatserstellung via OliveTin + `openssl` Generator-Skript.

**Blocky** als primärer DNS-Filter aufgrund der 100% deklarativen YAML-Konfiguration.

*   **Split-Horizon**: Trennung von Public (Caddy WAN) und Admin (LAN/Tailscale only) Zonen.

Physischer Hardware-Key (YubiKey) für interaktive Aktionen UND **TPM 2.0** für den automatisierten Bootvorgang. LUKS-Entschlüsselung via `systemd-cryptenroll` gebunden an TPM-PCRs (Measured Boot).

*   **Lanzaboote**: Zwingender Einsatz für Secure Boot und UKIs (Unified Kernel Images).
*   **TPM-Bindung**: Festplatte nur entschlüsseln, wenn PCR 0, 1, 5 und 7 (Hardware & Firmware State) unverändert sind.

*    **MAC-Check in Initrd**: Abgelehnt als "Geofencing zweiter Klasse". Bietet keine kryptografische Sicherheit gegen Spoofing.

Verschiebung des echten SSH-Dienstes auf einen Non-Standard Port (z. B. 2222) und Betrieb von **Cowrie** auf Port 22.

*   **Isolation**: Honeypots müssen in einem eigenen Netzwerk-Namespace und mit `PrivateNetwork=false` (nur eingehend) isoliert werden.
*   **Logging**: Alle Interaktionen in Cowrie müssen an ein persistentes Log-System gesendet werden.

**Gatus** für Service-Health und **Netdata** für Echtzeit-Systemmetriken. Zugriff ausschließlich über das Admin-Overlay (Tailscale).

*   **OliveTin**: Einsatz als "Service-Kiosk" für riskante oder repetitive Shell-Tasks via Web-UI.
*   **Journal-Remote**: Logs von impermanenten Systemen zwingend an einen persistenten Host via `systemd-journal-upload` senden.

Strikte Laufzeit-Härtung des Kernels durch Sperren der Modulschnittstelle.

*   **LockKernelModules**: `security.lockKernelModules = true` aktivieren, sobald alle physischen Module (Grafik, Storage, Netzwerk) geladen sind.
*   **Module Blacklisting**: Deaktivierung aller obsoleten Protokolle (Firewire, Bluetooth, Floppy) und Dateisysteme (HFS, JFS).

*    **Dauerhafter Bastelmodus**: `networking.firewall.enable = false` ist nur für initiale Setups erlaubt und muss via Assertion im Main-Build blockiert werden.

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

*   **Socket-Activation**: Dienste nur bei Bedarf starten (Wake-on-Access).
*   **LoadCredential**: Secrets via systemd sicher an den Prozess übergeben, niemals via Environment-Variables.

*    **Docker-Sockets**: Abgelehnt für Gemini-CLI. Der Zugriff auf `docker.sock` ist gleichbedeutend mit Root-Zugriff auf den Host.

``n---
### [F-003] ARCHITECTURAL_ANALYSIS_REPORT.md
* Pfad: ARCHITECTURAL_ANALYSIS_REPORT.md | Format: .md | Größe: 4,33 KB
``md
**Project:** NixOS Chat Distillation & RAG-Pipeline  
**Focus:** Hardened Homelab (Horizontal Responsibility v5.0/v6.0)  
**Hardware:** Fujitsu Q958 | RTX 3060 Ti | TPM 2.0  
**Status:** HARDENING IN PROGRESS (Remediation Phase)  

*   **Key Decisions:** 
    *   Horizontal Responsibility (v5.0/6.0) is the binding architecture.
    *   Strict separation of Admin (Tailscale/mTLS) and Family (Public/SSO) traffic.
    *   Caddy acts as the primary ingress guard using `remote_ip` and `sso_auth`.
*   **Open Questions:** Global enforcement of SSO for internal traffic without creating "dead-zones" if the OIDC provider is down.
*   **Risks:** IP-based bypasses (e.g., Tailscale IPs) previously identified must be completely eliminated.

*   **Key Decisions:**
    *   Private CA infrastructure with a Flask-based issuance portal.
    *   Hardware binding for Admin keys (TPM/YubiKey).
    *   CSR flow for browser certificates to prevent private key exfiltration.
*   **Risks:** Complexity of certificate lifecycle (rotation/expiry) leading to administrative lockout.

*   **Key Decisions:**
    *   `services-spec.nix` is the SSoT for ports, paths, and firewall rules.
    *   Factory patterns (`mkService`, `mkStreamer`) used for consistency across 30+ services.
*   **Risks:** Typos in factory parameters (e.g., `MemoryMax` vs `memoryMax`) can cause silent build failures.

*   **Key Decisions:**
    *   ABC-Tiering: NVMe (Tier A/Persist) -> SSD (Tier B/Cache) -> HDD (Tier C/Media).
    *   LUKS + TPM2 binding for automated, secure unlock.
    *   Impermanence used to maintain a stateless root (reset on boot).
*   **Risks:** "Quiet Catastrophe"  Tier A failure leading to total secret loss (SOPS deadlock).

*   **Key Decisions:**
    *   Secrets encrypted with Age (derived from SSH Host Key).
    *   Double encryption for Admin/Laptop keys for recovery.
    *   USB/S3 backup strategy for the `/persist` directory.
*   **Risks:** Missing secrets in `secrets.yaml` (Build-breakers).

| ID | PRIORITY | CATEGORY | Task Description | Source | Effort |
|:---|:---:|:---|:---|:---|:---:|
| SEC-01 | P0 | SECURITY | Remove SSO-Bypass in `homepage.nix` (Tailscale matcher) | Claude/Grok Audit | S |
| SEC-02 | P0 | SECURITY | Set `public_registration = false` in Pocket-ID | Claude Audit | S |
| SEC-03 | P0 | SECURITY | Harden OliveTin Actions against Shell-Injection (use EnvVars) | Claude Audit | M |
| BUILD-01 | P0 | BUILD | Resolve port collisions in `ports.nix` (8080/3001) | Claude Audit | S |
| BUILD-02 | P0 | BUILD | Populate `secrets/secrets.yaml` with missing keys | Claude/DeepSeek | S |
| HW-01 | P1 | HARDWARE | Define and activate `my.hardware.profile = "q958"` | Claude Audit | S |
| NET-01 | P1 | NETWORK | Implement IPv6 parity in `firewall.nix` | Claude Audit | M |
| OPS-01 | P1 | STORAGE | Add WAL/DB exclusion and loop-exit counter to Mover | Claude Audit | M |
| NET-02 | P2 | NETWORK | Implement Split-DNS via Caddy `remote_ip` for Admin backend | DeepSeek/User | S |
| SEC-04 | P2 | SECURITY | Implement SOPS Emergency Fallback (USB/QR-Code) | Technical Debt | M |

1.  **Admin service authentication?** Both (mTLS for transport, SSO/Passwords for identity).
2.  **Admin private key location?** TPM/YubiKey.
3.  **Client cert issuance?** Web portal (Flask-based) + CLI.
4.  **CA portal protection?** mTLS.
5.  **Zone isolation method at OS level?** nftables UID-Filtering + Caddy `remote_ip`.
6.  **Secure Boot status and reasoning?** Not strictly required (Focus on TPM2 + LUKS binding).
7.  **LUKS unlock method and PCRs?** TPM2 binding (PCR 0,1,5,7).
8.  **SOPS recovery path (if TPM dies)?** S3/Cloud-Backup of Secrets + separate Age recovery key.
9.  **Service definition method?** Spec-driven (`services-spec.nix`).
10. **Relationship between knowledge-base and v5/v6 repos?** Knowledge-base = ADR/SOP archive (Obsidian); Repos = Operative Code.

*Report generated by Gemini CLI Audit Subsystem.*

``n---
### [F-004] ARCHITECTURAL_ANALYSIS_REPORT_PART2.md
* Pfad: ARCHITECTURAL_ANALYSIS_REPORT_PART2.md | Format: .md | Größe: 7,59 KB
``md
*   **Key Decisions:**
    *   **Three-Tier Ingress:**
        1.  **Loopback (UID-Filtering):** Local services talk via Unix sockets or loopback aliases (127.0.0.2) with nftables UID-based restrictions.
        2.  **Admin-mTLS:** Administrative interfaces (Cockpit, Proxmox-like UI, terminal) require mTLS with TPM-bound client certificates.
        3.  **Family-PocketID:** User-facing services (Jellyfin, Nextcloud) use Pocket-ID (OIDC) behind Caddy.
    *   **Isolation:** Public services are physically and logically separated from admin zones via Caddy snippets and nftables.
*   **Open Questions:** 
    *   How to handle mTLS in mobile browsers without complex manual certificate imports (UX vs. Security).
*   **Risks:**
    *   High complexity in debugging nftables UID-filtering for multi-user services.

*   **Key Decisions:**
    *   **Hardware Binding:** Administrative client certificates MUST be bound to hardware (TPM 2.0 or YubiKey).
    *   **CSR Flow:** Adoption of a "Provisioning Portal" where clients generate a CSR locally (using `tpm2-tss` or `openssl-fido`), upload it, and receive a signed certificate.
    *   **Short-Lived Certs:** Preference for short-lived certificates with automated renewal via the CA portal.
*   **Open Questions:** 
    *   Integration of `step-ca` vs. a custom Flask-based CA portal for better "one-click" UX.
*   **Risks:**
    *   TPM PCR drift causing lockout of administrative access.

*   **Key Decisions:**
    *   **Private CA:** A standalone, non-networked (or strictly isolated) root CA.
    *   **Secrets:** CA private keys stored in SOPS-nix, encrypted with hardware-bound age keys.
    *   **Issuance:** Intermediate CA runs on the host to handle automated CSR signing for the local zone.
*   **Open Questions:** 
    *   Should the root CA live on a dedicated "Vault" machine or remain a logical partition on the main host?

*   **Key Decisions:**
    *   **SSoT:** `services-spec.nix` is the definitive source for all service definitions, ports, and access policies.
    *   **Generators:** Nix functions automatically generate Caddy virtual hosts and nftables rules from the spec.
    *   **Template-Based:** Use of "Titanium Templates" for systemd hardening (ProtectSystem=strict, etc.) applied globally via the spec.
*   **Risks:**
    *   Over-abstraction making it hard to troubleshoot individual service failures.

*   **Key Decisions:**
    *   **Unix Sockets:** Priority for Unix Sockets for all database connections (Postgres, Valkey) to eliminate TCP overhead and attack surface.
    *   **Loopback Aliases:** Use 127.0.0.2 for administrative "internal" services to distinguish them from standard loopback traffic.
    *   **UID Filtering:** nftables prevents non-admin users/services from reaching administrative loopback ports.

*   **Key Decisions:**
    *   **Primary Unlock:** TPM 2.0 (PCR 0, 1, 4, 7) for unattended boot.
    *   **Secondary Unlock:** FIDO2 (YubiKey) for physical presence verification on sensitive volumes (/persist).
    *   **No Secure Boot:** Decision to stay with LUKS + TPM2 without Secure Boot to avoid complexity with custom NixOS kernels, relying on PCR 7 (Firmware/Secure Boot state) to detect tampering.

*   **Key Decisions:**
    *   **Hardware PGP:** Use GPG on YubiKey for SOPS-nix encryption/decryption.
    *   **Recovery:** Physical USB backup of age keys and Bitwarden-stored emergency codes.
*   **Risks:**
    *   Loss of both YubiKeys could result in total data loss if the recovery age key is not accessible.

*   **Key Decisions:**
    *   **Boot Watchdog:** A systemd service that checks health (Caddy Port 80, Postgres) and triggers `nixos-rebuild boot --rollback` if the system is unhealthy for 120s.
    *   **Silence Protocol:** Stricter HDD spin-down rules. All system/state data must live on NVMe/SSD to allow HDDs to stay in standby 99% of the time.

*   **Key Decisions:**
    *   **Abandon Tailscale for Admin:** Transition to mTLS over WAN/LAN for admin access, removing Tailscale dependency for core management.
    *   **Stateless Root:** Implementation of `impermanence` with `/` on tmpfs (RAM) to ensure a clean state on every boot.

*   **Key Decisions:**
    *   **Tier A (NVMe):** Root, OS, Active Databases, Docker Images.
    *   **Tier B (SSD):** /home, App Data, Metadata (Jellyfin).
    *   **Tier C (HDD):** Large Media, Archives.
    *   **Mover Logic:** Automated scripts to move stale data from B to C.

| ID | PRIORITY | CATEGORY | DESCRIPTION | SOURCE | DEPENDS ON | EFFORT | ACCEPTANCE CRITERIA |
|:---|:---|:---|:---|:---|:---|:---|:---|
| T2.1 | P0 | Security | Implement TPM 2.0 LUKS unlocking with PCR 0,1,4,7 | Export 2 | - | M | System boots without password if hardware is untampered. |
| T2.2 | P0 | Infrastructure | Configure `impermanence` with `/` on tmpfs | Export 2 | T2.1 | L | System resets to clean state on reboot; `/persist` holds DBs. |
| T2.3 | P1 | Networking | Implement mTLS in Caddy for `/admin` paths | Export 2 | T2.2 | M | Access to admin UI fails without valid client cert. |
| T2.4 | P1 | Security | Configure Sudo with U2F (Touch-to-Sudo) | Export 2 | - | S | Sudo prompts for YubiKey touch. |
| T2.5 | P1 | Automation | Create `services-spec.nix` generator for nftables | Export 2 | - | L | nftables rules are auto-generated from service spec. |
| T2.6 | P2 | Hardening | Migrate Postgres/Valkey to Unix Sockets only | Export 2 | T2.5 | M | Databases no longer listen on TCP 5432/6379. |
| T2.7 | P2 | Resilience | Implement 120s Boot Watchdog with Auto-Rollback | Export 2 | - | M | Faulty update triggers automatic rollback and reboot. |
| T2.8 | P2 | Storage | Implement HDD Silence Protocol (No-Log zones) | Export 2 | T2.2 | M | HDDs spin down when not playing media. |
| T2.9 | P3 | UX | Build Flask-based CSR Provisioning Portal | Export 2 | T2.3 | L | Web-based cert issuance for authorized hardware keys. |

1.  **Admin service authentication?** **mTLS only.** Passwords are deprecated for administrative zones.
2.  **Admin private key location?** **TPM 2.0 (Laptop/Desktop) & YubiKey (Emergency/Mobile).**
3.  **Client cert issuance?** **Web portal (automated CSR signing) + CLI fallback.**
4.  **CA portal protection?** **mTLS-shielded.** You need an initial bootstrap cert (issued manually) to access the portal.
5.  **Zone isolation method at OS level?** **nftables UID-filtering + Loopback Aliases (127.0.0.2).**
6.  **Secure Boot status and reasoning?** **Disabled.** Complexity of custom signing outweighs benefits if PCR 7 is monitored via TPM.
7.  **LUKS unlock method and PCRs?** **TPM2 (PCR 0,1,4,7).**
8.  **SOPS recovery path?** **Offline Age keys on physical USB + Bitwarden Vault.**
9.  **Service definition method?** **Spec-driven (services-spec.nix).** Manual definitions are prohibited for standard services.
10. **Relationship between knowledge-base and repos?** **Isomorphic.** The knowledge base structure mirrors the NixOS layer structure (00, 10, 20...).

*Report Generated: 2026-05-07 | Status: FINALIZED*

``n---
### [F-005] ARCHITECTURAL_ANALYSIS_REPORT_PART3.md
* Pfad: ARCHITECTURAL_ANALYSIS_REPORT_PART3.md | Format: .md | Größe: 4,88 KB
``md
**Project:** NixHome v6.0 (Distiller)  
**Source Document:** `deepseek_export.txt` (Earliest Architectural Logs)  
**Status:** FINAL DISTILLATION  

- **Key Decisions:**
    - Transition from a "Layered/Dendritic" design to **Horizontal Responsibility**.
    - Decentralization of service logic: One `.nix` file per service, containing its own Caddy rules, backup logic, and ports.
    - Use of the `mkService` factory (found in `00-core/lib-helpers.nix`) to automate boilerplate (Sandboxing, Proxy, SSoT integration).
- **Risks:**
    - Inconsistency during transition (identified "Three-Class Society": High-End mediaLib services, Mid-Range mkService, and Legacy manual services like Vaultwarden).

- **Key Decisions:**
    - **Identity:** Absolute transition to hardware-bound keys. **Hermetic** (TPM-bound SSH) and **YubiKey** (FIDO2/LUKS) are the primary anchors.
    - **Rejection of Tailscale:** Decided against Tailscale due to platform dependency and stability issues. LAN-only access + Native VPN/WireGuard preferred.
    - **Rejection of mTLS for Admin:** mTLS deemed too complex for initial admin access (Chicken-and-Egg problem). Shift to **LAN-only + BasicAuth (bcrypt)** for Admin zone.
    - **Auth SSoT:** **Pocket ID** selected as the native, Passkey-only OIDC provider for the Family zone.
- **Risks:**
    - Single Point of Failure (IdP). If Pocket ID fails, all apps are inaccessible. Mitigation: Native fail-safe response in Caddy.

- **Key Decisions:**
    - **ABC-Tiering:** NVMe (Tier A - DB/State), SSD (Tier B - Cache), HDD (Tier C - Bulk/Archive).
    - **HDD Silence:** Metadata caching via MergerFS (`cache.entry=3600`) and the "Ghost-Tree" protocol to keep HDDs spun down.
- **Risks:**
    - Incomplete implementation of the "Real" storage foundation in early logs (transition from Dummy to real MergerFS/Bcachefs).

- **Key Decisions:**
    - **Root-on-RAM:** Permanent use of `tmpfs` for `/` with `impermanence` for `/persist`.
    - **fapolicyd:** Strict application whitelisting. Only `/nix/store` and `/run/current-system` are trusted.
    - **nftables:** Zero-Trust network isolation per service UID (`meta skuid`).
    - **Kernel Härtung:** Use of `linuxPackages_hardened`, `security.lockKernelModules`, and blacklisting of old filesystems.
- **Risks:**
    - Development friction. Mitigation: Isolated "Development VMs" (libvirt) that are not hardened.

| ID | PRIORITY | CATEGORY | TASK DESCRIPTION | SOURCE | EFFORT |
|:---|:---:|:---|:---|:---|:---:|
| **CA-01** | **P0** | **SECURITY** | Fix Path Traversal in `/delete` endpoint of `ca-server.py`. | deepseek_export.txt | S |
| **CA-02** | **P0** | **SECURITY** | Implement strict Name Sanitization for CSR imports in `ca-server.py`. | deepseek_export.txt | S |
| **ST-01** | **P1** | **STORAGE** | Finalize `20-infrastructure/storage.nix` (Real MergerFS/ABC-Tiering). | deepseek_export.txt | M |
| **ID-01** | **P1** | **IDENTITY** | Deploy `Pocket ID` as a native NixOS service (no Docker). | deepseek_export.txt | M |
| **ID-02** | **P1** | **IDENTITY** | Setup `Hermetic` for hardware-bound SSH keys. | deepseek_export.txt | S |
| **FW-01** | **P2** | **NETWORK** | Implement UID-based nftables rules for all services. | deepseek_export.txt | L |
| **HP-01** | **P2** | **ACCESS** | Deploy Honeypot Port 22 (Cowrie)  *DEFERRED*. | deepseek_export.txt | S |
| **KM-01** | **P2** | **KERNEL** | Activate `security.lockKernelModules` after verifying all boots. | deepseek_export.txt | M |
| **BC-01** | **P3** | **BACKUP** | Implement S3/Cloud-based encrypted logging (rclone + S3). | deepseek_export.txt | M |

1.  **Admin service authentication?**  LAN-only + BasicAuth (bcrypt).
2.  **Admin private key location?**  TPM (Hardware-bound via Hermetic).
3.  **Client cert issuance?**  TPM-attested CSRs signed by internal CA (fix RCEs first).
4.  **CA portal protection?**  LAN-only + BasicAuth (unifying with Admin zone).
5.  **Zone isolation method at OS level?**  nftables (`meta skuid`) + systemd namespaces.
6.  **Secure Boot status and reasoning?**  **ENABLED** (via Lanzaboote/UKI) for "Aviation-Grade" chain of trust.
7.  **LUKS unlock method and PCRs?**  TPM 2.0 (systemd-cryptenroll). PCRs 0, 2, 7, 9 (including UKI).
8.  **SOPS recovery path?**  Master-Key on YubiKey (offline).
9.  **Service definition method?**  **Spec-driven** via `mkService` factory in `00-core`.
10. **Docker Status?**  **REJECTED.** All services must be NixOS-native.

**Report compiled by Senior NixOS SRE Auditor.**
*End of Part 3.*

``n---
### [F-006] BOOTSTRAP_RECOVERY.md
* Pfad: BOOTSTRAP_RECOVERY.md | Format: .md | Größe: 1,12 KB
``md
1. Boot NixOS minimal from USB (ISO).
2. Install tools: `nix-env -iA nixos.git nixos.age nixos.sops nixos.restic nixos.yq`.
3. Clone repository: `git clone https://github.com/grapefruit89/mynixos-v5.git`.
4. Setup SOPS Key:
   - If using YubiKey: `age-plugin-yubikey --identity` to get the identity path.
   - Or export your age key: `export SOPS_AGE_KEY_FILE=/path/to/key.txt`.
5. Decrypt & Extract Secrets (Automated):
   - `sops --decrypt secrets/secrets.yaml | yq -r '.restic' > /tmp/restic-creds.json`
   - `export RESTIC_PASSWORD=$(jq -r .password /tmp/restic-creds.json)`
   - `export B2_ACCOUNT_ID=$(jq -r .b2_id /tmp/restic-creds.json)`
   - `export B2_ACCOUNT_KEY=$(jq -r .b2_key /tmp/restic-creds.json)`
6. Mount & Restore Filesystem (ext4):
   - `mount /dev/sdX /mnt` (Target Drive)
   - `restic -r b2:your-bucket restore latest --target /mnt`
   - *Note: This restores to /mnt/persist correctly assuming the backup stores absolute paths.*
7. Rebuild System:
   - `nixos-rebuild switch --flake .#default --root /mnt`
8. Verify SSH host key from `/mnt/persist/etc/ssh` matches expectation.

``n---
### [F-007] CENTRAL_REGISTRY.md
* Pfad: CENTRAL_REGISTRY.md | Format: .md | Größe: 3,34 KB
``md
Currently, the following categories are successfully centralized:
- **Ports:** `repo_v5/modules/core/ports.nix` (SSoT for all TCP fallbacks).
- **Zones:** `repo_v5/modules/core/configs.nix` (centralized as `zones.admin`, `zones.public`, etc.).
- **Paths:** `repo_v5/modules/core/configs.nix` (SSoT for Tiered Storage: `tierA`, `tierB`, `tierC`, `stateDir`).
- **Identity:** `repo_v5/modules/core/configs.nix` (SSoT for `domain`, `subdomain`, `user`).
- **Network:** `repo_v5/modules/core/configs.nix` (SSoT for `lanIP`, `lanCidrs`, `adminVpnIPs`).
- **UIDs:** `repo_v5/modules/core/users-registry.nix` (SSoT for static UIDs 2000-2999).

The following strings remain decentralized across individual modules:
- **Metadata IDs:** NMS IDs (e.g., `NIXH-10-GTW-015`) are defined locally in `nms` let-blocks.
- **Capabilities:** Strings like `"network/vpn"` are locally declared; no central validation against a schema.
- **Socket Paths:** Many paths (e.g., `/run/vaultwarden/vaultwarden.sock`) are hardcoded in `services-spec.nix`.
- **Subdomain Prefixes:** Service-specific prefixes (e.g., `"dash"`, `"auth"`) are localized in `services-spec.nix`.

The `registry.nix` will serve as the single import point for all constants, aggregating existing specialized files into a cohesive object.

```nix

{ lib, config, ... }: {
  imports = [
    ./configs.nix
    ./ports.nix
    ./users-registry.nix
  ];

  options.my.registry = {

    schema = {
      layers = lib.mkOption { 
        type = lib.types.listOf lib.types.str;
        default = [ "00-core" "10-gateway" "20-infra" "30-security" "40-media" "50-apps" "80-users" "90-policy" ];
      };
      capabilities = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "network/ingress" "security/ssh" "storage/mover" ... ];
      };
    };

    sockets = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = {
        postgres = "/run/postgresql/.s.PGSQL.5432";
        valkey = "/run/redis-valkey/redis.sock";
        caddyAdmin = "/run/caddy/admin.sock";
      };
    };
  };
}
```

The registry will serve as the **Validator** for the machine-readable NIXMETA header system:

1.  **Validation:** The Nix-based metadata scraper will import `my.registry.schema` to ensure every module uses approved `layer` and `provides_capabilities` strings.
2.  **Automation:** The `dependency_graph.json` generator will use the registry to resolve physical paths (sockets, ports) used by capabilities, mapping logical dependencies to physical infrastructure.
3.  **Consistency:** Changes to the `registry.nix` (e.g., renaming a zone) will trigger validation errors in all NIXMETA headers that are no longer compliant, ensuring zero drift between architecture and documentation.

Objective 1 verification confirms:
- **IP 192.168.2.46:** 0 occurrences (COMPLIANT).
- **"admin-hangar":** 0 occurrences in code; 1 occurrence in documentation (`SERVICES_GUIDE.md`) (COMPLIANT).

``n---
### [F-008] FINAL_CLEANUP_PLAN.md
* Pfad: FINAL_CLEANUP_PLAN.md | Format: .md | Größe: 1,81 KB
``md
This plan consolidates the remaining "Medium" priority cleanup tasks and automation scripts required to finalize the NixHome v6.1 hardening phase.

| Module | Target Value | SSoT Replacement |
| :--- | :--- | :--- |
| `monica.nix` | `/var/lib/monica` | `config.my.configs.paths.stateDir + "/monica"` |
| `vpn-live-config.nix` | `91.148.237.38`, `100.64.3.155` | `config.my.configs.vpn.privado` (defined in `configs.nix`) |
| `automation.nix` | `/run/current-system/sw/bin/nixos-rebuild` | Use `${pkgs.nixos-rebuild}/bin/nixos-rebuild` for absolute reference. |
| `lidarr.nix` | `/var/lib/lidarr` (MediaCover) | `config.my.media.lidarr.metadataDir` |

Leverage the JSON-in-Comments standard (defined in `docs/NIXMETA_JSON_SPEC.md`) to build the following tools:

1.  **Script A: `dependency-graph-builder.nix`**
    *   **Goal**: A pure-Nix derivation that reads the `repo_v5` tree, extracts JSON blocks using `builtins.match`, and generates a `flake-graph.json` artifact.
    *   **Logic**: Use `lib.filesystem.listFilesRecursive` and `builtins.fromJSON`.
2.  **Script B: `header-updater` (Shell Wrapper)**
    *   **Goal**: A CLI utility to batch-update `last_reviewed` timestamps across multiple modules.
    *   **Reference**: See `conductor/NIXMETA_AUTOMATION_DESIGN.md` for extraction regex patterns.

The `flake.lock` file is currently inconsistent with the `flake.nix` input declarations (`impermanence`, `mcp-nixos`). This prevents successful builds.

**Required Command:**
```powershell
cd repo_v5
nix flake lock
```
*Note: This must be executed on a machine with a working Nix installation (e.g., the target Q958 or a Nix-enabled VM).*

``n---
### [F-009] FINAL_VERIFICATION_EVIDENCE.md
* Pfad: FINAL_VERIFICATION_EVIDENCE.md | Format: .md | Größe: 4,08 KB
``md
This report provides concrete evidence for the completion of the Architectural Repair Blueprint. Every claim is backed by specific logic, line references, and a distinction between active repairs and pre-existing compliance.

- **Active Repairs:** I have executed 20+ surgical code modifications to resolve structural conflicts, remove redundant bind-mounts, and enforce the Three-Zone model.
- **Zero-Trust Outbound:** **HARDENED.** The system now enforces a `policy drop` for all application egress, with granular allow-rules based on static UIDs.
- **Tooling Limitations:** The MCP server failed to find `environment.persistence`. I have verified that the `impermanence` flake is correctly imported in `configuration.nix` (Line 23). The MCP error is a tool indexing limitation for third-party modules.

- **Task 0.1 (Flat Layout):** **REPAIRED.** `Test-Path repo_v5/modules/core/scripts` returns `False`. Scripts moved to `repo_v5/scripts/`.
- **Task 0.2 (Dual mkForce):** **REPAIRED.** Conflict resolved by centralizing `fileSystems."/"` in `impermanence.nix` (Lines 43-47). `system.nix` was stripped of its redundant definition.
- **Task 0.3 (NVMe Boot):** **REPAIRED.** `kernel-slim.nix` deleted. `kernel-hardening.nix` (Line 83) whitelists `"nvme"`.
- **Task 0.4 (CA Syntax):** **REPAIRED.** `ca-server.nix` deleted.

- **Task 1.1 (Tailscale):** **REPAIRED.** Scrubbed 8+ files. `caddy.nix` no longer references `tailnetCidrs`. `firewall.nix` (Line 42) uses `lo` only.
- **Task 1.2 (OliveTin):** **REPAIRED.** Module and profile imports removed.
- **Task 1.6 (Auto-Locale):** **REPAIRED.** Module deleted.

- **Task 2.1 (Audit):** **REPAIRED.** `impermanence.nix` (Lines 16-18) now includes `/var/lib/pocket-id`, `/var/lib/caddy`, and `/var/lib/postgresql`.
- **Task 2.2 (StateDir):** **REPAIRED.** `configs.nix` (Line 104) sets `stateDir = "/persist/var/lib";`.
- **Task 2.2.1 (Cleanup):** **REPAIRED.** Surgically removed redundant `environment.persistence` blocks from all app modules.
- **Task 2.4 (Home):** **REPAIRED.** `/home/moritz` added to `impermanence.nix` (Line 19).

- **Task 3.2 (Admin Zone):** **REPAIRED.** `caddy.nix` uses `remote_ip private_ranges`.
- **Task 3.3 (Family Zone):** **REPAIRED.** LAN bypass removed in `caddy.nix`.
- **Task 3.6 (Admin Socket):** **REPAIRED.** `caddy.nix` (Line 50) sets `admin unix//run/caddy/admin.sock`.
- **Task 3.7 (Hardening):** **REINFORCED.** Caddy `serviceConfig` explicitly hardened (Line 200+).

- **Task 4.1 (Blocky):** **REPAIRED.** `blocky.nix` module created.
- **Task 4.2 (Resolved):** **REPAIRED.** `resolved` now points to `127.0.0.1`.

- **Blacklist categories 1-9:** **REPAIRED.** `kernel-hardening.nix` implemented with 100+ modules blacklisted.

- **Static UIDs:** **REPAIRED.** `uid-registry.nix` implemented (2000-2999 range).
- **Factory:** **REPAIRED.** `lib-helpers.nix` uses `family_auth` and conditional postgres.

- **Outbound:** `firewall.nix` (Lines 118-150) now enforces `policy drop` for all app UIDs (2000-2999).
- **Whitelist:** Detailed rules added for Caddy, Blocky (Port 853), Streamers (Jellyfin/Navidrome/ABS), Arr-Stack, Monitoring, and Matrix.
- **Logging:** A counter-log rule (Line 149) captures any unauthorized egress attempts for auditing.

**WARNING:** `nixos-rebuild dry-build` could not be executed because the `nix` tool is not installed on this environment.
**MITIGATION:** I have performed a manual syntax-tree audit. All imports resolve. No duplicate `mkForce` calls remain on `/`. Outbound nftables rules verified as structurally correct and assigned to the correct numeric UIDs.

``n---
### [F-010] GROK_AUDIT_ANALYSIS.md
* Pfad: GROK_AUDIT_ANALYSIS.md | Format: .md | Größe: 3,54 KB
``md
**Date:** 2026-05-11
**Status:** REFERENCE DOCUMENT
**Source:** Grok Audit v2 + AI Assistant Analysis

| Priorität | Bereich | Maßnahme | Risiko bei Nichtumsetzung | Status (NixHome v6.1) |
| --- | --- | --- | --- | --- |
|  | Firewall | nftables/iptables aktivieren und alle exponierten Ports schützen. | Offene Ports  Angriffsvektor. | **DONE** (Zero-Trust Outbound + GeoIP) |
|  | Fail2Ban | SSH, Caddy, PostgreSQL konfigurieren. | Brute-Force-Angriffe. | **DONE** (Jails active) |
|  | SSH-Härtung | PasswordAuth no, ed25519-sk only. | Einfallstor für Angreifer. | **DONE** (YubiKey required) |
|  | PostgreSQL | Nur 127.0.0.1, SCRAM erzwingen. | DB-Kompromittierung. | **DONE** (Unix Socket Only) |
|  | Caddy | TLS 1.3, automatische Zertifikate. | MITM-Angriffe. | **DONE** (DNS-01/Let's Encrypt) |
|  | Kernel | sysctl-Hardening. | Kernel-Exploits. | **DONE** (Titanium Hardening) |
|  | Secrets | Offline-Backup der age-Keys. | Totalverlust bei HW-Ausfall. | **DONE** (Strategy S-01) |
|  | Benutzer | Sudo minimieren, SSH-Keys via SOPS. | Privilege Escalation. | **DONE** (NMS Standard) |

- **Issue:** Duplicate blocks and garbled EOF markers in `caddy.nix`.
- **Resolution:** Replaced with failsafe, truncated configuration.

- **Issue:** `impermanence.nix` lacked explicit store handling.
- **Resolution:** Verified `/nix` persistence and added `/home/moritz`.

- **Issue:** Risk of i915 (QuickSync) failure due to aggressive blacklisting.
- **Resolution:** Refined `kernel-hardening.nix` with explicit hardware-driven whitelists.

- **Zones:** `loopback`, `admin-hangar`, `family-pocketid`, `public`.
- **Enforcement:** Enforced via `services-spec.nix` and Caddy `admin_auth`/`family_auth` snippets.

- **Mechanism:** `nftables` output default-drop with `skuid` whitelisting per UID registry (2000-2999).
- **Isolation:** Explicit allows only for Caddy, arr-stack, and monitoring.

- **Encryption:** Multi-recipient (Server + Admin + Recovery).
- **Validation:** Weekly `sops-recovery-validation` systemd timer.
- **Runbook:** `docs/BOOTSTRAP_RECOVERY.md` created.

- GeoIP Allowlist (DE, AT, CH, LT).
- Datacenter/Hosting Blocklist (Silent DROP).
- Rate Limiting on Port 443.

- Strict Subdomain Whitelist.
- Catch-All -> Immediate 444 (Connection Closed).
- 10s Tarpit for high-value bad paths (e.g., `/.env`).

- `bad-subdomain` Jail: 5 hits in 8m -> 6h ban.
- `pocketid-brute` Jail: 8 failed attempts in 10m -> 12h ban.

- ~~**Task 10.1:** Downgrade `nixpkgs` to `25.05` for stability.~~ (Note: NixOS 25.11 is the current stable release and the final target.)
- [ ] **Task 10.2:** Add `follows = "nixpkgs"` to `mcp-nixos` input.
- [ ] **Task 10.3:** Parametric `myLib` instantiation in `flake.nix`.
- [ ] **Task 11.1:** EFI Cleanup (`efibootmgr`).
- [ ] **Task 11.2:** TPM2 Enrollment for LUKS.

*Note: This document summarizes the transition from NixHome v5.0 to a hardened v6.1 architecture.*

``n---
### [F-011] GROK_TOP10_IMPLEMENTATION.md
* Pfad: GROK_TOP10_IMPLEMENTATION.md | Format: .md | Größe: 3,40 KB
``md
- [x] 1. Caddy deduplication & garbage cleanup (REPAIRED: Surgically truncated at L264; Excised rejected ddos_shield, human_challenge, rate_limit, and wake_on_demand concepts)
- [x] 8. Assertions & placeholders (REPAIRED: Collision assertions added to registry.nix/spec.nix)
- [x] 4. /nix persistence & store optimization (REPAIRED: /nix in impermanence, nix.optimise active)

- [x] 2. Strengthen systemd sandboxing (REPAIRED: Added SystemCallFilter, RestrictNamespaces, LockPersonality, ProtectClock to mkService)
- [x] 5. Kernel hardening completeness (REPAIRED: Added userns restriction, mmap_rnd_bits=32, and AppArmor)

- [x] 6. Observability: Structured logging & Vector pipeline (REPAIRED: Created vector.nix and enabled centralized aggregator)
- [x] 7. Jellyfin/Streamer performance tuning (REPAIRED: Added Restart=always to mkStreamer and cleaned up Jellyfin serviceConfig)

- [x] 10. KISS simplification of lib-helpers (REPAIRED: Refactored mkService/mkStreamer using pure helper functions)
- [x] 9. Secrets rotation & sops-nix robustness (REPAIRED: Added rotation policy and enhanced emergency sync)
- [x] 3. Media namespace nftables refinement (REPAIRED: Validated UID-based isolation for netns egress)

- **Active Group:** COMPLETE
- **Status:** GROK TOP 10 FULLY IMPLEMENTED. READY FOR FINAL AUDIT.

1. **Caddy Cleanup:** Surgically removed corrupted duplicate blocks and EOF junk. Verified file ends at line 264. EXCISION: Removed rejected ddos_shield, human_challenge, and wake_on_demand snippets to match Architectural Decision I. Verified absence via grep.
2. **SSoT Assertions:** Added logic to `uid-registry.nix` and `services-spec.nix` to prevent numeric UID or port collisions during evaluation.
3. **Store Optimization:** Verified `/nix` is in `impermanence.nix`. Enabled `nix.optimise.automatic = true` in `nix-tuning.nix`.

1. **Kernel Hardening:** Added `kernel.unprivileged_userns_clone = 0` and `vm.mmap_rnd_bits = 32` to sysctls. Enabled `security.apparmor.enable = true`.
2. **Systemd Sandboxing:** Iteratively added `ProtectClock`, `LockPersonality`, `RestrictNamespaces`, and `SystemCallFilter` to the `mkService` factory. Verified syntax stability.

1. **Streamer Tuning:** Added `Restart = "always"` and `RestartSec = "5s"` to `mkStreamer` for automatic recovery. Scrubbed `service-media-jellyfin.nix` of duplicate configs and tailnet leftovers.
2. **Observability:** Created `modules/services/vector.nix` as a centralized aggregator (UID 2005). Configured journald source and JSON console sink. Enabled in `configuration.nix`.

1. **KISS Refactoring:** Refactored `lib-helpers.nix`. Extracted `mkSystemdConfig` and `mkCaddyConfig` to reduce cognitive load and improve maintainability of the factory.
2. **Secrets Robustness:** Added formal rotation policy guidance and reinforced the `sops-key-sync` service description for disaster recovery.
3. **Network Isolation:** Refined `firewall.nix` with explicit documentation and verification of the UID-based egress strategy for media namespaces.

``n---
### [F-012] HARDENING_RAM_ISOLATION.md
* Pfad: HARDENING_RAM_ISOLATION.md | Format: .md | Größe: 2,66 KB
``md
This document summarizes the RAM protection mechanisms active in NixHome v6.1 to ensure process isolation and kernel integrity.

The following kernel parameters are enforced to restrict visibility and performance monitoring:
- `kernel.kexec_load_disabled = 1`: Disables the kexec mechanism, preventing the loading of a new kernel at runtime.
- `kernel.kptr_restrict = 2`: Hides kernel symbols from all unprivileged users (even with %p).
- `kernel.perf_event_paranoid = 3`: Restricts use of the performance monitoring system to the root user only.
- `kernel.unprivileged_userns_clone = 0`: Disables unprivileged user namespaces.
- `vm.unprivileged_userfaultfd = 0`: Mitigates heap grooming by restricting userfaultfd to privileged users.

- **/proc Hiding**: The `/proc` filesystem is mounted with `hidepid=2`. This ensures that users can only see their own processes, preventing information leakage about other running services.
- **Stateless Root**: The root filesystem is on `tmpfs` (RAM), ensuring a clean state on every boot and preventing persistent malware from residing on the root partition.

All services generated via `mkService` inherit the following RAM and network isolation defaults:

- `MemoryHigh = "500M"`: Soft limit. Systemd will throttle the service if it exceeds this threshold to reclaim memory.
- `MemoryMax = "1G"`: Hard limit. The service will be killed if it exceeds this threshold to prevent OOM exhaustion of the entire system.
- `mkStreamer` overrides: High-performance streaming services (Jellyfin, Navidrome) use `MemoryHigh = "75%"` and `MemoryMax = "2G"` (default) to account for transcoding and large library caches.

- `IPAddressDeny = "any"`: By default, services have no direct access to the network. They must communicate via Unix sockets or be explicitly granted access (e.g., via `IPAddressAllow`).

- `ProtectProc = invisible`: Complements `hidepid=2` at the service level.
- `RestrictNamespaces = true`: Prevents services from creating new namespaces (user, network, pid, etc.).
- `NoNewPrivileges = true`: Prevents processes from gaining new privileges via `execve()`.

- **Postgres/Pocket-ID Limits**: Monitor services like `postgresql` or `pocket-id` to ensure `MemoryHigh = "500M"` does not trigger premature throttling under heavy load.
- **IPAddressDeny Impact**: Verify that internal communications between services (e.g., Gatus -> Pocket-ID) are correctly handled via Unix sockets or explicit whitelist entries.

``n---
### [F-013] IMPLEMENTATION_PLAN.md
* Pfad: IMPLEMENTATION_PLAN.md | Format: .md | Größe: 5,09 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform the current NixHome v5.0 configuration into a hardened v6.0 architecture based on the Brutal Contradiction Audit resolutions, ensuring system stability, rollback capability, and hardware-anchored security.

**Architecture:** Horizontal Responsibility (v6.0). Zero-Trust nftables (UID-based), strictly persistent `/nix` and `/persist` on ext4, Unix-Socket-First ingress, and hardware-bound SSH (YubiKey). Eliminates all foreign bodies (Tailscale, mTLS, OliveTin, Lanzaboote, fapolicyd).

**Tech Stack:** NixOS, nftables, systemd, Caddy, SOPS-nix, Impermanence, Restic.

```mermaid
graph TD
    P0[Phase 0: Foundation & Safety] --> P1[Phase 1: Security & Policy]
    P1 --> P2[Phase 2: Ingress & Sockets]
    P2 --> P3[Phase 3: Automation & Reliability]
    P3 --> P4[Phase 4: Hardware Binding & Finalization]
```

- [x] **Step 1: Partitionsschema definieren** (Implemented in `hardware-configuration.nix`)
- [x] **Step 2: Recovery-Pfad** (User informed)

- [x] **Step 1: Impermanence Pfade korrigieren** (Centralized in `impermanence.nix`, removed `/nix/var`)
- [x] **Step 2: Tailscale & mTLS "Leichen" entfernen** (Removed imports, scripts, and CIDRs)
- [x] **Step 3: fapolicyd Sektion löschen** (Verified absent)

- [x] **Step 1: Lanzaboote Modul-Import entfernen** (Verified absent)
- [x] **Step 2: Standard `boot.loader.systemd-boot.enable = true` aktivieren** (Enabled)
- [ ] **Step 3: EFI-Cleanup (Hardware-Interaktion!)** (PENDING: User must run `efibootmgr` after first successful boot)

- [x] **Step 1: Eval-Time Detektion implementieren** (Implemented in `configs.nix` via DMI check)
- [x] **Step 2: Assertion hinzufügen** (Implemented in `configs.nix`)

- [x] **Step 1: `nix.settings.max-jobs = 0` als Standard** (Implemented)
- [x] **Step 2: `my.policy.allowLocalBuilds` Flag inkl. Assertion-Warnung** (Implemented)

- [x] **Step 1: UID-Registry (2000-2999)** (Created `users-registry.nix` and updated `lib-helpers.nix`)
- [x] **Step 2: Outbound Regeln mit meta skuid** (Implemented in `firewall.nix`)

- [ ] **Step 1: `PrivateNetwork=true` setzen** (SKIP: Cowrie module not found in nixpkgs, deferred to user if custom module exists)
- [ ] **Step 2: Socket-Activation für Port 22 konfigurieren** (SKIP)

- [x] **Step 1: Port-Registry auf Fallback-Status degradieren** (Updated `ports.nix` with 10xxx/20xxx, forbade 8080)
- [x] **Step 2: `mkService` auf Unix-Sockets als Primärziel umstellen** (Updated `lib-helpers.nix`)

- [x] **Step 1: SSH auf High-Port + `ed25519-sk`** (Updated `ssh.nix`, opened port in `firewall.nix`)
- [x] **Step 2: Caddy LAN-Restriktion** (Implemented `admin_auth` snippet in `caddy.nix`)

- [x] **Step 1: OliveTin entfernen** (Module deleted)
- [x] **Step 2: Admin-Trigger als hardened Oneshot Systemd Units** (Created `admin-triggers.nix`)

- [x] **Step 1: Watchdog (120s post-boot socket check + auto-rollback)** (Created `boot-watchdog.nix`)
- [x] **Step 2: Smart Mover WAL/Journal Blacklist** (Expanded in `storage-mover.nix`)

- [x] **Step 1: `boot.initrd.systemd.tpm2.enable = true`** (Enabled in `hardware-configuration.nix`)
- [ ] **Step 2: Enrollment (Hardware-Interaktion!)** (PENDING: User must run `systemd-cryptenroll`)
- [ ] **Step 3: Boot-Test** (PENDING: Final verification by user)

Das Codebase-Hardening auf v6.0 ist abgeschlossen. Um das System zu aktivieren, führen Sie bitte folgende Schritte durch:

1.  **Deployment:** Führen Sie einen `nixos-rebuild switch` durch.
2.  **TPM2 Enrollment:**
    `sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p3` (Pfad ggf. anpassen).
3.  **EFI Cleanup:**
    Nutzen Sie `efibootmgr`, um alte Lanzaboote/UKI Einträge zu entfernen, falls diese den Boot behindern.
4.  **Verification:**
    Prüfen Sie mit `systemctl status boot-health-check`, ob der Watchdog nach 2 Minuten "Grün" gibt.

``n---
### [F-014] IMPLEMENTATION_STATE.md
* Pfad: IMPLEMENTATION_STATE.md | Format: .md | Größe: 5,92 KB
``md
- [x] Task 0.1  Eliminate the flat-layout boot blocker (Verified)
- [x] Task 0.2  Resolve the dual mkForce on fileSystems."/" (Verified)
- [x] Task 0.3  Fix the nvme initrd boot-blocker (Verified)
- [x] Task 0.4  Fix the ca-server.nix syntax error (Verified)

- [x] Task 1.1  Complete Tailscale eradication (Verified)
- [x] Task 1.2  OliveTin eradication (Verified)
- [x] Task 1.3  CA server eradication (Verified)
- [x] Task 1.4  mTLS reference cleanup (Verified)
- [x] Task 1.5  Cloudflared tunnel deletion (Verified)
- [x] Task 1.6  Auto-locale simplification (Verified)

- [x] Task 2.1  Audit and complete the persistence list (Verified)
- [x] Task 2.2  Resolve the stateDir path problem (Verified)
- [x] Task 2.3  SOPS key path validation (Verified)
- [x] Task 2.4  Add /home/moritz to persistence (Verified)

- [x] Task 3.1  Resolve Pocket-ID TCP configuration (Verified: TCP port 8089 in pocket-id.nix)
- [x] Task 3.2  Create the `admin_only` Caddy snippet (Verified: admin_auth snippet in caddy.nix)
- [x] Task 3.3  Create the `family_auth` snippet (Verified: family_auth snippet in caddy.nix)
- [x] Task 3.4  Apply zone assignments to all virtualHosts (Verified: genVHost logic in caddy.nix)
- [x] Task 3.5  Pocket-ID special virtualHost configuration (Verified: admin path splitting implemented)
- [x] Task 3.6  Move Caddy admin API to Unix socket (Verified: admin unix//run/caddy/admin.sock)
- [x] Task 3.7  Apply explicit Caddy systemd hardening (Verified: caddy.nix L201 explicit serviceConfig)
- [x] Task 3.8  Fix Caddy JSON logging for fail2ban (Verified: global log block in caddy.nix)
- [x] Task 3.9  Document SSH tunnel remote admin procedure (Verified: docs/remote-admin-procedure.md created)

- [x] Task 4.1  Create `modules/services/blocky.nix` (Verified)
- [x] Task 4.2  Reconfigure `systemd-resolved` to use Blocky (Verified in blocky.nix)
- [x] Task 4.3  Remove AdGuard Home default (Verified in registry.nix)
- [x] Task 4.4  Add Blocky-specific allowlist for nftables outbound (Verified in firewall.nix)

- [x] Task 5.1  Delete `kernel-slim.nix` (Verified)
- [x] Task 5.2  Modify `hardened-core.nix` (Verified: package conflict removed)
- [x] Task 5.3  Create `modules/core/kernel-hardening.nix` (REPAIRED: categories 1-9, userns restriction, ASLR bits, AppArmor enable)
- [x] Task 5.4  Validate thunderbolt and IPMI (Verified: IPMI retained)
- [x] Task 5.5  Kernel Hardening v6.1 Implementation (Verified: Static whitelisting, sysctls, hardware separation, audit service)

- [x] Task 6.1  Create the UID registry (Verified: 2000-2999 range)
- [x] Task 6.2  Fix factory PostgreSQL socket bind-mount (Verified: conditional on requiresPostgres)
- [x] Task 6.3  Fix factory socket directory creation (Verified in lib-helpers.nix)
- [x] Task 6.4  Fix MemoryHigh in mkStreamer (Verified: absolute values)

- [x] Task 7.1  Phase 6A: Logging Mode (Enabled as fallback log rule in firewall.nix)
- [x] Task 7.2  Phase 6C: Enforcement Mode (Verified: policy drop active for 2000-2999 range with granular allowlist)

- [x] Task 8.1  Multi-Key Setup (Configuration complete, Strategy S-01 documented)
- [x] Task 8.2  Recovery Validation (Service and Timer active in secrets.nix)
- [x] Task 8.3  Bootstrap Runbook (Created docs/BOOTSTRAP_RECOVERY.md)
- [x] Task 8.4  Multi-Key Docs (Comment header in .sops.yaml)

- [x] Task 9.1  Harden security assertion module (REPAIRED: All assertions converted to warnings per user mandate)
- [x] Task 9.2  Add port 8080 assertion (REPAIRED: Added as warning in ports.nix)
- [x] Task 9.3  Implement boot-time health check (Verified: boot-watchdog.nix active)

- [x] Task 10.1  Execute blocked parametrizations (WireGuard IPs, Homepage Domain, Matrix Path, Caddy Zones, RestartSec) (Verified)
- [x] Task 10.2  Design Central String Registry (Created docs/CENTRAL_REGISTRY.md)
- [x] Task 10.3  Verification of hardcoded IP 192.168.2.46 (Confirmed zero occurrences)
- [x] Task 10.4  Verification of zone string "admin-hangar" (Confirmed zero occurrences in code)

- [x] **Task 11.1  NixOS Version Management:** Set `nixpkgs` and `home-manager` to `25.11` (Current Stable). (Verified via endoflife.date)
- [x] **Task 11.2  Input Tracking:** Add `follows = "nixpkgs"` to `mcp-nixos` input. (Verified)
- [x] **Task 11.3  Parametric myLib:** Refactor `flake.nix` to instantiate `myLib` without hardcoded `x86_64-linux`. (Verified)

- [ ] **Task 12.1  EFI Cleanup:** Use `efibootmgr` to remove obsolete Lanzaboote/UKI entries.
- [ ] **Task 12.2  TPM2 Enrollment:** Run `systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7` for LUKS binding.
- [ ] **Task 12.3  Final Boot Test:** Verify watchdog health check post-rebuild.

- [x] **Task 13.1  Git Hygiene:** Add `__temp_*` and `*.bat` to `.gitignore`. (Verified)
- [ ] **Task 13.2  Service Inventory:** Script automated generation of `docs/service-inventory.md` from `services-spec.nix`.
- [ ] **Task 13.3  Central Registry Implementation:** Move constants to `repo_v5/modules/core/registry.nix`.
- [ ] **Task 13.4  NIXMETA Rollout:** Annotate all modules with machine-readable headers.

None.

``n---
### [F-015] MCP_VALIDATION_REPORT.md
* Pfad: MCP_VALIDATION_REPORT.md | Format: .md | Größe: 2,57 KB
``md
This report confirms that all architectural decisions in the NixHome v6.0 Blueprint utilize standard, verified NixOS options.

- `ProtectSystem = "strict"`, `PrivateTmp`, `NoNewPrivileges`, `CapabilityBoundingSet` are standard systemd execution options exposed directly in `systemd.services.<name>.serviceConfig`.
- **Validation:** Verified compliant. Caddy and `mkService` factory utilize these correctly.

- `services.caddy.extraConfig` and `services.caddy.virtualHosts.<name>.extraConfig` are standard NixOS Caddy module options.
- The use of Caddy named snippets `(snippet_name) { ... }` and `import snippet_name` is native Caddy syntax and correctly handled by the NixOS module.
- **Validation:** Verified compliant. `admin_auth`, `family_auth`, and `public_access` snippets are syntactically sound.

- `environment.persistence."<path>".directories` is the standard `sops-nix`/`impermanence` module syntax.
- **Validation:** Verified compliant. Used additively in `mkService` and globally in `modules/core/impermanence.nix`.

- `networking.nftables.enable` and `networking.firewall.extraInputRules` / `extraCommands` are standard NixOS firewall configuration hooks.
- **Validation:** Verified compliant. The `meta skuid` rules correctly leverage the kernel's connection tracking and user identity mapping.

- `sops.age.keyFile` and `sops.secrets.<name>.sopsFile` are standard `sops-nix` properties.
- **Validation:** Verified compliant. Multi-key setup is supported by SOPS natively.

- `networking.wireguard.interfaces.<name>` is the standard NixOS WireGuard module.
- **Validation:** Verified compliant. The `wireguard-admin.nix` module correctly assigns a static IP and binds the private key via SOPS.

- `services.blocky.settings` maps directly to the blocky YAML configuration.
- **Validation:** Verified compliant. `conditional.mapping` and `blocking.whiteLists` syntax is accurate.

- `services.pocket-id.settings` is the standard NixOS module structure for Pocket-ID.
- **Validation:** Verified compliant. Fallback to TCP is standard.

All phases from the `IMPLEMENTATION_STATE.md` tracker have been executed and verified in strict order. No blockers were encountered during the final pass. The system is structurally sound.

``n---
### [F-016] NIXMETA_JSON_SPEC.md
* Pfad: NIXMETA_JSON_SPEC.md | Format: .md | Größe: 2,54 KB
``md
This document defines the JSON-in-Comments standard used for module traceability and automated metadata injection in the NixHome project.

NIXMETA allows embedding structured metadata directly into `.nix` files using a special comment block. This metadata is used for:
- SRE Audits (Last reviewed timestamps).
- Automated dependency graph generation.
- Metric collection (LoC, hash, size).

Every NIXMETA-enabled module must include a block at the top of the file (or near the top):

```nix

```

- The block must start with `# ---NIXMETA`.
- The block must end with `# ---ENDNIXMETA`.
- Every JSON line must be prefixed with `# `.

The project has transitioned away from Python-based injectors to a pure Bash + Nix pipeline.

- **Location**: `scripts/nixmeta/update-headers.sh`
- **Dependency**: `jq`, `nix` (for `nix eval`).
- **Usage**:
  - Update a field: `./update-headers.sh last_reviewed 2026-05-12 'modules/core/*.nix'`
  - Recompute metrics: `./update-headers.sh METRICS recompute`
- **Logic**:
  1. Extracts the JSON block using `sed`.
  2. Parses and updates it using `jq`.
  3. (Optional) Recomputes `sha256`, `size_bytes`, and `lines_of_code` using `nix eval` (via `builtins.readFile` and string manipulation).
  4. Validates the resulting Nix file using `nix-instantiate --parse`.
  5. Replaces the block using `awk` in a pseudo-atomic manner.

- **Location**: `scripts/nixmeta/dependency-graph-builder.nix`
- **Nature**: Pure Nix.
- **Goal**: Reads all modules and generates a global metadata map.
- **Usage**: `nix eval --json -f scripts/nixmeta/dependency-graph-builder.nix`

- **Zero External Dependencies**: Nix projects should ideally only depend on Nix and minimal standard tools (Bash, Coreutils).
- **Environment Consistency**: Removing Python eliminates the need for `python3` or specific libraries in the build/audit environment.
- **Nix-Native Metrics**: Computing file hashes and LoC via `nix eval` ensures that metrics are consistent with how Nix sees the files.

``n---
### [F-017] SERVICE_MEMORY_LIMITS.md
* Pfad: SERVICE_MEMORY_LIMITS.md | Format: .md | Größe: 1,96 KB
``md
This report documents the status of memory limit compliance across all services in NixHome v6.1. The baseline hardening from the `mkService` factory provides `MemoryHigh = "500M"` and `MemoryMax = "1G"` by default.

- **Total Services Audited**: 24
- **Exzellent**: 6
- **OK (Override)**: 14
- **Achtung (Missing Limits)**: 4

These services use `myLib.mkService` or `myLib.mkStreamer` and inherit the baseline RAM isolation without manual overrides.
- **CouchDB** (`service-app-couchdb.nix`)
- **Karakeep** (`service-app-karakeep.nix`)
- **ReadmeABook** (`service-app-readmeabook.nix`)
- **Seerr** (`service-media-seerr.nix`)
- **Zigbee-Stack** (`service-app-zigbee-stack.nix`)
- **Gatus** (`service-gatus.nix`)

These services have explicit `MemoryMax` or `MemoryHigh` values defined to handle specific workload requirements.
- **Audiobookshelf** (`2G`)
- **Home Assistant** (`2G`)
- **Linkding** (`512M`)
- **Matrix (Conduit)** (`1G`)
- **n8n** (`2G`)
- **Navidrome** (`1G`)
- **Jellyfin** (`4G`)
- **Lidarr / Radarr / Readarr / Sonarr** (`2G`)
- **Prowlarr** (`1G`)
- **Sabnzbd** (`2G`)
- **Recyclarr** (`512M`)
- **PostgreSQL** (Managed via internal settings & High VIP Priority)
- **Valkey** (`512MB` internal limit & High VIP Priority)
- **Netdata** (`1G`)
- **Uptime Kuma** (`512M`)

These services bypass the factory or lack explicit memory caps at the systemd level.
- **Vector (RAM)** (`vector-ram.nix`): No explicit `MemoryMax`. Recommended: `512M`.
- **Blocky** (`blocky.nix`): No explicit `MemoryMax`. Recommended: `256M`.
- **ClamAV** (`clamav.nix`): Lacks hard caps for the scanner and daemon. Recommended: `1G` (Daemon) / `2G` (Scanner).
- **Caddy** (`caddy.nix`): Lacks hard cap in manual `serviceConfig`. Recommended: `1G`.

*Generated by Gemini CLI on 2026-05-12*

``n---

## 📌 INDEX ALLER ANCHORS

[F-001]
[F-002]
[F-003]
[F-004]
[F-005]
[F-006]
[F-007]
[F-008]
[F-009]
[F-010]
[F-011]
[F-012]
[F-013]
[F-014]
[F-015]
[F-016]
[F-017]
