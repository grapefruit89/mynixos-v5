---
title: "Identity & Authentication"
domain: 50
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
related:
  adr: docs/adr/ADR-003-Ejected-Services.md
nix_modules:
  - path: modules/services/pocket-id.nix
    anchor: pocket-id-sso
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/pocket-id.nix
  - path: modules/services/pocket-id.nix
    anchor: passkey-support
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/pocket-id.nix
  - path: modules/services/caddy.nix
    anchor: family-auth
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix
  - path: modules/services/caddy.nix
    anchor: forward-auth
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix
---

# Cluster 50: Identity & Authentication

Dieses Dokument beschreibt die souveräne Identitäts-Architektur von mynixos. Wir nutzen ein zentrales SSO-System (Single Sign-On) basierend auf Pocket-ID, um den Zugriff auf alle Dienste abzusichern.

---

## 🆔 Pocket-ID: Der OIDC Provider (anchor: pocket-id-sso)

Pocket-ID ist unser zentraler Identity Provider (IdP). Er ist hocheffizient, in Go geschrieben und unterstützt moderne Authentifizierungs-Standards.

- **Konfiguration**: `modules/services/pocket-id.nix`.
- **Datenhaltung**: Der State liegt persistent auf Tier A (`/persist/var/lib/pocket-id`).
- **Passkey-Unterstützung** (anchor: passkey-support): Pocket-ID erlaubt die passwortlose Authentifizierung via WebAuthn/Passkeys (z.B. YubiKey, TouchID).

---

## 🛡️ Forward-Auth Integration (anchor: forward-auth)

Um Dienste ohne nativen OIDC-Support (z.B. Gatus, Scrutiny) abzusichern, nutzen wir Caddy als Gatekeeper.

### 🏛️ Der Workflow
1.  Ein User ruft eine geschützte Domain auf (z.B. `stats.m7c5.de`).
2.  Caddy nutzt das `(family_auth)` Snippet (anchor: family-auth) und sendet eine Anfrage an Pocket-ID.
3.  Pocket-ID prüft das Session-Cookie oder leitet zum Login weiter.
4.  Erst bei Erfolg wird der Traffic an den Backend-Dienst weitergeleitet.

### ⚙️ Implementierung in Caddy
```nix
(family_auth) {
  forward_auth @needs_auth 127.0.0.1:8089 {
    uri /api/auth/verify
    copy_headers Remote-User Remote-Email Remote-Name
  }
}
```

---

## 🔑 MFA & Sicherheit

In mynixos folgen wir dem **Zero-Trust-Prinzip**:
- **Passwort-Policy**: Starke Passwörter werden via Argon2 gehasht.
- **MFA (Multi-Faktor-Authentifizierung)**: Die Nutzung von WebAuthn/Passkeys wird für alle administrativen Accounts empfohlen.
- **Session-Hardening**: Kurze Session-Laufzeiten und strikte Cookie-Attribute (Secure, HttpOnly, SameSite=Lax).

---

## ✅ Verifizierung

```bash
# 1. Prüfe Pocket-ID Service Status
systemctl status pocket-id

# 2. Teste Forward-Auth via Curl (erwartet 401/302 wenn nicht eingeloggt)
curl -I https://stats.m7c5.de

# 3. Prüfe Caddy Logs auf Auth-Entscheidungen
journalctl -u caddy -f | grep "forward_auth"

# 4. Verifiziere OIDC Discovery Endpoint
curl -s https://auth.m7c5.de/.well-known/openid-configuration | jq
```

---

## 🔗 Quellen & Verweise

### Externe Repositories
- [pocket-id/pocket-id](https://github.com/pocket-id/pocket-id) - Identity Provider
- [caddyserver/caddy](https://github.com/caddyserver/caddy) - Forward-Auth Implementierung

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/pocket-id.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/services/pocket-id.nix -->
<!-- mcp: repo_v5/modules/services/caddy.nix -->
