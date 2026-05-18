# Cluster 20: Networking Basics

### Inhalt aus `GUIDE-Blocky-Performance-DNS.md`

---
title: ⚡ Blocky Performance DNS (Layer 20-server)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [ultra-fast-dns, doh-dot-support, prometheus-metrics, declarative-filter]
sources: [https://github.com/0xERR0R/blocky, official nixpkgs modules]
---

# ⚡ Blocky: Der hocheffiziente DNS-Proxy

In mynixos ist Blocky die performante Alternative zu AdGuardHome. Er ist ideal für SREs, die maximale Geschwindigkeit und minimale Ressourcenbindung suchen.

## 🏛️ Architektur-Entscheidungen (Efficiency Standard)
1.  **Sprache:** Go (Binary-Mandat erfüllt). ✅
2.  **Stateless:** Keine Datenbank nötig. Alle Statistiken werden via Prometheus exportiert.
3.  **Config-First:** Keine Web-UI. Die gesamte Steuerung erfolgt über die Nix-Datei.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/20-server/dns-performance.nix`):

```nix
services.blocky = {
  enable = true;
  settings = {
    ports.dns = 53;
    upstream = {
      default = [
        "https://one.one.one.one/dns-query"
        "8.8.8.8"
      ];
    };
    blocking = {
      blackLists = {
        ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
      };
      clientGroupsBlock = {
        default = [ "ads" ];
      };
    };
    prometheus = {
      enable = true;
      path = "/metrics";
    };
  };
};
```

## 🛡️ SRE-Hardening
- **API-Sicherheit:** Die REST-Schnittstelle ist nur lokal (127.0.0.1) erreichbar.
- **DoH/DoT:** Wir erzwingen verschlüsseltes DNS zu den Upstream-Providern.

---

### Inhalt aus `GUIDE-DNS-Shield-AdGuardHome.md`

---
title: 🛡️ AdGuardHome DNS Shield (Layer 20-server)
category: architecture/services
status: [ACTIVE-SSoT]
capabilities: [ad-blocking, dns-over-tls, dhcp-server, network-security]
sources: [https://github.com/AdguardTeam/AdGuardHome, official nixpkgs modules]
---

# 🛡️ AdGuardHome: Dein DNS-Schutzschild

In mynixos ist AdGuardHome der zentrale DNS-Resolver. Er schützt alle Geräte in deinem Netzwerk vor Werbung und Tracking.

## 🏛️ Architektur-Entscheidungen (SRE Standard)
1.  **Sprache:** Go (Binary-Mandat erfüllt). ✅
2.  **Deployment:** Läuft als nativer systemd-Dienst.
3.  **Persistence:** Alle Filterdaten liegen in `/persist/var/lib/adguardhome`.

## ⚙️ Deklarative Nix-Konfiguration
Hier ist das Muster für deinen Dendriten (`modules/20-server/dns.nix`):

```nix
services.adguardhome = {
  enable = true;
  mutableSettings = true; # Erlaubt UI-Änderungen für Filter-Listen
  settings = {
    dns = {
      upstream_dns = [
        "https://dns.cloudflare.com/dns-query"
        "https://dns.google/dns-query"
      ];
    };
    filtering = {
      safe_search.enabled = true;
    };
  };
};
```

## 🛡️ SRE-Hardening
- **Port-Isolation:** Der DNS-Dienst (Port 53) ist nur im LAN und Tailnet erreichbar.
- **Ingress:** Das Web-Dashboard wird via Caddy über `dns.m7c5.de` mit mTLS abgesichert.

---

### Inhalt aus `GUIDE-Networking-Performance-SRE.md`

---
title: 📡 Networking Ops & Performance (Layer 00-core)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [network-performance, path-analysis, spa-security, vpn-routing]
sources: [nixpkgs/pkgs/tools/networking, fwknop docs, mtr guide]
---

# 📡 Networking Ops: Deine Werkzeuge für den "God Mode"

In mynixos sind Netzwerk-Probleme keine Glückssache, sondern messbare Daten. Wir nutzen chirurgische Werkzeuge für die Analyse und Sicherheit.

## 💎 1. SPA Security (fwknop)
Der Tower bleibt "Dunkel" für Port-Scanner.
- **Konzept:** Single Packet Authorization (Kapitel 20).
- **Vorteil:** SSH ist von außen unsichtbar, bis ein signiertes Paket den Port öffnet.

## ⚡ 2. Bandbreiten-Audit (iperf3)
Wir betreiben den Tower als permanenten iperf3-Server.
- **Dienst:** `services.iperf3.enable = true;`
- **Anwendung:** `iperf3 -c tower.m7c5.de` von jedem Client im Haus.
- **SRE-Nutzen:** Sofortige Erkennung von fehlerhaften Kabeln oder überlasteten Switches. ✅

## 📊 3. Path Analysis (mtr)
Der Standard für die Fehleranalyse bei Streaming-Problemen.
- **Tool:** `pkgs.mtr`.
- **Vorteil:** Zeigt Latenz und Paketverlust an jedem Hop in Echtzeit.

## 🔄 4. VPN-Routing (vpn-slice)
Für selektives Routing in Layer 10-gateway.
- **Tool:** `pkgs.vpn-slice`.
- **Anwendung:** Trennung von privatem (lokalem) und öffentlichem (VPN) Traffic pro Dienst.

---

### Inhalt aus `GUIDE-Stable-Network-Interface-MAC.md`

---
title: 📡 Stable Network Interface Names (MAC Binding)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [network-stability, hardware-binding, predictable-interface-names]
sources: [r/NixOS, systemd.link Documentation]
---

# 📡 Netzwerk-Stabilität: MAC-basierte Namen

In mynixos akzeptieren wir keine zufälligen Schnittstellennamen. Wir binden den Namen der Netzwerkschnittstelle fest an die physische MAC-Adresse der Intel-Hardware.

## 🏛️ 1. Das Problem
Standardmäßig nutzt NixOS/systemd "Predictable Interface Names" (z.B. enp2s0). Diese können sich jedoch bei BIOS-Updates oder Kernel-Wechseln ändern, was deine Firewall-Regeln (Kapitel 56) unbrauchbar macht.

## ⚙️ 2. Die Aviation-Grade Lösung (systemd.link)
Wir erzwingen den Namen `primary0` für die Haupt-NIC des Towers.

Hier ist das Muster für deinen Dendriten (`modules/00-core/network-harden.nix`):

```nix
systemd.network.links."10-primary0" = {
  matchConfig.MACAddress = "xx:xx:xx:xx:xx:xx"; # Deine Fuji Q958 MAC
  linkConfig.Name = "primary0";
};
```

## 🛡️ 3. SRE-Vorteil
- **Vorhersehbarkeit:** Deine Firewall und dein Caddy-Bypass (v8.5) beziehen sich immer auf `primary0`. ✅
- **Resilienz:** Selbst ein komplettes Hardware-Upgrade des Mainboards erfordert nur die Änderung einer einzigen Zeile im Code.

## 🚀 SRE-Anwendung
Der Name `primary0` wird systemweit als Standard für alle Netzwerk-Policies verwendet.

---
