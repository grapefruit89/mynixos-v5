---
title: 10-ingress-caddy
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
nix_modules:
  - path: modules/services/caddy.nix
    anchor: caddy-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix
  - path: modules/services/caddy.nix
    anchor: family-auth
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix
  - path: modules/services/pocket-id.nix
    anchor: pocket-id-sso
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/pocket-id.nix
  - path: modules/core/ssh.nix
    anchor: ssh-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/ssh.nix
---

# Cluster 10: Ingress & Caddy

Dieses Dokument bündelt alle Architektur- und Operations-Standards für den Ingress-Layer (Caddy) und das Identity-Management (Pocket-ID). Es dient als "Knowledge Cell" für den sicheren Zugriff auf den Fujitsu Q958 Tower.

---

## 🌐 Caddy: Das Gehirn deines Netzwerks

In mynixos verschmelzen wir die deklarative Power von Nix mit der dynamischen Agilität der Caddy-API.

### 🛡️ 1. Ingress Hardening (anchor: caddy-hardening)
Die Konfiguration erfolgt modular in `modules/services/caddy.nix`.
- **Admin-API**: Beschränkt auf den Unix-Socket `/run/caddy/admin.sock`.
- **Security Headers**: HSTS, CSP und Stealth-Header (Server-Header entfernen).

### ⚡ 2. Zero-Downtime Updates (Graceful Reload)
Wir nutzen die nativen Caddy-Reload-Signale (`systemctl reload caddy`), um aktive Streams (Jellyfin/Navidrome) bei Konfigurations-Updates zu schützen.

### 🛡️ 3. Forward-Auth (anchor: family-auth)
Wir nutzen `forward_auth` (anchor: forward-auth), um den Zugriff auf interne Dienste über **Pocket-ID** abzusichern.

---

## 🆔 Pocket-ID (OIDC Provider) (anchor: pocket-id-sso)

Self-hosted OIDC Identity Provider für sicheres SSO. Die Konfiguration erfolgt in `modules/services/pocket-id.nix`.

- **Issuer**: `https://auth.${subdomain}.${domain}`
- **Integration**: Caddy nutzt das `(family_auth)` Snippet für die Verifizierung.

---

## 🔒 Remote Administration Prozedur (anchor: ssh-hardening)

Administrative Dienste (Admin-Hangar Zone) sind auf das lokale Netzwerk beschränkt. Remote-Zugriff erfolgt über einen verschlüsselten SSH-SOCKS5-Proxy.

### 🚀 Initiation
```bash
ssh -D 9999 -N -i <key> moritz@nix.m7c5.de -p 53844
```

### 🌐 Browser-Konfiguration
Nutze den SOCKS5-Proxy `127.0.0.1:9999` und aktiviere "Proxy DNS when using SOCKS v5".

---

## ✅ Verifizierung

```bash
# 1. Prüfe Caddy Admin API (Unix-Socket)
curl --unix-socket /run/caddy/admin.sock http://localhost/config/ | jq

# 2. Prüfe Caddy Service Status
systemctl status caddy

# 3. Prüfe Pocket-ID Status
systemctl status pocket-id

# 4. Prüfe Port-Belegung (Caddy auf 80/443, SSH auf 53844)
ss -tulpn | grep -E "80|443|53844"
```

---

## 🔗 Quellen & Verweise

### Externe Repositories (NixOS-Native)
- [caddyserver/caddy](https://github.com/caddyserver/caddy) - Der Ingress Gateway Core
- [pocket-id/pocket-id](https://github.com/pocket-id/pocket-id) - Identity Provider
- [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs) - NixOS Module & Pakete

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/pocket-id.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/ssh.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/services/caddy.nix -->
<!-- mcp: repo_v5/modules/services/pocket-id.nix -->
<!-- mcp: repo_v5/modules/core/ssh.nix -->
