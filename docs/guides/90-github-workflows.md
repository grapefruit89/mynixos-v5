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
