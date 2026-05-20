---
title: "NixHome Anti-Patterns"
domain: 98
category: reference/standards
status: [ACTIVE-SSoT]
last_reviewed: 2026-05-18
---

# 🚫 NixHome Anti-Patterns (ANTIPATTERN.md)

Dieses Dokument listet explizit abgelehnte Technologien, Muster und Konzepte auf. Jede Entscheidung basiert auf den Prinzipien von NixHome (Hardening, KISS, Pure Nix, Minimal Attack Surface).

| Technologie | Status | Begründung | Referenz |
|-------------|--------|------------|----------|
| **Tailscale** | Abgelehnt | Verursacht DNS-Probleme und schafft ungewollte Abhängigkeiten. | service-forbidden-tech.nix |
| **Docker** | Abgelehnt | Widerspricht dem NixOS-Prinzip (Immutability). Native systemd-Services sind Pflicht. | service-forbidden-tech.nix |
| **Secure Boot (Lanzaboote)** | Abgelehnt | Zu riskant. Fehler führen zu permanentem Lockout. Einfaches systemd-boot bevorzugt. | service-forbidden-tech.nix |
| **Cron** | Abgelehnt | Veraltet. Ausschließlich systemd-Timer werden verwendet. | service-forbidden-tech.nix |
| **SFTPGo** | Abgelehnt | Zu komplex. Dateizugriff erfolgt via FileBrowser oder natives SSH/SFTP. | service-forbidden-tech.nix |
| **mTLS for Admin** | Abgelehnt | Zu komplex für den Erstzugriff (Chicken-and-Egg). SSH-Tunnel bevorzugt. | service-forbidden-tech.nix |
| **OliveTin** | Abgelehnt | Shell-Injection-Risiken. Durch systemd-Oneshot-Units ersetzt. | service-forbidden-tech.nix |
| **iptables (Legacy)** | Abgelehnt | Veraltet. Ausschließlich nftables wird verwendet. | service-forbidden-tech.nix |
| **SSH Password Auth** | Abgelehnt | Unsicher. Nur hardware-gebundene Keys (YubiKey sk-keys). | service-forbidden-tech.nix |
| **ZFS** | Abgelehnt | Komplexes Management auf Consumer-Hardware. Btrfs/EXT4 bevorzugt. | ADR (Archived) |
| **Cloudflare Proxy (Orange Cloud)** | Abgelehnt | Verstößt gegen Cloudflare TOS für nicht-HTML-Inhalte (Medien-Streaming, API-Traffic). Nur DNS-Modus (Gray Cloud) erlaubt. |
| **flake-parts** | Abgelehnt | Verdeckt Komplexität, schafft externe Abhängigkeiten. Pure Flakes bevorzugt. | GEMINI.md |
| **fapolicyd** | Abgelehnt | Nicht weiter verfolgt, zu hoher Wartungsaufwand. | service-forbidden-tech.nix |
| **Marketing-Floskeln** | Abgelehnt | Verwendung von nichtssagenden, nicht messbaren Begriffen (Aviation-Grade, Titanium, etc.). Stattdessen klare, technische Nomenklatur („gehärtet“, „strict“, „mandatory“). | ADR-014 |

---
*Letzte Aktualisierung: 2026-05-18*
