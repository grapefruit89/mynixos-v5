---
title: 10-ingress-caddy
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-19
adr: [ADR-010, ADR-011]
test: tests/basic.nix
nix_modules:
  - path: modules/services/caddy.nix
    anchor: caddy-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix
  - path: modules/core/ssh.nix
    anchor: ssh-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/ssh.nix
---

# Cluster 10: Ingress & Caddy

Dieses Dokument bündelt alle Architektur- und Operations-Standards für den Ingress-Layer (Caddy). Die Authentifizierung wurde in den dedizierten **[Guide 50 (Identity & Authentication)](./50-identity-authentication.md)** ausgelagert.

---

## 🌐 Caddy: Das Gehirn deines Netzwerks

In mynixos verschmelzen wir die deklarative Power von Nix mit der dynamischen Agilität der Caddy-API.

### 🛡️ 1. Ingress Hardening (anchor: caddy-hardening)
Die Konfiguration erfolgt modular in `modules/services/caddy.nix`.

### 🛠️ Konfiguration
```nix
my.services.caddy.enable = true;
```

- **Admin-API**: Beschränkt auf den Unix-Socket `/run/caddy/admin.sock`.
- **Security Headers**: HSTS, CSP und Stealth-Header (Server-Header entfernen).

### ⚡ 2. Zero-Downtime Updates (Graceful Reload)
Wir nutzen die nativen Caddy-Reload-Signale (`systemctl reload caddy`), um aktive Streams (Jellyfin/Navidrome) bei Konfigurations-Updates zu schützen.

---

## 🔒 Remote Administration Prozedur (anchor: ssh-hardening)

Administrative Dienste (Admin-Hangar Zone) sind auf das lokale Netzwerk beschränkt. Remote-Zugriff erfolgt über einen verschlüsselten SSH-SOCKS5-Proxy.

### 🛠️ Konfiguration
```nix
services.openssh.enable = true;
```

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
# Positiv-Test: API muss JSON liefern
curl -f --unix-socket /run/caddy/admin.sock http://localhost/config/ | jq . | grep "admin"

# 2. Prüfe Caddy Service Status
systemctl status caddy --no-pager
# Negativ-Test: Caddy darf NICHT als Root laufen (UID-Registry prüfen)
! ps aux | grep "caddy" | grep "^root"

# 3. Prüfe Pocket-ID Status
systemctl status pocket-id --no-pager

# 4. Prüfe Port-Belegung (Caddy auf 80/443, SSH auf 53844)
ss -tulpn | grep -E "80|443|53844"
# Negativ-Test: Port 22 darf NICHT offen sein
! ss -tulpn | grep ":22 "
```

---

## 🔗 Quellen & Verweise

### Externe Repositories (NixOS-Native)
- [caddyserver/caddy](https://github.com/caddyserver/caddy) - Der Ingress Gateway Core
- [pocket-id/pocket-id](https://github.com/pocket-id/pocket-id) - Identity Provider

### Context7 Observability
<!-- context7: nixpkgs/nixos/modules/services/web-servers/caddy/default.nix -->
<!-- context7: nixpkgs/nixos/modules/services/networking/ssh/default.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/caddy.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/pocket-id.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/ssh.nix -->

### Nix MCP Index
<!-- mcp: nixos:repo_v5/modules/services/caddy.nix -->
<!-- mcp: nixos:repo_v5/modules/services/pocket-id.nix -->
<!-- mcp: nixos:repo_v5/modules/core/ssh.nix -->

---
*Status: Production Hardened | Letzte Aktualisierung: 19. Mai 2026*
