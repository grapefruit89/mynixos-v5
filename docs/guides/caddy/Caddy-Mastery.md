---
title: 🛡️ Caddy Mastery (NixHome v7.1 Strict)
category: architecture/ingress
status: [ACTIVE-SSoT]
capabilities: [reverse-proxy, admin-api, hardened-ingress]
---

# 🛡️ Caddy Mastery: Ingress & Gateway Standard

Diese Dokumentation konsolidiert die Architektur- und Operations-Standards für Caddy im NixHome v7.1 Strict Umfeld.

## 1. Caddyfile Struktur & Snippets
Die Konfiguration erfolgt modular über Snippets in `modules/services/caddy.nix`.

### Admin-Auth (LAN-only)
```caddy
(admin_auth) {
    @admin_hangar {
        remote_ip private_ranges
    }
    handle @admin_hangar {
        import hardened_headers
        import compression
    }
    respond "Forbidden: Admin access restricted to LAN" 403
}
```

### Kern-Direktiven
- **reverse_proxy**: Leitet Traffic an lokale Sockets oder Ports weiter.
- **handle**: Exklusive Logik-Blöcke für präzises Routing.
- **import hardened_headers**: Setzt HSTS, CSP und entfernt den Server-Header.

## 2. Admin API (Unix-Socket)
Aus Sicherheitsgründen (Zero-Trust) ist die Admin-API **nicht** über TCP (Port 2019) erreichbar, sondern über einen Unix-Socket.

- **Socket-Pfad**: `/run/caddy/admin.sock`
- **Abfrage-Beispiel**:
  ```bash
  curl --unix-socket /run/caddy/admin.sock http://localhost/config/
  ```

## 3. Operations & Logging
- **Logging**: Caddy nutzt das Zap-Framework für strukturierte JSON-Logs in `/var/log/caddy/access.log`.
- **Monitoring**: Vector liest diese Logs für Fail2Ban und Metriken aus.
- **Systemd Steuerung**:
    - `systemctl reload caddy`: Lädt das Caddyfile neu ohne aktive Verbindungen zu trennen (bevorzugt).
    - `systemctl restart caddy`: Erforderlich bei Änderungen an der NixOS-Service-Struktur oder Environment-Files.

## 4. Sicherheit (Zero-Trust)
- **Kein Tailscale**: Ingress basiert rein auf Cloudflare/LAN-Zonen.
- **Honeypot**: Automatisches Blocken (444 No Response) bei Zugriffen auf sensible Pfade (`.env`, `.git`).
- **Purity**: Konfiguration wird über NixOS generiert (`services.caddy.virtualHosts`).
