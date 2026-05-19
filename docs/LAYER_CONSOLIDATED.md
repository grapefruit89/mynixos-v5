# Layer‑Übersicht – NixHome Architektur

Dieses Dokument konsolidiert alle Layer-Definitionen und Modul-Metadaten des NixHome-Projekts.

## Inhaltsverzeichnis
- [00 – Core](#00-core)
- [10 – Gateway](#10-gateway)
- [20 – Infrastructure](#20-infrastructure)
- [30 – Automation](#30-automation)
- [40 – Media](#40-media)
- [50 – Knowledge](#50-knowledge)
- [60 – Application](#60-application)
- [80 – Monitoring](#80-monitoring)
- [90 – Policy](#90-policy)
- [File Access Strategy](#file-access-strategy)

<a id="00-core"></a>
## 00 – Core

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-00-COR-001` | **Boot Safeguard** | `-` | Hardened boot configuration with UEFI focus and systemd-boot. |
| `NIXH-00-COR-002` | **AI Tools (SRE Assisted)** | `ai/workflow, shell/enhancement` | Optimized terminal environment for AI-assisted development and SRE tasks. |
| `NIXH-00-COR-003` | **Auto Locale (Zero-Touch)** | `automation/geolocate, system/boot-optimization` | Intelligent geolocation-based system localization with robust fallbacks and state persistence. |
| `NIXH-00-COR-004` | **Backup (Restic Aviation Edition)** | `backup/restic, cloud/sync, security/integrity-check` | Hardened Restic backup logic with atomical Cloud-Sync and failure-safe ExecConditions. |
| `NIXH-00-COR-006` | **Central Configs Plan** | `architecture/roadmap` | Roadmap and architectural planning for centralized configuration management. |
| `NIXH-00-COR-007` | **Config Merger** | `config/merger, system/runtime-config` | Dynamic bridge between NixOS declarations and user-managed JSON overrides for runtime services. |
| `NIXH-00-COR-009` | **00-defaults** | `architecture/defaults, storage/tiering` | Shared global defaults for network namespaces, filesystem prefixes, and security conventions. |
| `NIXH-00-COR-010` | **Fail2ban (Edge Hardened)** | `security/bruteforce-protection, network/hardening, caddy/security` | Aggressive protection with deep Caddy JSON log inspection and incremental banning logic. |
| `NIXH-00-COR-011` | **Firewall (NFTables Secured)** | `network/firewall, security/nftables` | Hardened nftables setup. Only SSoT ports and trusted LAN segments allowed. No legacy port 22. |
| `NIXH-00-COR-012` | **Hardware Configuration** | `system/hardware, boot/initrd` | Auto-generated hardware abstraction layer. |
| `NIXH-00-COR-013` | **Home Manager (User Cockpit)** | `user/environment, shell/hardening, git/configuration` | Hardened user environment. Git SSoT and Shell-Secret integration. |
| `NIXH-00-COR-016` | **Host Identity** | `system/identity` | Basic hostname and identity configuration for the server. |
| `NIXH-00-COR-017` | **Kernel Slim (Advanced Hardened)** | `kernel/hardening, system/performance, security/sysctl` | Aviation-grade optimized and hardened kernel. Max security via slab_nomerge and poison-paging. |
| `NIXH-00-COR-020` | **Locale (SRE Refactored)** | `system/localization, ssot/locale` | Centralized localization settings using the Master Source of Truth. |
| `NIXH-00-COR-022` | **MOTD & Shell UI** | `shell/ui, system/status-reminders` | Dynamic login dashboard and interactive shell initialization. |
| `NIXH-00-COR-023` | **Network (SRE Optimized)** | `network/systemd-networkd, performance/tcp-bbr, security/dns-over-tls` | systemd-networkd configuration with DNS hardening, TCP BBR tuning and fast-boot optimization. |
| `NIXH-00-COR-024` | **Nix Tuning (Pure Binary Policy)** | `nix/tuning, policy/binary-only, maintenance/auto-gc, impermanence/bash-fix` | Optimized nix-daemon settings. Strict binary-only enforcement to prevent local compilation wear. |
| `NIXH-00-COR-026` | **Architectural Principles** | `architecture/manifesto, system/standards, sre/best-practices` | The core manifesto of the NixHome project. Defines SRE standards and isomorphism. |
| `NIXH-00-COR-027` | **Registry (Master Switch)** | `system/feature-flags, ssot/registry` | Global feature-toggles for all layers. Single Source of Truth for service enablement. |
| `NIXH-00-COR-028` | **Secrets (Sops Master Vault)** | `security/secrets, sops/mapping, age/encryption` | Centralized secret-to-module mapping with NIXH-ID traceability. Uses age with SSH-hostkey backing. |
| `NIXH-00-COR-029` | **Shell Premium (M1 Abrams Edition)** | `shell/premium, observability/motd, system/status-checker` | Hardened and optimized shell environment with Caddy health-checks and fastfetch reporting. |
| `NIXH-00-COR-030` | **Shell** | `shell/bash, tools/productivity` | Standardized Bash environment with productivity tools and basic maintenance aliases. |
| `NIXH-00-COR-031` | **SSH Rescue (Fail-Safe)** | `security/recovery, ssh/fail-safe` | Isolated emergency SSH instance on port 2222. Auto-terminates after 5 minutes via systemd-timer. |
| `NIXH-00-COR-032` | **SSH (Post-Quantum Hardened)** | `security/ssh, network/hardening, crypto/post-quantum` | Hardened SSH daemon with Post-Quantum cryptography, strict CIDR-based forwarding and legal protections. |
| `NIXH-00-COR-033` | **Symbiosis** | `hardware/discovery, hardware/management` | Hardware abstraction layer with auto-discovery and microcode management. |
| `NIXH-00-COR-034` | **System Stability (SRE Guard)** | `system/maintenance, safety/watchdog, safety/recovery` | Proactive maintenance and fail-safe logic (Watchdogs, Kernel-Panic, EFI-Cleanup). |
| `NIXH-00-COR-035` | **Storage Foundation** | `storage/mergerfs, storage/abc-tiering` | Declarative storage paths and mergerfs pool definitions. Foundation for ABC-Tiering. |
| `NIXH-00-COR-036` | **Tty Info** | `system/observability, hardware/console-info` | Service to display critical system information like IP addresses on the physical console (TTY1). |
| `NIXH-00-COR-037` | **User Moritz Home** | `user/dotfiles, home-manager/config` | Personalized user environment configuration via Home-Manager for user 'moritz'. |
| `NIXH-00-COR-038` | **User Preferences** | `user/preferences` | Customized user preferences and personal system adjustments. |
| `NIXH-00-COR-039` | **Users (Declarative & Hardened)** | `system/users, security/no-mutable-users, security/sops-integration` | Strictly immutable user management. Passwords managed via Sops-Nix. Unified media group. |
| `NIXH-00-COR-040` | **Zram Swap (AI Optimized)** | `system/performance, hardware/ram-optimization, ai/optimization` | Optimized compressed RAM swap for AI workloads (Ollama/Claude). High swappiness for CPU-efficient memory management. |
| `NIXH-00-SEC-COR-001` | **Hardened Core (Titanium Fortress)** | `-` | Master security module implementing kernel lockdown, massive blacklisting, and service slimming. |
| `NIXH-00-SYS-ROOT-001` | **Modular Entrypoint (Horizontal)** | `-` | New horizontal responsibility entrypoint. Decouples hardware, users, and common modules. |

<a id="10-gateway"></a>
## 10 – Gateway

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-10-GTW-003` | **Cloudflared Tunnel (SRE Exhausted)** | `network/ingress, security/tunnel, cloudflare/integration` | Secure Ingress bridge using Cloudflare Tunnels for zero-port-forwarding connectivity. |
| `NIXH-10-GTW-004` | **Ddns Updater** | `network/ddns, cloudflare/integration` | Automated Dynamic DNS updates for Cloudflare and other providers. |
| `NIXH-10-GTW-005` | **Dns Automation** | `network/dns-automation, cloudflare/api` | Check Cloudflare for DNS conflicts and update runtime map for dynamic routing. |
| `NIXH-10-GTW-007` | **Homepage Dashboard** | `web/dashboard, observability/ui` | Highly customizable application dashboard, fully declarative. |
| `NIXH-10-GTW-008` | **Landing Zone Ui** | `web/landing-page` | Static landing page. |
| `NIXH-10-GTW-009` | **Pocket-ID (OIDC Provider)** | `security/oidc, identity/provider` | Self-hosted OIDC identity provider for secure SSO with Caddy integration. |
| `NIXH-10-GTW-010` | **SSO** | `security/sso` | SSO config. |

<a id="20-infrastructure"></a>
## 20 – Infrastructure

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-20-INF-001` | **ClamAV (SRE Exhausted)** | `security/antivirus, system/protection` | Professional antivirus protection. |
| `NIXH-20-INF-002` | **PostgreSQL (SRE Optimized)** | `database/postgresql, system/persistence, maintenance/auto-backup` | Optimized database cluster with automated backups and strict sandboxing. |
| `NIXH-20-INF-003` | **Secret Ingest** | `automation/secrets, security/ingest` | Watcher for secret landing zone. |
| `NIXH-20-INF-006` | **Valkey (SRE Exhausted)** | `database/key-value, caching/redis` | High-performance Valkey (Redis fork) with memory caps and aviation-grade sandboxing. |
| `NIXH-20-INF-008` | **Vpn Live Config** | `network/vpn-config` | Dynamic runtime configuration for VPN credentials and endpoints. |
| `NIXH-20-SRV-011` | **Open WebUI (SRE Hardened)** | `ai/ui, security/sandboxing` | User-friendly WebUI for LLMs, tightly sandboxed with DynamicUser. |

<a id="30-automation"></a>
## 30 – Automation

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-30-AUT-001` | **Automation** | `system/maintenance, security/sudo-rules` | Core automation settings, including sudo rules for rebuilds and maintenance. |
| `NIXH-30-AUT-002` | **Ai Agents (Ollama & Claude)** | `ai/ollama, ai/claude-code, gpu/acceleration` | Local AI orchestration with Ollama (GPU-accelerated) and Claude Code. |
| `NIXH-30-AUT-006` | **Semaphore** | `automation/ansible` | Ansible Web UI (Placeholder - Not yet implemented). |

<a id="40-media"></a>
## 40 – Media

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-40-MED-001` | **Media Stack (Exhausted Layout)** | `storage/layout, security/permissions` | Canonical data/state layout with ABC-tiering enforcement and global media permissions. |
| `NIXH-40-MED-006` | **Default Media Services** | `media/stack, architecture/imports` | Master import module for the entire media stack. |
| `NIXH-40-MED-008` | **Jellyseerr** | `media/requests` | Media requests. |
| `NIXH-40-MED-010` | **Media Stack Activation** | `system/media-activation` | Central toggle for activating the entire media stack and its default profiles. |
| `NIXH-40-MED-014` | **Recyclarr (SRE Declarative)** | `media/quality-profiles, automation/declarative-config` | Declarative management of Radarr/Sonarr quality profiles and custom formats. |
| `NIXH-40-MED-016` | **Services Common** | `media/defaults, architecture/common` | Common media service defaults and global configuration attributes. |

<a id="50-knowledge"></a>
## 50 – Knowledge

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-50-KNW-001` | **Linkding** | `web/bookmarks` | Bookmark manager (Placeholder - Not yet implemented). |
| `NIXH-50-KNW-002` | **Miniflux (SRE Exhausted)** | `web/rss, security/socket-activation` | Minimalist RSS reader with Wake-on-Access (Socket Activation). |
| `NIXH-50-KNW-004` | **Readeck (SRE Hardened)** | `web/read-it-later, security/sandboxing` | Self-hosted 'read-it-later' service, tightly sandboxed with DynamicUser. |
| `NIXH-50-KNW-005` | **Linkwarden (SRE Hardened)** | `web/bookmarks, archive/offline, security/sandboxing` | Collaborative bookmark manager with automatic archiving and DynamicUser sandboxing. |

<a id="60-application"></a>
## 60 – Application

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-60-APP-002` | **CouchDB (Aviation-Grade)** | `database/nosql, obsidian/sync` | Hardened NoSQL database for Obsidian LiveSync. |
| `NIXH-60-APP-003` | **Filebrowser (SRE Hardened)** | `web/file-management, security/sandboxing` | Web-based file manager with strict path restrictions and sandboxing. |
| `NIXH-60-APP-004` | **Karakeep (Aviation-Grade)** | `web/bookmarks, security/sandboxing` | Hardened bookmark management tool with SRE sandboxing. |
| `NIXH-60-APP-005` | **Matrix Conduit** | `communication/matrix, security/sandboxing` | Lightweight Matrix homeserver (Conduit) written in Rust. |
| `NIXH-60-APP-006` | **Monica** | `web/crm` | Personal CRM. |
| `NIXH-60-APP-007` | **Vaultwarden (SRE Exhausted)** | `security/passwords, security/socket-activation` | Tightly sandboxed password manager with Wake-on-Access (Socket Activation). |

<a id="80-monitoring"></a>
## 80 – Monitoring

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-80-MON-001` | **Cockpit** | `system/administration` | Web admin. |
| `NIXH-80-MON-002` | **Netdata (SRE Exhausted)** | `monitoring/real-time, observability/metrics` | Real-time performance monitoring with high-retention dbengine and strict sandboxing. |
| `NIXH-80-MON-003` | **Scrutiny (SRE Hardened)** | `monitoring/smart, hardware/health` | Hard drive S.M.A.R.T monitoring with automated collection and InfluxDB trends. |
| `NIXH-80-MON-004` | **Uptime Kuma (SRE Exhausted)** | `monitoring/uptime, web/dashboard` | Self-hosted monitoring tool, tightly sandboxed with resource limits. |

<a id="90-policy"></a>
## 90 – Policy

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-90-POL-001` | **Binary-Only Policy** | `policy/enforcement, system/stability` | Enforces a strict download-only workflow by forbidding local compilation to protect system resources. |
| `NIXH-90-POL-002` | **Runtime Security Watchdog** | `-` | Checks active system state (not just config) and alerts on violations. |
| `NIXH-90-POL-003` | **No Legacy** | `policy/enforcement, security/hardening` | Blocks legacy services and insecure protocols. |

<a id="file-access-strategy"></a>
## File Access Strategy

Entscheidungsmatrix für den modernen Dateizugriff auf NixHome.

### 🎯 Status Quo: SFTP (Primary)
Da SSH bereits auf Port `53844` (limitiert auf LAN/VPN) aktiv ist, wird **SFTP** als primäre Methode für den Dateizugriff genutzt.

| Client | Methode | Empfehlung |
| :--- | :--- | :--- |
| **Android** | Solid Explorer / CX File Explorer | SFTP-Verbindung via WireGuard-IP |
| **Windows** | WinSCP / sshfs-win | Einbindung als Netzlaufwerk oder File-Manager |
| **Linux** | Nautilus / Dolphin / sshfs | Nativ via `sftp://` |

**Vorteil:** Kein zusätzlicher Dienst nötig, maximale Sicherheit durch SSH-Hardening.

---

### 🛠️ Optionale Erweiterungen (Future Planning)

#### 1. WebDAV (via Caddy)
**Einsatzbereich:** Obsidian Vault Sync oder SSO-geschützter Dateizugriff für Dritte.
- **Vorteil:** Nutzt Port 443 und Pocket-ID (SSO).
- **Nachteil:** Erfordert Caddy-Plugin und ist oft langsamer als SFTP.

#### 2. SMB/CIFS
**Einsatzbereich:** Stationäre Windows-PCs im LAN (z.B. Media-Editing).
- **Vorteil:** Native Performance unter Windows.
- **Nachteil:** Protokoll-Overhead, komplexeres Hardening.

---

### 📋 Implementierungs-Leitfaden (WebDAV)
Falls WebDAV benötigt wird, ist folgendes Muster zu verwenden:

```nix
# Vorbereitung in modules/services/caddy.nix
services.caddy.package = pkgs.caddy.withPlugins [ pkgs.caddyPlugins.webdav ];

# Dienst-Definition
services.caddy.virtualHosts."dav.${domain}" = {
  extraConfig = ''
    import family_auth
    webdav {
      root /storage/media
      prefix /
    }
  '';
};
```

--- 
*Konsolidiert am: 2026-05-18*
