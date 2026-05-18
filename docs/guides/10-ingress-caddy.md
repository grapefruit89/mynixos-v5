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
