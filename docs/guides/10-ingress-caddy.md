# Cluster 10: Ingress & Caddy

### Inhalt aus `GUIDE-Caddy-Gateway-Mastery.md`

---
title: 🌐 Caddy Gateway Mastery (The Pro-Layer)
category: architecture/gateway
status: [ACTIVE-SSoT]
capabilities: [json-api-control, graceful-reloads, on-demand-tls, metrics-exporter]
sources: [Caddy Official Docs, Caddy GitHub, NixOS Module Audit]
---

# 🌐 Caddy: Das Gehirn deines Netzwerks

In mynixos verschmelzen wir die deklarative Power von Nix mit der dynamischen Agilität der Caddy-API.

## ⚡ 1. Zero-Downtime Updates (Graceful Reload)
Wir nutzen die nativen Caddy-Reload-Signale, um deine aktiven Streams (Jellyfin/Navidrome) bei Konfigurations-Updates zu schützen.
- **SRE-Vorteil:** Die Konfiguration wird atomar im Speicher getauscht. Kein Abbruch von HTTP-Sessions. ✅

## 💎 2. Die Admin-API (Monitoring & Control)
Caddy bietet eine mächtige REST-API auf Port 2019. Wir nutzen dies für Echtzeit-Einsichten.
- **Pattern:** Integration in Prometheus/Grafana für Layer 80 Monitoring.
- **SRE-Kontrolle:** Wir können Routen im Notfall über die API deaktivieren, ohne einen kompletten System-Rebuild abzuwarten.

## 🛡️ 3. On-Demand TLS (Dynamic SSL)
Caddy kann Zertifikate beim ersten Zugriff automatisch generieren.
- **Dienst:** `on_demand_tls { ... }` in den Global Options.
- **Vorteil:** Maximale Flexibilität für temporäre Test-Domains innerhalb deines m7c5.de Netzwerks. ✅

## 🏛️ 4. Native JSON-Injektion
Wo das Caddyfile an seine Grenzen stößt, injizieren wir direkt das hochperformante Caddy-JSON.
- **Anwendung:** Komplexe Filter für Layer 90-policy (z.B. Geo-Blocking oder mTLS-Verschachtelungen).

---

### Inhalt aus `GUIDE-Caddy-Operations-Master.md`

---
title: 🛡️ Caddy Operations Master-Config (Layer 20-server)
category: architecture/ingress
status: [ACTIVE-SSoT]
capabilities: [ingress-automation, zero-downtime, api-control, caddyfile-mastery]
sources: [https://caddyserver.com/docs/]
---

# 🛡️ Caddy Operations: Der mynixos Standard

Caddy ist das Herzstück deines Ingress-Layers. Wir nutzen die offizielle Philosophie für maximale Zuverlässigkeit.

## 🛠️ Der SRE-Workflow (CLI)
Wir nutzen diese Befehle zur Wartung:
1.  **Validierung:** `caddy validate --config /etc/caddy/Caddyfile` (Prüft Syntaxfehler).
2.  **Formatierung:** `caddy fmt --overwrite /etc/caddy/Caddyfile` (Garantierte Purity).
3.  **Trust:** `caddy trust` (Ermöglicht vertrauenswürdige interne HTTPS-Verbindungen).

## 📡 API-Interaktion
Für Live-Status-Abfragen nutzen wir den internen API-Endpunkt:
- **Status:** `curl localhost:2019/config/`
- **Reload:** `curl -X POST "http://localhost:2019/load" -H "Content-Type: application/json" -d @config.json`

## 🧩 Caddyfile Architektur (Dendritic Style)
Wir nutzen **Snippets**, um Redundanz zu vermeiden:
```caddy
(pocket_id_auth) {
    forward_auth localhost:8080 {
        uri /api/oidc/auth
    }
}

# Anwendung im Dendriten
jellyfin.m7c5.de {
    import pocket_id_auth
    reverse_proxy localhost:8096
}
```

## 🛡️ SRE-Hardening
- **Zero-Downtime:** Der `reload` Mechanismus von Caddy ist der Standard für alle mynixos-Updates.
- **Auto-HTTPS:** Wir verlassen uns auf die CertMagic-Engine (Kapitel 8).

---

### Inhalt aus `GUIDE-Caddy-M1-Abrams.md`

---
title: 🛡️ Caddy M1 Abrams (Ingress Standard)
category: architecture/guides
status: [ACTIVE-SSoT]
sources: [adr/nixhome-architecture.md, modules/services/caddy.nix]
---

# 🛡️ Caddy M1 Abrams: Der Ingress-Standard

Wir nutzen Caddy als gehärteten Reverse-Proxy. Im Gegensatz zu Legacy-Ansätzen (Traefik) setzen wir auf native NixOS-Integration und Sops-Secrets.

## Kern-Konfiguration
- **DNS-01 Challenge:** Automatisierte Zertifikate via Cloudflare.
- **Forward-Auth:** Anbindung an PocketID (OIDC).
- **Hardening:** Strikte Systemd-Isolation.

Siehe: [adr/nixhome-architecture.md](../adr/nixhome-architecture.md)

---

### Inhalt aus `GUIDE-Caddy-Mastery.md`

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

---

### Remote Administration Prozedur

To maintain a zero-trust architecture, administrative services (Admin-Hangar zone) are restricted to the local network and the loopback interface. Remote access is achieved via a temporary, encrypted SSH tunnel using SOCKS5 dynamic port forwarding.

## 🚀 Initiation (Admin Workstation)

Run the following command to establish the tunnel. This requires your **YubiKey** for authentication.

```bash
# Command Format
ssh -D 9999 -N -i <path-to-your-sk-key> moritz@nix.m7c5.de -p 53844

# Breakdown:
# -D 9999: Creates a local SOCKS5 proxy on port 9999.
# -N: Do not execute a remote command (port forwarding only).
# -p 53844: The hardened high-port for SSH.
```

## 🌐 Browser Configuration

To access services through the tunnel, configure your browser to use the SOCKS5 proxy:

1. **Firefox (Recommended):**
   - Settings -> Network Settings -> Settings...
   - Select **Manual proxy configuration**.
   - **SOCKS Host:** `127.0.0.1` | **Port:** `9999`
   - Ensure **SOCKS v5** is selected.
   - Check **Proxy DNS when using SOCKS v5** (Critical for `*.nix.m7c5.de` resolution).

2. **Access:**
   - Navigate to any Admin service (e.g., `https://admin.nix.m7c5.de` for Cockpit).
   - The browser will route traffic through the server, appearing as a LAN request.

## 🛑 Termination

Simply close the SSH session (Ctrl+C). The proxy will be destroyed, and remote access to the Admin-Hangar is immediately revoked.


---
### Inhalt aus MASTER-CONFIG-HOMEPAGE.md
---
title: ðŸ“š Homepage MASTER-VARIABLE-LIST (v1.0)
category: architecture/reference
status: [ACTIVE-SSoT]
sources: [https://github.com/gethomepage/homepage]
---

# ðŸ“š Homepage Dashboard: Konfigurations-Referenz

HOMEPAGE_ALLOWED_HOSTS
HOMEPAGE_BUILDTIME
HOMEPAGE_CONFIG_DIR
HOMEPAGE_FILE_
HOMEPAGE_FILE_SECRET
HOMEPAGE_FILE_XXX
HOMEPAGE_PROXY_DISABLE_IPV6
HOMEPAGE_VAR_
HOMEPAGE_VAR_FOO
HOMEPAGE_VAR_TITLE
HOMEPAGE_VAR_XXX

## ðŸš€ SRE-Anwendung
In NixOS nutzen wir \`services.homepage-dashboard\`.

---
### Inhalt aus remote-admin-procedure.md
# ðŸ” Remote Admin SOP: SSH SOCKS5 Proxy

To maintain a zero-trust architecture, administrative services (Admin-Hangar zone) are restricted to the local network and the loopback interface. Remote access is achieved via a temporary, encrypted SSH tunnel using SOCKS5 dynamic port forwarding.

## ðŸš€ Initiation (Admin Workstation)

Run the following command to establish the tunnel. This requires your **YubiKey** for authentication.

```bash
# Command Format
ssh -D 9999 -N -i <path-to-your-sk-key> moritz@nix.m7c5.de -p 53844

# Breakdown:
# -D 9999: Creates a local SOCKS5 proxy on port 9999.
# -N: Do not execute a remote command (port forwarding only).
# -p 53844: The hardened high-port for SSH.
```

## ðŸŒ Browser Configuration

To access services through the tunnel, configure your browser to use the SOCKS5 proxy:

1. **Firefox (Recommended):**
   - Settings -> Network Settings -> Settings...
   - Select **Manual proxy configuration**.
   - **SOCKS Host:** `127.0.0.1` | **Port:** `9999`
   - Ensure **SOCKS v5** is selected.
   - Check **Proxy DNS when using SOCKS v5** (Critical for `*.nix.m7c5.de` resolution).

2. **Access:**
   - Navigate to any Admin service (e.g., `https://admin.nix.m7c5.de` for Cockpit).
   - The browser will route traffic through the server, appearing as a LAN request.

## ðŸ›‘ Termination

Simply close the SSH session (Ctrl+C). The proxy will be destroyed, and remote access to the Admin-Hangar is immediately revoked.

