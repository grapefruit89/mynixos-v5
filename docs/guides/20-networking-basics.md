---
title: "Networking Basics"
domain: 20
category: architecture/consolidated
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
related:
  adr:
    - docs/adr/ADR-008-SSH-ProxyJump-Standard.md
    - docs/adr/ADR-017-Cloudflare-DNS-Only.md
nix_modules:
  - path: modules/core/network.nix
    anchor: network-interfaces
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/network.nix
  - path: modules/core/network.nix
    anchor: dns-hardening
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/network.nix
  - path: modules/core/network.nix
    anchor: tcp-tuning
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/network.nix
  - path: modules/services/blocky.nix
    anchor: blocky-dns
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/blocky.nix
  - path: modules/core/firewall.nix
    anchor: lan-dns-support
    github_url: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/firewall.nix
---

# Cluster 20: Networking Basics

Dieses Dokument bündelt die Konfigurationen für die Netzwerkschnittstellen, den DNS-Resolver (Blocky) und die Performance-Optimierung des TCP-Stacks. Es dient als "Knowledge Cell" für die Netzwerkinfrastruktur des Fujitsu Q958.

---

## 📡 Netzwerk-Schnittstellen (anchor: network-interfaces)

In mynixos nutzen wir `systemd-networkd` für eine performante und vorhersehbare Netzwerksteuerung. Die Konfiguration erfolgt in `modules/core/network.nix`.

### 🏛️ Vorhersehbare Namen (Predictable Names)
Wir binden Schnittstellennamen fest an die Hardware, um Konsistenz für Firewall-Regeln zu garantieren.
- **Primäres Interface**: `en*` (wird via DHCP konfiguriert).
- **SRE-Ziel**: Umstellung auf `primary0` via MAC-Binding in `systemd.network.links`.

---

## 🛡️ DNS & Ad-Blocking (Blocky) (anchor: blocky-dns)

Der zentrale DNS-Resolver ist **Blocky**. Er bietet hohe Performance, deklarative Filterlisten und Split-Horizon DNS. Die Konfiguration erfolgt in `modules/services/blocky.nix`.

### ⚙️ Kern-Features
- **Upstream**: DNS-over-TLS (DoT) zu Cloudflare (1.1.1.1) und Quad9.
- **Ad-Blocking** (anchor: dns-adblocking): Nutzung der StevenBlack Hosts-Liste.
- **Split-Horizon**: Auflösung interner Domains (`*.m7c5.de`) direkt auf Localhost.

### 🛡️ DNS Hardening (anchor: dns-hardening)
In `modules/core/network.nix` wird `resolved` so konfiguriert, dass Anfragen über TLS verschlüsselt werden.

---

## 🏎️ TCP Stack & Performance (anchor: tcp-tuning)

Für maximale Durchsatzraten und minimale Latenz (ideal für Streaming) nutzen wir moderne TCP-Algorithmen in `modules/core/network.nix`.

- **Congestion Control**: `bbr` (Bottleneck Bandwidth and Round-trip propagation time).
- **Queueing Discipline**: `fq` (Fair Queuing).
- **Fast Open**: `tcp_fastopen` aktiviert für beschleunigte Handshakes.

---

## ✅ Verifizierung

```bash
# 1. Prüfe DNS-Auflösung via Blocky
dig @127.0.0.1 google.com # Sollte IP liefern
dig @127.0.0.1 ads.google.com # Sollte 0.0.0.0 liefern (Blocklist)

# 2. Prüfe DNS-over-TLS Status
resolvectl status | grep "DNSOverTLS"

# 3. Prüfe TCP Congestion Control
sysctl net.ipv4.tcp_congestion_control # Sollte "bbr" zeigen

# 4. Prüfe Netzwerk-Interfaces
networkctl status
```

---

## 🔗 Quellen & Verweise

### Externe Repositories (NixOS-Native)
- [0xERR0R/blocky](https://github.com/0xERR0R/blocky) - Performanter DNS Proxy
- [AdguardTeam/AdGuardHome](https://github.com/AdguardTeam/AdGuardHome) - Alternative DNS Shield
- [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs) - Netzwerk-Module & Tools

### Context7 Observability
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/core/network.nix -->
<!-- context7: https://github.com/grapefruit89/mynixos-v5/blob/main/modules/services/blocky.nix -->

### Nix MCP Index
<!-- mcp: repo_v5/modules/core/network.nix -->
<!-- mcp: repo_v5/modules/services/blocky.nix -->
<!-- mcp: repo_v5/modules/core/firewall.nix -->
