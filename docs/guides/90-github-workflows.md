# 🚀 Guide 90: GitHub Workflows & Sovereign Git

---
title: 🚀 GitHub Workflows & Sovereign Git
category: architecture/automation
status: [ACTIVE-SSoT]
capabilities: [ci-cd, forgejo, cloud-ide, supply-chain-security]
sources: [GitHub Actions Docs, Forgejo Documentation, NixOS CI Patterns]
last_reviewed: 2026-05-19
adr: [ADR-003, ADR-014]
test: tests/basic.nix
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

### 🛠️ Konfiguration
```nix
my.services.forgejo.enable = true;
```

- **Leichtgewicht:** Nutzt SQLite3 statt Postgres für minimalen Ressourcenverbrauch.
- **Hardened:** Integration in das `mkService` Framework mit strikter Systemd-Sandboxing.
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

## ✅ Verifizierung

```bash
# 1. Prüfe Forgejo Status
systemctl status forgejo --no-pager
# Positiv-Test: Web-UI erreichbar (Local)
curl -f -s http://127.0.0.1:20003 | grep "Forgejo"

# 2. Prüfe Backup-Aktivität
ls -l /var/lib/forgejo/dump/

# 3. Teste CI-Konformität (Lokal)
./scripts/ci/audit-code-quality.sh
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [forgejo/forgejo](https://github.com/forgejo/forgejo) - Sovereign Git
- [DeterminateSystems/magic-nix-cache](https://github.com/DeterminateSystems/magic-nix-cache)

### Context7 Observability
<!-- context7: nixpkgs/nixos/modules/services/misc/forgejo.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/forgejo.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/modules/services/forgejo.nix -->

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
