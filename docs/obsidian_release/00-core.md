# 📂 Core System (Foundation)

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
| `NIXH-00-COR-035` | **Stateless System (Wipe-on-Boot)** | `system/stateless, impermanence/active, kernel/hardening` | Stateless root on tmpfs with declarative persistence via Impermanence. ADR 852 compliant. |
| `NIXH-00-COR-036` | **Tty Info** | `system/observability, hardware/console-info` | Service to display critical system information like IP addresses on the physical console (TTY1). |
| `NIXH-00-COR-037` | **User Moritz Home** | `user/dotfiles, home-manager/config` | Personalized user environment configuration via Home-Manager for user 'moritz'. |
| `NIXH-00-COR-038` | **User Preferences** | `user/preferences` | Customized user preferences and personal system adjustments. |
| `NIXH-00-COR-039` | **Users (Declarative & Hardened)** | `system/users, security/no-mutable-users, security/sops-integration` | Strictly immutable user management. Passwords managed via Sops-Nix. Unified media group. |
| `NIXH-00-COR-040` | **Zram Swap (AI Optimized)** | `system/performance, hardware/ram-optimization, ai/optimization` | Optimized compressed RAM swap for AI workloads (Ollama/Claude). High swappiness for CPU-efficient memory management. |
| `NIXH-00-SEC-COR-001` | **Hardened Core (Titanium Fortress)** | `-` | Master security module implementing kernel lockdown, massive blacklisting, and service slimming. |
| `NIXH-00-SYS-ROOT-001` | **Modular Entrypoint (Horizontal)** | `-` | New horizontal responsibility entrypoint. Decouples hardware, users, and common modules. |


--- 
*Generated from Nix Metadata v5.0*