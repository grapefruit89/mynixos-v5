# 🚀 Guide 90: GitHub Workflows & Sovereign Git

---
title: 🚀 GitHub Workflows & Sovereign Git
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [ci-cd, forgejo, cloud-ide, supply-chain-security]
sources: [GitHub Actions Docs, Forgejo Documentation, NixOS CI Patterns]
last_reviewed: 2026-05-19
---

Dieses Dokument konsolidiert die Strategie für Continuous Integration, Code-Souveränität und Remote-Management im NixHome-Projekt.

## 🏛️ 1. GitHub CI/CD: Der Pre-Flight Check

Wir nutzen GitHub Actions als primäres Qualitäts-Tor für unseren Code.

### 🛡️ Titan-Guard Audit (`.github/workflows/validate.yml`)
Jeder Push triggert eine automatisierte Validierung:
- **Flake Integrity:** `nix flake check --all-systems` prüft Syntax und Abhängigkeiten.
- **Security Scan:** Integration von `DeterminateSystems/nix-installer-action` für eine saubere Nix-Umgebung.
- **Custom Audit:** Ausführung von `scripts/ci/audit-code-quality.sh` zur Einhaltung der Projekt-Konventionen.

### ⚡ Beschleunigung: Magic Nix Cache
Um Build-Zeiten zu reduzieren, wird der `magic-nix-cache` von Determinate Systems genutzt. Dies teilt Build-Artefakte zwischen verschiedenen CI-Runs.

---

## 🛠️ 2. Sovereign Git: Forgejo (Layer 30)

Um die Abhängigkeit von externen Plattformen zu minimieren, hosten wir eine eigene Forgejo-Instanz.

### 💎 Forgejo Konfiguration (`modules/services/forgejo.nix`)
- **Leichtgewicht:** Nutzt SQLite3 statt Postgres für minimalen Ressourcenverbrauch.
- **Hardened:** Integration in das `mkService` Framework (ADR 005) mit strikter Systemd-Sandboxing.
- **SSO:** Erreichbar unter `https://git.m7c5.de/` (hinter Caddy & Pocket-ID).
- **Backup:** `services.forgejo.dump.enable = true` sorgt für tägliche atomare Snapshots des gesamten Git-States.

---

## ☁️ 3. GitHub Codespaces: Das Mobile Command Center

Codespaces dienen als redundante Entwicklungsumgebung für Notfälle.

- **DevContainer:** Vorkonfigurierte Umgebung mit allen SRE-Tools (`sops`, `age`, `git`).
- **Secret Integration:** Zugriff auf verschlüsselte Repository-Secrets zum Entsperren der Flake-Konfiguration in der Cloud.

---

## 🛡️ 4. Supply-Chain Security

- **Secret Scanning:** GitHub verhindert aktiv den Push unverschlüsselter Secrets.
- **Dependabot:** Automatische PRs für Sicherheitsupdates der Flake-Inputs.
- **CodeQL:** Statische Code-Analyse für unsere Custom Scripts.

---

## 📝 Nächste Schritte (Offene Punkte aus SSO-TODO)

| ID | Beschreibung | Status | Notizen |
|----|--------------|--------|---------|
| TODO-013 | Legacy Tech Cleanup (Tailscale/ZFS Reste entfernen). | 🟡 Offen | Betrifft `mkService` Factory. |
| TODO-014 | Batch Update aller NMS-Blöcke auf v4.2 Schema. | 🟡 Offen | Konsistenzprüfung läuft. |
| TODO-016 | Physischen USB-Key (Age) final einbinden. | 🔴 Hoch | Wichtig für Recovery-Workflows. |
| TODO-019 | PoW-Verfahren (Hashcash) in Challenge-Seite. | 🟡 Mittel | Schutz gegen L7-DDoS. |

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
