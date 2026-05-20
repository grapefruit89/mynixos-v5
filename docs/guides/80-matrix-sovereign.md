---
title: 80-matrix-sovereign
domain: 80
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-19
adr: [ADR-004, ADR-012, ADR-014]
test: tests/communication.nix
nix_modules:
  - path: modules/apps/service-app-matrix-conduit.nix
    anchor: matrix-conduit
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-matrix-conduit.nix
  - path: modules/apps/service-app-matrix-conduit.nix
    anchor: matrix-federation
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-matrix-conduit.nix
---

# Cluster 80: Matrix & Sovereign Communication

Dieses Dokument beschreibt die souveräne Kommunikations-Architektur von mynixos. Wir nutzen das Matrix-Protokoll als Rückgrat für Chat, System-Alerting und Föderation.

---

## 🦀 Conduit: Matrix Homeserver in Rust (anchor: matrix-conduit)

Conduit ist unser primärer Matrix-Server. Er ist in Rust geschrieben und besticht durch extreme Effizienz und minimale Ressourcen-Anforderungen.

### 🛠️ Konfiguration
```nix
my.services.matrixConduit.enable = true;
```

- **Datenbank**: Nutzt das eingebettete `rocksdb` Backend für maximale Performance bei geringem RAM-Verbrauch.
- **Sicherheit**: Läuft als isolierter Dienst, ist aber von der SSO-Authentifizierung (Pocket-ID) ausgenommen, um Client-Kompatibilität (Element, FluffyChat) zu gewährleisten.

---

## 🌐 Federation & Discovery (anchor: matrix-federation)

Um mit anderen Matrix-Servern weltweit zu kommunizieren, nutzt mynixos die automatische Discovery via Caddy.

- **Well-known Endpoints**: Caddy exponiert automatisch `/.well-known/matrix/server` und `client`, um die Föderation zu ermöglichen.
- **In-Memory Performance**: TLS-Termination erfolgt durch Caddy, Conduit verarbeitet nur den bereinigten Traffic.

---

## 🤖 System Voice: Matrix-Commander

Der Matrix-Server ist die "Stimme" des Fujitsu Q958 Towers. Wir nutzen den `matrix-commander` für automatisiertes Alerting.

- **E2EE Alerting**: Administrative Nachrichten werden Ende-zu-Ende verschlüsselt in private SRE-Räume gesendet.
- **Workflows**:
  - **Backup-Status**: Benachrichtigung nach Restic-Runs.
  - **Security-Alerts**: Sofortige Meldung bei Fail2ban-Sperren oder kritischen Kernel-Audit-Events.

---

## ✅ Verifizierung

```bash
# 1. Prüfe Conduit Service Status
systemctl status conduit --no-pager
# Positiv-Test: API muss 200 liefern
curl -f -s http://127.0.0.1:20048/_matrix/static/ | grep "Conduit"
# Negativ-Test: Keine Bindung auf 0.0.0.0 (Reverse Proxy only)
! ss -tulpn | grep ":20048" | grep "0.0.0.0"

# 2. Teste Client Discovery Endpoint
curl -f -s https://matrix.m7c5.de/.well-known/matrix/client | jq . | grep "m.homeserver"

# 3. Teste Server Federation Endpoint
curl -f -s https://matrix.m7c5.de/.well-known/matrix/server | jq . | grep "m.server"

# 4. Sende eine Test-Nachricht via Matrix-Commander
# matrix-commander --message "TEST: Mynixos Matrix-Voice Initialized"
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [girlbossceo/conduit](https://github.com/girlbossceo/conduit) - Matrix Homeserver
- [matrix-org/matrix-spec](https://github.com/matrix-org/matrix-spec) - Protokoll-Spezifikation

### Context7 Observability
<!-- context7: nixpkgs/nixos/modules/services/matrix/conduit.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/apps/service-app-matrix-conduit.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/modules/apps/service-app-matrix-conduit.nix -->

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
