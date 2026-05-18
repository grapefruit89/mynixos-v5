# 🚀 Cluster 90: GitHub Workflows

Dieses Dokument konsolidiert alle Informationen zur Nutzung von GitHub für CI/CD, Sicherheit und Remote-Management in mynixos.

### Inhalt aus `GUIDE-GitHub-Actions-SRE-Mastery.md`

---
title: 🚀 GitHub Actions SRE Mastery (CI/CD Pipeline)
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [automated-validation, dependency-auditing, status-reporting, deployment-automation]
sources: [GitHub Actions Docs, NixOS CI Patterns]
---

# 🚀 GitHub Maximalismus: Deine externe SRE-Abteilung

Wir nutzen GitHub nicht nur als Speicher, sondern als aktive Automatisierungs-Plattform für den mynixos-Tower.

## 🏛️ 1. Der "Pre-Flight Check" (CI)
Jeder Push triggert eine automatisierte Validierung im GitHub-Rechenzentrum.
- **Befehl:** `nix flake check --extra-experimental-features "nix-command flakes"`
- **SRE-Vorteil:** Syntaxfehler oder ungültige Modul-Imports werden abgefangen, bevor sie den Tower erreichen. ✅

## 🛡️ 2. Supply-Chain Security (Tor 6)
Wir nutzen GitHubs Enterprise-Scanner für dein Homelab.
- **CodeQL:** Automatische Analyse von Shell-Scripten und Python-Tools in `mynixos/scripts`.
- **Dependabot:** Automatische Pull-Requests für Flake-Update-Vorschläge.

## 📊 3. Public Status Reporting (GitHub Pages)
Ein kleiner Bot auf dem Tower lädt regelmäßig `status.json` Daten hoch.
- **Feature:** Visualisierung der System-Gesundheit auf `github.io`.
- **Nutzen:** Externer Status-Check bei Internet-Ausfall im Hausnetz.

## 📂 4. Artifact Storage
Wir nutzen GitHub Actions, um vorkompilierte Binaries oder wichtige Dokumente aus der Knowledge-Pipeline als verschlüsselte Artefakte zu sichern.

## 🚀 SRE-Anwendung
Die Workflows werden in `.github/workflows/` deklariert. Sie sind der Herzschlag deiner kontinuierlichen System-Verbesserung.

### Inhalt aus `GUIDE-GitHub-Codespaces-SRE.md`

---
title: ☁️ GitHub Codespaces (The Mobile Command Center)
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [cloud-ide, nix-integration, prebuild-performance, remote-management]
sources: [GitHub Codespaces Documentation, DevContainer Standard]
---

# ☁️ GitHub Codespaces: Deine IDE in der Cloud

In mynixos nutzen wir Codespaces als redundante, mobile Entwicklungsumgebung. Sie ermöglicht SRE-Eingriffe von jedem Gerät mit Browser.

## 🏛️ 1. Das Konzept (DevContainer)
Wir deklarieren unsere Entwicklungsumgebung in `.devcontainer/devcontainer.json`.
- **Nix-Support:** Wir nutzen das offizielle Nix-Feature für Codespaces.
- **Tools:** Alle SRE-Werkzeuge (sops, git, age, fwknop) sind vorinstalliert. ✅

## ⚡ 2. Prebuilds (Zero-Latency)
Wir aktivieren Prebuilds, damit der Cloud-Rechner sofort einsatzbereit ist.
- **Workflow:** GitHub baut das Environment bei jedem Push im Hintergrund.
- **SRE-Vorteil:** Im Notfall zählt jede Sekunde. Ein Codespace, der sofort da ist, schlägt jede lokale Installation.

## 🔑 3. Secret Management
GitHub Codespaces können auf deine Repository-Secrets (Kapitel 73) zugreifen.
- **Anwendung:** Automatisches Entsperren von Sops-Files im Cloud-Editor via injizierter Age-Keys.

## 🚀 SRE-Anwendung
Codespaces are the fallback if your local laptop is defective or you don't have access to your usual working environment. They guarantee **continuity of operations** under all circumstances.

### Inhalt aus `GUIDE-GitHub-Security-Hardening.md`

---
title: 🛡️ GitHub Security Hardening (SRE Tor 6)
category: architecture/security
status: [ACTIVE-SSoT]
capabilities: [secret-scanning, dependabot-automation, codeql-audit, security-advisories]
sources: [GitHub Security Documentation, Supply Chain Best Practices]
---

# 🛡️ GitHub Security: Das externe Schutzschild

Wir nutzen die Enterprise-Security-Features von GitHub, um die Integrität unserer Knowledge-Pipeline und des System-Codes zu garantieren.

## 🏛️ 1. Secret Scanning (The Emergency Brake)
Wir aktivieren das Secret-Scanning, um den Tower vor Datenlecks zu schützen.
- **Ziel:** Verhindern des Uploads unverschlüsselter SSH-Keys oder API-Tokens. ✅
- **Workflow:** Falls ein Secret erkannt wird, wird der Push sofort durch GitHub verweigert.

## 🤖 2. Dependabot Automation
Dependabot fungiert als dein automatisierter Junior-Admin.
- **Alerts:** Benachrichtigung bei CVEs in Flake-Inputs (via `flake.lock`).
- **Auto-Updates:** Automatische Pull-Requests für Sicherheits-Patches.

## 🔍 3. CodeQL Analysis (Static Analysis)
Wir integrieren CodeQL in unsere CI-Pipeline (Kapitel 72).
- **Nutzen:** Erkennt SQL-Injektionen, Cross-Site-Scripting oder unsichere Dateizugriffe in unseren Python/Bash-Hilfsscripten.

## 🛡️ 4. Security Policy
Wir hinterlegen eine `SECURITY.md` im Repo-Root.
- **Inhalt:** Klare Anweisungen für die Offenlegung von Schwachstellen.

## 🚀 SRE-Anwendung
Diese Einstellungen werden in den GitHub Repository-Settings unter "Security" permanent aktiviert. Sie bilden das externe Qualitäts-Tor 6 für mynixos.

---

### Offene SSO-Aufgaben

| ID | Quelle | Beschreibung | Betroffene Dateien | Priorität | Status | Notizen |
|----|--------|--------------|--------------------|-----------|--------|---------|
| TODO-001 | AUDIT_MASTER_TRACKER, CURRENT_STATUS | Implementiere WAL/SHM Exclusions im Storage Mover Script. | `repo_v5/modules/storage/storage-mover.nix` | hoch | erledigt | |
| TODO-002 | AUDIT_MASTER_TRACKER | Lokale ntfy-Instanz statt ntfy.sh implementieren. | `repo_v5/modules/monitoring/gatus.nix` | mittel | offen | |
| TODO-003 | HARDENING_OPTIMIZATIONS_AUDIT | **KRITISCH:** Systemd-Härtung für Blocky DNS implementieren. | `repo_v5/modules/services/blocky.nix` | hoch | erledigt | |
| TODO-004 | HARDENING_OPTIMIZATIONS_AUDIT | Ergänzung fehlender Härtungs-Flags für Pocket-ID. | `repo_v5/modules/services/pocket-id.nix` | hoch | erledigt | |
| TODO-005 | HARDENING_OPTIMIZATIONS_AUDIT | Globale mkService Härtungs-Flags vervollständigen. | `repo_v5/modules/core/lib-helpers.nix` | hoch | erledigt | ProtectKernelLogs, ProtectKernelModules etc. bereits vorhanden. |
| TODO-006 | HARDENING_OPTIMIZATIONS_AUDIT | API Rate-Limiting via Caddy & Fail2ban (L7). | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |
| TODO-007 | HARDENING_OPTIMIZATIONS_AUDIT | Auto-Block von Honeypot-Hits via Fail2ban/nftables. | `repo_v5/modules/services/caddy.nix`, `firewall.nix` | mittel | offen | |
| TODO-016 | TECHNICAL_DEBT [C-03] | Physischen USB-Key mit Age-Fallback erstellen und in `secrets.nix` final einbinden. | `secrets.nix` | hoch | offen | |
| TODO-019 | TECHNICAL_DEBT [M-08] | Implementierung eines PoW-Verfahrens (z.B. Hashcash) in der Challenge-Seite. | `repo_v5/modules/services/caddy.nix` | mittel | offen | |
| TODO-020 | TECHNICAL_DEBT [M-09] | Token-basierte Whitelist für bekannte API-Clients in Caddy. | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |
| TODO-021 | TECHNICAL_DEBT [M-10] | WebDAV für Obsidian via Caddy (SSO-protected) nachrüsten. | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |

---

### Determinate Systems Tools (für NixHome)

Diese Dokumentation fasst die relevanten Tools von Determinate Systems zusammen, die in der NixHome CI oder optional genutzt werden können.

## Nix Installer (GitHub Actions)
Wir verwenden `determinate-systems/nix-installer-action` in unserer CI (`.github/workflows/validate.yml`), um Nix auf dem GitHub-Runner zu installieren.  
Die manuelle Installation auf dem Host ist nicht nötig – NixOS wird separat gemanagt.

## Magic Nix Cache (optional)
Kann die CI beschleunigen, indem es Build-Artefakte zwischen verschiedenen Runs teilt.  
**Aktivierung:** Füge nach dem Nix-Installer folgende Zeile hinzu:
```yaml
- uses: DeterminateSystems/magic-nix-cache-action@main
```
Aktuell ist der Cache nicht aktiviert, könnte aber bei langsamen Workflows helfen.

## flake-checker (optional)
Prüft die `flake.lock` auf bekannte Sicherheitslücken (CVEs) und veraltete Inputs.  
Kann manuell ausgeführt werden:
```bash
nix run github:DeterminateSystems/flake-checker
```
Oder als systemd-Timer auf dem Host (nicht aktiv).

## Nicht verwendete Enterprise-Features
- **FlakeHub** (wir beziehen `nixpkgs` direkt von GitHub)
- **Private Flakes / Secure Packages** (nicht benötigt)
- **SBOMs / Nixd** (Overkill für Homelab)

---

### 🛠️ Sovereign Git Mastery (Layer 30-automation)

---
title: 🛠️ Sovereign Git Mastery (Layer 30-automation)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [self-hosted-git, ssh-only-forge, automated-dumps, code-sovereignty]
sources: [nixpkgs/pkgs/applications/version-management, forgejo docs, soft-serve]
---

# 🛠️ Code-Souveränität: Deine private Git-Infrastruktur

In mynixos sind wir nicht auf externe Plattformen angewiesen. Wir hosten unsere kritischen Repositories (Flakes, Secrets, ADRs) selbst.

## 🏛️ 1. Die SSoT-Wahl: Forgejo (The Full Forge)
Wir nutzen Forgejo als hocheffizienten GitHub-Ersatz.
- **Dienst:** `services.forgejo.enable = true;`
- **Nugget:** Wir nutzen `services.forgejo.database.type = "sqlite3"` für minimalen RAM-Verbrauch (Layer 20).
- **Backup:** `services.forgejo.dump.enable = true` schiebt tägliche Git-Snapshots auf Tier A (NVMe). ✅

## 💎 2. Der SRE-Weg: Soft-serve (SSH Only)
Für Puristen und extrem schnelle Workflows.
- **Konzept:** Ein Git-Server ohne HTTP-Overhead. Alles läuft über SSH.
- **Anwendung:** Ideal für die Synchronisation deiner `mynixos-knowledge-base` zwischen Server und Laptop.

## 🛡️ 3. Repo-Hygiene (Git-Filter-Repo)
Unser Werkzeug für den Ernstfall (SRE Tor 6).
- **Tool:** `pkgs.git-filter-repo`.
- **Anwendung:** Chirurgische Entfernung von sensiblen Daten aus der gesamten Git-Historie, falls Sops-Secrets versehentlich im Klartext committed wurden.

## 🚀 SRE-Vorteil
Eigene Git-Server folgen dem **Headless-Gesetz (ADR-010)** und dem **Efficiency-Mandat**. Sie geben dir die volle Kontrolle über deine geistige Arbeit.


---
### Inhalt aus SSO-TODO.md
# Zentrale To-Do-Liste â€“ alle offenen Aufgaben

Diese Datei ist die Single Source of Truth (SSoT) fÃ¼r alle Aufgaben, Verbesserungen und HÃ¤rtungen im Distiller-Projekt (NixHome v6.0).

| ID | Quelle | Beschreibung | Betroffene Dateien | PrioritÃ¤t | Status | Notizen |
|----|--------|--------------|--------------------|-----------|--------|---------|
| TODO-001 | AUDIT_MASTER_TRACKER, CURRENT_STATUS | Implementiere WAL/SHM Exclusions im Storage Mover Script. | `repo_v5/modules/storage/storage-mover.nix` | hoch | erledigt | |
| TODO-002 | AUDIT_MASTER_TRACKER | Lokale ntfy-Instanz statt ntfy.sh implementieren. | `repo_v5/modules/monitoring/gatus.nix` | mittel | offen | |
| TODO-003 | HARDENING_OPTIMIZATIONS_AUDIT | **KRITISCH:** Systemd-HÃ¤rtung fÃ¼r Blocky DNS implementieren. | `repo_v5/modules/services/blocky.nix` | hoch | erledigt | |
| TODO-004 | HARDENING_OPTIMIZATIONS_AUDIT | ErgÃ¤nzung fehlender HÃ¤rtungs-Flags fÃ¼r Pocket-ID. | `repo_v5/modules/services/pocket-id.nix` | hoch | erledigt | |
| TODO-005 | HARDENING_OPTIMIZATIONS_AUDIT | Globale mkService HÃ¤rtungs-Flags vervollstÃ¤ndigen. | `repo_v5/modules/core/lib-helpers.nix` | hoch | erledigt | ProtectKernelLogs, ProtectKernelModules etc. bereits vorhanden. |
| TODO-006 | HARDENING_OPTIMIZATIONS_AUDIT | API Rate-Limiting via Caddy & Fail2ban (L7). | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |
| TODO-007 | HARDENING_OPTIMIZATIONS_AUDIT | Auto-Block von Honeypot-Hits via Fail2ban/nftables. | `repo_v5/modules/services/caddy.nix`, `firewall.nix` | mittel | offen | |
| TODO-008 | HARDENING_OPTIMIZATIONS_AUDIT | TPM PCR Measurements (Hardware Integrity) in Boot-Watchdog. | `repo_v5/modules/services/boot-watchdog.nix` | mittel | offen | |
| TODO-009 | MAINTAINABILITY_UX_AUDIT | SFTPGo als Multi-Protokoll Gateway (WebDAV/SFTP). | â€” | niedrig | abgelehnt | Laut `forbidden-tech.nix` und ADR explizit abgelehnt (KISS). |
| TODO-010 | MAINTAINABILITY_UX_AUDIT | Host-Metriken (Disk, CPU, Mem) in Vector integrieren. | `repo_v5/modules/services/vector.nix` | hoch | offen | |
| TODO-011 | MAINTAINABILITY_UX_AUDIT | RFC1918 Hardcoded IP Detector (Assertion). | `repo_v5/modules/security/security-assertions.nix` | mittel | offen | |
| TODO-012 | MAINTAINABILITY_UX_AUDIT | Warnung fÃ¼r `mkForce` Missbrauch in App-Modulen. | `repo_v5/modules/security/security-assertions.nix` | mittel | offen | |
| TODO-013 | MAINTAINABILITY_UX_AUDIT, GROK_AUDIT | Legacy Tech Cleanup (Entferne Tailscale/ZFS Reste). | `repo_v5/modules/core/lib-helpers.nix`, `BACKEND.md` | mittel | offen | Reste wie `tailscaleOnly` in Factory noch vorhanden. |
| TODO-014 | MAINTAINABILITY_UX_AUDIT | Batch Update aller NMS-BlÃ¶cke auf v4.2 Schema. | diverse in `repo_v5/` | mittel | teilweise | |
| TODO-015 | AUDIT_MASTER_TRACKER | IPv6 Parity in nftables (ssh_meter_v6, ICMPv6 ND). | `repo_v5/modules/security/firewall.nix` | mittel | erledigt | Bereits in `firewall.nix` vorhanden. |
| TODO-016 | TECHNICAL_DEBT [C-03] | Physischen USB-Key mit Age-Fallback erstellen und in `secrets.nix` final einbinden. | `secrets.nix` | hoch | offen | |
| TODO-017 | TECHNICAL_DEBT [H-09] | Integration von `geoip-shell` oder einem systemd-timer fÃ¼r nftables Geoblock. | `repo_v5/modules/security/firewall.nix` | mittel | offen | |
| TODO-018 | TECHNICAL_DEBT [H-07] | Kontinuierliche Spiegelung aller IPv4 nftables Sets nach IPv6. | `repo_v5/modules/security/firewall.nix` | mittel | offen | |
| TODO-019 | TECHNICAL_DEBT [M-08] | Implementierung eines PoW-Verfahrens (z.B. Hashcash) in der Challenge-Seite. | `repo_v5/modules/services/caddy.nix` | mittel | offen | |
| TODO-020 | TECHNICAL_DEBT [M-09] | Token-basierte Whitelist fÃ¼r bekannte API-Clients in Caddy. | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |
| TODO-021 | TECHNICAL_DEBT [M-10] | WebDAV fÃ¼r Obsidian via Caddy (SSO-protected) nachrÃ¼sten. | `repo_v5/modules/services/caddy.nix` | niedrig | offen | |

