# 🤖 SYSTEM PROMPT FÜR DIE KI
**Rolle:** Du bist ein professioneller AI-Coding-Assistent und Software-Architekt.
**Kontext:** Diese Datei ist eine aggregierte "Single Source of Truth" (SSoT) des Projekts "temp_mynixos".
**Anweisung:** 1. Nutze die untenstehende Landkarte und die Semantic Tags, um das gesamte Projekt zu verstehen.
2. Wenn du Code-Änderungen vorschlägst, beziehe dich IMMER auf die genauen [F-XXX] Anker und Dateipfade, damit der User weiß, wo der Code hingehört.
3. Analysiere Zusammenhänge zwischen den Dateien, bevor du Architektur-Entscheidungen triffst.

---

# 💎 PLATINUM AI CONTEXT BUNDLE: temp_mynixos
Erstellt: 29.04.2026 11:33:49 | Quelle: C:\Users\morit\Documents\distiller_project\temp_mynixos

## 🗺️ LANDKARTE (PROJECT TREE)
- [F-001] .sops.yaml
- [F-002] configuration.nix
- [F-003] flake.lock
- [F-004] flake.nix
- [F-005] README.md
- [F-006] ROADMAP.md
- [F-007] TECHNICAL_DEBT.md
- [F-008] __temp_mynixos_Bundle.md
 - [F-009] .legacy_folders\10-infrastructure\tailscale-policy.current.hujson
 - [F-010] .legacy_folders\10-infrastructure\tailscale-policy.target.hujson
 - [F-011] .legacy_folders\10-infrastructure\_imports.nix
 - [F-012] .legacy_folders\20-automation\service-app-open-webui.nix
 - [F-013] .legacy_folders\20-automation\_imports.nix
 - [F-014] docs\MetaBibliothek
 - [F-015] docs\SPEC_REGISTRY.md
 - [F-016] docs\superpowers\plans\2026-04-27-00-core-refactoring.md
 - [F-017] docs\superpowers\plans\2026-04-28-advanced-storage-tiering.md
 - [F-018] docs\superpowers\plans\2026-04-28-emergency-logging-ntfy.md
 - [F-019] docs\superpowers\plans\2026-04-28-hdd-ghosting-refinement.md
 - [F-020] docs\superpowers\plans\2026-04-28-hdd-silence-protocol.md
 - [F-021] docs\superpowers\plans\2026-04-28-metadata-injection-resumed.md
 - [F-022] docs\superpowers\plans\2026-04-28-navidrome-integration.md
 - [F-023] docs\superpowers\plans\2026-04-28-persist-backup-implementation.md
 - [F-024] docs\superpowers\plans\2026-04-28-phase4-init.md
 - [F-025] docs\superpowers\plans\2026-04-28-ssd-endurance-hardening.md
 - [F-026] docs\superpowers\plans\2026-04-28-storage-mover-implementation.md
 - [F-027] docs\superpowers\plans\2026-04-28-tier-synergy-metadata.md
 - [F-028] docs\superpowers\plans\2026-04-28-vector-logging-implementation.md
 - [F-029] docs\superpowers\specs\2026-04-27-00-core-foundation-design.md
 - [F-030] docs\superpowers\specs\2026-04-28-navidrome-integration-design.md
 - [F-031] docs\superpowers\specs\2026-04-28-persist-backup-design.md
 - [F-032] docs\superpowers\specs\2026-04-28-vector-logging-design.md
 - [F-033] hardware\q958\hardware-configuration.nix
 - [F-034] hardware\q958\hardware-profile.nix
 - [F-035] hardware\q958\README.md
 - [F-036] hardware\q958\registry.nix
 - [F-037] modules\apps\automation.nix
 - [F-038] modules\apps\media-stack.nix
 - [F-039] modules\apps\service-app-ai-agents.nix
 - [F-040] modules\apps\service-app-ai-tools.nix
 - [F-041] modules\apps\service-app-audiobookshelf.nix
 - [F-042] modules\apps\service-app-couchdb.nix
 - [F-043] modules\apps\service-app-filebrowser.nix
 - [F-044] modules\apps\service-app-home-assistant.nix
 - [F-045] modules\apps\service-app-karakeep.nix
 - [F-046] modules\apps\service-app-linkding.nix
 - [F-047] modules\apps\service-app-linkwarden.nix
 - [F-048] modules\apps\service-app-matrix-conduit.nix
 - [F-049] modules\apps\service-app-miniflux.nix
 - [F-050] modules\apps\service-app-monica.nix
 - [F-051] modules\apps\service-app-n8n.nix
 - [F-052] modules\apps\service-app-navidrome.nix
 - [F-053] modules\apps\service-app-olivetin.nix
 - [F-054] modules\apps\service-app-paperless.nix
 - [F-055] modules\apps\service-app-readeck.nix
 - [F-056] modules\apps\service-app-seerr.nix
 - [F-057] modules\apps\service-app-semaphore.nix
 - [F-058] modules\apps\service-app-vaultwarden.nix
 - [F-059] modules\apps\service-media-arr-wire.nix
 - [F-060] modules\apps\service-media-default.nix
 - [F-061] modules\apps\service-media-jellyfin.nix
 - [F-062] modules\apps\service-media-jellyseerr.nix
 - [F-063] modules\apps\service-media-lidarr.nix
 - [F-064] modules\apps\service-media-media-stack.nix
 - [F-065] modules\apps\service-media-prowlarr-setup.nix
 - [F-066] modules\apps\service-media-prowlarr.nix
 - [F-067] modules\apps\service-media-radarr-setup.nix
 - [F-068] modules\apps\service-media-radarr.nix
 - [F-069] modules\apps\service-media-readarr.nix
 - [F-070] modules\apps\service-media-recyclarr.nix
 - [F-071] modules\apps\service-media-sabnzbd.nix
 - [F-072] modules\apps\service-media-services-common.nix
 - [F-073] modules\apps\service-media-sonarr-setup.nix
 - [F-074] modules\apps\service-media-sonarr.nix
 - [F-075] modules\apps\service-media-_lib.nix
 - [F-076] modules\apps\service-media-_servarr-factory.nix
 - [F-077] modules\apps\SERVICE_TEMPLATE.nix
 - [F-078] modules\core\auto-locale.nix
 - [F-079] modules\core\backup.nix
 - [F-080] modules\core\boot-safeguard.nix
 - [F-081] modules\core\central-configs-plan.nix
 - [F-082] modules\core\config-merger.nix
 - [F-083] modules\core\configs.nix
 - [F-084] modules\core\defaults.nix
 - [F-085] modules\core\fail2ban.nix
 - [F-086] modules\core\firewall.nix
 - [F-087] modules\core\graphics.nix
 - [F-088] modules\core\hardware-configuration.nix
 - [F-089] modules\core\home-manager.nix
 - [F-090] modules\core\host.nix
 - [F-091] modules\core\impermanence.nix
 - [F-092] modules\core\kernel-slim.nix
 - [F-093] modules\core\lib-helpers-meta.nix
 - [F-094] modules\core\lib-helpers.nix
 - [F-095] modules\core\locale.nix
 - [F-096] modules\core\motd.nix
 - [F-097] modules\core\network.nix
 - [F-098] modules\core\nix-tuning.nix
 - [F-099] modules\core\ports.nix
 - [F-100] modules\core\principles.nix
 - [F-101] modules\core\registry.nix
 - [F-102] modules\core\secrets.nix
 - [F-103] modules\core\shell-premium.nix
 - [F-104] modules\core\shell.nix
 - [F-105] modules\core\ssh-rescue.nix
 - [F-106] modules\core\ssh.nix
 - [F-107] modules\core\storage.nix
 - [F-108] modules\core\symbiosis.nix
 - [F-109] modules\core\system-stability.nix
 - [F-110] modules\core\system.nix
 - [F-111] modules\core\tty-info.nix
 - [F-112] modules\core\zram-swap.nix
 - [F-113] modules\logging\vector-hdd.nix
 - [F-114] modules\monitoring\gatus.nix
 - [F-115] modules\security\binary-only.nix
 - [F-116] modules\security\flat-layout.nix
 - [F-117] modules\security\hardened-core.nix
 - [F-118] modules\security\no-legacy.nix
 - [F-119] modules\security\runtime-guard.nix
 - [F-120] modules\security\security-assertions.nix
 - [F-121] modules\services\caddy.nix
 - [F-122] modules\services\clamav.nix
 - [F-123] modules\services\cloudflared-tunnel.nix
 - [F-124] modules\services\cockpit.nix
 - [F-125] modules\services\ddns-updater.nix
 - [F-126] modules\services\dns-automation.nix
 - [F-127] modules\services\dns-map.nix
 - [F-128] modules\services\homepage.nix
 - [F-129] modules\services\landing-zone-ui.nix
 - [F-130] modules\services\pocket-id.nix
 - [F-131] modules\services\postgresql.nix
 - [F-132] modules\services\secret-ingest.nix
 - [F-133] modules\services\service-app-zigbee-stack.nix
 - [F-134] modules\services\service-netdata.nix
 - [F-135] modules\services\service-scrutiny.nix
 - [F-136] modules\services\sso.nix
 - [F-137] modules\services\tailscale.nix
 - [F-138] modules\services\uptime-kuma.nix
 - [F-139] modules\services\valkey.nix
 - [F-140] modules\services\vpn-confinement.nix
 - [F-141] modules\services\vpn-live-config.nix
 - [F-142] modules\storage\deferred-ops.nix
 - [F-143] modules\storage\storage-mover.nix
 - [F-144] profiles\automation-apps.nix
 - [F-145] profiles\base-server.nix
 - [F-146] profiles\extra-apps.nix
 - [F-147] profiles\knowledge-apps.nix
 - [F-148] profiles\media-beast.nix
 - [F-149] profiles\security-hardened.nix
 - [F-150] secrets\secrets.yaml
 - [F-151] users\freund\default.nix
 - [F-152] users\freund\home.nix
 - [F-153] users\moritz\default.nix
 - [F-154] users\moritz\home-manager-config.nix
 - [F-155] users\moritz\home.nix
 - [F-156] users\moritz\locale.nix
 - [F-157] users\moritz\preferences.nix

## 🧠 SEMANTIC TAGS (Top-80 Dateien)
[F-008] __temp_mynixos_Bundle.md | 320,46 KB | Tags: [config, modules, service, media, services]
[F-015] docs\SPEC_REGISTRY.md | 27,09 KB | Tags: [service, moritz, unten, MetaBibliothek, documents]
[F-121] modules\services\caddy.nix | 9,33 KB | Tags: [Caddy, Fragment, config, remote_ip, header_regexp]
[F-094] modules\core\lib-helpers.nix | 7,68 KB | Tags: [config, description, srePaths, SERVICE, stateDir]
[F-017] docs\superpowers\plans\2026-04-28-advanced-storage-tiering.md | 7,48 KB | Tags: [Storage, mover, types, mkOption, default]
[F-016] docs\superpowers\plans\2026-04-27-00-core-refactoring.md | 6,44 KB | Tags: [temp_mynixos, Hardware, Ports, configs, types]
[F-044] modules\apps\service-app-home-assistant.nix | 6,11 KB | Tags: [Assistant, types, default, mkOption, group]
[F-051] modules\apps\service-app-n8n.nix | 5,95 KB | Tags: [types, group, default, mkOption, config]
[F-150] secrets\secrets.yaml | 5,69 KB | Tags: [AES256_GCM, ENCRYPTED, BEGIN, YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0, recipient]
[F-133] modules\services\service-app-zigbee-stack.nix | 5,03 KB | Tags: [Zigbee2MQTT, Mosquitto, Zigbee, config, description]
[F-065] modules\apps\service-media-prowlarr-setup.nix | 4,83 KB | Tags: [Prowlarr, prowlarrCfg, Radarr, Sonarr, apiKeyFile]
[F-026] docs\superpowers\plans\2026-04-28-storage-mover-implementation.md | 4,83 KB | Tags: [Mover, Storage, SMART, Hardware, Update]
[F-018] docs\superpowers\plans\2026-04-28-emergency-logging-ntfy.md | 4,77 KB | Tags: [vector, Logging, Emergency, module, temp_mynixos]
[F-071] modules\apps\service-media-sabnzbd.nix | 4,69 KB | Tags: [SABNZBD, types, default, mkOption, description]
[F-022] docs\superpowers\plans\2026-04-28-navidrome-integration.md | 4,55 KB | Tags: [Navidrome, media, config, group, temp_mynixos]
[F-103] modules\core\shell-premium.nix | 4,46 KB | Tags: [fastfetch, Shell, config, services, Rebuild]
[F-056] modules\apps\service-app-seerr.nix | 4,40 KB | Tags: [SEERR, group, config, MEDIA, types]
[F-069] modules\apps\service-media-readarr.nix | 4,35 KB | Tags: [READARR, MEDIA, factory, config, types]
[F-143] modules\storage\storage-mover.nix | 4,35 KB | Tags: [FREE_GB, mover, oldest, Space, SOURCE_DIR]
[F-063] modules\apps\service-media-lidarr.nix | 4,34 KB | Tags: [LIDARR, MEDIA, Music, types, factory]
[F-074] modules\apps\service-media-sonarr.nix | 4,34 KB | Tags: [SONARR, MEDIA, Hardened, types, config]
[F-066] modules\apps\service-media-prowlarr.nix | 4,28 KB | Tags: [PROWLARR, MEDIA, config, factory, types]
[F-083] modules\core\configs.nix | 4,24 KB | Tags: [types, default, mkOption, description, myLib]
[F-068] modules\apps\service-media-radarr.nix | 4,21 KB | Tags: [RADARR, MEDIA, config, types, factory]
[F-028] docs\superpowers\plans\2026-04-28-vector-logging-implementation.md | 4,07 KB | Tags: [Vector, Logging, modules, message, temp_mynixos]
[F-142] modules\storage\deferred-ops.nix | 3,94 KB | Tags: [queue, ENTRY, devices, Deletion, deferred]
[F-067] modules\apps\service-media-radarr-setup.nix | 3,93 KB | Tags: [Radarr, Setup, ROOT_PATH, EXISTING, API_KEY]
[F-140] modules\services\vpn-confinement.nix | 3,90 KB | Tags: [nsName, netns, namespace, namespaces, network]
[F-084] modules\core\defaults.nix | 3,89 KB | Tags: [types, default, mkOption, defaults, description]
[F-041] modules\apps\service-app-audiobookshelf.nix | 3,88 KB | Tags: [Audiobookshelf, config, default, mkOption, types]
[F-092] modules\core\kernel-slim.nix | 3,87 KB | Tags: [Kernel, mkForce, MODULES, false, hardening]
[F-061] modules\apps\service-media-jellyfin.nix | 3,75 KB | Tags: [JELLYFIN, config, MEDIA, Hardened, srePaths]
[F-075] modules\apps\service-media-_lib.nix | 3,66 KB | Tags: [media, stateDir, srePaths, config, service]
[F-073] modules\apps\service-media-sonarr-setup.nix | 3,61 KB | Tags: [Sonarr, ROOT_PATH, Setup, FOLDER, API_KEY]
[F-114] modules\monitoring\gatus.nix | 3,49 KB | Tags: [gatus, config, types, default, mkOption]
[F-053] modules\apps\service-app-olivetin.nix | 3,39 KB | Tags: [OLIVETIN, nixos, rebuild, title, Socket]
[F-054] modules\apps\service-app-paperless.nix | 3,38 KB | Tags: [PAPERLESS, config, services, ENVIRONMENT, Valkey]
[F-113] modules\logging\vector-hdd.nix | 3,33 KB | Tags: [vector, message, config, Journald, logDir]
[F-085] modules\core\fail2ban.nix | 3,28 KB | Tags: [Caddy, Fail2ban, config, Aggressive, services]
[F-005] README.md | 3,24 KB | Tags: [Dienste, modules, erfolgt, Caddy, Tailscale]
[F-034] hardware\q958\hardware-profile.nix | 3,22 KB | Tags: [Fragment, KERNEL, Power, Intel, storage]
[F-107] modules\core\storage.nix | 3,20 KB | Tags: [Storage, mergerfs, cache, description, Media]
[F-128] modules\services\homepage.nix | 3,10 KB | Tags: [dnsMap, https, dnsMapping, config, Homepage]
[F-101] modules\core\registry.nix | 3,09 KB | Tags: [enable, mkEnableOption, mkDefault, default, types]
[F-106] modules\core\ssh.nix | 3,08 KB | Tags: [config, Quantum, false, openssh, Grade]
[F-079] modules\core\backup.nix | 3,02 KB | Tags: [Backup, Restic, config, Cloud, LIMIT]
[F-102] modules\core\secrets.nix | 2,91 KB | Tags: [config, Secrets, placeholder, radarr_api_key, TEMPLATES]
[F-082] modules\core\config-merger.nix | 2,79 KB | Tags: [config, nixhome, userConfig, Merger, finalConfig]
[F-117] modules\security\hardened-core.nix | 2,75 KB | Tags: [false, enable, kernel, security, accept_redirects]
[F-052] modules\apps\service-app-navidrome.nix | 2,60 KB | Tags: [NAVIDROME, config, group, Music, default]
[F-109] modules\core\system-stability.nix | 2,59 KB | Tags: [System, Kernel, efibootmgr, watchdog, Panic]
[F-086] modules\core\firewall.nix | 2,57 KB | Tags: [Firewall, dport, saddr, lanCidr, accept]
[F-110] modules\core\system.nix | 2,56 KB | Tags: [mkForce, System, Stateless, kernel, enable]
[F-009] .legacy_folders\10-infrastructure\tailscale-policy.current.hujson | 2,55 KB | Tags: [Example, users, devices, Tailscale, Define]
[F-029] docs\superpowers\specs\2026-04-27-00-core-foundation-design.md | 2,53 KB | Tags: [Funktion, mkService, helpers, Dateien, ports]
[F-019] docs\superpowers\plans\2026-04-28-hdd-ghosting-refinement.md | 2,53 KB | Tags: [metadata, Jellyfin, Inode, Warmer, Commit]
[F-006] ROADMAP.md | 2,50 KB | Tags: [Obsidian, Medium, Status, Geoblock, Hardening]
[F-111] modules\core\tty-info.nix | 2,47 KB | Tags: [system, config, target, description, local]
[F-097] modules\core\network.nix | 2,45 KB | Tags: [mkForce, enable, networking, false, systemd]
[F-126] modules\services\dns-automation.nix | 2,42 KB | Tags: [domain, Cloudflare, config, ZONE_ID, services]
[F-123] modules\services\cloudflared-tunnel.nix | 2,41 KB | Tags: [Tunnel, config, Cloudflare, default, tunnelId]
[F-007] TECHNICAL_DEBT.md | 2,40 KB | Tags: [Problem, Risiko, Lösung, Challenge, WebDAV]
[F-058] modules\apps\service-app-vaultwarden.nix | 2,33 KB | Tags: [VAULTWARDEN, mkForce, config, Socket, security]
[F-023] docs\superpowers\plans\2026-04-28-persist-backup-implementation.md | 2,31 KB | Tags: [Restic, Persist, Backblaze, secrets, Backup]
[F-120] modules\security\security-assertions.nix | 2,28 KB | Tags: [config, Security, Policy, strict, warnings]
[F-078] modules\core\auto-locale.nix | 2,25 KB | Tags: [COUNTRY, Locale, system, state, geolocation]
[F-131] modules\services\postgresql.nix | 2,21 KB | Tags: [PostgreSQL, services, paperless, miniflux, systemd]
[F-076] modules\apps\service-media-_servarr-factory.nix | 2,20 KB | Tags: [types, mkOption, default, value, false]
[F-035] hardware\q958\README.md | 2,19 KB | Tags: [Hardware, Intel, Fujitsu, Physical, power]
[F-098] modules\core\nix-tuning.nix | 2,17 KB | Tags: [Binary, Fragment, cachix, TRUSTED, settings]
[F-033] hardware\q958\hardware-configuration.nix | 2,07 KB | Tags: [Hardware, Fujitsu, nct6775, sensors, config]
[F-047] modules\apps\service-app-linkwarden.nix | 2,03 KB | Tags: [LINKWARDEN, config, services, domain, sandboxing]
[F-025] docs\superpowers\plans\2026-04-28-ssd-endurance-hardening.md | 2,01 KB | Tags: [SABnzbd, Commit, Vector, Mounts, noatime]
[F-048] modules\apps\service-app-matrix-conduit.nix | 1,99 KB | Tags: [Matrix, CONDUIT, config, services, mkForce]
[F-104] modules\core\shell.nix | 1,98 KB | Tags: [nixos, config, programs, Shell, rebuild]
[F-155] users\moritz\home.nix | 1,98 KB | Tags: [Manager, config, Shell, environment, rebase]
[F-040] modules\apps\service-app-ai-tools.nix | 1,96 KB | Tags: [TOOLS, blesh, inshellisense, gemini, config]
[F-089] modules\core\home-manager.nix | 1,96 KB | Tags: [Manager, config, environment, Shell, programs]
[F-030] docs\superpowers\specs\2026-04-28-navidrome-integration-design.md | 1,96 KB | Tags: [Navidrome, Media, Stack, Beast, enable]
[F-119] modules\security\runtime-guard.nix | 1,95 KB | Tags: [Security, Runtime, Lockdown, Check, config]


## 📊 DATEI-STATISTIK

Count Name SizeSum
----- ---- -------
 128 .nix 0,28 MB
 23 .md 0,40 MB
 2 .hujson 0,00 MB
 2 .yaml 0,01 MB
 1 0,00 MB
 1 .lock 0,00 MB




## 📦 DATEI-INHALTE (SEMANTIC ANCHORS)
### [F-001] .sops.yaml
* Pfad: .sops.yaml | Format: .yaml | Größe: 282 B
``yaml
creation_rules:
 - path_regex: secrets\.yaml$
 key_groups:
 - age:
 - age1pjl6xt8zu80p4dpp6yqnk5u53ratgc58sdtnf7c2krlxyt8msgvs9s763s # Emergency Key (Moritz)
 - age1t2uu2un4trvvyhg7ryp8h8tqjxl5vnd0qd48dq4s8yvhc6jwtd4smyet95 # Server Host Key (q958)

``n---
### [F-002] configuration.nix
* Pfad: configuration.nix | Format: .nix | Größe: 1,80 KB
``nix
{ lib, pkgs, config, inputs, myLib, ... }:
let

 nms = {
 id = "NIXH-00-SYS-ROOT-001";
 title = "Modular Entrypoint (Horizontal)";
 description = "New horizontal responsibility entrypoint. Decouples hardware, users, and common modules.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
in
{
 options.my.meta.configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [

 inputs.sops-nix.nixosModules.sops
 inputs.impermanence.nixosModules.impermanence

 ./modules/core/configs.nix
 ./modules/core/ports.nix
 ./modules/core/registry.nix
 ./modules/core/lib-helpers-meta.nix
 ./modules/core/secrets.nix
 ./modules/core/graphics.nix
 ./modules/core/backup.nix

 ./profiles/base-server.nix
 ./profiles/media-beast.nix
 ./profiles/security-hardened.nix
 ./profiles/automation-apps.nix
 ./profiles/knowledge-apps.nix
 ./profiles/extra-apps.nix

 ./users/moritz/default.nix
 ./users/moritz/home.nix
 ];

 config = {
 system.stateVersion = "25.11";
 networking.hostName = "nixhome";

 nixpkgs.overlays = [ inputs.mcp-nixos.overlays.default ];
 environment.systemPackages = [ pkgs.mcp-nixos ];

 my.services = {
 kernelSlim.enable = true;
 shell.premium.enable = true;
 storagePool.enable = true;
 caddy.enable = true;
 postgresql.enable = true;
 };
 };
}

``n---
### [F-003] flake.lock
* Pfad: flake.lock | Format: .lock | Größe: 1,70 KB
``lock
{
 "nodes": {
 "home-manager": {
 "inputs": {
 "nixpkgs": [
 "nixpkgs"
 ]
 },
 "locked": {
 "lastModified": 1772380125,
 "narHash": "sha256-8C+y46xA9bxcchj9GeDPJaRUDApaA3sy2fhJr1bTbUw=",
 "owner": "nix-community",
 "repo": "home-manager",
 "rev": "a07a44a839eb036e950bf397d9b782916f8dcab3",
 "type": "github"
 },
 "original": {
 "owner": "nix-community",
 "ref": "release-25.11",
 "repo": "home-manager",
 "type": "github"
 }
 },
 "nixpkgs": {
 "locked": {
 "lastModified": 1772047000,
 "narHash": "sha256-7DaQVv4R97cii/Qdfy4tmDZMB2xxtyIvNGSwXBBhSmo=",
 "owner": "nixos",
 "repo": "nixpkgs",
 "rev": "1267bb4920d0fc06ea916734c11b0bf004bbe17e",
 "type": "github"
 },
 "original": {
 "owner": "nixos",
 "ref": "nixos-25.11",
 "repo": "nixpkgs",
 "type": "github"
 }
 },
 "root": {
 "inputs": {
 "home-manager": "home-manager",
 "nixpkgs": "nixpkgs",
 "sops-nix": "sops-nix"
 }
 },
 "sops-nix": {
 "inputs": {
 "nixpkgs": [
 "nixpkgs"
 ]
 },
 "locked": {
 "lastModified": 1772401007,
 "narHash": "sha256-YHykQg0h9hrlZGpMcywnaFzQ1Kn/5YNCCOSaaAl6z7Q=",
 "owner": "Mic92",
 "repo": "sops-nix",
 "rev": "d8be5ea4cd3bc363492ab5bc6e874ccdc5465fe4",
 "type": "github"
 },
 "original": {
 "owner": "Mic92",
 "repo": "sops-nix",
 "type": "github"
 }
 }
 },
 "root": "root",
 "version": 7
}

``n---
### [F-004] flake.nix
* Pfad: flake.nix | Format: .nix | Größe: 1,48 KB
``nix
{
 description = "NixHome - hardened Horizontal Configuration";

 inputs = {
 nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

 sops-nix.url = "github:Mic92/sops-nix";
 sops-nix.inputs.nixpkgs.follows = "nixpkgs";

 home-manager.url = "github:nix-community/home-manager/release-25.11";
 home-manager.inputs.nixpkgs.follows = "nixpkgs";

 impermanence.url = "github:nix-community/impermanence";

 mcp-nixos.url = "github:utensils/mcp-nixos";
 };

 outputs = { self, nixpkgs, ... }@inputs: let

 myLib = import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; pkgs = nixpkgs.legacyPackages.x86_64-linux; };

 specialArgs = { inherit inputs myLib; };
 in {
 nixosConfigurations = {

 nixhome = nixpkgs.lib.nixosSystem {
 system = "x86_64-linux";
 inherit specialArgs;
 modules = [
 ./hardware/q958/hardware-configuration.nix
 ./hardware/q958/hardware-profile.nix
 ./configuration.nix # Der horizontale Entrypoint
 ];
 };

 };
 };
}

``n---
### [F-005] README.md
* Pfad: README.md | Format: .md | Größe: 3,24 KB
``md
NixOS-basierte Homelab-Konfiguration (v5.0) mit horizontaler Modulstruktur, fokussiert auf Daten-Tiering und Identitätsmanagement.

Das System verteilt Daten basierend auf Latenz- und Haltbarkeitsanforderungen über drei Ebenen:

| Tier | Hardware | Mountpoint | Nutzung | Besonderheiten |
| :--- | :--- | :--- | :--- | :--- |
| **A** | NVMe | `/persist` | OS, DBs, `/data/state` | Persistent via Impermanence |
| **B** | SATA SSD | `/mnt/cache` | Incomplete Downloads, Transcodes | Schonung der NVMe-Zyklen |
| **C** | HDD Mirror | `/mnt/hdd_pool` | Bulk Media, Backups | Spindown nach 10 Min. |

Ein systemd-Service überwacht Tier B. Bei Unterschreitung von 20GB freiem Speicher werden die ältesten Dateien via `rsync --remove-source-files` nach Tier C verschoben. 
- **Sicherheitsregeln:** Datenbank-Dateien (`.wal`, `.db`, `.sqlite`) sind von der Verschiebung ausgeschlossen.
- **Zustandsprüfung:** Verschiebung erfolgt primär, wenn die HDDs bereits aktiv sind, um unnötige Spin-ups zu vermeiden.

Die Dienste sind in zwei Zonen unterteilt. Der Zugriff erfolgt über Caddy als Edge-Proxy.

- **Media:** Jellyfin, Audiobookshelf, Navidrome
- **Requests:** Jellyseerr
- **Smart Home:** Home Assistant

- **Download:** Radarr, Sonarr, Prowlarr, Lidarr, Readarr, SABnzbd
- **Automation:** n8n, Semaphore
- **Produktivität:** Paperless-ngx, Vaultwarden, Linkding, Monica, Readeck
- **Infrastruktur:** AdGuard Home, Netdata, Scrutiny, Cockpit, Filebrowser

- **SSO:** Pocket-ID (OIDC) ist für alle Web-Dienste verpflichtend.
- **Keine Bypässe:** IP-basierte Ausnahmen für LAN oder Tailscale wurden entfernt; jeder Zugriff erfordert einen gültigen Token.
- **Impermanence:** Das Root-Dateisystem ist ein `tmpfs`. Nur explizit unter `/persist` gelistete Pfade überdauern einen Neustart.
- **Runtime Guard:** Ein Watchdog prüft periodisch den Status der nftables-Regelsätze und des Kernel-Lockdowns.
- **Fail2ban:** Schützt SSH (Port 22) und die SSH-Rescue-Instanz (Port 2222).

- `modules/core/`: Systemgrundlagen (Netzwerk, Dateisysteme, Sops).
- `modules/security/`: Security-Policies und Runtime-Monitoring.
- `modules/apps/`: Applikations-Module (nutzen zentrale Service-Factories).
- `modules/services/`: Infrastruktur-Dienste (Caddy, Tailscale, SSO).

Das System verzichtet auf die automatische Erstellung von Docker-Containern. Sofern Docker genutzt wird, erfolgt die Pflege der Container manuell außerhalb der Nix-Konfiguration.

- **Transcoding:** Jellyfin nutzt Tier B (SSD) für temporäre Daten, um RAM-Überläufe (`/dev/shm`) bei hochbitratigen 4K-Streams zu verhindern.
- **MergerFS:** `cache.files` ist auf `off` gesetzt, um Inkonsistenzen bei parallelen Schreibvorgängen durch den Mover zu vermeiden.
- **Sops-Deadlock:** Bei Totalausfall von Tier A (NVMe) fehlen die SSH-Hostkeys zur Entschlüsselung der Secrets. Ein physischer Emergency-Key (USB) wird als Fallback empfohlen.

``n---
### [F-006] ROADMAP.md
* Pfad: ROADMAP.md | Format: .md | Größe: 2,50 KB
``md
- **v5.0 Core:** Horizontal Responsibility Design implemented.
- **Identity:** Strict SSO (Pocket-ID) for all services, no IP-bypasses.
- **Storage:** ABC-Tiering with Smart Mover (SSD HDD) and transactional safety.
- **Networking:** nftables Geoblock (DE/AT/LT) and 3-Stage DDoS Shield in Caddy.
- **Security:** Runtime Security Guard (stündliche Checks) active.
- **Resilience:** Sops-Fallback for Tier A failure prepared on Tier B.

- **Disaster Recovery:** Physical Emergency-Key for Sops needs to be created on USB.
- **IPv6 Parity:** Geoblock sets for IPv6 need dynamic population.
- **Bot Defense:** JS-Challenge could be upgraded to PoW (Hashcash).

| Priority | Task | Complexity | Impact | Status |
| :--- | :--- | :--- | :--- | :--- |
| **P1** | **Persistent Logs (Vector)** | Low | High | **[DONE]** |
| **P2** | **Backup of `/persist` (Restic)** | Low | High | **[DONE]** |
| **P3** | **Storage Tiering Mover** | Medium | Medium | **[DONE]** |
| **P4** | **Core Hardening (Kernel/Systemd)** | Low | Medium | **[DONE]** |
| **P5** | **Gatus / Healthchecks** | Low | Medium | **[DONE]** |
| **P6** | **Extra Apps (Vaultwarden, etc.)** | Low | Low | **[DONE]** |
| **P7** | **Knowledge Pipeline (Obsidian)** | High | Low | **[IN PROGRESS]** |

- **Objective:** Bridge Nix metadata to Obsidian without "cluttering".
- **Implementation:** `meta_to_obsidian.py` script active.
- **Status:** Initial Dossiers generated in `docs/obsidian_export/`.
- **Next Step:** Import to main Obsidian Vault.

- [x] **nftables-Geoblock:** DE, AT, LT restricted for port 443 (Kernel-Level).
- [x] **Caddy DDoS Shield:** 3-Stage defense (Unknown, Human, Auth) with JS-Challenge.
- [x] **API Compatibility:** Exceptions for native apps (/api, /Users, /jellyfin).
- [x] **Isolation:** Closed port 80 and SSH (53844) for public WAN.
- [x] **Integrity:** `cache.files=off` in MergerFS to prevent metadata drift.

- [x] **TECHNICAL_DEBT.md:** Documentation of known risks and future tasks.
- [x] **README.md:** Clean, factual project documentation created.

``n---
### [F-007] TECHNICAL_DEBT.md
* Pfad: TECHNICAL_DEBT.md | Format: .md | Größe: 2,40 KB
``md
Dieses Dokument listet bekannte Einschränkungen, akzeptierte Restrisiken und geplante Architektur-Verbesserungen auf.

- **Problem:** SSH-Hostkeys liegen auf `/persist` (NVMe). Wenn diese Partition physisch stirbt, kann SOPS keine Secrets mehr entschlüsseln. Der Fallback-Pfad auf Tier B ist vorbereitet, aber aktuell nicht mit einem Live-Key befüllt.
- **Risiko:** System bootet, aber alle Dienste (Cloudflare, Tailscale, DBs) schlagen fehl. Kein Remote-Access möglich.
- **Lösung:** Physischen USB-Key mit Age-Fallback erstellen und in `secrets.nix` final einbinden.

- **Problem:** IP-Ranges in `firewall.nix` sind manuell gepflegt und veralten.
- **Risiko:** Angreifer aus zugelassenen Ländern kommen durch; legitime User aus geänderten Ranges werden blockiert.
- **Lösung:** Integration von `geoip-shell` oder einem systemd-timer, der die nftables-Sets wöchentlich via MaxMind API aktualisiert.

- **Problem:** Viele Security-Regeln sind IPv4-fokussiert.
- **Risiko:** Umgehung der Limits via IPv6.
- **Lösung:** Kontinuierliche Spiegelung aller IPv4 nftables Sets nach IPv6.

- **Problem:** Die aktuelle `13+37` Challenge hält nur einfache Scripte ab. Headless Browser (Puppeteer) können sie lösen.
- **Risiko:** Gezielte Bot-Angriffe überwinden den Rate-Limit-Schutz.
- **Lösung:** Implementierung eines echten Proof-of-Work (PoW) Verfahrens (z.B. Hashcash) in der Challenge-Seite.

- **Problem:** API-Endpunkte (arr-Apps) sind von der Challenge befreit, unterliegen aber dem Stage-0 Limit (30 req/min).
- **Risiko:** Mobile Apps könnten bei intensiver Synchronisation blockiert werden.
- **Lösung:** Token-basierte Whitelist für bekannte API-Clients in Caddy.

- **Status:** Aktuell ist nur SFTP aktiv (Port 53844).
- **Lücke:** Obsidian-Vault-Sync erfordert WebDAV; native Windows-Netzlaufwerke sind via SMB/WebDAV komfortabler.
- **Strategie:** SFTP bleibt Standard für Admin/Universal. WebDAV wird bei Bedarf für Obsidian via Caddy (SSO-protected) nachgerüstet.

``n---
### [F-008] __temp_mynixos_Bundle.md
* Pfad: __temp_mynixos_Bundle.md | Format: .md | Größe: 320,46 KB
``md
**Rolle:** Du bist ein professioneller AI-Coding-Assistent und Software-Architekt.
**Kontext:** Diese Datei ist eine aggregierte "Single Source of Truth" (SSoT) des Projekts "temp_mynixos".
**Anweisung:** 1. Nutze die untenstehende Landkarte und die Semantic Tags, um das gesamte Projekt zu verstehen.
2. Wenn du Code-Änderungen vorschlägst, beziehe dich IMMER auf die genauen [F-XXX] Anker und Dateipfade, damit der User weiß, wo der Code hingehört.
3. Analysiere Zusammenhänge zwischen den Dateien, bevor du Architektur-Entscheidungen triffst.

Erstellt: 28.04.2026 21:40:33 | Quelle: C:\Users\morit\Documents\distiller_project\temp_mynixos

- [F-001] .sops.yaml
- [F-002] configuration.nix
- [F-003] flake.lock
- [F-004] flake.nix
- [F-005] README.md
 - [F-006] .legacy_folders\10-infrastructure\tailscale-policy.current.hujson
 - [F-007] .legacy_folders\10-infrastructure\tailscale-policy.target.hujson
 - [F-008] .legacy_folders\10-infrastructure\_imports.nix
 - [F-009] .legacy_folders\20-automation\service-app-open-webui.nix
 - [F-010] .legacy_folders\20-automation\_imports.nix
 - [F-011] docs\MetaBibliothek
 - [F-012] docs\SPEC_REGISTRY.md
 - [F-013] docs\superpowers\plans\2026-04-27-00-core-refactoring.md
 - [F-014] docs\superpowers\plans\2026-04-28-navidrome-integration.md
 - [F-015] docs\superpowers\plans\2026-04-28-persist-backup-implementation.md
 - [F-016] docs\superpowers\plans\2026-04-28-storage-mover-implementation.md
 - [F-017] docs\superpowers\plans\2026-04-28-vector-logging-implementation.md
 - [F-018] docs\superpowers\specs\2026-04-27-00-core-foundation-design.md
 - [F-019] docs\superpowers\specs\2026-04-28-navidrome-integration-design.md
 - [F-020] docs\superpowers\specs\2026-04-28-persist-backup-design.md
 - [F-021] docs\superpowers\specs\2026-04-28-vector-logging-design.md
 - [F-022] hardware\q958\hardware-configuration.nix
 - [F-023] hardware\q958\hardware-profile.nix
 - [F-024] hardware\q958\README.md
 - [F-025] hardware\q958\registry.nix
 - [F-026] modules\apps\automation.nix
 - [F-027] modules\apps\media-stack.nix
 - [F-028] modules\apps\service-app-ai-agents.nix
 - [F-029] modules\apps\service-app-ai-tools.nix
 - [F-030] modules\apps\service-app-audiobookshelf.nix
 - [F-031] modules\apps\service-app-couchdb.nix
 - [F-032] modules\apps\service-app-filebrowser.nix
 - [F-033] modules\apps\service-app-home-assistant.nix
 - [F-034] modules\apps\service-app-karakeep.nix
 - [F-035] modules\apps\service-app-linkding.nix
 - [F-036] modules\apps\service-app-linkwarden.nix
 - [F-037] modules\apps\service-app-matrix-conduit.nix
 - [F-038] modules\apps\service-app-miniflux.nix
 - [F-039] modules\apps\service-app-monica.nix
 - [F-040] modules\apps\service-app-n8n.nix
 - [F-041] modules\apps\service-app-navidrome.nix
 - [F-042] modules\apps\service-app-olivetin.nix
 - [F-043] modules\apps\service-app-paperless.nix
 - [F-044] modules\apps\service-app-readeck.nix
 - [F-045] modules\apps\service-app-seerr.nix
 - [F-046] modules\apps\service-app-semaphore.nix
 - [F-047] modules\apps\service-app-vaultwarden.nix
 - [F-048] modules\apps\service-media-arr-wire.nix
 - [F-049] modules\apps\service-media-default.nix
 - [F-050] modules\apps\service-media-jellyfin.nix
 - [F-051] modules\apps\service-media-jellyseerr.nix
 - [F-052] modules\apps\service-media-lidarr.nix
 - [F-053] modules\apps\service-media-media-stack.nix
 - [F-054] modules\apps\service-media-prowlarr-setup.nix
 - [F-055] modules\apps\service-media-prowlarr.nix
 - [F-056] modules\apps\service-media-radarr-setup.nix
 - [F-057] modules\apps\service-media-radarr.nix
 - [F-058] modules\apps\service-media-readarr.nix
 - [F-059] modules\apps\service-media-recyclarr.nix
 - [F-060] modules\apps\service-media-sabnzbd.nix
 - [F-061] modules\apps\service-media-services-common.nix
 - [F-062] modules\apps\service-media-sonarr-setup.nix
 - [F-063] modules\apps\service-media-sonarr.nix
 - [F-064] modules\apps\service-media-_lib.nix
 - [F-065] modules\apps\service-media-_servarr-factory.nix
 - [F-066] modules\apps\SERVICE_TEMPLATE.nix
 - [F-067] modules\core\auto-locale.nix
 - [F-068] modules\core\backup.nix
 - [F-069] modules\core\boot-safeguard.nix
 - [F-070] modules\core\central-configs-plan.nix
 - [F-071] modules\core\config-merger.nix
 - [F-072] modules\core\configs.nix
 - [F-073] modules\core\defaults.nix
 - [F-074] modules\core\fail2ban.nix
 - [F-075] modules\core\firewall.nix
 - [F-076] modules\core\hardware-configuration.nix
 - [F-077] modules\core\home-manager.nix
 - [F-078] modules\core\host.nix
 - [F-079] modules\core\impermanence.nix
 - [F-080] modules\core\kernel-slim.nix
 - [F-081] modules\core\lib-helpers-meta.nix
 - [F-082] modules\core\lib-helpers.nix
 - [F-083] modules\core\locale.nix
 - [F-084] modules\core\motd.nix
 - [F-085] modules\core\network.nix
 - [F-086] modules\core\nix-tuning.nix
 - [F-087] modules\core\ports.nix
 - [F-088] modules\core\principles.nix
 - [F-089] modules\core\registry.nix
 - [F-090] modules\core\secrets.nix
 - [F-091] modules\core\shell-premium.nix
 - [F-092] modules\core\shell.nix
 - [F-093] modules\core\ssh-rescue.nix
 - [F-094] modules\core\ssh.nix
 - [F-095] modules\core\storage.nix
 - [F-096] modules\core\symbiosis.nix
 - [F-097] modules\core\system-stability.nix
 - [F-098] modules\core\system.nix
 - [F-099] modules\core\tty-info.nix
 - [F-100] modules\core\zram-swap.nix
 - [F-101] modules\logging\vector-tier-b.nix
 - [F-102] modules\security\binary-only.nix
 - [F-103] modules\security\flat-layout.nix
 - [F-104] modules\security\no-legacy.nix
 - [F-105] modules\security\security-assertions.nix
 - [F-106] modules\services\caddy.nix
 - [F-107] modules\services\clamav.nix
 - [F-108] modules\services\cloudflared-tunnel.nix
 - [F-109] modules\services\cockpit.nix
 - [F-110] modules\services\ddns-updater.nix
 - [F-111] modules\services\dns-automation.nix
 - [F-112] modules\services\dns-map.nix
 - [F-113] modules\services\homepage.nix
 - [F-114] modules\services\landing-zone-ui.nix
 - [F-115] modules\services\pocket-id.nix
 - [F-116] modules\services\postgresql.nix
 - [F-117] modules\services\secret-ingest.nix
 - [F-118] modules\services\service-app-zigbee-stack.nix
 - [F-119] modules\services\service-netdata.nix
 - [F-120] modules\services\service-scrutiny.nix
 - [F-121] modules\services\sso.nix
 - [F-122] modules\services\tailscale.nix
 - [F-123] modules\services\uptime-kuma.nix
 - [F-124] modules\services\valkey.nix
 - [F-125] modules\services\vpn-confinement.nix
 - [F-126] modules\services\vpn-live-config.nix
 - [F-127] modules\storage\storage-mover.nix
 - [F-128] profiles\automation-apps.nix
 - [F-129] profiles\base-server.nix
 - [F-130] profiles\extra-apps.nix
 - [F-131] profiles\knowledge-apps.nix
 - [F-132] profiles\media-beast.nix
 - [F-133] profiles\security-hardened.nix
 - [F-134] secrets\secrets.yaml
 - [F-135] users\freund\default.nix
 - [F-136] users\freund\home.nix
 - [F-137] users\moritz\default.nix
 - [F-138] users\moritz\home-manager-config.nix
 - [F-139] users\moritz\home.nix
 - [F-140] users\moritz\locale.nix
 - [F-141] users\moritz\preferences.nix

[F-012] docs\SPEC_REGISTRY.md | 27,09 KB | Tags: [service, moritz, unten, MetaBibliothek, documents]
[F-082] modules\core\lib-helpers.nix | 7,34 KB | Tags: [config, description, SERVICE, stateDir, srePaths]
[F-013] docs\superpowers\plans\2026-04-27-00-core-refactoring.md | 6,44 KB | Tags: [temp_mynixos, Hardware, Ports, configs, types]
[F-033] modules\apps\service-app-home-assistant.nix | 5,96 KB | Tags: [Assistant, types, default, mkOption, config]
[F-040] modules\apps\service-app-n8n.nix | 5,78 KB | Tags: [group, types, default, mkOption, Postgres]
[F-134] secrets\secrets.yaml | 5,69 KB | Tags: [AES256_GCM, ENCRYPTED, BEGIN, YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0, recipient]
[F-106] modules\services\caddy.nix | 5,46 KB | Tags: [Caddy, Fragment, Source, config, GeoIP]
[F-118] modules\services\service-app-zigbee-stack.nix | 5,03 KB | Tags: [Zigbee2MQTT, Mosquitto, Zigbee, config, description]
[F-054] modules\apps\service-media-prowlarr-setup.nix | 4,83 KB | Tags: [Prowlarr, prowlarrCfg, Radarr, Sonarr, apiKeyFile]
[F-016] docs\superpowers\plans\2026-04-28-storage-mover-implementation.md | 4,83 KB | Tags: [Mover, Storage, SMART, Hardware, Update]
[F-014] docs\superpowers\plans\2026-04-28-navidrome-integration.md | 4,55 KB | Tags: [Navidrome, media, config, group, temp_mynixos]
[F-091] modules\core\shell-premium.nix | 4,46 KB | Tags: [fastfetch, Shell, config, services, Rebuild]
[F-060] modules\apps\service-media-sabnzbd.nix | 4,40 KB | Tags: [SABnzbd, types, mkOption, default, description]
[F-045] modules\apps\service-app-seerr.nix | 4,22 KB | Tags: [Seerr, group, config, types, Media]
[F-058] modules\apps\service-media-readarr.nix | 4,17 KB | Tags: [Readarr, types, factory, config, description]
[F-063] modules\apps\service-media-sonarr.nix | 4,16 KB | Tags: [Sonarr, types, factory, config, media]
[F-052] modules\apps\service-media-lidarr.nix | 4,16 KB | Tags: [Lidarr, types, factory, config, default]
[F-055] modules\apps\service-media-prowlarr.nix | 4,11 KB | Tags: [Prowlarr, types, factory, config, description]
[F-017] docs\superpowers\plans\2026-04-28-vector-logging-implementation.md | 4,07 KB | Tags: [Vector, Logging, modules, message, temp_mynixos]
[F-057] modules\apps\service-media-radarr.nix | 4,03 KB | Tags: [Radarr, config, types, factory, mkOption]
[F-056] modules\apps\service-media-radarr-setup.nix | 3,93 KB | Tags: [Radarr, Setup, ROOT_PATH, EXISTING, API_KEY]
[F-125] modules\services\vpn-confinement.nix | 3,90 KB | Tags: [nsName, netns, network, namespaces, accept]
[F-073] modules\core\defaults.nix | 3,89 KB | Tags: [types, default, mkOption, defaults, description]
[F-080] modules\core\kernel-slim.nix | 3,87 KB | Tags: [Kernel, mkForce, MODULES, false, hardening]
[F-072] modules\core\configs.nix | 3,80 KB | Tags: [types, default, mkOption, description, myLib]
[F-030] modules\apps\service-app-audiobookshelf.nix | 3,70 KB | Tags: [Audiobookshelf, config, default, mkOption, types]
[F-064] modules\apps\service-media-_lib.nix | 3,66 KB | Tags: [media, stateDir, srePaths, config, service]
[F-062] modules\apps\service-media-sonarr-setup.nix | 3,61 KB | Tags: [Sonarr, ROOT_PATH, Setup, FOLDER, API_KEY]
[F-042] modules\apps\service-app-olivetin.nix | 3,24 KB | Tags: [OliveTin, nixos, Socket, rebuild, systemd]
[F-043] modules\apps\service-app-paperless.nix | 3,22 KB | Tags: [Paperless, config, services, ENVIRONMENT, Valkey]
[F-023] hardware\q958\hardware-profile.nix | 3,22 KB | Tags: [Fragment, KERNEL, Power, Intel, storage]
[F-101] modules\logging\vector-tier-b.nix | 3,21 KB | Tags: [vector, total, logDir, Journald, config]
[F-050] modules\apps\service-media-jellyfin.nix | 3,18 KB | Tags: [Jellyfin, config, media, srePaths, Grade]
[F-089] modules\core\registry.nix | 3,09 KB | Tags: [enable, mkEnableOption, mkDefault, default, types]
[F-074] modules\core\fail2ban.nix | 3,08 KB | Tags: [Caddy, Fail2ban, config, filter, services]
[F-094] modules\core\ssh.nix | 3,08 KB | Tags: [config, Quantum, false, openssh, Grade]
[F-113] modules\services\homepage.nix | 3,03 KB | Tags: [dnsMap, dnsMapping, https, config, Homepage]
[F-068] modules\core\backup.nix | 3,02 KB | Tags: [Backup, Restic, config, Cloud, LIMIT]
[F-127] modules\storage\storage-mover.nix | 2,99 KB | Tags: [mover, SOURCE, TARGET, default, types]
[F-071] modules\core\config-merger.nix | 2,79 KB | Tags: [config, nixhome, userConfig, Merger, finalConfig]
[F-090] modules\core\secrets.nix | 2,70 KB | Tags: [config, Secrets, placeholder, sonarr_api_key, radarr_api_key]
[F-097] modules\core\system-stability.nix | 2,59 KB | Tags: [System, Kernel, efibootmgr, watchdog, Panic]
[F-098] modules\core\system.nix | 2,56 KB | Tags: [mkForce, System, Stateless, kernel, enable]
[F-006] .legacy_folders\10-infrastructure\tailscale-policy.current.hujson | 2,55 KB | Tags: [Example, users, devices, Tailscale, Define]
[F-018] docs\superpowers\specs\2026-04-27-00-core-foundation-design.md | 2,53 KB | Tags: [Funktion, mkService, helpers, Dateien, ports]
[F-099] modules\core\tty-info.nix | 2,47 KB | Tags: [system, config, target, description, local]
[F-111] modules\services\dns-automation.nix | 2,42 KB | Tags: [domain, Cloudflare, config, ZONE_ID, services]
[F-108] modules\services\cloudflared-tunnel.nix | 2,41 KB | Tags: [Tunnel, config, Cloudflare, default, tunnelId]
[F-041] modules\apps\service-app-navidrome.nix | 2,41 KB | Tags: [Navidrome, config, group, types, mkOption]
[F-085] modules\core\network.nix | 2,40 KB | Tags: [mkForce, enable, networking, systemd, config]
[F-015] docs\superpowers\plans\2026-04-28-persist-backup-implementation.md | 2,31 KB | Tags: [Restic, Persist, Backblaze, secrets, Backup]
[F-067] modules\core\auto-locale.nix | 2,25 KB | Tags: [COUNTRY, Locale, system, state, geolocation]
[F-116] modules\services\postgresql.nix | 2,21 KB | Tags: [PostgreSQL, services, paperless, miniflux, systemd]
[F-065] modules\apps\service-media-_servarr-factory.nix | 2,20 KB | Tags: [types, mkOption, default, value, false]
[F-005] README.md | 2,19 KB | Tags: [policy, Storage, Layer, Caddy, infrastructure]
[F-024] hardware\q958\README.md | 2,19 KB | Tags: [Hardware, Intel, Fujitsu, Physical, power]
[F-086] modules\core\nix-tuning.nix | 2,17 KB | Tags: [Binary, Fragment, cachix, TRUSTED, settings]
[F-047] modules\apps\service-app-vaultwarden.nix | 2,16 KB | Tags: [Vaultwarden, mkForce, config, Socket, services]
[F-022] hardware\q958\hardware-configuration.nix | 2,07 KB | Tags: [Hardware, Fujitsu, nct6775, sensors, config]
[F-115] modules\services\pocket-id.nix | 2,00 KB | Tags: [config, Pocket, identity, services, domain]
[F-092] modules\core\shell.nix | 1,98 KB | Tags: [nixos, config, programs, Shell, rebuild]
[F-139] users\moritz\home.nix | 1,98 KB | Tags: [Manager, config, Shell, environment, rebase]
[F-077] modules\core\home-manager.nix | 1,96 KB | Tags: [Manager, config, environment, Shell, programs]
[F-019] docs\superpowers\specs\2026-04-28-navidrome-integration-design.md | 1,96 KB | Tags: [Navidrome, Media, Stack, Beast, enable]
[F-093] modules\core\ssh-rescue.nix | 1,91 KB | Tags: [Rescue, config, instance, description, systemd]
[F-036] modules\apps\service-app-linkwarden.nix | 1,87 KB | Tags: [Linkwarden, services, config, domain, sandboxing]
[F-095] modules\core\storage.nix | 1,85 KB | Tags: [Storage, mergerfs, Media, config, description]
[F-037] modules\apps\service-app-matrix-conduit.nix | 1,83 KB | Tags: [Matrix, Conduit, config, services, mkForce]
[F-029] modules\apps\service-app-ai-tools.nix | 1,79 KB | Tags: [blesh, Tools, gemini, inshellisense, config]
[F-119] modules\services\service-netdata.nix | 1,77 KB | Tags: [Netdata, config, services, dbengine, mkForce]
[F-003] flake.lock | 1,70 KB | Tags: [nixpkgs, github, owner, manager, sha256]
[F-021] docs\superpowers\specs\2026-04-28-vector-logging-design.md | 1,68 KB | Tags: [Vector, Logging, masking, modules, server]
[F-122] modules\services\tailscale.nix | 1,68 KB | Tags: [Tailscale, services, config, status, tailscaled]
[F-027] modules\apps\media-stack.nix | 1,67 KB | Tags: [Media, srePaths, mediaLibrary, config, Layout]
[F-059] modules\apps\service-media-recyclarr.nix | 1,65 KB | Tags: [Recyclarr, config, Radarr, services, Sonarr]
[F-137] users\moritz\default.nix | 1,65 KB | Tags: [Users, media, security, config, group]
[F-075] modules\core\firewall.nix | 1,64 KB | Tags: [Firewall, lanCidr, accept, NFTables, config]
[F-002] configuration.nix | 1,62 KB | Tags: [modules, PROFILES, enable, inputs, users]
[F-096] modules\core\symbiosis.nix | 1,60 KB | Tags: [Hardware, config, ramGB, nixhome, cpuType]
[F-048] modules\apps\service-media-arr-wire.nix | 1,59 KB | Tags: [media, services, Namespace, useVPN, config]

Count Name SizeSum

 123 .nix 0,25 MB
 12 .md 0,06 MB
 2 .hujson 0,00 MB
 2 .yaml 0,01 MB
 1 0,00 MB
 1 .lock 0,00 MB

* Pfad: .sops.yaml | Format: .yaml | Größe: 282 B
``yaml
creation_rules:
 - path_regex: secrets\.yaml$
 key_groups:
 - age:
 - age1pjl6xt8zu80p4dpp6yqnk5u53ratgc58sdtnf7c2krlxyt8msgvs9s763s # Emergency Key (Moritz)
 - age1t2uu2un4trvvyhg7ryp8h8tqjxl5vnd0qd48dq4s8yvhc6jwtd4smyet95 # Server Host Key (q958)

``n---

* Pfad: configuration.nix | Format: .nix | Größe: 1,62 KB
``nix
{ lib, pkgs, config, inputs, myLib, ... }:
let

 nms = {
 id = "NIXH-00-SYS-ROOT-001";
 title = "Modular Entrypoint (Horizontal)";
 description = "New horizontal responsibility entrypoint. Decouples hardware, users, and common modules.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
in
{
 options.my.meta.configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [

 inputs.sops-nix.nixosModules.sops
 inputs.impermanence.nixosModules.impermanence

 ./modules/core/configs.nix
 ./modules/core/ports.nix
 ./modules/core/registry.nix
 ./modules/core/lib-helpers-meta.nix
 ./modules/core/secrets.nix
 ./modules/core/backup.nix

 ./profiles/base-server.nix
 ./profiles/media-beast.nix
 ./profiles/security-hardened.nix
 ./profiles/automation-apps.nix
 ./profiles/knowledge-apps.nix
 ./profiles/extra-apps.nix

 ./users/moritz/default.nix
 ./users/moritz/home.nix
 ];

 config = {
 system.stateVersion = "25.11";
 networking.hostName = "nixhome";

 my.services = {
 kernelSlim.enable = true;
 shell.premium.enable = true;
 storagePool.enable = true;
 caddy.enable = true;
 postgresql.enable = true;
 };
 };
}

``n---

* Pfad: flake.lock | Format: .lock | Größe: 1,70 KB
``lock
{
 "nodes": {
 "home-manager": {
 "inputs": {
 "nixpkgs": [
 "nixpkgs"
 ]
 },
 "locked": {
 "lastModified": 1772380125,
 "narHash": "sha256-8C+y46xA9bxcchj9GeDPJaRUDApaA3sy2fhJr1bTbUw=",
 "owner": "nix-community",
 "repo": "home-manager",
 "rev": "a07a44a839eb036e950bf397d9b782916f8dcab3",
 "type": "github"
 },
 "original": {
 "owner": "nix-community",
 "ref": "release-25.11",
 "repo": "home-manager",
 "type": "github"
 }
 },
 "nixpkgs": {
 "locked": {
 "lastModified": 1772047000,
 "narHash": "sha256-7DaQVv4R97cii/Qdfy4tmDZMB2xxtyIvNGSwXBBhSmo=",
 "owner": "nixos",
 "repo": "nixpkgs",
 "rev": "1267bb4920d0fc06ea916734c11b0bf004bbe17e",
 "type": "github"
 },
 "original": {
 "owner": "nixos",
 "ref": "nixos-25.11",
 "repo": "nixpkgs",
 "type": "github"
 }
 },
 "root": {
 "inputs": {
 "home-manager": "home-manager",
 "nixpkgs": "nixpkgs",
 "sops-nix": "sops-nix"
 }
 },
 "sops-nix": {
 "inputs": {
 "nixpkgs": [
 "nixpkgs"
 ]
 },
 "locked": {
 "lastModified": 1772401007,
 "narHash": "sha256-YHykQg0h9hrlZGpMcywnaFzQ1Kn/5YNCCOSaaAl6z7Q=",
 "owner": "Mic92",
 "repo": "sops-nix",
 "rev": "d8be5ea4cd3bc363492ab5bc6e874ccdc5465fe4",
 "type": "github"
 },
 "original": {
 "owner": "Mic92",
 "repo": "sops-nix",
 "type": "github"
 }
 }
 },
 "root": "root",
 "version": 7
}

``n---

* Pfad: flake.nix | Format: .nix | Größe: 1,43 KB
``nix
{
 description = "NixHome - hardened Horizontal Configuration";

 inputs = {
 nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

 sops-nix.url = "github:Mic92/sops-nix";
 sops-nix.inputs.nixpkgs.follows = "nixpkgs";

 home-manager.url = "github:nix-community/home-manager/release-25.11";
 home-manager.inputs.nixpkgs.follows = "nixpkgs";

 impermanence.url = "github:nix-community/impermanence";
 };

 outputs = { self, nixpkgs, ... }@inputs: let

 myLib = import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; pkgs = nixpkgs.legacyPackages.x86_64-linux; };

 specialArgs = { inherit inputs myLib; };
 in {
 nixosConfigurations = {

 nixhome = nixpkgs.lib.nixosSystem {
 system = "x86_64-linux";
 inherit specialArgs;
 modules = [
 ./hardware/q958/hardware-configuration.nix
 ./hardware/q958/hardware-profile.nix
 ./configuration.nix # Der horizontale Entrypoint
 ];
 };

 };
 };
}

``n---

* Pfad: README.md | Format: .md | Größe: 2,19 KB
``md
Willkommen in der **MetaBibliothek**. Dies ist die Single Source of Truth für das gesamte Wissen deines Fujitsu Q958 Homelabs. Sie vereint deine realen NixOS-Konfigurationen mit dem geistigen Erbe aus über 650 historischen Dokumenten (11.000+ Wissens-Chunks).

Jeder Ordner hier spiegelt exakt einen Layer in `/etc/nixos/` wider:

* **[00-core](./00-core/)**: Das Fundament. Sicherheit, Hardware-Profile (Q958), SSoT-Configs und Shell-Premium.
* **[10-infrastructure](./10-infrastructure/)**: Die Plattform. Caddy Edge Proxy, AdGuard DNS, Pocket-ID (SSO) und PostgreSQL.
* **[20-automation](./20-automation/)**: Intelligenz & Steuerung. Lokale KI (Ollama/Claude), Home-Assistant und n8n.
* **[30-media](./30-media/)**: Der Media-Stack. Jellyfin mit HW-Beschleunigung, *arr-Suite und ABC-Tiering Storage.
* **[40-knowledge](./40-knowledge/)**: Wissensmanagement. Paperless-ngx und RSS-Reader.
* **[50-apps](./50-apps/)**: Zusätzliche Web-Apps wie Vaultwarden, Monica und Matrix.
* **[80-analyse](./80-analyse/)**: Observability. Echtzeit-Monitoring mit Netdata und Scrutiny.
* **[90-policy](./90-policy/)**: Die Leitplanken. Binary-Only Policy und Sicherheits-Assertions.

Alle Dokumente folgen dem **NMS v2.3 Standard**. Jedes File enthält einen maschinenlesbaren Header:

```yaml
id: "NIXH-LAYER-CAT-NUM" # Eindeutige Identität
ref.code: "path/to.nix" # Direkte Verbindung zum echten Code
audit.doc_status: "enriched" # Status der Wissens-Anreicherung
```

* **[Master Config (SSoT)](./00-core/configs.md)**: Wer bin ich? (IPs, Domains, Quotas)
* **[Edge Proxy (Caddy)](./10-infrastructure/caddy.md)**: Wer darf rein? (Ingress, Geoblock, SSO)
* **[Storage Strategy](./00-core/storage.md)**: Wo liegen die Daten? (mergerfs, Tiering)
* **[Security Policy](./90-policy/security-assertions.md)**: Bin ich sicher? (Automatisierte Compliance)

*Generiert am 2026-03-02 Synthetisiert aus realem Code & historischem Wissen.*

``n---

* Pfad: .legacy_folders\10-infrastructure\tailscale-policy.current.hujson | Format: .hujson | Größe: 2,55 KB
``hujson
{

	"grants": [

		{
			"src": ["*"],
			"dst": ["*"],
			"ip": ["*"],
		},

	],

	"ssh": [

		{
			"action": "check",
			"src": ["autogroup:member"],
			"dst": ["autogroup:self"],
			"users": ["autogroup:nonroot", "root"],
		},
	],
	"nodeAttrs": [
		{

			"target": ["autogroup:member"],
			"attr": ["funnel"],
		},
	],

}

``n---

* Pfad: .legacy_folders\10-infrastructure\tailscale-policy.target.hujson | Format: .hujson | Größe: 1,05 KB
``hujson
{
 "tagOwners": {
 "tag:infra": ["autogroup:admin"],
 "tag:media": ["autogroup:admin"],
 "tag:admin": ["autogroup:admin"]
 },

 "grants": [
 {
 "src": ["autogroup:member"],
 "dst": ["autogroup:self"],
 "ip": ["*"]
 },
 {
 "src": ["moritz.baumeister@gmail.com"],
 "dst": ["tag:infra"],
 "ip": ["*"]
 },
 {
 "src": ["autogroup:admin"],
 "dst": ["tag:admin"],
 "ip": ["*"]
 }
 ],

 "ssh": [
 {
 "action": "check",
 "src": ["autogroup:member"],
 "dst": ["autogroup:self"],
 "users": ["autogroup:nonroot", "root"]
 }
 ],

 "tests": [
 {
 "src": "moritz.baumeister@gmail.com",
 "accept": ["tag:infra:22", "tag:infra:443"]
 },
 {
 "src": "not-allowed@example.com",
 "deny": ["tag:infra:22"]
 }
 ]
}

``n---

* Pfad: .legacy_folders\10-infrastructure\_imports.nix | Format: .nix | Größe: 440 B
``nix
{ ... }:
{
 imports = [
 ./adguardhome.nix
 ./caddy.nix
 ./clamav.nix
 ./cloudflared-tunnel.nix
 ./cockpit.nix
 ./ddns-updater.nix
 ./dns-automation.nix
 ./homepage.nix
 ./landing-zone-ui.nix
 ./pocket-id.nix
 ./postgresql.nix
 ./secret-ingest.nix
 ./sso.nix
 ./tailscale.nix
 ./uptime-kuma.nix
 ./valkey.nix
 ./vpn-confinement.nix
 ./vpn-live-config.nix
 ];
}

``n---

* Pfad: .legacy_folders\20-automation\service-app-open-webui.nix | Format: .nix | Größe: 1,43 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-20-SRV-011";
 title = "Open WebUI (SRE Hardened)";
 description = "User-friendly WebUI for LLMs, tightly sandboxed with DynamicUser.";
 layer = 20;
 nixpkgs.category = "services/misc";
 capabilities = [ "ai/ui" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.openWebui;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.open_webui = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for open-webui module";
 };

 config = lib.mkIf config.my.services.openWebui.enable {
 services.open-webui = {
 enable = true; host = "127.0.0.1"; port = port;
 environment = { OLLAMA_API_BASE_URL = "http://127.0.0.1:${toString config.my.ports.ollama}"; SCARF_NO_ANALYTICS = "True"; DO_NOT_TRACK = "True"; ANONYMIZED_TELEMETRY = "False"; };
 };
 services.caddy.virtualHosts."ai.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.open-webui.serviceConfig = { DynamicUser = true; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; SupplementaryGroups = [ "render" "video" ]; SystemCallFilter = [ "@system-service" "~@privileged" ]; OOMScoreAdjust = 200; };
 };
}

``n---

* Pfad: .legacy_folders\20-automation\_imports.nix | Format: .nix | Größe: 324 B
``nix
{ ... }:
{
 imports = [
 ./automation.nix
 ./service-app-ai-agents.nix
 ./service-app-home-assistant.nix
 ./service-app-karakeep.nix
 ./service-app-n8n.nix
 ./service-app-olivetin.nix
 ./service-app-open-webui.nix
 ./service-app-semaphore.nix
 ./service-app-zigbee-stack.nix
 ];
}

``n---

* Pfad: docs\MetaBibliothek | Format: .txt | Größe: 37 B
``txt
/home/moritz/documents/MetaBibliothek

``n---

* Pfad: docs\SPEC_REGISTRY.md | Format: .md | Größe: 27,09 KB
``md
Dieses Dokument ist die zentrale Master-Source für Traceability und Inspirationen.

> [!warning] SRE Audit Befunde (Stand 2026-03-02)
> * **CRITICAL BUG:** `PrivateDevices = true` in `jellyfin.nix` bricht das Hardware-Transcoding. (BEHOBEN in v4.0)
> * **ARCHITECTURAL GAP:** Fehlendes `mkEnableOption` Pattern. (BEHOBEN in v4.0 via registry.nix)
> * **DEPRECATION:** Deprecated Intel-Treiber entfernt. (BEHOBEN in v4.0)

| ID | Nix-Modul | Dokumentation (MetaBib) | Inspiration / Vorbild |
|---|---|---|---|
| NIXH-00-COR-001 | `00-core/.secrets-local.nix` | [.secrets-local.nix](../../home/moritz/documents/MetaBibliothek/00-core/.secrets-local.md) | [Link unten](#NIXH-00-COR-001) |
| NIXH-00-COR-002 | `00-core/ai-tools.nix` | [ai-tools.nix](../../home/moritz/documents/MetaBibliothek/00-core/ai-tools.md) | [Link unten](#NIXH-00-COR-002) |
| NIXH-00-COR-003 | `00-core/auto-locale.nix` | [auto-locale.nix](../../home/moritz/documents/MetaBibliothek/00-core/auto-locale.md) | [Link unten](#NIXH-00-COR-003) |
| NIXH-00-COR-004 | `00-core/backup.nix` | [backup.nix](../../home/moritz/documents/MetaBibliothek/00-core/backup.md) | [Link unten](#NIXH-00-COR-004) |
| NIXH-00-COR-005 | `00-core/boot-safeguard.nix` | [boot-safeguard.nix](../../home/moritz/documents/MetaBibliothek/00-core/boot-safeguard.md) | [Link unten](#NIXH-00-COR-005) |
| NIXH-00-COR-006 | `00-core/central-configs-plan.nix` | [central-configs-plan.nix](../../home/moritz/documents/MetaBibliothek/00-core/central-configs-plan.md) | [Link unten](#NIXH-00-COR-006) |
| NIXH-00-COR-007 | `00-core/config-merger.nix` | [config-merger.nix](../../home/moritz/documents/MetaBibliothek/00-core/config-merger.md) | [Link unten](#NIXH-00-COR-007) |
| NIXH-00-COR-008 | `00-core/configs.nix` | [configs.nix](../../home/moritz/documents/MetaBibliothek/00-core/configs.md) | [Link unten](#NIXH-00-COR-008) |
| NIXH-00-COR-009 | `00-core/defaults.nix` | [defaults.nix](../../home/moritz/documents/MetaBibliothek/00-core/defaults.md) | [Link unten](#NIXH-00-COR-009) |
| NIXH-00-COR-010 | `00-core/fail2ban.nix` | [fail2ban.nix](../../home/moritz/documents/MetaBibliothek/00-core/fail2ban.md) | [Link unten](#NIXH-00-COR-010) |
| NIXH-00-COR-011 | `00-core/firewall.nix` | [firewall.nix](../../home/moritz/documents/MetaBibliothek/00-core/firewall.md) | [Link unten](#NIXH-00-COR-011) |
| NIXH-00-COR-012 | `00-core/hardware-configuration.nix` | [hardware-configuration.nix](../../home/moritz/documents/MetaBibliothek/00-core/hardware-configuration.md) | [Link unten](#NIXH-00-COR-012) |
| NIXH-00-COR-013 | `00-core/home-manager.nix` | [home-manager.nix](../../home/moritz/documents/MetaBibliothek/00-core/home-manager.md) | [Link unten](#NIXH-00-COR-013) |
| NIXH-00-COR-014 | `00-core/host-q958-hardware-configuration.nix` | [host-q958-hardware-configuration.nix](../../home/moritz/documents/MetaBibliothek/00-core/host-q958-hardware-configuration.md) | [Link unten](#NIXH-00-COR-014) |
| NIXH-00-COR-015 | `00-core/host-q958-hardware-profile.nix` | [host-q958-hardware-profile.nix](../../home/moritz/documents/MetaBibliothek/00-core/host-q958-hardware-profile.md) | [Link unten](#NIXH-00-COR-015) |
| NIXH-00-COR-016 | `00-core/host.nix` | [host.nix](../../home/moritz/documents/MetaBibliothek/00-core/host.md) | [Link unten](#NIXH-00-COR-016) |
| NIXH-00-COR-017 | `00-core/kernel-slim.nix` | [kernel-slim.nix](../../home/moritz/documents/MetaBibliothek/00-core/kernel-slim.md) | [Link unten](#NIXH-00-COR-017) |
| NIXH-00-COR-018 | `00-core/lib-helpers-meta.nix` | [lib-helpers-meta.nix](../../home/moritz/documents/MetaBibliothek/00-core/lib-helpers-meta.md) | [Link unten](#NIXH-00-COR-018) |
| NIXH-00-COR-019 | `00-core/lib-helpers.nix` | [lib-helpers.nix](../../home/moritz/documents/MetaBibliothek/00-core/lib-helpers.md) | [Link unten](#NIXH-00-COR-019) |
| NIXH-00-COR-020 | `00-core/locale.nix` | [locale.nix](../../home/moritz/documents/MetaBibliothek/00-core/locale.md) | [Link unten](#NIXH-00-COR-020) |
| NIXH-00-COR-021 | `00-core/logging.nix` | [logging.nix](../../home/moritz/documents/MetaBibliothek/00-core/logging.md) | [Link unten](#NIXH-00-COR-021) |
| NIXH-00-COR-022 | `00-core/motd.nix` | [motd.nix](../../home/moritz/documents/MetaBibliothek/00-core/motd.md) | [Link unten](#NIXH-00-COR-022) |
| NIXH-00-COR-023 | `00-core/network.nix` | [network.nix](../../home/moritz/documents/MetaBibliothek/00-core/network.md) | [Link unten](#NIXH-00-COR-023) |
| NIXH-00-COR-024 | `00-core/nix-tuning.nix` | [nix-tuning.nix](../../home/moritz/documents/MetaBibliothek/00-core/nix-tuning.md) | [Link unten](#NIXH-00-COR-024) |
| NIXH-00-COR-025 | `00-core/ports.nix` | [ports.nix](../../home/moritz/documents/MetaBibliothek/00-core/ports.md) | [Link unten](#NIXH-00-COR-025) |
| NIXH-00-COR-026 | `00-core/principles.nix` | [principles.nix](../../home/moritz/documents/MetaBibliothek/00-core/principles.md) | [Link unten](#NIXH-00-COR-026) |
| NIXH-00-COR-027 | `00-core/registry.nix` | [registry.nix](../../home/moritz/documents/MetaBibliothek/00-core/registry.md) | [Link unten](#NIXH-00-COR-027) |
| NIXH-00-COR-028 | `00-core/secrets.nix` | [secrets.nix](../../home/moritz/documents/MetaBibliothek/00-core/secrets.md) | [Link unten](#NIXH-00-COR-028) |
| NIXH-00-COR-029 | `00-core/shell-premium.nix` | [shell-premium.nix](../../home/moritz/documents/MetaBibliothek/00-core/shell-premium.md) | [Link unten](#NIXH-00-COR-029) |
| NIXH-00-COR-030 | `00-core/shell.nix` | [shell.nix](../../home/moritz/documents/MetaBibliothek/00-core/shell.md) | [Link unten](#NIXH-00-COR-030) |
| NIXH-00-COR-031 | `00-core/ssh-rescue.nix` | [ssh-rescue.nix](../../home/moritz/documents/MetaBibliothek/00-core/ssh-rescue.md) | [Link unten](#NIXH-00-COR-031) |
| NIXH-00-COR-032 | `00-core/ssh.nix` | [ssh.nix](../../home/moritz/documents/MetaBibliothek/00-core/ssh.md) | [Link unten](#NIXH-00-COR-032) |
| NIXH-00-COR-033 | `00-core/symbiosis.nix` | [symbiosis.nix](../../home/moritz/documents/MetaBibliothek/00-core/symbiosis.md) | [Link unten](#NIXH-00-COR-033) |
| NIXH-00-COR-034 | `00-core/system-stability.nix` | [system-stability.nix](../../home/moritz/documents/MetaBibliothek/00-core/system-stability.md) | [Link unten](#NIXH-00-COR-034) |
| NIXH-00-COR-035 | `00-core/system.nix` | [system.nix](../../home/moritz/documents/MetaBibliothek/00-core/system.md) | [Link unten](#NIXH-00-COR-035) |
| NIXH-00-COR-036 | `00-core/tty-info.nix` | [tty-info.nix](../../home/moritz/documents/MetaBibliothek/00-core/tty-info.md) | [Link unten](#NIXH-00-COR-036) |
| NIXH-00-COR-037 | `00-core/user-moritz-home.nix` | [user-moritz-home.nix](../../home/moritz/documents/MetaBibliothek/00-core/user-moritz-home.md) | [Link unten](#NIXH-00-COR-037) |
| NIXH-00-COR-038 | `00-core/user-preferences.nix` | [user-preferences.nix](../../home/moritz/documents/MetaBibliothek/00-core/user-preferences.md) | [Link unten](#NIXH-00-COR-038) |
| NIXH-00-COR-039 | `00-core/users.nix` | [users.nix](../../home/moritz/documents/MetaBibliothek/00-core/users.md) | [Link unten](#NIXH-00-COR-039) |
| NIXH-00-COR-040 | `00-core/zram-swap.nix` | [zram-swap.nix](../../home/moritz/documents/MetaBibliothek/00-core/zram-swap.md) | [Link unten](#NIXH-00-COR-040) |
| NIXH-10-GTW-001 | `10-gateway/adguardhome.nix` | [adguardhome.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/adguardhome.md) | [Link unten](#NIXH-10-GTW-001) |
| NIXH-10-GTW-002 | `10-gateway/caddy.nix` | [caddy.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/caddy.md) | [Link unten](#NIXH-10-GTW-002) |
| NIXH-10-GTW-003 | `10-gateway/cloudflared-tunnel.nix` | [cloudflared-tunnel.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/cloudflared-tunnel.md) | [Link unten](#NIXH-10-GTW-003) |
| NIXH-10-GTW-004 | `10-gateway/ddns-updater.nix` | [ddns-updater.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/ddns-updater.md) | [Link unten](#NIXH-10-GTW-004) |
| NIXH-10-GTW-005 | `10-gateway/dns-automation.nix` | [dns-automation.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/dns-automation.md) | [Link unten](#NIXH-10-GTW-005) |
| NIXH-10-GTW-006 | `10-gateway/dns-map.nix` | [dns-map.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/dns-map.md) | [Link unten](#NIXH-10-GTW-006) |
| NIXH-10-GTW-007 | `10-gateway/homepage.nix` | [homepage.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/homepage.md) | [Link unten](#NIXH-10-GTW-007) |
| NIXH-10-GTW-008 | `10-gateway/landing-zone-ui.nix` | [landing-zone-ui.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/landing-zone-ui.md) | [Link unten](#NIXH-10-GTW-008) |
| NIXH-10-GTW-009 | `10-gateway/pocket-id.nix` | [pocket-id.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/pocket-id.md) | [Link unten](#NIXH-10-GTW-009) |
| NIXH-10-GTW-010 | `10-gateway/sso.nix` | [sso.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/sso.md) | [Link unten](#NIXH-10-GTW-010) |
| NIXH-10-GTW-011 | `10-gateway/tailscale.nix` | [tailscale.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/tailscale.md) | [Link unten](#NIXH-10-GTW-011) |
| NIXH-20-INF-001 | `20-infrastructure/clamav.nix` | [clamav.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/clamav.md) | [Link unten](#NIXH-20-INF-001) |
| NIXH-20-INF-002 | `20-infrastructure/postgresql.nix` | [postgresql.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/postgresql.md) | [Link unten](#NIXH-20-INF-002) |
| NIXH-20-INF-003 | `20-infrastructure/secret-ingest.nix` | [secret-ingest.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/secret-ingest.md) | [Link unten](#NIXH-20-INF-003) |
| NIXH-20-INF-004 | `20-infrastructure/service-app-zigbee-stack.nix` | [service-app-zigbee-stack.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/service-app-zigbee-stack.md) | [Link unten](#NIXH-20-INF-004) |
| NIXH-20-INF-005 | `20-infrastructure/storage.nix` | [storage.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/storage.md) | [Link unten](#NIXH-20-INF-005) |
| NIXH-20-INF-006 | `20-infrastructure/valkey.nix` | [valkey.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/valkey.md) | [Link unten](#NIXH-20-INF-006) |
| NIXH-20-INF-007 | `20-infrastructure/vpn-confinement.nix` | [vpn-confinement.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/vpn-confinement.md) | [Link unten](#NIXH-20-INF-007) |
| NIXH-20-INF-008 | `20-infrastructure/vpn-live-config.nix` | [vpn-live-config.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/vpn-live-config.md) | [Link unten](#NIXH-20-INF-008) |
| NIXH-30-AUT-001 | `30-automation/automation.nix` | [automation.nix](../../home/moritz/documents/MetaBibliothek/30-automation/automation.md) | [Link unten](#NIXH-30-AUT-001) |
| NIXH-30-AUT-002 | `30-automation/service-app-ai-agents.nix` | [service-app-ai-agents.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-ai-agents.md) | [Link unten](#NIXH-30-AUT-002) |
| NIXH-30-AUT-003 | `30-automation/service-app-home-assistant.nix` | [service-app-home-assistant.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-home-assistant.md) | [Link unten](#NIXH-30-AUT-003) |
| NIXH-30-AUT-004 | `30-automation/service-app-n8n.nix` | [service-app-n8n.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-n8n.md) | [Link unten](#NIXH-30-AUT-004) |
| NIXH-30-AUT-005 | `30-automation/service-app-olivetin.nix` | [service-app-olivetin.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-olivetin.md) | [Link unten](#NIXH-30-AUT-005) |
| NIXH-30-AUT-006 | `30-automation/service-app-semaphore.nix` | [service-app-semaphore.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-semaphore.md) | [Link unten](#NIXH-30-AUT-006) |
| NIXH-40-MED-001 | `40-media/media-stack.nix` | [media-stack.nix](../../home/moritz/documents/MetaBibliothek/40-media/media-stack.md) | [Link unten](#NIXH-40-MED-001) |
| NIXH-40-MED-002 | `40-media/service-app-audiobookshelf.nix` | [service-app-audiobookshelf.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-app-audiobookshelf.md) | [Link unten](#NIXH-40-MED-002) |
| NIXH-40-MED-003 | `40-media/service-media-_lib.nix` | [service-media-_lib.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-_lib.md) | [Link unten](#NIXH-40-MED-003) |
| NIXH-40-MED-004 | `40-media/service-media-_servarr-factory.nix` | [service-media-_servarr-factory.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-_servarr-factory.md) | [Link unten](#NIXH-40-MED-004) |
| NIXH-40-MED-005 | `40-media/service-media-arr-wire.nix` | [service-media-arr-wire.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-arr-wire.md) | [Link unten](#NIXH-40-MED-005) |
| NIXH-40-MED-006 | `40-media/service-media-default.nix` | [service-media-default.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-default.md) | [Link unten](#NIXH-40-MED-006) |
| NIXH-40-MED-007 | `40-media/service-media-jellyfin.nix` | [service-media-jellyfin.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-jellyfin.md) | [Link unten](#NIXH-40-MED-007) |
| NIXH-40-MED-008 | `40-media/service-media-jellyseerr.nix` | [service-media-jellyseerr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-jellyseerr.md) | [Link unten](#NIXH-40-MED-008) |
| NIXH-40-MED-009 | `40-media/service-media-lidarr.nix` | [service-media-lidarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-lidarr.md) | [Link unten](#NIXH-40-MED-009) |
| NIXH-40-MED-010 | `40-media/service-media-media-stack.nix` | [service-media-media-stack.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-media-stack.md) | [Link unten](#NIXH-40-MED-010) |
| NIXH-40-MED-011 | `40-media/service-media-prowlarr.nix` | [service-media-prowlarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-prowlarr.md) | [Link unten](#NIXH-40-MED-011) |
| NIXH-40-MED-012 | `40-media/service-media-radarr.nix` | [service-media-radarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-radarr.md) | [Link unten](#NIXH-40-MED-012) |
| NIXH-40-MED-013 | `40-media/service-media-readarr.nix` | [service-media-readarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-readarr.md) | [Link unten](#NIXH-40-MED-013) |
| NIXH-40-MED-014 | `40-media/service-media-recyclarr.nix` | [service-media-recyclarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-recyclarr.md) | [Link unten](#NIXH-40-MED-014) |
| NIXH-40-MED-015 | `40-media/service-media-sabnzbd.nix` | [service-media-sabnzbd.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-sabnzbd.md) | [Link unten](#NIXH-40-MED-015) |
| NIXH-40-MED-016 | `40-media/service-media-services-common.nix` | [service-media-services-common.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-services-common.md) | [Link unten](#NIXH-40-MED-016) |
| NIXH-40-MED-017 | `40-media/service-media-sonarr.nix` | [service-media-sonarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-sonarr.md) | [Link unten](#NIXH-40-MED-017) |
| NIXH-50-KNW-001 | `50-knowledge/service-app-linkding.nix` | [service-app-linkding.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-linkding.md) | [Link unten](#NIXH-50-KNW-001) |
| NIXH-50-KNW-002 | `50-knowledge/service-app-miniflux.nix` | [service-app-miniflux.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-miniflux.md) | [Link unten](#NIXH-50-KNW-002) |
| NIXH-50-KNW-003 | `50-knowledge/service-app-paperless.nix` | [service-app-paperless.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-paperless.md) | [Link unten](#NIXH-50-KNW-003) |
| NIXH-50-KNW-004 | `50-knowledge/service-app-readeck.nix` | [service-app-readeck.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-readeck.md) | [Link unten](#NIXH-50-KNW-004) |
| NIXH-60-APP-001 | `60-apps/SERVICE_TEMPLATE.nix` | [SERVICE_TEMPLATE.nix](../../home/moritz/documents/MetaBibliothek/60-apps/SERVICE_TEMPLATE.md) | [Link unten](#NIXH-60-APP-001) |
| NIXH-60-APP-002 | `60-apps/service-app-couchdb.nix` | [service-app-couchdb.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-couchdb.md) | [Link unten](#NIXH-60-APP-002) |
| NIXH-60-APP-003 | `60-apps/service-app-filebrowser.nix` | [service-app-filebrowser.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-filebrowser.md) | [Link unten](#NIXH-60-APP-003) |
| NIXH-60-APP-004 | `60-apps/service-app-karakeep.nix` | [service-app-karakeep.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-karakeep.md) | [Link unten](#NIXH-60-APP-004) |
| NIXH-60-APP-005 | `60-apps/service-app-matrix-conduit.nix` | [service-app-matrix-conduit.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-matrix-conduit.md) | [Link unten](#NIXH-60-APP-005) |
| NIXH-60-APP-006 | `60-apps/service-app-monica.nix` | [service-app-monica.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-monica.md) | [Link unten](#NIXH-60-APP-006) |
| NIXH-60-APP-007 | `60-apps/service-app-vaultwarden.nix` | [service-app-vaultwarden.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-vaultwarden.md) | [Link unten](#NIXH-60-APP-007) |
| NIXH-80-MON-001 | `80-monitoring/cockpit.nix` | [cockpit.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/cockpit.md) | [Link unten](#NIXH-80-MON-001) |
| NIXH-80-MON-002 | `80-monitoring/service-netdata.nix` | [service-netdata.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/service-netdata.md) | [Link unten](#NIXH-80-MON-002) |
| NIXH-80-MON-003 | `80-monitoring/service-scrutiny.nix` | [service-scrutiny.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/service-scrutiny.md) | [Link unten](#NIXH-80-MON-003) |
| NIXH-80-MON-004 | `80-monitoring/uptime-kuma.nix` | [uptime-kuma.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/uptime-kuma.md) | [Link unten](#NIXH-80-MON-004) |
| NIXH-90-POL-001 | `90-policy/binary-only.nix` | [binary-only.nix](../../home/moritz/documents/MetaBibliothek/90-policy/binary-only.md) | [Link unten](#NIXH-90-POL-001) |
| NIXH-90-POL-002 | `90-policy/flat-layout.nix` | [flat-layout.nix](../../home/moritz/documents/MetaBibliothek/90-policy/flat-layout.md) | [Link unten](#NIXH-90-POL-002) |
| NIXH-90-POL-003 | `90-policy/no-legacy.nix` | [no-legacy.nix](../../home/moritz/documents/MetaBibliothek/90-policy/no-legacy.md) | [Link unten](#NIXH-90-POL-003) |
| NIXH-90-POL-004 | `90-policy/security-assertions.nix` | [security-assertions.nix](../../home/moritz/documents/MetaBibliothek/90-policy/security-assertions.md) | [Link unten](#NIXH-90-POL-004) |

- [ryan4yin/nix-config (Secrets)](https://github.com/ryan4yin/nix-config/tree/main/hosts/common/core/sops.nix)
- [Mic92/sops-nix](https://github.com/Mic92/sops-nix)

- [NixOS Search: ai-tools](https://search.nixos.org/packages?query=ollama)

- [NixOS Manual: Localization](https://nixos.org/manual/nixos/stable/#ch-localization)

- [NixOS Search: restic](https://search.nixos.org/options?query=services.restic)
- [ironicbadger/infra (Backup)](https://github.com/ironicbadger/infra/blob/master/nixos/backup.nix)

- [mitchellh/nixos-config (Boot)](https://github.com/mitchellh/nixos-config/blob/main/system/boot.nix)

- [Architecture Blueprint](https://nixos.wiki/wiki/Module)

- [JSON Nix Integration](https://nixos.org/manual/nix/stable/expressions/builtins.html#builtins-fromJSON)

- [Global Options Pattern](https://nixos.wiki/wiki/NixOS_modules#Options)

- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)

- [NixOS Search: fail2ban](https://search.nixos.org/options?query=services.fail2ban)

- [NixOS Manual: Firewall](https://nixos.org/manual/nixos/stable/#sec-firewall)

- [NixOS Hardware (GitHub)](https://github.com/NixOS/nixos-hardware)

- [nix-community/home-manager](https://github.com/nix-community/home-manager)

- [IronicBadger: Kernel Hardening](https://github.com/ironicbadger/infra/blob/master/nixos/kernel.nix)

- [NixOS Manual: Networkd](https://nixos.org/manual/nixos/stable/#sec-systemd-networkd)

- [NixOS Wiki: Storage optimization](https://nixos.wiki/wiki/Storage_optimization)

- [Modular Design Patterns](https://github.com/ryan4yin/nix-config)

- [Mic92/sops-nix Examples](https://github.com/Mic92/sops-nix/tree/master/examples)

- [ryan4yin/nix-config (Shell)](https://github.com/ryan4yin/nix-config/tree/main/modules/nixos/base/shell)

- [NixOS Search: adguardhome](https://search.nixos.org/options?query=services.adguardhome)

- [ironicbadger/infra (Caddy)](https://github.com/ironicbadger/infra/blob/master/nixos/caddy.nix)
- [Caddy Docs: Docker Proxy Pattern](https://caddyserver.com/docs/quick-start/reverse-proxy)

- [NixOS Search: cloudflared](https://search.nixos.org/options?query=services.cloudflared)

- [Upstream: qdm12/ddns-updater](https://github.com/qdm12/ddns-updater)

- [gethomepage/homepage](https://github.com/gethomepage/homepage)

- [pocket-id/pocket-id](https://github.com/pocket-id/pocket-id)

- [tailscale/tailscale](https://github.com/tailscale/tailscale)
- [NixOS Wiki: Tailscale](https://nixos.wiki/wiki/Tailscale)

- [NixOS Manual: PostgreSQL](https://nixos.org/manual/nixos/stable/#module-services-postgres)

- [zigbee2mqtt/zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)

- [mergerfs GitHub](https://github.com/trapexit/mergerfs)
- [IronicBadger: Perfect Media Server](https://github.com/ironicbadger/book-perfectmediaserver)

- [valkey-io/valkey](https://github.com/valkey-io/valkey)

- [Maroka-chan/VPN-Confinement](https://github.com/Maroka-chan/VPN-Confinement)

- [home-assistant/core](https://github.com/home-assistant/core)

- [n8n-io/n8n](https://github.com/n8n-io/n8n)

- [OliveTin/OliveTin](https://github.com/OliveTin/OliveTin)

- [ansible-semaphore/semaphore](https://github.com/ansible-semaphore/semaphore)

- [nix-media-server/nixarr](https://github.com/nix-media-server/nixarr)
- [kiriwalawren/nixflix](https://github.com/kiriwalawren/nixflix)

- [advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf)

- [jellyfin/jellyfin](https://github.com/jellyfin/jellyfin)

- [Fallenbagel/jellyseerr](https://github.com/Fallenbagel/jellyseerr)

- [Lidarr/Lidarr](https://github.com/Lidarr/Lidarr)

- [Prowlarr/Prowlarr](https://github.com/Prowlarr/Prowlarr)

- [Radarr/Radarr](https://github.com/Radarr/Radarr)

- [Readarr/Readarr](https://github.com/Readarr/Readarr)

- [recyclarr/recyclarr](https://github.com/recyclarr/recyclarr)

- [sabnzbd/sabnzbd](https://github.com/sabnzbd/sabnzbd)

- [Sonarr/Sonarr](https://github.com/Sonarr/Sonarr)

- [sissis/linkding](https://github.com/sissis/linkding)

- [miniflux/v2](https://github.com/miniflux/v2)

- [paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)

- [readeck/readeck](https://github.com/readeck/readeck)

- [karakeep-app/karakeep](https://github.com/karakeep-app/karakeep)

- [girlbossceo/conduit](https://github.com/girlbossceo/conduit)

- [monicahq/monica](https://github.com/monicahq/monica)

- [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)

- [cockpit-project/cockpit](https://github.com/cockpit-project/cockpit)

- [netdata/netdata](https://github.com/netdata/netdata)

- [AnalogJ/scrutiny](https://github.com/AnalogJ/scrutiny)

- [louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)

- [NixOS Wiki: Binary Cache](https://nixos.wiki/wiki/Binary_Cache)

- [NixOS Wiki: Hardening](https://nixos.wiki/wiki/Hardening)

``n---

* Pfad: docs\superpowers\plans\2026-04-27-00-core-refactoring.md | Format: .md | Größe: 6,44 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Konsolidierung des `00-core` Layers (Hardware, SSoT-Register, mkService-Fabrik und Traceability), um eine unerschütterliche Basis für alle höheren Layer zu schaffen.

**Architecture:** Refactoring der Basis-Nix-Module. Zentralisierung von Ports in `ports.nix`, globaler Settings in `configs.nix` und Ausbau von `lib-helpers.nix` (`mkService`), um Boilerplate in Layern 10-90 zu eliminieren. Hardware-Profile werden vereinfacht.

**Tech Stack:** NixOS, Nix Language, Systemd

**Files:**
- Modify: `temp_mynixos/00-core/host-q958-hardware-profile.nix`
- Modify: `temp_mynixos/00-core/boot-safeguard.nix`

- [ ] **Step 1: Clean up hardware profile**

Optimiere das Hardware-Profile für den Q958. Entferne veraltete oder doppelte Einträge und stelle sicher, dass Intel QuickSync/VA-API geladen werden.

```nix

{ config, lib, pkgs, ... }:
{
 hardware.graphics = {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver
 intel-vaapi-driver
 libvdpau-va-gl
 ];
 };
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```

- [ ] **Step 2: Streamline boot safeguard**

Sorge dafür, dass `boot-safeguard.nix` nur die allernötigsten Boot-Parameter enthält, ohne das System zu überladen.

```nix

{ config, lib, ... }:
{
 boot.loader.systemd-boot.enable = true;
 boot.loader.efi.canTouchEfiVariables = true;
 boot.kernelParams = [ "quiet" "loglevel=3" ];
 boot.tmp.cleanOnBoot = true;
}
```

- [ ] **Step 3: Test evaluation**

Run: `nix-instantiate --eval -E 'with import <nixpkgs> { }; 1'` (Or run `nix flake check` if a flake is present, just a basic syntax check).
Expected: No syntax errors in the modified files.

- [ ] **Step 4: Commit**

```bash
git add temp_mynixos/00-core/host-q958-hardware-profile.nix temp_mynixos/00-core/boot-safeguard.nix
git commit -m "refactor(core): consolidate hardware and boot configurations"
```

**Files:**
- Modify: `temp_mynixos/00-core/ports.nix`
- Modify: `temp_mynixos/00-core/configs.nix`

- [ ] **Step 1: Enforce complete port registry**

Stelle sicher, dass `ports.nix` alle Ports als SSoT exportiert.

```nix

{ lib, ... }:
{
 options.my.ports = lib.mkOption {
 type = lib.types.attrsOf lib.types.port;
 default = {
 vaultwarden = 8222;
 jellyfin = 8096;
 paperless = 28981;

 };
 description = "Central port registry (SSoT)";
 };
}
```

- [ ] **Step 2: Define global configs**

Zentralisiere Domain und LAN-IPs in `configs.nix`.

```nix

{ lib, ... }:
{
 options.my.configs = {
 identity = {
 domain = lib.mkOption { type = lib.types.str; default = "m7c5.de"; };
 subdomain = lib.mkOption { type = lib.types.str; default = "nix"; };
 };
 server = {
 lanIP = lib.mkOption { type = lib.types.str; default = "192.168.2.73"; };
 };
 };
}
```

- [ ] **Step 3: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/ports.nix temp_mynixos/00-core/configs.nix`
Expected: Silent return (no errors).

- [ ] **Step 4: Commit**

```bash
git add temp_mynixos/00-core/ports.nix temp_mynixos/00-core/configs.nix
git commit -m "feat(core): centralize SSoT registries for ports and configs"
```

**Files:**
- Modify: `temp_mynixos/00-core/lib-helpers.nix`

- [ ] **Step 1: Enhance mkService for standard reverse proxy routing**

Erweitere `mkService` so, dass es Systemd-Sandboxing und Caddy-Reverse-Proxy-Logik nahtlos kapselt.

```nix

{ lib, ... }:
let

 getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
in {
 mkService = { config, name, port ? null, useSSO ? true, description ? "Managed Service", netns ? null }:
 let
 finalPort = if port != null then port else config.my.ports.${name};
 targetUrl = "http://${if netns != null then "10.200.1.2" else "127.0.0.1"}:${toString finalPort}";
 hostName = getDomain config name;
 in {
 systemd.services.${name}.serviceConfig = {
 Description = description;
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 };

 services.caddy.virtualHosts.${hostName}.extraConfig = ''
 ${lib.optionalString useSSO "import sso_auth"}
 reverse_proxy ${targetUrl}
 '';
 };
}
```

- [ ] **Step 2: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/lib-helpers.nix`
Expected: Silent return (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/00-core/lib-helpers.nix
git commit -m "feat(core): expand mkService factory for unified service definitions"
```

**Files:**
- Modify: `temp_mynixos/00-core/lib-helpers-meta.nix`

- [ ] **Step 1: Define NMS metadata schema**

Implementiere das NMS (NixOS Management System) Metadaten-Schema, um Traceability für Audits sicherzustellen.

```nix

{ lib, ... }:
{
 options.my.meta = lib.mkOption {
 type = lib.types.attrsOf (lib.types.submodule {
 options = {
 id = lib.mkOption { type = lib.types.str; };
 title = lib.mkOption { type = lib.types.str; };
 layer = lib.mkOption { type = lib.types.int; };
 audit.last_reviewed = lib.mkOption { type = lib.types.str; };
 };
 });
 default = {};
 description = "NMS Traceability Metadata";
 };
}
```

- [ ] **Step 2: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/lib-helpers-meta.nix`
Expected: Silent return (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/00-core/lib-helpers-meta.nix
git commit -m "feat(core): implement NMS metadata schema for traceability"
```

``n---

* Pfad: docs\superpowers\plans\2026-04-28-navidrome-integration.md | Format: .md | Größe: 4,55 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate Navidrome music server using the `mkStreamer` factory with ABC-Tiering and SSO.

**Architecture:** Horizontal module pattern (v5.0). Uses `myLib.mkStreamer` for standard hardening, Caddy reverse proxy, and systemd sandboxing.

**Tech Stack:** NixOS, Navidrome, Caddy.

**Files:**
- Create: `temp_mynixos/modules/apps/service-app-navidrome.nix`

- [ ] **Step 1: Write the module code**

```nix
{ config, lib, pkgs, myLib, ... }:
let
 nms = {
 id = "NIXH-01-APP-NAV-001";
 title = "Navidrome (hardened Music Server)";
 layer = 40;
 audit.last_reviewed = "2026-04-28";
 };
 cfg = config.my.apps.navidrome;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;
in
{
 options.my.apps.navidrome = {
 enable = lib.mkEnableOption "Navidrome Music Server";
 user = lib.mkOption { type = lib.types.str; default = "navidrome"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.navidrome or 4533; };
 stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/navidrome"; };
 cacheDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/cache/navidrome"; };
 musicDir = lib.mkOption { type = lib.types.str; default = "${srePaths.mediaLibrary}/music"; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "navidrome";
 port = cfg.port;
 useGPU = false;
 memoryMax = "1G";
 cpuWeight = 60;
 description = "Navidrome Music Streaming";
 })

 {
 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };

 services.navidrome = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 address = "127.0.0.1";
 port = cfg.port;
 musicFolder = cfg.musicDir;
 dataFolder = cfg.stateDir;
 cacheFolder = cfg.cacheDir;
 settings.EnableSubsonicApi = true;
 };

 services.caddy.virtualHosts."music.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" =
 config.services.caddy.virtualHosts."navidrome.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.navidrome.serviceConfig.ReadOnlyPaths = [ cfg.musicDir ];

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist".directories = [
 "/var/lib/navidrome"
 ];
 }
 ]);
}
```

- [ ] **Step 2: Verify syntax (Dry Run)**

Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-navidrome.nix`
Expected: File content printed (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/apps/service-app-navidrome.nix
git commit -m "feat(apps): add navidrome service module with mkStreamer"
```

**Files:**
- Modify: `temp_mynixos/modules/apps/media-stack.nix`

- [ ] **Step 1: Add navidrome to media group members**

Add `"navidrome"` to the list in `users.groups.media.members`.

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/apps/media-stack.nix
git commit -m "chore(media): add navidrome user to shared media group"
```

**Files:**
- Modify: `temp_mynixos/profiles/media-beast.nix`

- [ ] **Step 1: Add import for navidrome module**

Add `../modules/apps/service-app-navidrome.nix` to `imports`.

- [ ] **Step 2: Enable the service**

Add `my.apps.navidrome.enable = true;` to the config.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/profiles/media-beast.nix
git commit -m "feat(profile): activate navidrome in media-beast profile"
```

- [ ] **Step 1: Run Flake Check**

Run: `nix flake check temp_mynixos/`
Expected: SUCCESS

- [ ] **Step 2: Update Project Log**

Update `GEMINI.md` to mark Navidrome as DONE.

``n---

* Pfad: docs\superpowers\plans\2026-04-28-persist-backup-implementation.md | Format: .md | Größe: 2,31 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a secondary Restic job for `/persist` targeting Backblaze B2.

**Architecture:** Extended `restic.backups` with Sops secret injection.

**Tech Stack:** NixOS, Restic, Sops, Backblaze B2.

**Files:**
- Modify: `temp_mynixos/modules/core/secrets.nix`

- [ ] **Step 1: Add secret definitions**

Add `restic_password`, `backblaze_access_key`, and `backblaze_secret_key` to `sops.secrets`.

- [ ] **Step 2: Add Sops Template for Restic Env**

Add `templates."backblaze-restic.env"` to provide `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

```nix
 templates."backblaze-restic.env" = {
 owner = "root";
 mode = "0400";
 content = ''
 AWS_ACCESS_KEY_ID="${config.sops.placeholder.backblaze_access_key}"
 AWS_SECRET_ACCESS_KEY="${config.sops.placeholder.backblaze_secret_key}"
 '';
 };
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/secrets.nix
git commit -m "chore(secrets): add backblaze and restic secret definitions"
```

**Files:**
- Modify: `temp_mynixos/modules/core/backup.nix`

- [ ] **Step 1: Add the 'persist' job**

```nix
 services.restic.backups.persist = {
 initialize = true;
 repository = "s3:https://s3.eu-central-003.backblazeb2.com/nixhome-persist";
 passwordFile = config.sops.secrets.restic_password.path;
 environmentFile = config.sops.templates."backblaze-restic.env".path;

 paths = [ "/persist" ];
 exclude = [ "**/.cache" "**/tmp" ];

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];

 timerConfig = {
 OnCalendar = "03:00";
 Persistent = true;
 };

 extraOptions = [ "--compression=max" ];
 };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/backup.nix
git commit -m "feat(backup): add secondary restic job for /persist to cloud"
```

- [ ] **Step 1: Update ROADMAP.md**

Mark P2 as DONE.

``n---

* Pfad: docs\superpowers\plans\2026-04-28-storage-mover-implementation.md | Format: .md | Größe: 4,83 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement an intelligent "Unraid-style" mover that shifts files from Tier B (SSD) to Tier C (HDD) safely.

**Architecture:** Custom module `modules/storage/storage-mover.nix`. Uses `rsync` for atomic moves and `lsof` for safety.

**Tech Stack:** NixOS, Bash, Rsync.

**Files:**
- Create: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Write the module code**

```nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;

 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail

 SOURCE="${cfg.ssdDir}"
 TARGET="${cfg.hddDir}"
 DRY_RUN=${if cfg.dryRun then "1" else "0"}
 AGE_DAYS=${toString cfg.minAgeDays}
 THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}

 echo "--- Starting Smart Mover [DryRun: $DRY_RUN, Age: $AGE_DAYS, Threshold: $THRESHOLD_GB GB] ---"

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))

 FORCE_MOVE=0
 if [ "$FREE_GB" -lt "$THRESHOLD_GB" ]; then
 echo " Low space detected ($FREE_GB GB < $THRESHOLD_GB GB). Forcing move of older files."
 FORCE_MOVE=1
 fi

 FIND_AGE=$AGE_DAYS
 [ "$FORCE_MOVE" -eq 1 ] && FIND_AGE=7

 echo " Scanning for files older than $FIND_AGE days..."

 find "$SOURCE" -type f -mtime +"$FIND_AGE" | while read -r file; do

 if ${pkgs.lsof}/bin/lsof "$file" > /dev/null 2>&1; then
 echo " Skipping active file: $file"
 continue
 fi

 REL_PATH=''${file#"$SOURCE/"}
 DEST_DIR=$(dirname "$TARGET/$REL_PATH")

 if [ "$DRY_RUN" -eq 1 ]; then
 echo "[DRY-RUN] Would move: $REL_PATH"
 else
 echo " Moving: $REL_PATH"
 mkdir -p "$DEST_DIR"

 ${pkgs.rsync}/bin/rsync -a --remove-source-files "$file" "$TARGET/$REL_PATH"
 fi
 done

 if [ "$DRY_RUN" -eq 0 ]; then
 find "$SOURCE" -type d -empty -delete
 echo " Cleaned up empty directories."

 if systemctl is-active --quiet update-metadata-db.service; then
 systemctl start update-metadata-db.service
 echo " Metadata DB update triggered."
 fi
 fi

 echo "--- Mover finished ---"
 '';

in
{
 options.my.storage.mover = {
 enable = lib.mkEnableOption "Smart Storage Tiering Mover";
 ssdDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/media"; };
 hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/media"; };
 minAgeDays = lib.mkOption { type = lib.types.int; default = 30; };
 lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 100; };
 dryRun = lib.mkOption { type = lib.types.bool; default = false; };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.storage-mover = {
 description = "hardened Smart Mover (SSD -> HDD)";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = moverScript;
 Nice = 19;
 IOSchedulingClass = "idle";
 CPUSchedulingPolicy = "idle";
 };
 };

 systemd.timers.storage-mover = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "*-*-* 04:00:00";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };
 };
}
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "feat(storage): add smart storage tiering mover module"
```

**Files:**
- Modify: `temp_mynixos/hardware/q958/hardware-profile.nix` (or similar)

- [ ] **Step 1: Check hardware profile imports**

- [ ] **Step 2: Add import and activation**

```nix
imports = [
 ../../modules/storage/storage-mover.nix
];

my.storage.mover.enable = true;
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/hardware/q958/hardware-profile.nix
git commit -m "feat(hardware): enable smart storage mover for Q958"
```

- [ ] **Step 1: Update ROADMAP.md**

Mark P3 as DONE.

``n---

* Pfad: docs\superpowers\plans\2026-04-28-vector-logging-implementation.md | Format: .md | Größe: 4,07 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement persistent logging via Vector to Tier B (SSD) with 14-day rotation.

**Architecture:** Custom module leveraging `services.vector` and `systemd.timers`.

**Tech Stack:** NixOS, Vector.

**Files:**
- Create: `temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 1: Write the module code**

```nix

{ config, lib, pkgs, ... }:
let
 cfg = config.my.logging.vector;
 srePaths = config.my.configs.paths;
 logDir = "${srePaths.tierB}/logs/vector";
in
{
 options.my.logging.vector = {
 enable = lib.mkEnableOption "Vector logging to Tier B";
 retentionDays = lib.mkOption { type = lib.types.int; default = 14; };
 };

 config = lib.mkIf cfg.enable {

 services.journald.extraConfig = ''
 Storage=volatile
 Compress=yes
 RateLimitIntervalSec=30
 RateLimitBurst=1000
 '';

 services.vector = {
 enable = true;
 config = {
 sources.journald = {
 type = "journald";
 current_boot_only = false;
 include_units = [
 "*.service"
 "*.socket"
 "systemd-journald"
 "kernel"
 ];
 };
 transforms.mask_sensitive = {
 type = "remap";
 inputs = [ "journald" ];
 source = ''

 .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
 .message = replace(.message, r'\b[\w\s\-\.]+\.(mkv|mp4|avi|m4b|epub|pdf|nzb)\b', "[FILENAME]")
 .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
 '';
 };
 sinks.file = {
 type = "file";
 inputs = [ "mask_sensitive" ];
 path = "${logDir}/journal-%Y-%m-%d.log";
 encoding.codec = "json";
 compression = "gzip";
 batch.max_bytes = 104857600;
 healthcheck = true;
 };
 };
 };

 systemd.services.rotate-vector-logs = {
 description = "Delete old Vector log files from Tier B";
 serviceConfig = {
 Type = "oneshot";
 Nice = 19;
 IOSchedulingClass = "idle";
 ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
 set -euo pipefail
 find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete
 '';
 };
 };
 systemd.timers.rotate-vector-logs = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };

 systemd.tmpfiles.rules = [
 "d ${logDir} 0750 root root - -"
 ];
 };
}
```

- [ ] **Step 2: Verify syntax**

Run: `nix-instantiate --parse temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/logging/vector-tier-b.nix
git commit -m "feat(logging): add vector tier-b logging module with masking"
```

**Files:**
- Modify: `temp_mynixos/profiles/base-server.nix`

- [ ] **Step 1: Swap logging imports**

Replace `../modules/core/logging.nix` with `../modules/logging/vector-tier-b.nix`.

- [ ] **Step 2: Enable Vector logging**

Add `my.logging.vector.enable = true;` to the configuration block.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/profiles/base-server.nix
git commit -m "feat(profile): switch base-server to persistent vector logging"
```

- [ ] **Step 1: Remove old logging module (Optional)**

If no longer needed, remove `temp_mynixos/modules/core/logging.nix`.

- [ ] **Step 2: Update ROADMAP.md**

Mark P1 as DONE.

``n---

* Pfad: docs\superpowers\specs\2026-04-27-00-core-foundation-design.md | Format: .md | Größe: 2,53 KB
``md
Das Ziel ist die absolute Festigung des `00-core` Layers (Das Fundament). Bevor höhere Layer (wie Media, Apps oder Gateway) konfiguriert werden, muss die Basis zu 100 % verlässlich, nachvollziehbar und zentralisiert sein. Alle höheren Layer sind reine Konsumenten der hier definierten Schnittstellen und Standards.

Die Hardware-Abstraktion für den Q958 wird konsolidiert, damit das System deterministisch bootet und alle nötigen Treiber (z.B. für Transcoding) bereitstellt.
* **Betroffene Dateien:** `host-q958-hardware-profile.nix`, `boot-safeguard.nix`, `kernel-slim.nix`.
* **Funktion:** Sicheres Booten, Microcode-Updates, Intel QuickSync/VA-API Treiber-Init.

Dies ist das Herzstück der Automatisierung. Die Funktion `mkService` wird zur universellen Schnittstelle für alle Dienste in den Layern 10-90 ausgebaut.
* **Betroffene Dateien:** `lib-helpers.nix`.
* **Funktion:** Ein einziger Aufruf (`mkService { name = "vaultwarden"; port = 8080; }`) generiert automatisch:
 * Systemd Hardening & Sandboxing (ProtectSystem, PrivateTmp, etc.).
 * Caddy Reverse Proxy VirtualHosts (inkl. SSO/mTLS Routing).
 * Optional: Firewall-Regeln und Persistenz-Pfade.

Zentrale Verwaltung aller "Magic Strings" und Nummern, um Konfigurationsdrift zu vermeiden.
* **Betroffene Dateien:** `ports.nix`, `configs.nix`, `registry.nix`.
* **Funktion:**
 * `ports.nix`: Eindeutige Zuweisung aller Ports. Kein Dienst darf seinen Port selbst definieren.
 * `configs.nix`: Globale Variablen (Domain `nix.m7c5.de`, Admin-Mail, LAN-IPs).
 * `registry.nix`: Feature-Toggles (z.B. globale Aktivierung von Backups oder mTLS).

Metadaten-Tracking für jede Konfiguration, um bei Fehlern in zz.B. `80-monitoring` den Ursprung in `00-core` sofort lokalisieren zu können.
* **Betroffene Dateien:** `lib-helpers-meta.nix`.
* **Funktion:** Definition und Durchsetzung des `nms` (NixOS Management System) Metadaten-Standards für Audits und Versionierung.

1. **Bottom-Up:** `configs.nix` und `ports.nix` werden zuerst geladen.
2. **Middle:** `lib-helpers.nix` nutzt die SSoT-Werte, um die `mkService` Logik zu bauen.
3. **Top-Down:** Alle Dateien in Layern >00 importieren `lib-helpers.nix` und rufen `mkService` auf.

``n---

* Pfad: docs\superpowers\specs\2026-04-28-navidrome-integration-design.md | Format: .md | Größe: 1,96 KB
``md
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Approved (User)

Integrate Navidrome as the primary audio streaming server into the NixOS home lab environment. This completes the "Media Beast" profile by providing a dedicated music streaming solution alongside Jellyfin and Audiobookshelf.

- **Architecture:** Horizontal Responsibility (v5.0).
- **Hardening:** hardened (SSO, LAN Bypass, Systemd hardening).
- **Storage:** ABC-Tiering (Tier A for State, Tier B for Cache, Tier C for Bulk Media).
- **Patterns:** Use `myLib.mkStreamer` factory.
- **Port:** 4533 (Already registered in `ports.nix`).

- **Options:** `my.apps.navidrome.enable`, paths (Tier A/B/C), user/group settings.
- **Factory Integration:** Calls `mkStreamer` with `useGPU = false`.
- **Hardening:** `ReadOnlyPaths` for music library, systemd sandbox (via factory).
- **Caddy:** Subdomain `music.nix.m7c5.de` aliased to the auto-generated `navidrome` host.
- **Persistence:** Mount `/var/lib/navidrome` to `/persist`.

- Add `navidrome` to `users.groups.media.members` to ensure consistent GID-based access to shared media folders.

- Import `service-app-navidrome.nix`.
- Enable the service: `my.apps.navidrome.enable = true`.

1. Create the Navidrome module.
2. Update `media-stack.nix` members list.
3. Update `media-beast.nix` imports and toggles.
4. Validation via `nixos-rebuild test`.

- Navidrome runs as a system user.
- Network confinement: Restricted to localhost + Caddy proxy.
- File system: Restricted writes to state and cache dirs only.
- Resource limits: 1G RAM, 60 CPU weight.

``n---

* Pfad: docs\superpowers\specs\2026-04-28-persist-backup-design.md | Format: .md | Größe: 1,18 KB
``md
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Approved

Implement a direct-to-cloud backup for the `/persist` directory (Tier A) using Restic and Backblaze B2 (S3 API). This provides offsite redundancy for the system's most critical data.

- **New Secrets:**
 - `restic_password`: Master encryption key.
 - `backblaze_access_key`: B2 Key ID.
 - `backblaze_secret_key`: B2 Application Key.
- **New Template:** `backblaze-restic.env` providing `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for Restic.

- **New Job:** `services.restic.backups.persist`.
- **Target:** S3 endpoint (Backblaze B2).
- **Retention:**
 - Daily: 7 snapshots.
 - Weekly: 4 snapshots.
 - Monthly: 6 snapshots.
- **Timer:** Daily at 03:00.

1. Update `modules/core/secrets.nix` to include new secrets and the environment template.
2. Update `modules/core/backup.nix` to include the `persist` Restic job.
3. Verify syntax and dependencies.

``n---

* Pfad: docs\superpowers\specs\2026-04-28-vector-logging-design.md | Format: .md | Größe: 1,68 KB
``md
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Draft

Implement a persistent logging pipeline that survives reboots (surmounting the current `volatile` journald restriction) while maintaining high system performance.

- **Architecture:** Horizontal Responsibility (v5.0).
- **Hardening:** hardened (Sensitive data masking).
- **Storage:** Tier B (SSD) for log archives to avoid NVMe wear and RAM usage.
- **Framework:** Vector (Lightweight, Go/Rust-based).

- **Source:** Pulls from `journald`.
- **Transform:** 
 - Masking of `/mnt/media`, `/mnt/hdd_pool`, `/mnt/tierC`.
 - Masking of filenames (mkv, mp4, etc.).
 - Masking of API keys (32+ chars).
- **Sink:** 
 - Local file on Tier B (`${srePaths.tierB}/logs/vector/journal-%Y-%m-%d.log.gz`).
 - Format: NDJSON.
 - Compression: GZIP.
- **Rotation:** 14-day retention via `find` script and `systemd.timer`.

- **Profile:** `profiles/base-server.nix`.
- **Action:** Replace `modules/core/logging.nix` import with `modules/logging/vector-tier-b.nix`.
- **Toggle:** `my.logging.vector.enable = true;`.

1. Create `modules/logging` directory.
2. Create `vector-tier-b.nix` with the approved code.
3. Update `profiles/base-server.nix` imports.
4. Enable the service in `profiles/base-server.nix`.
5. Run `nix-instantiate` to verify.

- S3 Sink for long-term offsite archiving.
- Gatus integration for log-based health alerts.

``n---

* Pfad: hardware\q958\hardware-configuration.nix | Format: .nix | Größe: 2,07 KB
``nix
{
 config,
 lib,
 pkgs,
 modulesPath,
 myLib,
 ...
}: let

 nms = {
 id = "NIXH-01-HW-Q958-CFG";
 title = "Hardware Configuration (Fujitsu Q958)";
 description = "Physical identity and board-specific settings for Fujitsu Esprimo Q958.";
 layer = 1;
 nixpkgs.category = "system/boot";
 capabilities = ["system/hardware" "hardware/q958" "sensors/nct6775"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.host_q958_hardware_configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [(modulesPath + "/installer/scan/not-detected.nix")];

 config = {

 boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "nvme"];
 boot.initrd.kernelModules = [];

 boot.kernelModules = [ 
 "kvm-intel" 
 "nct6775" # Mainboard Sensors (Fan/Temp)
 "coretemp" # CPU Sensors
 ];

 boot.kernelParams = [

 "acpi_enforce_resources=lax"
 ];

 boot.extraModulePackages = [];

 fileSystems."/" = {
 device = "/dev/disk/by-uuid/8d1d5128-6413-4b5b-bd96-e55851ae5dc2";
 fsType = "ext4";
 };

 fileSystems."/boot" = {
 device = "/dev/disk/by-uuid/B413-DB53";
 fsType = "vfat";
 options = ["fmask=0077" "dmask=0077"];
 };

 swapDevices = [];

 nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}

``n---

* Pfad: hardware\q958\hardware-profile.nix | Format: .nix | Größe: 3,22 KB
``nix
{ config, lib, pkgs, myLib, ... }: 
let
 cfg = config.my.hardware;
in
{

 imports = [
 ../../modules/storage/storage-mover.nix
 ];

 config = lib.mkIf (cfg.profile == "q958") {

 my.storage.mover.enable = true;

 boot.kernelPackages = pkgs.linuxPackages_latest; # Latest kernel for best CFL support

 boot.kernelParams = [
 "quiet"
 "mitigations=auto"

 "acpi_osi=Linux" # Better power management (Fragment 975)
 "i915.enable_guc=3" # GuC/HuC Firmware for QSV/HEVC (Fragment 2272)
 "i915.enable_fbc=1" # Frame Buffer Compression (Saves power)
 "i915.fastboot=1" # Cleaner boot transition
 "intel_idle.max_cstate=4" # Balance between power saving and C-state exit latency stability
 "ibt=off" # Disable Indirect Branch Tracking (Workaround for some CFL issues)
 "intel_pstate=passive" # Use passive mode to allow TLP/thermald better control
 ];

 boot.kernelModules = [ "kvm_intel" ];

 hardware.graphics = {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver # Modern VAAPI for Broadwell+ (Fragment 4899)
 vpl-gpu-rt # OneVPL runtime for QSV
 libvdpau-va-gl # VDPAU to VAAPI bridge
 ];
 };

 environment.variables.LIBVA_DRIVER_NAME = "iHD"; # Fragment 2272

 services.thermald.enable = true; # Intel Thermal Daemon (Fragment 2291)

 services.tlp = {
 enable = true; # Fragment 2292
 settings = {

 CPU_SCALING_GOVERNOR_ON_AC = "powersave";
 CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
 PCIE_ASPM_ON_AC = "performance"; # Prioritize I/O stability on AC
 START_CHARGE_THRESH_BAT8 = 75; # Not relevant for Q958 desktop but good practice in profiles
 STOP_CHARGE_THRESH_BAT8 = 80;
 };
 };

 boot.kernel.sysctl = {
 "vm.swappiness" = myLib.mkTracedOption "NIXH-HW-001" (lib.mkOption { 
 type = lib.types.int; default = 10; 
 }).default;

 "kernel.nmi_watchdog" = 0; # Save power by disabling NMI watchdog

 "fs.protected_symlinks" = 1;
 "fs.protected_hardlinks" = 1;

 "kernel.kptr_restrict" = 2;
 };

 zramSwap.enable = true; # Fragment 4937
 swapDevices = []; # Prefer ZRAM over SSD wear (Fragment 731)

 hardware.cpu.intel.updateMicrocode = true;
 };
}

``n---

* Pfad: hardware\q958\README.md | Format: .md | Größe: 2,19 KB
``md
This directory contains the "Hardware-Geist" (Physical Identity) of the Fujitsu Esprimo Q958 system.

- **CPU:** Intel Core i3-9100 (Coffee Lake / 4 Cores / 4 Threads)
- **GPU:** Intel UHD Graphics 630 (9.5th Gen)
- **Chipset:** Intel Q370
- **NIC:** Intel I219-LM (Gigabit)
- **Storage:** NVMe SSD + SATA AHCI
- **Sensor Chip:** Nuvoton NCT6775

In accordance with **ADR-001 (Hardware-Geist Separation)**, all physical identifiers (UUIDs, PCIe paths, firmware) are isolated here. The Core logic (Layer 00) remains "pure" and hardware-agnostic.

- **Driver:** Using `intel-media-driver` (iHD) instead of the older `vaapi-intel` (i965) for modern Gen 9 support.
- **Firmware:** `i915.enable_guc=3` enables GuC/HuC loading, required for low-power HEVC decoding/encoding and hardware-accelerated scheduling.
- **Environment:** `LIBVA_DRIVER_NAME=iHD` is forced globally to ensure applications like Jellyfin use the modern VAAPI path.

- **TLP & Thermald:** TLP handles the power profiles (set to `powersave` governor for intel_pstate), while Thermald prevents thermal throttling on the small form factor (SFF) chassis.
- **C-States:** `intel_idle.max_cstate=4` is used as a stability compromise. Deep C-states (C6/C7) can sometimes cause hangs on these Fujitsu boards during idle.
- **ASPM:** PCIe ASPM is enabled but set to `performance` on AC to prevent network/storage latency spikes.

- **Module:** `nct6775` provides fan speed and voltage monitoring.
- **Kernel Fix:** `acpi_enforce_resources=lax` is required because the BIOS/ACPI reserves the sensor address space, preventing the Linux kernel driver from accessing it. This is safe on this specific Fujitsu hardware.

- **ZRAM:** Prioritized over physical swap to reduce SSD wear and improve responsiveness under OOM conditions.
- **Sysctl:** `vm.swappiness=10` ensures the system only swaps to ZRAM when absolutely necessary.

*Last Audit: 2026-04-27 | Status: hardened*

``n---

* Pfad: hardware\q958\registry.nix | Format: .nix | Größe: 218 B
``nix
{ lib, ... }: {
 options.my.profiles.hardware = {
 q958.enable = lib.mkOption {
 type = lib.types.bool;
 default = true;
 description = "Enable Fujitsu Q958 hardware profile";
 };
 };
}

``n---

* Pfad: modules\apps\automation.nix | Format: .nix | Größe: 1,08 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-30-AUT-001";
 title = "Automation";
 description = "Core automation settings, including sudo rules for rebuilds and maintenance.";
 layer = 20;
 nixpkgs.category = "system/settings";
 capabilities = [ "system/maintenance" "security/sudo-rules" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 bastelmodus = config.my.configs.bastelmodus;
 user = config.my.configs.identity.user;
in
{
 options.my.meta.automation = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for automation module";
 };

 config = {
 security.sudo.extraRules = [
 {
 users = [ user ];
 commands = [
 { command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
 { command = "${pkgs.nix}/bin/nix"; options = [ "NOPASSWD" ]; }
 { command = "ALL"; options = lib.mkIf bastelmodus [ "NOPASSWD" ]; }
 ];
 }
 ];
 };
}

``n---

* Pfad: modules\apps\media-stack.nix | Format: .nix | Größe: 1,67 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-40-MED-001";
 title = "Media Stack (Exhausted Layout)";
 description = "Canonical data/state layout with ABC-tiering enforcement and global media permissions.";
 layer = 40;
 nixpkgs.category = "system/storage";
 capabilities = [ "storage/layout" "security/permissions" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 srePaths = config.my.configs.paths;
in
{
 options.my.meta.media_stack = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for media-stack module";
 };

 config = lib.mkIf config.my.services.mediaStack.enable {
 users.groups.media = { gid = 169; };
 users.groups.media.members = [ "jellyfin" "sabnzbd" "audiobookshelf" "sonarr" "radarr" "lidarr" "readarr" "prowlarr" "navidrome" ];
 systemd.tmpfiles.rules = [
 "d ${srePaths.mediaLibrary} 0775 root media -"
 "d ${srePaths.mediaLibrary}/movies 0775 radarr media -"
 "d ${srePaths.mediaLibrary}/tv 0775 sonarr media -"
 "d ${srePaths.mediaLibrary}/music 0775 lidarr media -"
 "d ${srePaths.mediaLibrary}/books 0775 readarr media -"
 "d ${srePaths.mediaLibrary}/documents 0775 paperless media -"
 "d ${srePaths.storagePool}/downloads 0775 root media -"
 "d ${srePaths.storagePool}/downloads/torrents 0775 prowlarr media -"
 "d ${srePaths.storagePool}/downloads/usenet 0775 sabnzbd media -"
 "d ${srePaths.stateDir} 0755 root root -"
 "d /mnt/fast-pool/metadata 0775 root media -"
 "d /mnt/fast-pool/cache 0775 root media -"
 ];
 };
}

``n---

* Pfad: modules\apps\service-app-ai-agents.nix | Format: .nix | Größe: 1,40 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-30-AUT-002";
 title = "Ai Agents (Ollama & Claude)";
 description = "Local AI orchestration with Ollama (GPU-accelerated) and Claude Code.";
 layer = 20;
 nixpkgs.category = "services/misc";
 capabilities = [ "ai/ollama" "ai/claude-code" "gpu/acceleration" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 kimiClaudeScript = pkgs.writeShellScriptBin "kimi-claude" "echo ' Starting AI...'; ${pkgs.ollama}/bin/ollama run kimi-k2.5:cloud; ${pkgs.nodejs_22}/bin/npx -y @anthropic-ai/claude-code --model kimi-k2.5:cloud";
in
{
 options.my.meta.ai_agents = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for ai-agents module";
 };

 config = lib.mkIf config.my.services.aiAgents.enable {
 services.ollama = {
 enable = true;
 package = if config.my.configs.hardware.intelGpu then pkgs.ollama-vulkan else pkgs.ollama;
 loadModels = [ "kimi-k2.5:cloud" ];
 };
 environment.systemPackages = [ kimiClaudeScript pkgs.ollama pkgs.nodejs_22 ];
 programs.bash.shellAliases.kimi = "kimi-claude";
 systemd.services.ollama.serviceConfig = { DeviceAllow = [ "/dev/dri/renderD128 rw" ]; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; OOMScoreAdjust = 500; };
 };
}

``n---

* Pfad: modules\apps\service-app-ai-tools.nix | Format: .nix | Größe: 1,79 KB
``nix
{ pkgs, lib, config, ... }:
let

 nms = {
 id = "NIXH-00-COR-002";
 title = "AI Tools (SRE Assisted)";
 description = "Optimized terminal environment for AI-assisted development and SRE tasks.";
 layer = 00;
 nixpkgs.category = "tools/admin";
 capabilities = [ "ai/workflow" "shell/enhancement" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.ai_tools = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for ai-tools module";
 };

 options.my.tools.ai.enable = lib.mkEnableOption "AI Tools (aider, uv, etc.)";

 config = lib.mkIf config.my.tools.ai.enable {

 environment.systemPackages = with pkgs; [
 aider-chat uv python3 blesh inshellisense fzf jq curl
 ];

 programs.bash.interactiveShellInit = ''

 if [[ -f ${pkgs.blesh}/share/blesh/ble.sh ]]; then
 source ${pkgs.blesh}/share/blesh/ble.sh
 bleopt edit_multi_line=0 2>/dev/null || true
 fi

 if command -v inshellisense > /dev/null; then
 alias gemini-hint='inshellisense bind gemini -- gemini'

 alias p-graph='python3 /etc/nixos/scripts/generate-mermaid.py'
 fi
 '';
 };
}

``n---

* Pfad: modules\apps\service-app-audiobookshelf.nix | Format: .nix | Größe: 3,70 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-ABS-001";
 title = "Audiobookshelf (hardened)";
 description = "Hardened Audiobook & Podcast server with ABC-Tiering and specialized cache.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/audiobooks" "media/podcasts" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.apps.audiobookshelf;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

in
{
 options.my.meta.audiobookshelf = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.audiobookshelf = {
 enable = lib.mkEnableOption "Audiobookshelf media server";
 user = lib.mkOption { type = lib.types.str; default = "audiobookshelf"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.audiobookshelf or 20081; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/audiobookshelf"; 
 description = "Database and metadata (Tier A/Persist)";
 };
 audiobookDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.mediaLibrary}/audiobooks";
 description = "Audiobook library (Tier C)";
 };
 podcastDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.mediaLibrary}/podcasts";
 description = "Podcast library (Tier C)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "audiobookshelf";
 port = cfg.port;
 useGPU = false; # Audiobookshelf uses CPU for transcoding
 memoryMax = "2G";
 cpuWeight = 70;
 oomScoreAdjust = 350;
 description = "Audiobookshelf Instance";
 })

 {

 services.caddy.virtualHosts."abs.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" = 
 config.services.caddy.virtualHosts."audiobookshelf.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 services.audiobookshelf = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 dataDir = cfg.stateDir;
 port = cfg.port;
 host = "127.0.0.1";
 };

 systemd.services.audiobookshelf = {

 serviceConfig = {

 ReadWritePaths = [
 cfg.stateDir
 cfg.audiobookDir
 cfg.podcastDir
 ];

 MemoryDenyWriteExecute = false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.audiobookDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${cfg.podcastDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/audiobookshelf" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-couchdb.nix | Format: .nix | Größe: 656 B
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-60-APP-002";
 title = "CouchDB";
 description = "NoSQL database (Placeholder - Not yet implemented).";
 layer = 60;
 nixpkgs.category = "services/databases";
 capabilities = [ "database/nosql" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.couchdb = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for couchdb module";
 };

 config = lib.mkIf config.my.services.couchdb.enable {

 };
}

``n---

* Pfad: modules\apps\service-app-filebrowser.nix | Format: .nix | Größe: 1,30 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-60-APP-003";
 title = "Filebrowser (SRE Hardened)";
 description = "Web-based file manager with strict path restrictions and sandboxing.";
 layer = 60;
 nixpkgs.category = "services/web-apps";
 capabilities = [ "web/file-management" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.filebrowser;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.filebrowser = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for filebrowser module";
 };

 config = lib.mkIf config.my.services.filebrowser.enable {
 services.filebrowser = { enable = true; settings = { port = port; address = "127.0.0.1"; root = "/mnt/storage"; }; };
 services.caddy.virtualHosts."files.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.filebrowser.serviceConfig = { ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; ReadWritePaths = [ "/var/lib/filebrowser" "/mnt/storage" ]; NoNewPrivileges = true; SystemCallFilter = [ "@system-service" "~@privileged" ]; };
 };
}

``n---

* Pfad: modules\apps\service-app-home-assistant.nix | Format: .nix | Größe: 5,96 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-HASS-001";
 title = "Home Assistant (hardened)";
 description = "Hardened Home Automation with ABC-Tiering and Secret-Isolation.";
 layer = 30;
 nixpkgs.category = "services/home-automation";
 capabilities = ["home-automation/hass" "iot/mqtt" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.home-assistant;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

 isUsbDevice = lib.hasPrefix "/dev/" cfg.zigbeeDevice;

in
{
 options.my.meta.home_assistant = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.home-assistant = {
 enable = lib.mkEnableOption "Home Assistant (IoT)";
 user = lib.mkOption { type = lib.types.str; default = "hass"; };
 group = lib.mkOption { type = lib.types.str; default = "hass"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.home-assistant or 8123; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/home-assistant"; 
 description = "Configuration and primary DB (Tier A/Persist)";
 };
 cacheDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/cache/home-assistant";
 description = "Python bytecode and temp cache (Tier B)";
 };
 mediaDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.mediaLibrary}/home-assistant";
 description = "Media archive for recordings/snapshots (Tier C)";
 };

 zigbeeDevice = lib.mkOption { 
 type = lib.types.str; 
 default = "socket://192.168.2.46:6638"; 
 description = "Zigbee adapter path or socket";
 };
 bluetooth = lib.mkOption { type = lib.types.bool; default = false; };

 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to HA Secrets (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "home-assistant";
 port = cfg.port;
 useSSO = true;
 description = "Home Assistant Core";
 persist = true;
 readWritePaths = [ cfg.stateDir cfg.cacheDir cfg.mediaDir ];
 })

 {

 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "dialout" "video" "media" ] ++ (lib.optional cfg.bluetooth "bluetooth");
 };
 users.groups.${cfg.group} = {};

 services.home-assistant = {
 enable = true;
 configDir = cfg.stateDir;
 extraComponents = [ 
 "default_config" "met" "esphome" "prometheus" "mobile_app" 
 "sun" "radio_browser" "google_translate" "mqtt" 
 ];
 config = {
 homeassistant = {
 name = "NixHome";
 unit_system = "metric";
 time_zone = sreConfig.locale.timezone;
 external_url = "https://home.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";
 internal_url = "http://localhost:${toString cfg.port}";
 };

 mqtt = {
 broker = "127.0.0.1";
 port = config.my.ports.mqtt or 1883;
 };
 http = {
 use_x_forwarded_for = true;
 trusted_proxies = [ "127.0.0.1" "::1" ] ++ sreConfig.network.tailnetCidrs;
 };
 };
 };

 systemd.services.home-assistant = {
 description = "Home Assistant Core (hardened)";

 environment.PYTHONPYCACHEPREFIX = "${cfg.cacheDir}/pycache";

 serviceConfig = {

 LoadCredential = lib.optional (cfg.secretFile != null) "HA_SECRET:${toString cfg.secretFile}";

 MemoryMax = "2G";
 CPUWeight = 70;
 OOMScoreAdjust = 300;

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 PrivateDevices = if isUsbDevice || cfg.bluetooth then lib.mkForce false else true;
 DeviceAllow = (lib.optional isUsbDevice "${cfg.zigbeeDevice} rw")
 ++ (lib.optional cfg.bluetooth "/dev/rfkill rw")
 ++ [ "/dev/dri/renderD128 rw" ]; # Hardware Transcoding (selten gebraucht)

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir}/pycache 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.mediaDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/home-assistant" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-karakeep.nix | Format: .nix | Größe: 995 B
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-60-APP-004";
 title = "Karakeep (SRE Hardened)";
 description = "Bookmark management tool with SRE sandboxing.";
 layer = 60;
 nixpkgs.category = "web/apps";
 capabilities = [ "web/bookmarks" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 port = config.my.ports.karakeep;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.karakeep = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for karakeep module";
 };

 config = lib.mkIf config.my.services.karakeep.enable {
 services.karakeep = { enable = true; extraEnvironment = { PORT = toString port; DISABLE_SIGNUPS = "true"; }; };
 services.caddy.virtualHosts."bookmarks.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 };
}

``n---

* Pfad: modules\apps\service-app-linkding.nix | Format: .nix | Größe: 651 B
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-50-KNW-001";
 title = "Linkding";
 description = "Bookmark manager (Placeholder - Not yet implemented).";
 layer = 50;
 nixpkgs.category = "web/apps";
 capabilities = [ "web/bookmarks" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.linkding = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for linkding module";
 };

 config = lib.mkIf config.my.services.linkding.enable {

 };
}

``n---

* Pfad: modules\apps\service-app-linkwarden.nix | Format: .nix | Größe: 1,87 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let
 nms = {
 id = "NIXH-50-KNW-005";
 title = "Linkwarden (SRE Hardened)";
 description = "Collaborative bookmark manager with automatic archiving and DynamicUser sandboxing.";
 layer = 50;
 nixpkgs.category = "services/web-apps";
 capabilities = ["web/bookmarks" "archive/offline" "security/sandboxing"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 port = config.my.ports.linkwarden or 3000;
 domain = config.my.configs.identity.domain;

in {
 options.my.meta.linkwarden = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for linkwarden module";
 };

 options.my.services.linkwarden = {
 enable = lib.mkEnableOption "Linkwarden";
 };

 config = lib.mkIf config.my.services.linkwarden.enable {
 services.linkwarden = {
 enable = true;
 environment = {
 NEXTAUTH_URL = "https://links.${domain}/api/v1/auth";
 };
 };

 services.caddy.virtualHosts."links.${domain}" = {
 extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}";
 };

 systemd.services.linkwarden = {
 serviceConfig = {
 DynamicUser = true;
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 SystemCallFilter = ["@system-service" "~@privileged"];
 OOMScoreAdjust = 300;
 StateDirectory = "linkwarden";
 };
 };
 };
}

``n---

* Pfad: modules\apps\service-app-matrix-conduit.nix | Format: .nix | Größe: 1,83 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-60-APP-005";
 title = "Matrix Conduit";
 description = "Lightweight Matrix homeserver (Conduit) written in Rust.";
 layer = 60;
 nixpkgs.category = "services/matrix";
 capabilities = [ "communication/matrix" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 myLib = import ../core/lib-helpers.nix { inherit lib; };
 port = config.my.ports.matrix;
 domain = config.my.configs.identity.domain;
 subdomain = config.my.configs.identity.subdomain;
 serverName = "matrix.${subdomain}.${domain}";
 serviceBase = myLib.mkService { inherit config; name = "matrix"; port = port; useSSO = false; description = "Matrix Homeserver (Conduit)"; };
in
{
 options.my.meta.matrix_conduit = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for matrix-conduit module";
 };

 config = lib.mkIf config.my.services.matrixConduit.enable (lib.mkMerge [
 (lib.filterAttrs (n: v: n != "systemd") serviceBase)
 {
 services.matrix-conduit = { enable = true; settings.global = { server_name = serverName; port = port; address = "127.0.0.1"; database_backend = "rocksdb"; allow_registration = true; }; };
 systemd.services.conduit = { serviceConfig = lib.mkMerge [ serviceBase.systemd.services.matrix.serviceConfig { StateDirectory = lib.mkForce "matrix-conduit"; ReadWritePaths = lib.mkForce [ "/var/lib/matrix-conduit" ]; MemoryDenyWriteExecute = lib.mkForce false; CPUWeight = lib.mkForce 50; MemoryMax = lib.mkForce "1G"; } ]; };
 services.caddy.virtualHosts."${serverName}".extraConfig = lib.mkAfter "handle /.well-known/matrix/server { ... } handle /.well-known/matrix/client { ... }"; # Shortened
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-miniflux.nix | Format: .nix | Größe: 1,49 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-50-KNW-002";
 title = "Miniflux (SRE Exhausted)";
 description = "Minimalist RSS reader with Wake-on-Access (Socket Activation).";
 layer = 50;
 nixpkgs.category = "services/web-apps";
 capabilities = [ "web/rss" "security/socket-activation" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.miniflux;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.miniflux = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for miniflux module";
 };

 config = lib.mkIf config.my.services.miniflux.enable {
 services.miniflux = {
 enable = true; config = { LISTEN_ADDR = "fd://3"; WATCHDOG = 1; RUN_MIGRATIONS = 1; ADMIN_USERNAME = "admin"; };
 createDatabaseLocally = true; adminCredentialsFile = config.sops.secrets.miniflux_admin_password.path;
 };
 systemd.sockets.miniflux = { description = "Miniflux Socket"; wantedBy = [ "sockets.target" ]; listenStreams = [ (toString port) ]; };
 systemd.services.miniflux = {
 wantedBy = lib.mkForce [ ]; requires = [ "miniflux.socket" ]; after = [ "miniflux.socket" ];
 serviceConfig = { DynamicUser = true; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; SystemCallFilter = [ "@system-service" "~@privileged" ]; OOMScoreAdjust = 500; };
 };
 };
}

``n---

* Pfad: modules\apps\service-app-monica.nix | Format: .nix | Größe: 1,29 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-60-APP-006"; title = "Monica"; description = "Personal CRM."; layer = 60; nixpkgs.category = "services/web-apps"; capabilities = [ "web/crm" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 3; };
 port = config.my.ports.monica;
 domain = config.my.configs.identity.domain;
 appKeyFile = "/var/lib/monica/app-key";
in
{
 options.my.meta.monica = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf config.my.services.monica.enable {
 services.monica = { enable = true; hostname = "monica.${domain}"; appURL = "https://monica.${domain}"; inherit appKeyFile; nginx.listen = [ { addr = "127.0.0.1"; port = port; ssl = false; } ]; database.createLocally = true; };
 services.caddy.virtualHosts."monica.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 system.activationScripts.monicaAppKeyFile.text = "install -d -m 0750 -o monica -g monica /var/lib/monica; if [ ! -s ${appKeyFile} ]; then head -c 32 /dev/urandom | base64 > ${appKeyFile}; fi";
 systemd.services.phpfpm-monica.serviceConfig = { ProtectSystem = lib.mkForce "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; ReadWritePaths = [ "/var/lib/monica" ]; };
 };
}

``n---

* Pfad: modules\apps\service-app-n8n.nix | Format: .nix | Größe: 5,78 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-N8N-001";
 title = "n8n Workflow Automation (hardened)";
 description = "Hardened n8n instance with Postgres backend and Secret-Isolation.";
 layer = 30;
 nixpkgs.category = "services/misc";
 capabilities = ["automation/workflows" "security/sandboxing" "database/postgres"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.n8n;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

in
{
 options.my.meta.n8n = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.n8n = {
 enable = lib.mkEnableOption "n8n Workflow Automation";
 user = lib.mkOption { type = lib.types.str; default = "n8n"; };
 group = lib.mkOption { type = lib.types.str; default = "n8n"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.n8n or 20017; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/n8n"; 
 description = "Database and binary state (Tier A/Persist)";
 };
 cacheDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/cache/n8n";
 description = "Workflow execution cache (Tier B)";
 };

 database = {
 type = lib.mkOption { 
 type = lib.types.enum [ "sqlite" "postgres" ]; 
 default = "postgres"; 
 description = "Backend database engine";
 };
 };

 encryptionKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to n8n Encryption Key (via Sops)";
 };

 memoryMax = lib.mkOption { type = lib.types.str; default = "2G"; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "n8n";
 port = cfg.port;
 useSSO = true;
 description = "n8n Workflow Automation";
 persist = true;
 readWritePaths = [ cfg.stateDir cfg.cacheDir ];
 })

 {

 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };
 users.groups.${cfg.group} = {};

 services.n8n = {
 enable = true;

 };

 systemd.services.n8n = {
 description = "n8n Workflow Engine (hardened)";
 after = [ "network.target" ] ++ (lib.optional (cfg.database.type == "postgres") "postgresql.service");

 environment = {
 N8N_PORT = toString cfg.port;
 N8N_HOST = "127.0.0.1";
 N8N_EDITOR_BASE_URL = "https://n8n.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";
 N8N_NODE_OPTIONS = "--max-old-space-size=2048";

 EXECUTIONS_DATA_PRUNE = "true";
 EXECUTIONS_DATA_MAX_AGE = "336"; # 14 days

 N8N_USER_FOLDER = cfg.stateDir;
 } // (lib.optionalAttrs (cfg.database.type == "postgres") {
 DB_TYPE = "postgresdb";
 DB_POSTGRESDB_DATABASE = "n8n";
 DB_POSTGRESDB_HOST = "/run/postgresql";
 DB_POSTGRESDB_USER = "n8n";
 });

 serviceConfig = {
 User = cfg.user;
 Group = cfg.group;

 LoadCredential = lib.optional (cfg.encryptionKeyFile != null) "N8N_ENCRYPTION_KEY:${toString cfg.encryptionKeyFile}";

 MemoryMax = cfg.memoryMax;
 CPUWeight = 50;
 OOMScoreAdjust = 300;

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 NoNewPrivileges = true;

 MemoryDenyWriteExecute = false; # Needed for Node.js JIT

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
 };
 };

 services.postgresql = lib.mkIf (cfg.database.type == "postgres") {
 ensureDatabases = [ "n8n" ];
 ensureUsers = [ {
 name = "n8n";
 ensureDBOwnership = true;
 } ];
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/n8n" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-navidrome.nix | Format: .nix | Größe: 2,41 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let
 nms = {
 id = "NIXH-01-APP-NAV-001";
 title = "Navidrome (hardened Music Server)";
 layer = 40;
 audit.last_reviewed = "2026-04-28";
 };
 cfg = config.my.apps.navidrome;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;
in
{
 options.my.apps.navidrome = {
 enable = lib.mkEnableOption "Navidrome Music Server";
 user = lib.mkOption { type = lib.types.str; default = "navidrome"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.navidrome or 4533; };
 stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/navidrome"; };
 cacheDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/cache/navidrome"; };
 musicDir = lib.mkOption { type = lib.types.str; default = "${srePaths.mediaLibrary}/music"; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "navidrome";
 port = cfg.port;
 useGPU = false;
 memoryMax = "1G";
 cpuWeight = 60;
 description = "Navidrome Music Streaming";
 })

 {
 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };

 services.navidrome = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 address = "127.0.0.1";
 port = cfg.port;
 musicFolder = cfg.musicDir;
 dataFolder = cfg.stateDir;
 cacheFolder = cfg.cacheDir;
 settings.EnableSubsonicApi = true;
 };

 services.caddy.virtualHosts."music.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" =
 config.services.caddy.virtualHosts."navidrome.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.navidrome.serviceConfig.ReadOnlyPaths = [ cfg.musicDir ];

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist".directories = [
 "/var/lib/navidrome"
 ];
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-olivetin.nix | Format: .nix | Größe: 3,24 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-30-AUT-005";
 title = "OliveTin (SRE Exhausted)";
 description = "Web-based control panel with Wake-on-Access (Socket Activation) and secure command pinning.";
 layer = 30;
 nixpkgs.category = "web/apps";
 capabilities = ["automation/shell" "system/control-panel" "security/socket-activation"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 port = config.my.ports.olivetin;
 mtlsGenScript = "/etc/nixos/00-core/scripts/mtls-generator.sh";
 sopsScript = "/etc/nixos/00-core/scripts/add-sops-secret.sh";
in {
 options.my.meta.olivetin = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for olivetin module";
 };

 config = lib.mkIf config.my.services.olivetin.enable {
 services.olivetin = {
 enable = true;
 path = with pkgs; [
 bash
 openssl
 jq
 coreutils
 gnused
 systemd
 nixos-rebuild
 nix-output-monitor
 curl
 sops
 ];
 settings = {
 ListenAddressSingleHTTPFrontend = "127.0.0.1:${toString port}";
 actions = [
 {
 title = "SOPS: Neues Secret";
 shell = "sudo ${sopsScript} '{{ secret_key }}' '{{ secret_value }}'";
 icon = "&#128272;";
 arguments = [
 {
 name = "secret_key";
 type = "ascii";
 }
 {
 name = "secret_value";
 type = "ascii";
 }
 ];
 }
 {
 title = "mTLS: Client Zertifikat erstellen";
 shell = "sudo ${mtlsGenScript} '{{ client_name }}'";
 icon = "";
 arguments = [
 {
 name = "client_name";
 type = "ascii";
 }
 ];
 }
 {
 title = "System Update";
 shell = "sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch 2>&1 | ${pkgs.nix-output-monitor}/bin/nom";
 icon = "&#128259;";
 }
 ];
 };
 };

 systemd.sockets.olivetin = {
 description = "OliveTin Socket";
 wantedBy = ["sockets.target"];
 listenStreams = [(toString port)];
 };

 systemd.services.olivetin = {
 wantedBy = lib.mkForce [];
 requires = ["olivetin.socket"];
 after = ["olivetin.socket"];
 };

 security.sudo.extraRules = [
 {
 users = ["olivetin"];
 commands = [
 {
 command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
 options = ["NOPASSWD"];
 }
 {
 command = mtlsGenScript;
 options = ["NOPASSWD"];
 }
 ];
 }
 ];

 systemd.tmpfiles.rules = [
 "d /var/www/landing-zone/certs 0755 caddy caddy -"
 ];
 };
}

``n---

* Pfad: modules\apps\service-app-paperless.nix | Format: .nix | Größe: 3,22 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-PAP-002";
 title = "Paperless-ngx (hardened)";
 description = "Hardened document management system with Valkey and PostgreSQL.";
 layer = 50;
 nixpkgs.category = "services/misc";
 capabilities = ["knowledge/documents" "security/sandboxing" "database/postgres" "caching/valkey"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.paperless;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.paperless = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.paperless = {
 enable = lib.mkEnableOption "Paperless-ngx Document Management";
 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Paperless Secret Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkDocumentApp {
 inherit config;
 name = "paperless";
 port = config.my.ports.paperless or 20981;
 description = "Paperless-ngx Document Management";
 useValkey = true; # Nutzt die Open-Source Alternative zu Redis
 usePostgres = true;
 inherit (cfg) secretFile;
 ocrLanguages = [ "deu" "eng" ];
 })

 {
 services.paperless = {
 enable = true;
 user = "paperless";
 address = "127.0.0.1";
 port = config.my.ports.paperless or 20981;
 };

 systemd.services.paperless-web = {
 environment = {
 PAPERLESS_URL = "https://paperless.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
 PAPERLESS_TIME_ZONE = config.my.configs.locale.timezone;
 PAPERLESS_OCR_LANGUAGE = "deu+eng";

 PAPERLESS_DATA_DIR = "${srePaths.stateDir}/paperless";
 PAPERLESS_MEDIA_ROOT = "${srePaths.mediaLibrary}/documents/paperless";
 PAPERLESS_CONSUMPTION_DIR = "${srePaths.tierC}/consume/paperless";

 PAPERLESS_DBHOST = "/run/postgresql";
 PAPERLESS_DBNAME = "paperless";
 PAPERLESS_DBUSER = "paperless";

 PAPERLESS_REDIS = "unix://${config.services.redis.servers.paperless.unixSocket}";
 };

 serviceConfig.EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;
 };

 systemd.services.paperless-worker.environment = config.systemd.services.paperless-web.environment;
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-readeck.nix | Format: .nix | Größe: 1,30 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-50-KNW-004";
 title = "Readeck (SRE Hardened)";
 description = "Self-hosted 'read-it-later' service, tightly sandboxed with DynamicUser.";
 layer = 50;
 nixpkgs.category = "services/web-apps";
 capabilities = [ "web/read-it-later" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.readeck;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.readeck = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for readeck module";
 };

 config = lib.mkIf config.my.services.readeck.enable {
 services.readeck = { enable = true; settings = { server.host = "127.0.0.1"; server.port = port; log.level = "info"; }; environmentFile = config.sops.secrets.readeck_env.path; };
 services.caddy.virtualHosts."read.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.readeck.serviceConfig = { DynamicUser = true; ProtectSystem = "full"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; SystemCallFilter = [ "@system-service" "~@privileged" ]; OOMScoreAdjust = 300; };
 };
}

``n---

* Pfad: modules\apps\service-app-seerr.nix | Format: .nix | Größe: 4,22 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-SEE-001";
 title = "Seerr (hardened Requests)";
 description = "Hardened Media Request Management (Seerr/Jellyseerr) with ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/requests" "security/sandboxing" "identity/sso"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.apps.seerr;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

in
{
 options.my.meta.seerr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.seerr = {
 enable = lib.mkEnableOption "Seerr Media Request Service";
 user = lib.mkOption { type = lib.types.str; default = "seerr"; };
 group = lib.mkOption { type = lib.types.str; default = "seerr"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.seerr or 5055; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/seerr"; 
 description = "Database and config (Tier A/Persist)";
 };
 cacheDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/cache/seerr";
 description = "Image and session cache (Tier B)";
 };

 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Seerr environment file containing API keys (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "seerr";
 port = cfg.port;
 useSSO = true;
 description = "Seerr Media Request Manager";
 persist = true;
 readWritePaths = [ cfg.stateDir cfg.cacheDir ];
 })

 {

 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };
 users.groups.${cfg.group} = {};

 services.caddy.virtualHosts."requests.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" = 
 config.services.caddy.virtualHosts."seerr.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.seerr = {
 description = "Seerr Media Request Service (hardened)";
 after = [ "network.target" "jellyfin.service" ];

 serviceConfig = {
 User = cfg.user;
 Group = cfg.group;
 ExecStart = "${pkgs.jellyseerr}/bin/jellyseerr"; # Using jellyseerr package as Seerr base
 WorkingDirectory = cfg.stateDir;

 EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;

 MemoryMax = "1G";
 CPUWeight = 30;
 OOMScoreAdjust = 400;

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 MemoryDenyWriteExecute = false; 

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/seerr" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-app-semaphore.nix | Format: .nix | Größe: 664 B
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-30-AUT-006";
 title = "Semaphore";
 description = "Ansible Web UI (Placeholder - Not yet implemented).";
 layer = 20;
 nixpkgs.category = "services/admin";
 capabilities = [ "automation/ansible" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.semaphore = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for semaphore module";
 };

 config = lib.mkIf config.my.services.semaphore.enable {

 };
}

``n---

* Pfad: modules\apps\service-app-vaultwarden.nix | Format: .nix | Größe: 2,16 KB
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-60-APP-007";
 title = "Vaultwarden (SRE Exhausted)";
 description = "Tightly sandboxed password manager with Wake-on-Access (Socket Activation).";
 layer = 60;
 nixpkgs.category = "services/security";
 capabilities = ["security/passwords" "security/socket-activation"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 port = config.my.ports.vaultwarden;

 secretEnv = config.sops.secrets.vaultwarden_env.path;
in {
 options.my.meta.vaultwarden = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for vaultwarden module";
 };

 config = lib.mkIf config.my.services.vaultwarden.enable {
 services.vaultwarden = {
 enable = true;
 config = {
 ROCKET_ADDRESS = "127.0.0.1";
 ROCKET_PORT = port;
 SIGNUPS_ALLOWED = false;
 INVITATIONS_ALLOWED = true;
 SHOW_PASSWORD_HINT = false;
 DATABASE_MAX_CONNS = 10;
 };
 environmentFile = secretEnv;
 };

 systemd.sockets.vaultwarden = {
 description = "Vaultwarden Socket";
 wantedBy = ["sockets.target"];
 listenStreams = [(toString port)];
 };

 systemd.services.vaultwarden = {
 wantedBy = lib.mkForce [];
 requires = ["vaultwarden.socket"];
 after = ["vaultwarden.socket"];
 serviceConfig = {
 ProtectSystem = lib.mkForce "strict";
 ReadWritePaths = ["/var/lib/vaultwarden"];
 MemoryDenyWriteExecute = lib.mkForce true;
 RestrictAddressFamilies = lib.mkForce ["AF_INET" "AF_UNIX"];
 SystemCallFilter = lib.mkForce ["@system-service" "~@privileged" "~@resources"];
 NoNewPrivileges = lib.mkForce true;
 PrivateDevices = lib.mkForce true;
 PrivateTmp = lib.mkForce true;
 OOMScoreAdjust = 200;
 };
 };
 };
}

``n---

* Pfad: modules\apps\service-media-arr-wire.nix | Format: .nix | Größe: 1,59 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-ARR-WIR";
 title = "Arr-Wire (VPN Orchestration)";
 description = "Wires downloader services into specialized VPN namespaces.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["network/vpn" "automation/wiring"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

in {
 options.my.meta.arr_wire = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.vpnConfinement.enable {

 my.services.vpnConfinement.namespaces.media-vault = {
 wgConf = "/etc/nixos/secrets/vpn/privado-de.conf"; # Sops-Pfad
 killSwitch = true;
 };

 my.media.sabnzbd.useVPN = true;
 my.media.sonarr.useVPN = true;
 my.media.radarr.useVPN = true;

 };
}

``n---

* Pfad: modules\apps\service-media-default.nix | Format: .nix | Größe: 1,00 KB
``nix
{ lib, ... }:
let
 nms = {
 id = "NIXH-40-MED-006";
 title = "Default Media Services";
 description = "Master import module for the entire media stack.";
 layer = 40;
 nixpkgs.category = "system/settings";
 capabilities = [ "media/stack" "architecture/imports" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.service_media_default = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [

 ./service-media-arr-wire.nix
 ./service-media-jellyfin.nix
 ./service-media-jellyseerr.nix
 ./service-media-sonarr.nix
 ./service-media-radarr.nix
 ./service-media-lidarr.nix
 ./service-media-readarr.nix
 ./service-media-prowlarr.nix
 ./service-media-sabnzbd.nix
 ./service-media-recyclarr.nix
 ];
}

``n---

* Pfad: modules\apps\service-media-jellyfin.nix | Format: .nix | Größe: 3,18 KB
``nix
{ lib, pkgs, config, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-JEL-001";
 title = "Jellyfin (hardened)";
 description = "Hardware-accelerated media server with QuickSync and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = [ "media/jellyfin" "gpu/qsv" "security/sandboxing" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.media.jellyfin;
 srePaths = config.my.configs.paths;

 encodingXml = pkgs.writeText "encoding.xml" ''
 <?xml version="1.0" encoding="utf-8"?><EncodingOptions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><EncodingThreadCount>-1</EncodingThreadCount><TranscodingTempPath>${srePaths.tierB}/cache/jellyfin/transcoding-temp</TranscodingTempPath><EnableHardwareAcceleration>true</EnableHardwareAcceleration><HardwareAccelerationType>qsv</HardwareAccelerationType></EncodingOptions>
 '';

in
{
 options.my.meta.jellyfin = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.jellyfin.enable = lib.mkEnableOption "Jellyfin Media Server";

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "jellyfin";
 port = config.my.ports.jellyfin;
 useGPU = true; # QuickSync / UHD 630 Zugriff
 memoryMax = "4G";
 cpuWeight = 80;
 description = "Jellyfin hardened Instance";
 })

 {
 services.jellyfin = {
 enable = true;
 group = "media";
 };

 systemd.services.jellyfin = {

 environment = {
 OCL_ICD_VENDORS = "intel";
 LIBVA_DRIVER_NAME = "iHD"; # Force modern Intel Driver
 };

 preStart = ''
 mkdir -p ${srePaths.stateDir}/jellyfin/config
 cp -f ${encodingXml} ${srePaths.stateDir}/jellyfin/config/encoding.xml
 mkdir -p ${srePaths.tierB}/cache/jellyfin/transcoding-temp
 '';

 serviceConfig = {

 IPAddressAllow = [ "127.0.0.1/8" "::1/128" ] 
 ++ config.my.configs.network.lanCidrs
 ++ config.my.configs.network.tailnetCidrs;
 };
 };

 systemd.tmpfiles.rules = [
 "d /mnt/fast-pool/metadata/jellyfin 0775 jellyfin media -"
 ];
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-jellyseerr.nix | Format: .nix | Größe: 1,53 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-40-MED-008"; title = "Jellyseerr"; description = "Media requests."; layer = 40; nixpkgs.category = "services/media"; capabilities = [ "media/requests" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 2; };
 myLib = import ../core/lib-helpers.nix { inherit lib; };
 cfg = config.my.media.jellyseerr;
 defs = config.my.defaults;
in
{
 options.my.meta.jellyseerr = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 options.my.media.jellyseerr = { enable = lib.mkEnableOption "Jellyseerr"; stateDir = lib.mkOption { type = lib.types.str; default = "${config.my.configs.paths.stateDir}/jellyseerr"; }; port = lib.mkOption { type = lib.types.port; default = 5055; }; user = lib.mkOption { type = lib.types.str; default = "jellyseerr"; }; group = lib.mkOption { type = lib.types.str; default = "media"; }; netns = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; }; };
 config = lib.mkIf cfg.enable (lib.mkMerge [
 (myLib.mkService { inherit config; name = "jellyseerr"; port = cfg.port; useSSO = true; description = "Jellyseerr"; netns = cfg.netns; })
 {
 services.jellyseerr = { enable = true; port = cfg.port; };
 systemd.services.jellyseerr = {
 environment.CONFIG_DIRECTORY = lib.mkForce cfg.stateDir;
 serviceConfig = { User = cfg.user; Group = cfg.group; ReadWritePaths = [ cfg.stateDir ]; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; };
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-lidarr.nix | Format: .nix | Größe: 4,16 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-LID-001";
 title = "Lidarr (hardened)";
 description = "Music downloader with sandboxing and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/music" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.lidarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.lidarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.lidarr = {
 enable = lib.mkEnableOption "Lidarr Music Downloader";
 user = lib.mkOption { type = lib.types.str; default = "lidarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/lidarr/.config/Lidarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/lidarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "lidarr" 8686;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Lidarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "lidarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Lidarr Music Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.lidarr = {
 description = "Lidarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "LIDARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.lidarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "LIDARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/lidarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/music 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/lidarr" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-media-stack.nix | Format: .nix | Größe: 1003 B
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-40-MED-010";
 title = "Media Stack Activation";
 description = "Central toggle for activating the entire media stack and its default profiles.";
 layer = 40;
 nixpkgs.category = "system/settings";
 capabilities = [ "system/media-activation" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.service_media_media_stack = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for service-media-media-stack module";
 };

 config = {
 my.media = {
 defaults.domain = config.my.configs.identity.domain;
 defaults.netns = "media-vault";
 jellyfin.enable = true;
 sonarr.enable = true;
 radarr.enable = true;
 readarr.enable = true;
 prowlarr.enable = true;
 sabnzbd.enable = true;
 jellyseerr.enable = true;
 };
 };
}

``n---

* Pfad: modules\apps\service-media-prowlarr-setup.nix | Format: .nix | Größe: 4,83 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-PRO-SET";
 title = "Prowlarr Indexer Sync";
 description = "Idempotent API configuration for Prowlarr: Registering Radarr and Sonarr.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/indexer-management" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 prowlarrCfg = config.my.media.prowlarr;
 radarrCfg = config.my.media.radarr;
 sonarrCfg = config.my.media.sonarr;

in
{
 options.my.meta.prowlarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf prowlarrCfg.enable {
 systemd.services.prowlarr-setup = {
 description = "Prowlarr Indexer Sync (hardened)";
 after = [ "prowlarr.service" "radarr.service" "sonarr.service" "network.target" ];
 requires = [ "prowlarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = prowlarrCfg.user;
 Group = prowlarrCfg.group;

 LoadCredential = lib.flatten [
 (lib.optional (prowlarrCfg.apiKeyFile != null) "prowlarr-api-key:${toString prowlarrCfg.apiKeyFile}")
 (lib.optional (radarrCfg.apiKeyFile != null) "radarr-api-key:${toString radarrCfg.apiKeyFile}")
 (lib.optional (sonarrCfg.apiKeyFile != null) "sonarr-api-key:${toString sonarrCfg.apiKeyFile}")
 ];

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ExecStart = pkgs.writeShellScript "prowlarr-setup-script" ''
 set -euo pipefail

 get_key() {
 if [ -f "$CREDENTIALS_DIRECTORY/$1" ]; then cat "$CREDENTIALS_DIRECTORY/$1"; else echo ""; fi
 }

 PROWLARR_KEY=$(get_key "prowlarr-api-key")
 RADARR_KEY=$(get_key "radarr-api-key")
 SONARR_KEY=$(get_key "sonarr-api-key")

 if [ -z "$PROWLARR_KEY" ]; then
 echo " ERROR: Prowlarr API key missing."
 exit 1
 fi

 PROWLARR_URL="http://127.0.0.1:${toString prowlarrCfg.settings.server.port}/api/v1"

 echo " Waiting for Prowlarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $PROWLARR_KEY" "$PROWLARR_URL/system/status" > /dev/null; then
 echo " Prowlarr API is online."
 break
 fi
 sleep 5
 done

 register_app() {
 local name=$1
 local port=$2
 local key=$3
 local implementation=$4

 if [ -z "$key" ]; then
 echo " Skipping $name: No API key provided."
 return
 fi

 echo " Checking $name integration..."
 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $PROWLARR_KEY" "$PROWLARR_URL/applications" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$name\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 echo " Registering $name in Prowlarr..."
 ${pkgs.curl}/bin/curl -s -X POST "$PROWLARR_URL/applications" \
 -H "X-Api-Key: $PROWLARR_KEY" \
 -H "Content-Type: application/json" \
 -d "{
 \"name\": \"$name\",
 \"configContract\": \"$implementation\",
 \"implementation\": \"$implementation\",
 \"fields\": [
 {\"name\": \"baseUrl\", \"value\": \"http://127.0.0.1:$port\"},
 {\"name\": \"apiKey\", \"value\": \"$key\"}
 ],
 \"syncLevel\": \"fullAndIndexers\"
 }" > /dev/null
 echo " $name registered."
 else
 echo " $name already registered (ID: $EXISTING)."
 fi
 }

 register_app "Radarr" "${toString radarrCfg.settings.server.port}" "$RADARR_KEY" "Radarr"
 register_app "Sonarr" "${toString sonarrCfg.settings.server.port}" "$SONARR_KEY" "Sonarr"

 echo " Prowlarr Indexer Sync setup completed."
 '';

 RemainAfterExit = true;
 };
 };
 };
}

``n---

* Pfad: modules\apps\service-media-prowlarr.nix | Format: .nix | Größe: 4,11 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-PRO-001";
 title = "Prowlarr (hardened)";
 description = "Indexer manager for *arr apps with sandboxing.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/indexer-management" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.prowlarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.prowlarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.prowlarr = {
 enable = lib.mkEnableOption "Prowlarr Indexer Manager";
 user = lib.mkOption { type = lib.types.str; default = "prowlarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/prowlarr/.config/Prowlarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/prowlarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "prowlarr" 9696;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Prowlarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "prowlarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Prowlarr Indexer Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 ];
 })

 {
 systemd.services.prowlarr = {
 description = "Prowlarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "PROWLARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.prowlarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "PROWLARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "1G"; # Prowlarr needs less than Sonarr/Radarr
 CPUWeight = 20; 
 OOMScoreAdjust = 700;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/prowlarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/prowlarr" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-radarr-setup.nix | Format: .nix | Größe: 3,93 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-RAD-SET";
 title = "Radarr API Setup";
 description = "Idempotent API configuration for Radarr: Root Folders, Quality Profiles.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/movies" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.media.radarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.radarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {
 systemd.services.radarr-setup = {
 description = "Radarr API Configuration (hardened)";
 after = [ "radarr.service" "network.target" ];
 requires = [ "radarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = cfg.user;
 Group = cfg.group;

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "radarr-api-key:${toString cfg.apiKeyFile}";

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ExecStart = pkgs.writeShellScript "radarr-setup-script" ''
 set -euo pipefail

 if [ -d "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/radarr-api-key" ]; then
 API_KEY=$(cat "$CREDENTIALS_DIRECTORY/radarr-api-key")
 else
 echo " ERROR: Radarr API key not found in credentials directory."
 exit 1
 fi

 URL="http://127.0.0.1:${toString cfg.settings.server.port}/api/v3"

 echo " Waiting for Radarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $API_KEY" "$URL/system/status" > /dev/null; then
 echo " Radarr API is online."
 break
 fi
 if [ $i -eq 12 ]; then
 echo " ERROR: Radarr API timed out."
 exit 1
 fi
 sleep 5
 done

 ROOT_PATH="${srePaths.mediaLibrary}/movies"
 echo " Checking root folder: $ROOT_PATH"

 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $API_KEY" "$URL/rootfolder" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.path == \"$ROOT_PATH\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 ${pkgs.curl}/bin/curl -s -X POST "$URL/rootfolder" \
 -H "X-Api-Key: $API_KEY" \
 -H "Content-Type: application/json" \
 -d "{\"path\":\"$ROOT_PATH\"}" > /dev/null
 echo " Created root folder $ROOT_PATH"
 else
 echo " Root folder $ROOT_PATH already exists (ID: $EXISTING)"
 fi

 echo " API Setup for Radarr completed successfully."
 '';

 RemainAfterExit = true;
 };
 };
 in {

 };
}

``n---

* Pfad: modules\apps\service-media-radarr.nix | Format: .nix | Größe: 4,03 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-RAD-001";
 title = "Radarr (hardened)";
 description = "Movie downloader with sandboxing and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/movies" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.radarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.radarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.radarr = {
 enable = lib.mkEnableOption "Radarr Movie Downloader";
 user = lib.mkOption { type = lib.types.str; default = "radarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/radarr/.config/Radarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/radarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "radarr" 7878;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Radarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "radarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Radarr Movie Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.radarr = {
 description = "Radarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "RADARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = "${pkgs.radarr}/bin/Radarr -nobrowser -data='${cfg.stateDir}'";
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "RADARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30; # Lower than Sabnzbd
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/radarr/MediaCover"
 ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/movies 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/radarr" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-readarr.nix | Format: .nix | Größe: 4,17 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-REA-001";
 title = "Readarr (hardened)";
 description = "Book management and downloader with sandboxing.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/books" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.readarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.readarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.readarr = {
 enable = lib.mkEnableOption "Readarr Book Manager";
 user = lib.mkOption { type = lib.types.str; default = "readarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/readarr/.config/Readarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/readarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "readarr" 8787;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Readarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "readarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Readarr Book Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.readarr = {
 description = "Readarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "READARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.readarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "READARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/readarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/books 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/readarr" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-recyclarr.nix | Format: .nix | Größe: 1,65 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-40-MED-014";
 title = "Recyclarr (SRE Declarative)";
 description = "Declarative management of Radarr/Sonarr quality profiles and custom formats.";
 layer = 40;
 nixpkgs.category = "services/misc";
 capabilities = [ "media/quality-profiles" "automation/declarative-config" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.recyclarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for recyclarr module";
 };

 config = lib.mkIf config.my.services.recyclarr.enable {
 services.recyclarr = {
 enable = true;
 configuration = {
 sonarr.tv = { base_url = "https://sonarr.${config.my.configs.identity.domain}"; api_key = "!env_var SONARR_API_KEY"; include = [ { template = "v3-sonarr-web-dl-1080p-v2-remux-720p"; } ]; };
 radarr.movies = { base_url = "https://radarr.${config.my.configs.identity.domain}"; api_key = "!env_var RADARR_API_KEY"; include = [ { template = "v3-radarr-web-dl-1080p-v2-remux-720p"; } ]; };
 };
 };
 systemd.services.recyclarr.serviceConfig = {
 LoadCredential = [ "sonarr_api:${config.sops.secrets.sonarr_api_key.path}" "radarr_api:${config.sops.secrets.radarr_api_key.path}" ];
 Environment = [ "SONARR_API_KEY_FILE=/run/credentials/recyclarr.service/sonarr_api" "RADARR_API_KEY_FILE=/run/credentials/recyclarr.service/radarr_api" ];
 ProtectSystem = "strict"; PrivateTmp = true; NoNewPrivileges = true; MemoryMax = "512M"; OOMScoreAdjust = 1000;
 };
 };
}

``n---

* Pfad: modules\apps\service-media-sabnzbd.nix | Format: .nix | Größe: 4,40 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-SAB-001";
 title = "SABnzbd (hardened)";
 description = "Hardened Usenet download client with ABC-Tiering and Secret-Isolation.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/usenet" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.media.sabnzbd;
 srePaths = config.my.configs.paths;
in
{
 options.my.meta.sabnzbd = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.sabnzbd = {
 enable = lib.mkEnableOption "SABnzbd Usenet Downloader";
 user = lib.mkOption { type = lib.types.str; default = "sabnzbd"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = 8080; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/sabnzbd"; 
 description = "State directory (Tier A/Persist)";
 };
 incompleteDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.tierB}/downloads/incomplete"; 
 description = "Fast cache for active downloads (Tier B)";
 };
 downloadDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.tierC}/downloads/usenet"; 
 description = "Final storage for downloads (Tier C)";
 };

 apiKeyFile = lib.mkOption { 
 type = lib.types.nullOr lib.types.path; 
 default = null; 
 description = "Path to the SABnzbd API Key (via Sops)";
 };
 nzbKeyFile = lib.mkOption { 
 type = lib.types.nullOr lib.types.path; 
 default = null; 
 description = "Path to the SABnzbd NZB Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "sabnzbd";
 port = cfg.port;
 useSSO = true;
 description = "SABnzbd Usenet Client";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.incompleteDir 
 cfg.downloadDir 
 ];
 })

 {
 services.sabnzbd = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 };

 systemd.services.sabnzbd = {

 environment.SAB_CONFIG_FILE = "${cfg.stateDir}/sabnzbd.ini";

 serviceConfig = {

 LoadCredential = lib.flatten [
 (lib.optional (cfg.apiKeyFile != null) "SAB_API_KEY:${toString cfg.apiKeyFile}")
 (lib.optional (cfg.nzbKeyFile != null) "SAB_NZB_KEY:${toString cfg.nzbKeyFile}")
 ];

 MemoryMax = "2G";
 CPUWeight = 40; # Lower priority than Jellyfin
 OOMScoreAdjust = 500; # Kill SABnzbd before Core services

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 NoNewPrivileges = true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.incompleteDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${cfg.downloadDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/sabnzbd" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-services-common.nix | Format: .nix | Größe: 1,05 KB
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-40-MED-016";
 title = "Services Common";
 description = "Common media service defaults and global configuration attributes.";
 layer = 40;
 nixpkgs.category = "system/settings";
 capabilities = [ "media/defaults" "architecture/common" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.service_media_services_common = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for service-media-services-common module";
 };

 options.my.media.defaults = {
 domain = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; };
 hostPrefix = lib.mkOption { type = lib.types.str; default = "nix"; };
 netns = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; };
 };

 config.assertions = [ { assertion = config.my.media.defaults.domain != null; message = "my.media.defaults.domain must be set."; } ];
}

``n---

* Pfad: modules\apps\service-media-sonarr-setup.nix | Format: .nix | Größe: 3,61 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-SON-SET";
 title = "Sonarr API Setup";
 description = "Idempotent API configuration for Sonarr: Root Folders, Quality Profiles.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/tv" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.media.sonarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.sonarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {
 systemd.services.sonarr-setup = {
 description = "Sonarr API Configuration (hardened)";
 after = [ "sonarr.service" "network.target" ];
 requires = [ "sonarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = cfg.user;
 Group = cfg.group;

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "sonarr-api-key:${toString cfg.apiKeyFile}";

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ExecStart = pkgs.writeShellScript "sonarr-setup-script" ''
 set -euo pipefail

 if [ -d "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/sonarr-api-key" ]; then
 API_KEY=$(cat "$CREDENTIALS_DIRECTORY/sonarr-api-key")
 else
 echo " ERROR: Sonarr API key not found in credentials directory."
 exit 1
 fi

 URL="http://127.0.0.1:${toString cfg.settings.server.port}/api/v3"

 echo " Waiting for Sonarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $API_KEY" "$URL/system/status" > /dev/null; then
 echo " Sonarr API is online."
 break
 fi
 if [ $i -eq 12 ]; then
 echo " ERROR: Sonarr API timed out."
 exit 1
 fi
 sleep 5
 done

 ROOT_PATH="${srePaths.mediaLibrary}/tv"
 echo " Checking root folder: $ROOT_PATH"

 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $API_KEY" "$URL/rootfolder" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.path == \"$ROOT_PATH\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 ${pkgs.curl}/bin/curl -s -X POST "$URL/rootfolder" \
 -H "X-Api-Key: $API_KEY" \
 -H "Content-Type: application/json" \
 -d "{\"path\":\"$ROOT_PATH\"}" > /dev/null
 echo " Created root folder $ROOT_PATH"
 else
 echo " Root folder $ROOT_PATH already exists (ID: $EXISTING)"
 fi

 echo " API Setup for Sonarr completed successfully."
 '';

 RemainAfterExit = true;
 };
 };
 };
}

``n---

* Pfad: modules\apps\service-media-sonarr.nix | Format: .nix | Größe: 4,16 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-SON-001";
 title = "Sonarr (hardened)";
 description = "TV series downloader with sandboxing and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/tv" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.sonarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.sonarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.sonarr = {
 enable = lib.mkEnableOption "Sonarr TV Series Downloader";
 user = lib.mkOption { type = lib.types.str; default = "sonarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/sonarr/.config/NzbDrone"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/sonarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "sonarr" 8989;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Sonarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "sonarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Sonarr TV Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.sonarr = {
 description = "Sonarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "SONARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.sonarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "SONARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/sonarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/tv 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/sonarr" ];
 };
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-_lib.nix | Format: .nix | Größe: 3,66 KB
``nix
{ lib, pkgs, ... }:
{ name, port, stateOption, defaultStateDir, supportsUserGroup ? true, defaultUser ? name, defaultGroup ? "media", statePathSuffix ? null, useVpn ? false, extraServiceConfig ? {} }:
{ config, ... }:
let
 myLib = import ../core/lib-helpers.nix { inherit lib; };
 cfg = config.my.media.${name};
 sreConfig = config.my.configs;
 srePaths = config.my.configs.paths;

 nativePort = if name == "sonarr" then 8989 
 else if name == "radarr" then 7878 
 else if name == "prowlarr" then 9696 
 else if name == "readarr" then 8787 
 else if name == "lidarr" then 8686 
 else if name == "sabnzbd" then 8080 
 else if name == "jellyfin" then 8096 
 else if name == "jellyseerr" then 5055 
 else port;

 stateValue = if statePathSuffix == null 
 then "${srePaths.stateDir}/${name}" 
 else "${srePaths.stateDir}/${name}/${statePathSuffix}";

 vpnConfig = lib.optionalAttrs useVpn { 
 requires = [ "wireguard-vault.service" ]; 
 after = [ "wireguard-vault.service" ]; 
 serviceConfig = { 
 NetworkNamespacePath = "/var/run/netns/media-vault"; 
 RestrictAddressFamilies = lib.mkForce [ "AF_INET" "AF_INET6" "AF_UNIX" "AF_NETLINK" ]; 
 }; 
 };

 serviceBase = myLib.mkService { 
 inherit config; 
 name = name; 
 port = nativePort; 
 useSSO = true; 
 description = "${name} Service (hardened)"; 
 netns = if useVpn then "media-vault" else null;
 isStream = (name == "jellyfin"); # PROXY_STREAM PIPELINE AKTIVIEREN
 };
in
{
 options.my.media.${name} = {
 enable = lib.mkEnableOption "the ${name} service";
 stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/${name}"; };
 user = lib.mkOption { type = lib.types.str; default = defaultUser; };
 group = lib.mkOption { type = lib.types.str; default = defaultGroup; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 serviceBase
 {
 services.${name} = { 
 enable = true; 
 openFirewall = lib.mkForce false; 
 ${stateOption} = stateValue; 
 } // lib.optionalAttrs supportsUserGroup { 
 user = cfg.user; 
 group = cfg.group; 
 } // lib.optionalAttrs (name == "jellyfin") { 
 cacheDir = "/mnt/fast-pool/cache/jellyfin"; 
 };

 systemd.services.${name} = lib.mkMerge [ 
 vpnConfig 
 { 
 serviceConfig = { 
 ProtectSystem = lib.mkForce "full"; 
 ProtectHome = true; 
 PrivateTmp = true; 
 NoNewPrivileges = true; 
 MemoryMax = "${toString sreConfig.resourceLimits.maxMediaRamMB}M"; 
 CPUWeight = 50; 
 OOMScoreAdjust = 500; 
 ReadWritePaths = [ 
 cfg.stateDir 
 srePaths.mediaLibrary 
 "${srePaths.storagePool}/downloads" 
 "/mnt/fast-pool/cache" 
 "/mnt/fast-pool/metadata" 
 ]; 
 BindPaths = lib.mkIf (name == "sonarr" || name == "radarr" || name == "readarr" || name == "prowlarr" || name == "lidarr") [ 
 "/mnt/fast-pool/metadata/${name}:/var/lib/${name}/MediaCover" 
 ]; 
 }; 
 } 
 extraServiceConfig 
 ];

 systemd.tmpfiles.rules = [ 
 "d ${cfg.stateDir} 0750 ${cfg.user} media -" 
 "d /mnt/fast-pool/metadata/${name} 0775 ${cfg.user} media -" 
 "d /mnt/fast-pool/cache/${name} 0775 ${cfg.user} media -" 
 ];
 }
 ]);
}

``n---

* Pfad: modules\apps\service-media-_servarr-factory.nix | Format: .nix | Größe: 2,20 KB
``nix
{ lib, pkgs }:
let
 servarrHardening = { CapabilityBoundingSet = ""; NoNewPrivileges = true; ProtectHome = true; ProtectClock = true; ProtectKernelLogs = true; PrivateTmp = true; PrivateDevices = true; PrivateUsers = true; ProtectKernelTunables = true; ProtectKernelModules = true; ProtectControlGroups = true; RestrictSUIDSGID = true; RemoveIPC = true; UMask = "0022"; ProtectHostname = true; ProtectProc = "invisible"; ProcSubset = "pid"; RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ]; RestrictNamespaces = true; RestrictRealtime = true; LockPersonality = true; SystemCallArchitectures = "native"; SystemCallFilter = [ "@system-service" "~@privileged" "~@debug" "~@mount" "@chown" ]; };
in
{
 mkServarrSettingsOptions = name: port: lib.mkOption { type = lib.types.submodule { freeformType = (pkgs.formats.ini { }).type; options = { update = { mechanism = lib.mkOption { type = with lib.types; nullOr (enum [ "external" "builtIn" "script" ]); default = "external"; }; automatically = lib.mkOption { type = lib.types.bool; default = false; }; }; server = { port = lib.mkOption { type = lib.types.port; default = port; }; bindAddress = lib.mkOption { type = lib.types.str; default = "127.0.0.1"; }; }; log = { analyticsEnabled = lib.mkOption { type = lib.types.bool; default = false; }; }; }; }; default = { }; };
 mkServarrEnvironmentFiles = name: lib.mkOption { type = lib.types.listOf lib.types.path; default = [ ]; };
 mkServarrSettingsEnvVars = name: settings: lib.pipe settings [ (lib.mapAttrsRecursive (path: value: lib.optionalAttrs (value != null) { name = lib.toUpper "${name}__${lib.concatStringsSep "__" path}"; value = toString (if lib.isBool value then lib.boolToString value else value); })) (lib.collect (x: lib.isString x.name or false && lib.isString x.value or false)) lib.listToAttrs ];
 mkServarrHardening = servarrHardening;
 mkServarrTmpfiles = name: cfg: { "10-${name}".${cfg.stateDir}.d = { inherit (cfg) user group; mode = "0700"; }; };
 mkServarrUserGroup = name: cfg: defaultGroup: { users.users.${cfg.user} = lib.mkIf (cfg.user == name) { group = cfg.group; home = cfg.stateDir; isSystemUser = true; description = "${name} service user"; }; users.groups.${cfg.group} = lib.mkDefault { }; };
}

``n---

* Pfad: modules\apps\SERVICE_TEMPLATE.nix | Format: .nix | Größe: 1,47 KB
``nix
{ config, lib, pkgs, ... }:

let
 domain = config.my.configs.identity.domain;

 serviceName = "<service-name>";
in
{
 services.${serviceName} = {
 enable = true;
 };

 systemd.services.${serviceName}.serviceConfig = {
 NoNewPrivileges = lib.mkForce true;
 PrivateTmp = lib.mkForce true;
 PrivateDevices = lib.mkForce true;
 ProtectHome = lib.mkForce true;
 ProtectSystem = lib.mkForce "strict";
 ProtectKernelTunables = lib.mkForce true;
 ProtectKernelModules = lib.mkForce true;
 ProtectControlGroups = lib.mkForce true;
 RestrictRealtime = lib.mkForce true;
 RestrictSUIDSGID = lib.mkForce true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
}

``n---

* Pfad: modules\core\auto-locale.nix | Format: .nix | Größe: 2,25 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-003";
 title = "Auto Locale (Zero-Touch)";
 description = "Intelligent geolocation-based system localization with robust fallbacks and state persistence.";
 layer = 00;
 nixpkgs.category = "system/localization";
 capabilities = ["automation/geolocate" "system/boot-optimization"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 cfg = config.my.autoLocale;

 geolocateScript = pkgs.writeShellScript "geolocate" ''
 set -euo pipefail

 COUNTRY=$(${pkgs.curl}/bin/curl -sf --max-time 5 "http://ip-api.com/json/?fields=countryCode" | ${pkgs.jq}/bin/jq -r '.countryCode' 2>/dev/null || echo "")

 if [ -z "$COUNTRY" ] || [ "$COUNTRY" == "null" ]; then
 COUNTRY=$(${pkgs.curl}/bin/curl -sf --max-time 5 "https://ipapi.co/country_name/" 2>/dev/null || echo "Germany")
 [[ "$COUNTRY" == "Germany" ]] && COUNTRY="DE"
 fi

 echo "''${COUNTRY:-DE}"
 '';

 cacheFile = "/var/lib/auto-locale/state.json";
in {
 options.my.meta.auto_locale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf (cfg.enable or false) {

 time.timeZone = lib.mkDefault "Europe/Berlin";
 i18n.defaultLocale = lib.mkDefault "de_DE.UTF-8";

 systemd.services.auto-locale-sync = {
 description = "Auto-Locale: Sync System State with Geolocation";
 wantedBy = ["multi-user.target"];
 after = ["network-online.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 };
 script = ''
 mkdir -p "$(dirname ${cacheFile})"
 COUNTRY=$(${geolocateScript})
 echo "{\"country\": \"$COUNTRY\", \"last_sync\": \"$(date -Iseconds)\"}" > ${cacheFile}
 logger -t auto-locale "hardened Sync: System localized to $COUNTRY"
 '';
 };

 environment.systemPackages = with pkgs; [ curl jq ];
 };
}

``n---

* Pfad: modules\core\backup.nix | Format: .nix | Größe: 3,02 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-004";
 title = "Backup (Restic edition)";
 description = "Hardened Restic backup logic with atomical Cloud-Sync and failure-safe ExecConditions.";
 layer = 00;
 nixpkgs.category = "services/backup";
 capabilities = ["backup/restic" "cloud/sync" "security/integrity-check"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 localRepo = "/mnt/archive/.restic-vault";
 maxSizeGB = 20; # Erhöht für Media-Metadaten
in {
 options.my.meta.backup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.backup.enable {
 services.restic.backups.daily = {
 initialize = true;
 repository = localRepo;
 passwordFile = config.sops.secrets.restic_password.path; # Sops Integration

 paths = [
 "/data/state"
 "/data/metadata"
 "/etc/nixos"
 "/var/lib/pocket-id"
 "/persist" # Impermanence Support
 ];

 exclude = [ "**/.cache" "**/tmp" "**/node_modules" "*.log" ];

 createWrapper = true;
 runCheck = true;
 checkOpts = ["--with-cache"];

 extraOptions = [ "--exclude-caches" "--compression=max" ];
 inhibitsSleep = true;

 backupPrepareCommand = ''
 DATA_SIZE=$(${pkgs.coreutils}/bin/du -sb /data/state /etc/nixos | ${pkgs.gawk}/bin/awk '{sum+=$1} END {print sum}')
 LIMIT=$(( ${toString maxSizeGB} * 1024 * 1024 * 1024 ))
 if [ "$DATA_SIZE" -gt "$LIMIT" ]; then
 echo " BACKUP ABGEBROCHEN: Datenmenge ($DATA_SIZE) > Limit ($LIMIT)!"
 exit 1
 fi
 '';

 backupCleanupCommand = ''
 echo " Starte Cloud-Sync..."
 ${pkgs.rclone}/bin/rclone sync ${localRepo} cloud-backup:nixhome-vault --bwlimit 5M
 echo " Cloud-Sync abgeschlossen."
 '';

 timerConfig = {
 OnCalendar = "02:00";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];
 };

 services.restic.backups.persist = {
 initialize = true;
 repository = "s3:https://s3.eu-central-003.backblazeb2.com/nixhome-persist";
 passwordFile = config.sops.secrets.restic_password.path;
 environmentFile = config.sops.templates."backblaze-restic.env".path;

 paths = [ "/persist" ];
 exclude = [ "**/.cache" "**/tmp" ];

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];

 timerConfig = {
 OnCalendar = "03:00";
 Persistent = true;
 };

 extraOptions = [ "--compression=max" ];
 };

 environment.systemPackages = with pkgs; [restic rclone];
 };
}

``n---

* Pfad: modules\core\boot-safeguard.nix | Format: .nix | Größe: 648 B
``nix
{
 config,
 lib,
 ...
}: let
 nms = {
 id = "NIXH-00-COR-001";
 title = "Boot Safeguard";
 description = "Hardened boot configuration with UEFI focus and systemd-boot.";
 layer = 00;
 };
in {
 boot.loader.systemd-boot = {
 enable = true;
 configurationLimit = 10; # Gegen Speicherüberlauf in /boot
 consoleMode = "max";
 };

 boot.loader.efi.canTouchEfiVariables = true;

 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "rd.udev.log_level=3"
 ];

 boot.tmp.cleanOnBoot = true;
 boot.initrd.verbose = false;
}

``n---

* Pfad: modules\core\central-configs-plan.nix | Format: .nix | Größe: 697 B
``nix
{ lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-006";
 title = "Central Configs Plan";
 description = "Roadmap and architectural planning for centralized configuration management.";
 layer = 0;
 nixpkgs.category = "documentation/architecture";
 capabilities = ["architecture/roadmap"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.central_configs_plan = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for central-configs-plan module";
 };

 config = {

 };
}

``n---

* Pfad: modules\core\config-merger.nix | Format: .nix | Größe: 2,79 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-007";
 title = "Config Merger";
 description = "Dynamic bridge between NixOS declarations and user-managed JSON overrides for runtime services.";
 layer = 0;
 nixpkgs.category = "tools/admin";
 capabilities = ["config/merger" "system/runtime-config"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 runDir = "/run/nixhome";
 userConfig = "/var/lib/nixhome/user-config.json";
 finalConfig = "${runDir}/config.json";

 nixDefaults = pkgs.writeText "nix-defaults.json" (builtins.toJSON {
 domain = config.my.configs.identity.domain;
 email = config.my.configs.identity.email;
 lanIP = config.my.configs.network.lanIP;
 hostName = config.my.configs.identity.host;
 bastelmodus = config.my.configs.bastelmodus;
 });

 mergerScript = pkgs.writeShellScript "nixhome-config-merger" ''
 set -euo pipefail
 mkdir -p ${runDir}
 if [ ! -f "${userConfig}" ]; then
 echo "{}" > "${userConfig}"
 chown root:root "${userConfig}"
 chmod 644 "${userConfig}"
 fi
 ${pkgs.jq}/bin/jq -s '.[0] * .[1]' "${nixDefaults}" "${userConfig}" > "${finalConfig}.tmp"
 mv "${finalConfig}.tmp" "${finalConfig}"
 chmod 644 "${finalConfig}"
 '';

 applyScript = pkgs.writeShellScriptBin "nixhome-apply" ''
 set -euo pipefail
 echo " Merging configuration..."
 systemctl start nixhome-config-merger.service
 echo " Reloading services..."
 if systemctl is-active caddy >/dev/null 2>&1; then systemctl reload caddy; fi
 if systemctl is-active pocket-id >/dev/null 2>&1; then systemctl restart pocket-id; fi
 echo " Fertig!"
 '';
in {
 options.my.meta.config_merger = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for config-merger module";
 };

 config = lib.mkIf config.my.services.configMerger.enable {
 systemd.services.nixhome-config-merger = {
 description = "Merge Nix Defaults with User JSON Config";
 before = ["caddy.service" "pocket-id.service" "landing-zone-ui.service"];
 wantedBy = ["multi-user.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 ExecStart = mergerScript;

 Restart = "always";
 RestartSec = "10s";
 OOMScoreAdjust = -1000;
 };
 };
 environment.systemPackages = [applyScript pkgs.jq];
 systemd.tmpfiles.rules = ["d /var/lib/nixhome 0755 root root -"];
 };
}

``n---

* Pfad: modules\core\configs.nix | Format: .nix | Größe: 3,80 KB
``nix
{ lib, myLib, ... }: {

 options.my.configs = {
 identity = {
 domain = myLib.mkTracedOption "SRC-OBS-220" (lib.mkOption { 
 type = lib.types.str; 
 default = "m7c5.de"; 
 description = "Global base domain (hardened)";
 });
 subdomain = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption { 
 type = lib.types.str; 
 default = "nix"; 
 description = "NixOS specific subdomain";
 });
 user = myLib.mkTracedOption "SRC-CHAT-748" (lib.mkOption {
 type = lib.types.str;
 default = "moritz";
 description = "Primary system administrator user";
 });
 email = lib.mkOption {
 type = lib.types.str;
 default = "git@m7c5.de";
 description = "Global administrator email";
 };
 host = lib.mkOption {
 type = lib.types.str;
 default = "nixhome";
 description = "The target hostname";
 };
 };

 network = {
 lanIP = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption { 
 type = lib.types.str; 
 default = "192.168.2.73"; 
 description = "Primary LAN IP of the target host";
 });
 lanCidr = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
 type = lib.types.str;
 default = "192.168.2.0/24";
 description = "Trusted local network range";
 });
 lanCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
 type = lib.types.listOf lib.types.str;
 default = [ "192.168.2.0/24" ];
 description = "List of trusted LAN ranges";
 });
 tailnetCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
 type = lib.types.listOf lib.types.str;
 default = [ "100.64.0.0/10" ];
 description = "Tailscale network range";
 });
 };

 locale = {
 default = lib.mkOption { type = lib.types.str; default = "de_DE.UTF-8"; };
 timezone = lib.mkOption { type = lib.types.str; default = "Europe/Berlin"; };
 };

 hardware = {
 ramGB = myLib.mkTracedOption "SRC-CHAT-160" (lib.mkOption {
 type = lib.types.int;
 default = 16;
 description = "Physical RAM in GB (for ZRAM tuning)";
 });
 intelGpu = lib.mkOption { type = lib.types.bool; default = true; };
 cpuType = lib.mkOption { type = lib.types.str; default = "intel"; };
 };

 paths = {
 stateDir = lib.mkOption { type = lib.types.str; default = "/var/lib"; };
 tierA = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/persist"; description = "NVMe: Persistent State"; });
 tierB = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/cache"; description = "SSD: Cache & Transcodes"; });
 tierC = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; description = "HDD: Bulk Media Archive"; });
 mediaLibrary = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool/media"; };
 storagePool = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; };
 };

 bastelmodus = lib.mkOption {
 type = lib.types.bool;
 default = false;
 description = "If true, disables some security assertions for easier debugging.";
 };

 vpn = {
 privado = lib.mkOption {
 type = lib.types.attrs;
 default = {};
 description = "Privado VPN configuration (placeholder)";
 };
 };

 resourceLimits = {
 maxMediaRamMB = lib.mkOption { type = lib.types.int; default = 4096; };
 };
 };
}

``n---

* Pfad: modules\core\defaults.nix | Format: .nix | Größe: 3,89 KB
``nix
{lib, ...}: let

 nms = {
 id = "NIXH-00-COR-009";
 title = "00-defaults";
 description = "Shared global defaults for network namespaces, filesystem prefixes, and security conventions.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["architecture/defaults" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };
in {
 options.my.meta.defaults = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for defaults module";
 };

 options.my.defaults = {

 netns = lib.mkOption {
 type = lib.types.nullOr lib.types.str;
 default = null;
 description = "Standard Network-Namespace für alle Dienste.";
 };

 bindAddress = lib.mkOption {
 type = lib.types.str;
 default = "127.0.0.1";
 description = "Standard-Bind-Adresse für alle Dienste.";
 };

 locale = {
 timezone = lib.mkOption {
 type = lib.types.str;
 default = "Europe/Berlin";
 };
 language = lib.mkOption {
 type = lib.types.str;
 default = "de_DE.UTF-8";
 };
 dateOrder = lib.mkOption {
 type = lib.types.enum ["DMY" "MDY" "YMD"];
 default = "DMY";
 };
 };

 ocr = {
 languages = lib.mkOption {
 type = lib.types.listOf lib.types.str;
 default = ["deu" "eng"];
 };
 outputType = lib.mkOption {
 type = lib.types.enum ["pdfa" "pdfa-1" "pdfa-2" "pdfa-3" "pdf" "none"];
 default = "pdfa";
 };
 };

 paths = {
 statePrefix = lib.mkOption {
 type = lib.types.str;
 default = "/data/state";
 };
 mediaRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/media";
 };
 downloadsDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/media/downloads";
 };
 fastPoolRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool";
 };
 documentRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/documents";
 };
 backupRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/backup";
 };
 };

 security = {
 defaultGroup = lib.mkOption {
 type = lib.types.str;
 default = "media";
 };
 ssoEnable = lib.mkOption {
 type = lib.types.bool;
 default = true;
 };
 };

 observability = {
 logLevel = lib.mkOption {
 type = lib.types.enum ["DEBUG" "INFO" "WARNING" "ERROR"];
 default = "WARNING";
 };
 metricsPortOffset = lib.mkOption {
 type = lib.types.int;
 default = 9000;
 };
 };
 };
}

``n---

* Pfad: modules\core\fail2ban.nix | Format: .nix | Größe: 3,08 KB
``nix
{
 config,
 pkgs,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-010";
 title = "Fail2ban (Edge Hardened)";
 description = "Aggressive protection with deep Caddy JSON log inspection and incremental banning logic.";
 layer = 00;
 nixpkgs.category = "services/security";
 capabilities = ["security/bruteforce-protection" "network/hardening" "caddy/security"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 sshPort = toString config.my.ports.ssh;
in {
 options.my.meta.fail2ban = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.fail2ban.enable or true) {
 services.fail2ban = {
 enable = true;

 banaction = "nftables-multiport";
 banaction-allports = "nftables-allports";

 ignoreIP = [
 "127.0.0.1/8" "::1"
 config.my.configs.network.lanCidr
 ];

 bantime = "1h";
 maxretry = 5;

 bantime-increment = {
 enable = true;
 multipliers = "1 2 4 8 16 32 64";
 maxtime = "168h"; # Max 1 Woche
 };

 jails = {
 sshd.settings = {
 enabled = true;
 port = sshPort;
 mode = "aggressive";
 };

 caddy-auth.settings = {
 enabled = true;
 port = "http,https";
 filter = "caddy-json";
 backend = "systemd";
 maxretry = 3;
 findtime = "5m";
 bantime = "24h";
 };

 caddy-scan.settings = {
 enabled = true;
 port = "http,https";
 filter = "caddy-scan";
 backend = "systemd";
 maxretry = 2;
 findtime = "1m";
 bantime = "168h";
 };
 };
 };

 environment.etc = {
 "fail2ban/filter.d/caddy-json.conf".text = ''
 [Definition]
 failregex = ^.*"remote_ip":"<ADDR>".*"status":(401|403).*$
 journalmatch = _SYSTEMD_UNIT=caddy.service
 '';
 "fail2ban/filter.d/caddy-scan.conf".text = ''
 [Definition]

 failregex = ^.*"remote_ip":"<ADDR>".*"uri":".*(?:\.env|\.git|\.config|\.php|\.zip|\.gz|wp-admin|wp-login|xmlrpc)".*"status":404.*$
 journalmatch = _SYSTEMD_UNIT=caddy.service
 '';
 };

 systemd.services.fail2ban.serviceConfig = {
 OOMScoreAdjust = 500;
 ProtectSystem = "strict";
 ReadWritePaths = ["/var/lib/fail2ban" "/var/run/fail2ban"];
 PrivateTmp = true;
 };
 };
}

``n---

* Pfad: modules\core\firewall.nix | Format: .nix | Größe: 1,64 KB
``nix
{
 lib,
 config,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-011";
 title = "Firewall (NFTables Secured)";
 description = "Hardened nftables setup. Only SSoT ports and trusted LAN segments allowed. No legacy port 22.";
 layer = 00;
 nixpkgs.category = "system/networking";
 capabilities = ["network/firewall" "security/nftables"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 sshPort = config.my.ports.ssh;
 lanCidr = config.my.configs.network.lanCidr;
in {
 options.my.meta.firewall = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for firewall module";
 };

 config = {
 networking.nftables.enable = true;
 networking.firewall = {
 enable = true; # hardened: Firewall ALWAYS active.
 trustedInterfaces = [ "lo" "tailscale0" ];

 allowedTCPPorts = [
 80 # HTTP Redirect
 443 # HTTPS (Caddy Edge)
 sshPort # Custom SSH (SSoT)
 ];

 extraInputRules = ''

 ip saddr ${lanCidr} tcp dport 53 accept
 ip saddr ${lanCidr} udp dport 53 accept

 ip saddr ${lanCidr} udp dport 5353 accept

 ip protocol icmp accept
 '';

 logRefusedConnections = false; # Reduziert Log-Spam
 };
 };
}

``n---

* Pfad: modules\core\hardware-configuration.nix | Format: .nix | Größe: 1,26 KB
``nix
{ config, lib, pkgs, modulesPath, ... }:
let
 nms = {
 id = "NIXH-00-COR-012";
 title = "Hardware Configuration";
 description = "Auto-generated hardware abstraction layer.";
 layer = 00;
 nixpkgs.category = "system/boot";
 capabilities = [ "system/hardware" "boot/initrd" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.hardware_configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

 config = {
 boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
 boot.initrd.kernelModules = [ ];
 boot.kernelModules = [ "kvm-intel" ];
 boot.extraModulePackages = [ ];
 fileSystems."/" = { device = "/dev/disk/by-uuid/8d1d5128-6413-4b5b-bd96-e55851ae5dc2"; fsType = "ext4"; };
 fileSystems."/boot" = { device = "/dev/disk/by-uuid/1EDF-972E"; fsType = "vfat"; options = [ "fmask=0077" "dmask=0077" ]; };
 swapDevices = [ ];
 nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}

``n---

* Pfad: modules\core\home-manager.nix | Format: .nix | Größe: 1,96 KB
``nix
{
 config,
 lib,
 pkgs,
 inputs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-013";
 title = "Home Manager (User Cockpit)";
 description = "Hardened user environment. Git SSoT and Shell-Secret integration.";
 layer = 00;
 nixpkgs.category = "tools/admin";
 capabilities = ["user/environment" "shell/hardening" "git/configuration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.home_manager = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [ inputs.home-manager.nixosModules.home-manager ];

 config = {
 home-manager = {
 useGlobalPkgs = true;
 useUserPackages = true;
 backupFileExtension = "hm-backup";

 users.${user} = { pkgs, ... }: {
 home.stateVersion = "24.05"; # Stable anchor

 imports = [ (./user-${user}-home.nix) ];

 programs.git = {
 enable = true;
 userName = "Moritz";
 userEmail = "git@${config.my.configs.identity.domain}";
 extraConfig = {
 init.defaultBranch = "main";
 pull.rebase = true;
 core.editor = "micro";
 };
 aliases = {
 st = "status";
 co = "checkout";
 br = "branch";
 up = "pull --rebase";
 };
 };

 programs.bash = {
 enable = true;
 shellAliases = {

 godmode = "gemini --yolo --include-directories /etc/nixos,$(pwd)";
 };
 };
 };
 };
 };
}

``n---

* Pfad: modules\core\host.nix | Format: .nix | Größe: 662 B
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-016";
 title = "Host Identity";
 description = "Basic hostname and identity configuration for the server.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["system/identity"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.host = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for host module";
 };

 config = {
 networking.hostName = lib.mkForce config.my.configs.identity.host;
 };
}

``n---

* Pfad: modules\core\impermanence.nix | Format: .nix | Größe: 1,33 KB
``nix
{ config, lib, ... }: {

 config = {

 environment.persistence."/persist" = {
 hideMounts = true;
 directories = [
 "/var/log"
 "/var/lib/nixos"
 "/var/lib/systemd/coredump"
 "/var/lib/sops-nix"
 "/etc/NetworkManager/system-connections"
 ];
 files = [
 "/etc/machine-id"
 "/etc/ssh/ssh_host_ed25519_key"
 "/etc/ssh/ssh_host_ed25519_key.pub"
 "/etc/ssh/ssh_host_rsa_key"
 "/etc/ssh/ssh_host_rsa_key.pub"
 ];
 };

 fileSystems."/" = {
 device = "none";
 fsType = "tmpfs";
 options = [ "defaults" "size=4G" "mode=755" ];
 };

 swapDevices = [];

 my.meta.impermanence = {
 id = "NIXH-00-COR-IMP";
 title = "Impermanence Core";
 description = "System-wide persistence for stateless root-on-RAM setup.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
 };
}

``n---

* Pfad: modules\core\kernel-slim.nix | Format: .nix | Größe: 3,87 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-017";
 title = "Kernel Slim (Advanced Hardened)";
 description = "hardened optimized and hardened kernel. Max security via slab_nomerge and poison-paging.";
 layer = 00;
 nixpkgs.category = "system/boot";
 capabilities = ["kernel/hardening" "system/performance" "security/sysctl"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 ramBenchmark = pkgs.writeShellScriptBin "ram-benchmark" ''

 echo ""
 echo " Kernel RAM-Footprint Analyse"
 echo ""
 TOTAL=$(free -m | awk 'NR==2 {print $2}')
 USED=$(free -m | awk 'NR==2 {print $3}')
 echo "Gesamt-RAM: ''${TOTAL} MB"
 echo "Verwendet: ''${USED} MB"
 MODULES=$(lsmod | wc -l)
 echo "Geladene Module: $((MODULES - 1))"
 '';
in {
 options.my.meta.kernel_slim = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for kernel-slim module";
 };

 config = lib.mkIf (config.my.services.kernelSlim.enable) {
 boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

 boot.blacklistedKernelModules = [
 "bluetooth" "btusb" "btrtl" "btbcm" "btintel" "bnep" "rfcomm"
 "iwlwifi" "ath9k" "ath10k_core" "ath10k_pci" "rtl8192ce" 
 "rtl8192cu" "rtl8192de" "rtl8188ee" "mt76" "brcmfmac" "brcmutil"
 "nouveau" "radeon" "amdgpu" "mgag200" "ast" "pcspkr" "iTCO_wdt"
 "thunderbolt"
 ];

 boot.kernel.sysctl = {

 "net.ipv4.conf.all.rp_filter" = lib.mkForce 1;
 "net.ipv4.conf.default.rp_filter" = lib.mkForce 1;
 "net.ipv4.tcp_syncookies" = lib.mkForce 1;
 "net.ipv4.icmp_echo_ignore_broadcasts" = true;
 "net.ipv4.conf.all.accept_redirects" = false;
 "net.ipv4.conf.all.secure_redirects" = false;

 "kernel.kptr_restrict" = lib.mkForce 2;
 "kernel.dmesg_restrict" = lib.mkForce 1;
 "kernel.unprivileged_bpf_disabled" = 1; 
 "net.core.bpf_jit_enable" = false; # Against JIT spray
 "kernel.ftrace_enabled" = false;
 "kernel.perf_event_paranoid" = 3;

 "vm.swappiness" = 10;
 "vm.vfs_cache_pressure" = 50;
 };

 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "slab_nomerge" # Prevents heap grooming
 "page_poison=1" # Overwrites free'd pages
 "page_alloc.shuffle=1" # Randomizes page allocation
 "debugfs=off" # Closes debug attack vector
 ];

 boot.initrd.availableKernelModules = lib.mkForce ["ahci" "sd_mod" "xhci_pci" "usbhid" "usb_storage"];

 environment.systemPackages = with pkgs; [
 linuxPackages_latest.perf
 ramBenchmark
 kmod pciutils usbutils
 ];

 programs.bash.shellAliases = { ram-bench = "${ramBenchmark}/bin/ram-benchmark"; };

 systemd.services.kernel-slim-info = {
 description = "Kernel Slim Info Banner";
 wantedBy = ["multi-user.target"];
 serviceConfig = { Type = "oneshot"; RemainAfterExit = true; };
 script = ''
 logger -t kernel-slim "hardened Hardened Kernel loaded"
 MODULES=$(lsmod | wc -l)
 logger -t kernel-slim "Loaded modules: $((MODULES - 1))"
 '';
 };
 };
}

``n---

* Pfad: modules\core\lib-helpers-meta.nix | Format: .nix | Größe: 1,39 KB
``nix
{ lib, ... }: {

 options.my.meta = lib.mkOption {
 type = lib.types.attrsOf (lib.types.submodule {
 options = {
 id = lib.mkOption { 
 type = lib.types.str; 
 description = "Eindeutige ID (z.B. NIXH-60-APP-001)";
 };
 title = lib.mkOption { 
 type = lib.types.str; 
 description = "Anzeigename des Dienstes";
 };
 description = lib.mkOption {
 type = lib.types.str;
 default = "";
 };
 layer = lib.mkOption { 
 type = lib.types.int; 
 description = "Architektur-Layer (00-90)";
 };
 audit = {
 last_reviewed = lib.mkOption { 
 type = lib.types.str; 
 default = "2026-04-27";
 description = "Letztes Audit-Datum";
 };
 complexity = lib.mkOption {
 type = lib.types.int;
 default = 1;
 description = "Komplexitäts-Score (1-5)";
 };
 };
 source_repo = lib.mkOption {
 type = lib.types.str;
 default = "grapefruit89/mynixos";
 description = "Herkunfts-Repository (GitHub)";
 };
 };
 });
 default = {};
 description = "NMS Traceability Metadata Registry";
 };
}

``n---

* Pfad: modules\core\lib-helpers.nix | Format: .nix | Größe: 7,34 KB
``nix
{ lib, pkgs, ... }: 
let

 getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";

 mkTracedOption = src: opt: opt // { 
 description = (opt.description or "") + " [Source: ${src}]"; 
 };

in {
 inherit mkTracedOption;

 mkService = {
 config,
 name,
 port,
 description ? "hardened Service",
 useSSO ? true,
 useVPN ? false, # Neu: VPN-Namespace Support
 netns ? null, # Expliziter Namespace-Name
 isStream ? false,
 readWritePaths ? [],
 persist ? true,
 socket ? false,
 extraServiceConfig ? {},
 }: let
 hostName = getDomain config name;
 targetUrl = if socket then "unix//run/service-sockets/${name}.sock" else "localhost:${toString port}";

 finalNetns = if useVPN then (if netns != null then netns else "vpn-${name}") else null;

 in {

 systemd.services."${name}" = {
 inherit description;
 after = [ "network.target" ] ++ (lib.optional (finalNetns != null) "netns-${finalNetns}.service");
 bindsTo = lib.optional (finalNetns != null) "netns-${finalNetns}.service";

 serviceConfig = lib.recursiveUpdate {

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 StateDirectory = name;
 ReadWritePaths = readWritePaths ++ [ "/var/lib/${name}" ];

 NetworkNamespacePath = lib.mkIf (finalNetns != null) "/var/run/netns/${finalNetns}";
 } extraServiceConfig;
 };

 services.caddy.virtualHosts."${hostName}" = {
 extraConfig = let
 proxyCommand = if isStream then "import proxy_stream ${targetUrl}" else "reverse_proxy ${targetUrl}";
 in ''

 @trusted_network {
 remote_ip ${config.my.configs.network.lanCidr}
 }
 handle @trusted_network {
 ${proxyCommand}
 }

 ${lib.optionalString useSSO "import sso_auth"}
 ${proxyCommand}
 '';
 };

 environment.persistence."/persist" = lib.mkIf persist {
 directories = [ "/var/lib/${name}" ];
 };

 my.meta.${name} = {
 id = "NIXH-AUTO-${name}";
 title = description;
 layer = 60;
 audit.last_reviewed = "2026-04-27";
 };
 };

 mkStreamer = {
 config,
 name,
 port,
 useGPU ? false,
 persist ? true,
 memoryMax ? "2G",
 cpuWeight ? 80,
 oomScoreAdjust ? 400,
 description ? "Streaming Service",
 useVPN ? false,
 }: let
 srePaths = config.my.configs.paths;
 stateDir = "${srePaths.stateDir}/${name}";
 cacheDir = "${srePaths.tierB}/cache/${name}";
 mediaDir = srePaths.mediaLibrary;
 in (lib.mkMerge [
 (config.myLib.mkService {
 inherit config name port description persist useVPN;
 isStream = true;
 readWritePaths = [ cacheDir mediaDir ];
 extraServiceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 MemoryMax = memoryMax;
 CPUWeight = cpuWeight;
 OOMScoreAdjust = oomScoreAdjust;
 PrivateDevices = if useGPU then lib.mkForce false else true;
 DeviceAllow = if useGPU then [ "/dev/dri/renderD128 rw" ] else [];
 };
 })
 {
 systemd.tmpfiles.rules = [
 "d ${stateDir} 0750 ${name} media -"
 "d ${cacheDir} 0775 ${name} media -"
 ];
 services.${name} = lib.optionalAttrs (name == "jellyfin") {
 dataDir = stateDir;
 inherit cacheDir;
 };
 }
 ]);

 mkDocumentApp = {
 config,
 name,
 port,
 description ? "Document Management Service",
 useValkey ? false,
 usePostgres ? true,
 memoryMax ? "2G",
 cpuWeight ? 50,
 oomScoreAdjust ? 400,
 persist ? true,
 ocrLanguages ? ["deu" "eng"],
 workerCount ? 2,
 secretFile ? null,
 }: let
 srePaths = config.my.configs.paths;
 stateDir = "${srePaths.stateDir}/${name}";
 consumeDir = "${srePaths.tierC}/consume/${name}";
 mediaDir = "${srePaths.mediaLibrary}/documents/${name}";
 cacheDir = "${srePaths.tierB}/cache/${name}";
 pythonHardening = {
 MemoryDenyWriteExecute = false;
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 in (lib.mkMerge [
 (config.myLib.mkService {
 inherit config name port description persist;
 useSSO = true;
 readWritePaths = [ stateDir consumeDir mediaDir cacheDir ];
 extraServiceConfig = pythonHardening // {
 inherit MemoryMax oomScoreAdjust;
 CPUWeight = cpuWeight;
 LoadCredential = lib.optional (secretFile != null) "${lib.toUpper name}_SECRET_KEY:${toString secretFile}";
 };
 })
 {
 systemd.services."${name}-worker" = {
 inherit description;
 after = [ "network.target" "redis-${name}.service" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];
 serviceConfig = lib.recursiveUpdate pythonHardening {
 User = name;
 Group = "media";
 ExecStart = "${config.services.${name}.package}/bin/celery -A ${name} worker -l info -c ${toString workerCount}";
 Restart = "always";
 ReadWritePaths = [ stateDir consumeDir mediaDir cacheDir ];
 };
 };
 systemd.services."${name}-beat" = {
 description = "${description} Scheduler";
 after = [ "network.target" "${name}-worker.service" ];
 wantedBy = [ "multi-user.target" ];
 serviceConfig = lib.recursiveUpdate pythonHardening {
 User = name;
 Group = "media";
 ExecStart = "${config.services.${name}.package}/bin/celery -A ${name} beat -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler";
 Restart = "always";
 ReadWritePaths = [ stateDir ];
 };
 };
 services.postgresql = lib.mkIf usePostgres {
 ensureDatabases = [ name ];
 ensureUsers = [ { name = name; ensureDBOwnership = true; } ];
 };
 services.redis.servers.${name} = lib.mkIf useValkey {
 enable = true;
 package = pkgs.valkey;
 port = 0;
 unixSocket = "/run/redis-${name}/redis.sock";
 unixSocketPerm = 660;
 };
 systemd.tmpfiles.rules = [
 "d ${stateDir} 0750 ${name} media -"
 "d ${consumeDir} 0775 ${name} media -"
 "d ${mediaDir} 0775 ${name} media -"
 "d ${cacheDir} 0750 ${name} media -"
 ];
 }
 ]);
}

``n---

* Pfad: modules\core\locale.nix | Format: .nix | Größe: 1,30 KB
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-00-COR-020";
 title = "Locale (SRE Refactored)";
 description = "Centralized localization settings using the Master Source of Truth.";
 layer = 0;
 nixpkgs.category = "system/localization";
 capabilities = ["system/localization" "ssot/locale"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };

 tz = config.my.configs.locale.timezone;
 loc = config.my.configs.locale.default;
in {
 options.my.meta.locale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for locale module";
 };

 config = {
 time.timeZone = lib.mkForce tz;
 i18n.defaultLocale = lib.mkForce loc;
 i18n.supportedLocales = lib.mkForce ["de_DE.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];

 console.keyMap = lib.mkForce "de-latin1";
 services.xserver.xkb = {
 layout = lib.mkForce "de";
 variant = "";
 };

 networking.timeServers = lib.mkForce [
 "0.de.pool.ntp.org"
 "1.de.pool.ntp.org"
 "2.de.pool.ntp.org"
 "3.de.pool.ntp.org"
 ];

 services.resolved = {
 enable = true;
 dnssec = "true";
 dnsovertls = "opportunistic";
 domains = [ "~." ];
 };
 };
}

``n---

* Pfad: modules\core\motd.nix | Format: .nix | Größe: 1,45 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-022";
 title = "MOTD & Shell UI";
 description = "Dynamic login dashboard and interactive shell initialization.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["shell/ui" "system/status-reminders"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
 domain = config.my.configs.identity.domain;
 host = config.my.configs.identity.host;
 firewallReminder = if config.networking.firewall.enable then "Firewall: ACTIVE" else "WARNING: Firewall is DISABLED.";
in
{
 options.my.meta.motd = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
 environment.etc."motd".text = ''
 ${host}.${domain} (NMS v2.3 SRE Edition)
 ${firewallReminder}
 Standard Port: ${toString config.my.ports.ssh}
 Local Proxy: Caddy (Edge)
 '';
 programs.bash.interactiveShellInit = ''
 if [[ $- == *i* ]] && [[ -t 1 ]]; then
 IP=$(hostname -I | awk '{print $1}')
 echo -e "\e[1;32mWelcome back, ${config.my.configs.identity.user}!\e[0m"
 echo -e "\e[1;34mSystem IP:\e[0m $IP"
 if timeout 0.2 systemctl is-active --quiet sshd-recovery.service 2>/dev/null; then
 echo -e "\e[1;31m RECOVERY WINDOW ACTIVE (Port 2222)\e[0m"
 fi
 fi
 '';
 };
}

``n---

* Pfad: modules\core\network.nix | Format: .nix | Größe: 2,40 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-023";
 title = "Network (SRE Optimized)";
 description = "systemd-networkd configuration with DNS hardening, TCP BBR tuning and fast-boot optimization.";
 layer = 0;
 nixpkgs.category = "system/networking";
 capabilities = ["network/systemd-networkd" "performance/tcp-bbr" "security/dns-over-tls"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };
 cfg = config.my.profiles.networking.systemd-networkd;
in {
 options.my.meta.network = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf cfg.enable {
 networking.useNetworkd = true;
 networking.useDHCP = false;
 networking.networkmanager.enable = lib.mkForce false;

 systemd.network = {
 enable = true;
 config.networkConfig.IPv6PrivacyExtensions = "kernel";
 networks."10-lan" = {
 matchConfig.Name = "en*";
 networkConfig = {
 DHCP = "yes";
 IPv6AcceptRA = true;
 IPv4Forwarding = true;
 IPv6Forwarding = true;
 MulticastDNS = "yes";
 LLMNR = "no";
 };
 linkConfig.RequiredForOnline = "yes";
 };

 wait-online.anyInterface = true;
 };

 services.resolved = {
 enable = true;
 dnssec = lib.mkForce "allow-downgrade";
 domains = ["~."];
 fallbackDns = ["1.1.1.1" "8.8.8.8"];
 extraConfig = ''
 DNSOverTLS=yes
 Cache=yes
 CacheMaxAgeSec=86400
 '';
 };

 boot.kernel.sysctl = {
 "net.core.default_qdisc" = lib.mkForce "fq";
 "net.ipv4.tcp_congestion_control" = lib.mkForce "bbr";
 "net.core.netdev_max_backlog" = lib.mkForce 10000;
 "net.ipv4.tcp_slow_start_after_idle" = lib.mkForce 0;
 "net.ipv4.tcp_fastopen" = lib.mkForce 3;
 };

 services.avahi = {
 enable = true;
 nssmdns4 = true;
 publish = {
 enable = true;
 addresses = true;
 workstation = true;
 };
 };
 };
}

``n---

* Pfad: modules\core\nix-tuning.nix | Format: .nix | Größe: 2,17 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-024";
 title = "Nix Tuning (Pure Binary Policy)";
 description = "Optimized nix-daemon settings. Strict binary-only enforcement to prevent local compilation wear.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["nix/tuning" "policy/binary-only" "maintenance/auto-gc" "impermanence/bash-fix"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.nix_tuning = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {
 nix.settings = {

 substituters = [
 "https://cache.nixos.org"
 "https://nix-community.cachix.org"
 ];
 trusted-public-keys = [
 "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
 "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
 ];

 max-jobs = lib.mkForce 0;
 builders-use-substitutes = true;
 fallback = false;

 auto-optimise-store = true;
 connect-timeout = 5;
 experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];

 sandbox = true;
 trusted-users = ["root" config.my.configs.identity.user];
 };

 nix.daemonCPUSchedPolicy = "idle";
 nix.daemonIOSchedClass = "idle";

 nix.gc = {
 automatic = true;
 dates = "weekly";
 options = "--delete-older-than 14d";
 };

 programs.bash.interactiveShellInit = "trap 'history -a' EXIT";

 environment.systemPackages = with pkgs; [
 cachix
 nix-tree
 nix-diff
 nix-output-monitor
 ];
 };
}

``n---

* Pfad: modules\core\ports.nix | Format: .nix | Größe: 937 B
``nix
{ lib, ... }: {

 options.my.ports = lib.mkOption {
 type = lib.types.attrsOf lib.types.port;
 default = {

 pocket-id = 8080;
 postgres = 5432;
 adguard = 3001; # Web UI

 home-assistant = 8123;
 n8n = 5678;
 ollama = 11434;

 jellyfin = 8096;
 sonarr = 8989;
 radarr = 7878;
 bazarr = 6767;
 prowlarr = 9696;
 sabnzbd = 8080;
 navidrome = 4533;
 audiobookshelf = 8000;

 paperless = 28981;

 vaultwarden = 8222;
 monica = 8080;

 netdata = 19999;
 scrutiny = 8080;
 uptime-kuma = 3001;
 };
 description = "Central port registry (SSoT)";
 };
}

``n---

* Pfad: modules\core\principles.nix | Format: .nix | Größe: 1,46 KB
``nix
{ lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-026";
 title = "Architectural Principles";
 description = "The core manifesto of the NixHome project. Defines SRE standards and isomorphism.";
 layer = 00;
 nixpkgs.category = "documentation/architecture";
 capabilities = [ "architecture/manifesto" "system/standards" "sre/best-practices" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 source_repo = "grapefruit89/mynixos";
 };
in
{
 options.my.meta.principles = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 assertions = [
 {
 assertion = true; # Placeholder for future logic check
 message = "NMS v4.2: Architectural Integrity Check passed.";
 }
 ];
 };
}

``n---

* Pfad: modules\core\registry.nix | Format: .nix | Größe: 3,09 KB
``nix
{lib, ...}: let

 nms = {
 id = "NIXH-00-COR-027";
 title = "Registry (Master Switch)";
 description = "Global feature-toggles for all layers. Single Source of Truth for service enablement.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/feature-flags" "ssot/registry"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.registry = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my = {
 profiles = {
 hardware.q958.enable = lib.mkOption { type = lib.types.bool; default = true; };
 networking.reverseProxy = lib.mkOption {
 type = lib.types.enum ["caddy" "none"];
 default = "caddy";
 };
 };

 services = {

 adguardhome.enable = lib.mkEnableOption "AdGuard Home";
 pocketId.enable = lib.mkEnableOption "Pocket-ID (OIDC)";
 postgresql.enable = lib.mkEnableOption "PostgreSQL Cluster";

 aiAgents.enable = lib.mkEnableOption "AI (Ollama/Claude)";
 homeAssistant.enable = lib.mkEnableOption "Home Assistant";
 n8n.enable = lib.mkEnableOption "n8n Workflows";

 jellyfin.enable = lib.mkEnableOption "Jellyfin";
 navidrome.enable = lib.mkEnableOption "Navidrome (Music)";
 audiobookshelf.enable = lib.mkEnableOption "Audiobookshelf";
 sonarr.enable = lib.mkEnableOption "Sonarr";
 radarr.enable = lib.mkEnableOption "Radarr";
 prowlarr.enable = lib.mkEnableOption "Prowlarr";
 sabnzbd.enable = lib.mkEnableOption "SABnzbd";
 storagePool.enable = lib.mkEnableOption "MergerFS Pool";

 paperless.enable = lib.mkEnableOption "Paperless-ngx";
 miniflux.enable = lib.mkEnableOption "Miniflux RSS";

 vaultwarden.enable = lib.mkEnableOption "Vaultwarden";
 monica.enable = lib.mkEnableOption "Monica CRM";

 netdata.enable = lib.mkEnableOption "Netdata";
 uptimeKuma.enable = lib.mkEnableOption "Uptime Kuma";
 scrutiny.enable = lib.mkEnableOption "Scrutiny";

 backup.enable = lib.mkEnableOption "Restic Backup";
 kernelSlim.enable = lib.mkEnableOption "Kernel Slim";
 shell.premium.enable = lib.mkEnableOption "Shell Premium";
 };
 };

 config.my.services = {

 adguardhome.enable = lib.mkDefault true;
 aiAgents.enable = lib.mkDefault true;
 audiobookshelf.enable = lib.mkDefault true;
 backup.enable = lib.mkDefault true;
 jellyfin.enable = lib.mkDefault true;
 navidrome.enable = lib.mkDefault true;
 paperless.enable = lib.mkDefault true;
 postgresql.enable = lib.mkDefault true;
 sonarr.enable = lib.mkDefault true;
 radarr.enable = lib.mkDefault true;
 vaultwarden.enable = lib.mkDefault true;
 shell.premium.enable = lib.mkDefault true;
 };
}

``n---

* Pfad: modules\core\secrets.nix | Format: .nix | Größe: 2,70 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-028";
 title = "Secrets (Sops Master Vault)";
 description = "Centralized secret-to-module mapping with NIXH-ID traceability. Uses age with SSH-hostkey backing.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["security/secrets" "sops/mapping" "age/encryption"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 secretMap = {
 "NIXH-40-MED-017" = "sonarr_api_key";
 "NIXH-40-MED-012" = "radarr_api_key";
 "NIXH-60-APP-007" = "vaultwarden_env";
 "NIXH-10-GTW-002" = "cloudflare_token";
 };
in {
 options.my.meta.secrets = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {
 sops = {
 defaultSopsFile = ../secrets.yaml;
 defaultSopsFormat = "yaml";

 age = {
 sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
 keyFile = "/var/lib/sops-nix/key.txt";
 generateKey = true;
 };

 secrets = {

 cloudflare_token = {};
 github_token = {};
 tailscale_token = {};
 unraid_root_password = {};

 n8n_enc_key = {};
 vaultwarden_env = {};
 paperless_secret_key = {};

 sonarr_api_key = {};
 radarr_api_key = {};
 readarr_api_key = {};

 restic_password = {};
 backblaze_access_key = {};
 backblaze_secret_key = {};
 };

 templates."media-stack.env" = {
 owner = "root";
 group = "media"; # Ermöglicht sonarr/radarr Zugriff
 mode = "0440";
 content = ''
 SONARR_API_KEY="${config.sops.placeholder.sonarr_api_key}"
 RADARR_API_KEY="${config.sops.placeholder.radarr_api_key}"
 '';
 };

 templates."caddy-env" = {
 owner = "caddy";
 mode = "0400";
 content = ''
 CLOUDFLARE_API_TOKEN="${config.sops.placeholder.cloudflare_token}"
 '';
 };

 templates."backblaze-restic.env" = {
 owner = "root";
 mode = "0400";
 content = ''
 AWS_ACCESS_KEY_ID="${config.sops.placeholder.backblaze_access_key}"
 AWS_SECRET_ACCESS_KEY="${config.sops.placeholder.backblaze_secret_key}"
 '';
 };
 };

 environment.systemPackages = [ pkgs.sops pkgs.age ];
 };
}

``n---

* Pfad: modules\core\shell-premium.nix | Format: .nix | Größe: 4,46 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-00-COR-029";
 title = "Shell Premium (M1 Abrams Edition)";
 description = "Hardened and optimized shell environment with Caddy health-checks and fastfetch reporting.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = [ "shell/premium" "observability/motd" "system/status-checker" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
 domain = config.my.configs.identity.domain;

 fastfetchConfig = pkgs.writeText "fastfetch-homelab.jsonc" (builtins.toJSON {
 logo = { source = "nixos"; padding = { top = 1; left = 2; }; };
 display = { separator = " "; color = { keys = "blue"; title = "green"; }; };
 modules = [
 { type = "title"; format = "{user-name}@{host-name}"; } "separator"
 { type = "os"; key = "OS"; } { type = "kernel"; key = "Kernel"; } { type = "uptime"; key = "Uptime"; }
 { type = "packages"; key = "Pkgs"; } { type = "shell"; key = "Shell"; } "break"
 { type = "cpu"; key = "CPU"; } { type = "gpu"; key = "GPU"; } { type = "memory"; key = "Mem"; }
 { type = "disk"; key = "Disk (/)"; folders = "/"; } "break"
 { type = "localip"; key = "LAN"; compact = true; }
 { type = "custom"; format = "https://${domain}"; key = "Base"; }
 { type = "custom"; format = "https://admin.${domain}"; key = "Admin"; } "break" "colors"
 ];
 });

 serviceStatusScript = pkgs.writeShellScriptBin "check-services" ''

 CRITICAL_SERVICES=("sshd:SSH" "caddy:Proxy" "tailscaled:VPN" "jellyfin:Jellyfin" "postgres:Database")
 echo -e "\n hardened Service Status:\n"
 for entry in "''${CRITICAL_SERVICES[@]}"; do
 service="''${entry%%:*}"; label="''${entry##*:}"
 if systemctl is-active --quiet "$service"; then
 echo -e " \e[32m$label\e[0m"
 else
 echo -e " \e[31m$label (DOWN!)\e[0m"
 fi
 done
 echo ""
 '';
in
{
 options.my.meta.shell_premium = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for shell-premium module";
 };

 config = lib.mkIf (config.my.shell.premium.enable && user == "moritz") {

 programs.bash.shellAliases = {

 nsw = "sudo nixos-rebuild switch --flake .#default";
 ntest = "sudo nixos-rebuild test --flake .#default";
 ndry = "sudo nixos-rebuild dry-run --flake .#default";

 nup = "nix flake update";
 nclean = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3 && sudo nix-store --gc";
 nopt = "sudo nix-store --optimise";
 nlog = "journalctl -xef";

 ls = "${pkgs.eza}/bin/eza --icons";
 ll = "${pkgs.eza}/bin/eza -la --icons --git";
 tree = "${pkgs.eza}/bin/eza --tree --icons";
 cat = "${pkgs.bat}/bin/bat --paging=never";
 sysinfo = "${pkgs.fastfetch}/bin/fastfetch --config ${fastfetchConfig}";
 services = "${serviceStatusScript}/bin/check-services";
 ports = "sudo ss -tulpn | grep LISTEN";

 gs = "git status -sb";
 ga = "git add";
 gc = "git commit -m";
 gp = "git push";
 };

 programs.bash.interactiveShellInit = ''

 if [[ $- == *i* ]]; then
 ${pkgs.fastfetch}/bin/fastfetch --config ${fastfetchConfig}
 ${serviceStatusScript}/bin/check-services
 echo " Hint: 'nsw' to rebuild, 'nlog' for logs, 'services' for health."
 fi
 '';

 environment.systemPackages = with pkgs; [
 bat eza ripgrep fd duf dust htop btop
 nix-tree nix-diff nixfmt-classic nix-output-monitor
 fastfetch micro git curl wget tree serviceStatusScript
 ];
 };
}

``n---

* Pfad: modules\core\shell.nix | Format: .nix | Größe: 1,98 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-00-COR-030";
 title = "Shell";
 description = "Standardized Bash environment with productivity tools and basic maintenance aliases.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = [ "shell/bash" "tools/productivity" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 user = config.my.configs.identity.user;
in
{
 options.my.meta.shell = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for shell module";
 };

 config = lib.mkIf (user == "moritz") {
 programs.bash.shellAliases = {
 nsw = "sudo nixos-rebuild switch"; ntest = "sudo nixos-rebuild test"; ndry = "sudo nixos-rebuild dry-run"; nboot = "sudo nixos-rebuild boot";
 nclean = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-store --gc";
 nopt = "sudo nix-store --optimise"; ngen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
 ncfg = "cd /etc/nixos"; ngit = "cd /etc/nixos && git status -sb"; nlog = "journalctl -xef";
 ls = "${pkgs.eza}/bin/eza --icons"; ll = "${pkgs.eza}/bin/eza -la --icons --git"; tree = "${pkgs.eza}/bin/eza --tree --icons";
 cat = "${pkgs.bat}/bin/bat --paging=never"; less = "${pkgs.bat}/bin/bat"; top = "${pkgs.htop}/bin/htop";
 df = "${pkgs.duf}/bin/duf"; du = "${pkgs.dust}/bin/dust"; ports = "sudo ss -tulpn";
 };

 programs.bash.completion.enable = true;
 environment.systemPackages = with pkgs; [ bat eza ripgrep fd nix-tree nix-diff nixfmt fastfetch duf dust htop ];
 programs.git = { enable = true; config = { user.name = "Moritz Baumeister"; user.email = config.my.configs.identity.email; pull.ff = "only"; init.defaultBranch = "main"; }; };
 programs.bash.shellInit = "export HISTCONTROL=ignoredups:ignorespace\nexport EDITOR='micro'\nexport VISUAL='micro'";
 };
}

``n---

* Pfad: modules\core\ssh-rescue.nix | Format: .nix | Größe: 1,91 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-031";
 title = "SSH Rescue (Fail-Safe)";
 description = "Isolated emergency SSH instance on port 2222. Auto-terminates after 5 minutes via systemd-timer.";
 layer = 00;
 nixpkgs.category = "system/networking";
 capabilities = ["security/recovery" "ssh/fail-safe"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
 rescuePort = 2222;
in {
 options.my.meta.ssh_rescue = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf (config.my.services.sshRescue.enable or false) {

 systemd.services.sshd-rescue = {
 description = "Emergency SSH Service (Password Auth)";
 serviceConfig = {
 ExecStart = "${pkgs.openssh}/bin/sshd -D -f ${pkgs.writeText "sshd-rescue-config" ''
 Port ${toString rescuePort}
 PasswordAuthentication yes
 PermitRootLogin no
 AllowUsers ${user}
 PidFile /run/sshd-rescue.pid
 ''}";
 KillMode = "process";
 Restart = "no";
 };
 };

 systemd.timers.sshd-rescue-stopper = {
 description = "Auto-stops SSH Rescue Instance after 5 minutes";
 wantedBy = ["timers.target"];
 timerConfig = {
 OnActiveSec = "5min";
 Unit = "sshd-rescue-stop.service";
 };
 };

 systemd.services.sshd-rescue-stop = {
 description = "Stops the rescue SSH instance";
 serviceConfig.Type = "oneshot";
 script = "systemctl stop sshd-rescue.service";
 };

 networking.firewall.allowedTCPPorts = [ rescuePort ];
 };
}

``n---

* Pfad: modules\core\ssh.nix | Format: .nix | Größe: 3,08 KB
``nix
{
 lib,
 config,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-032";
 title = "SSH (Post-Quantum Hardened)";
 description = "Hardened SSH daemon with Post-Quantum cryptography, strict CIDR-based forwarding and legal protections.";
 layer = 00;
 nixpkgs.category = "system/networking";
 capabilities = ["security/ssh" "network/hardening" "crypto/post-quantum"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 sshPort = config.my.ports.ssh;
 user = config.my.configs.identity.user;
 lanCidr = config.my.configs.network.lanCidr;
in {
 options.my.meta.ssh = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
 services.openssh = {
 enable = true;
 openFirewall = false; # Firewall wird separat in firewall.nix geregelt
 ports = [ sshPort ]; # Nur der Custom Port aus SSoT erlaubt

 banner = ''

 NIXOS hardened COCKPIT [v4.2]
 UNAUTHORIZED ACCESS IS PROHIBITED BY POLICY NIXH-90-POL-001
 System Owner: ${user} | Domain: ${config.my.configs.identity.domain}

 '';

 settings = {
 PermitRootLogin = "no";
 PasswordAuthentication = false;
 KbdInteractiveAuthentication = false;
 AllowUsers = [ user ];
 LogLevel = "VERBOSE";
 LoginGraceTime = 20;
 MaxAuthTries = 2;
 ClientAliveInterval = 300;
 ClientAliveCountMax = 2;
 X11Forwarding = false;

 KexAlgorithms = [
 "sntrup761x25519-sha512@openssh.com" # Post-Quantum champion
 "curve25519-sha256"
 "curve25519-sha256@libssh.org"
 ];
 Ciphers = [
 "chacha20-poly1305@openssh.com"
 "aes256-gcm@openssh.com"
 ];
 };

 extraConfig = ''
 Match Address 127.0.0.1,::1,${lanCidr}
 AllowTcpForwarding yes
 GatewayPorts yes
 '';
 };

 systemd.services.sshd = {
 stopIfChanged = false; # Verhindert SSH-Verlust bei Updates
 serviceConfig = {
 Restart = "always";
 RestartSec = "5s";
 ProtectProc = "invisible";
 ProcSubset = "pid";
 PrivateTmp = true;
 ProtectSystem = "strict";
 ProtectHome = "read-only";
 };
 };
 };
}

``n---

* Pfad: modules\core\storage.nix | Format: .nix | Größe: 1,85 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-00-COR-035";
 title = "Storage Foundation";
 description = "Declarative storage paths and mergerfs pool definitions. Foundation for ABC-Tiering.";
 layer = 00;
 nixpkgs.category = "system/storage";
 capabilities = ["storage/mergerfs" "storage/abc-tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 cfg = config.my.services.storagePool;

 lanIP = config.my.configs.network.lanIP;
in
{
 options.my.meta.storage = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {

 systemd.mounts = [
 {
 description = "Unified Storage Pool (MergerFS)";
 where = "/storage";
 what = "/mnt/cache:/mnt/hdd1:/mnt/hdd2";
 type = "fuse.mergerfs";
 options = "allow_other,use_ino,cache.readdir=true,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,direct_io";
 wantedBy = [ "multi-user.target" ];
 }
 ];

 systemd.services.storage-init = {
 description = "Storage Path Initialization";
 wantedBy = [ "multi-user.target" ];
 serviceConfig.Type = "oneshot";
 script = ''

 mkdir -p /storage/{media,downloads,documents,backups}

 chown -R root:media /storage/media /storage/downloads
 chmod -R 775 /storage/media /storage/downloads
 '';
 };

 environment.systemPackages = with pkgs; [ mergerfs util-linux ];
 };
}

``n---

* Pfad: modules\core\symbiosis.nix | Format: .nix | Größe: 1,60 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-033";
 title = "Symbiosis";
 description = "Hardware abstraction layer with auto-discovery and microcode management.";
 layer = 0;
 nixpkgs.category = "system/hardware";
 capabilities = ["hardware/discovery" "hardware/management"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 userConfigFile = "/var/lib/nixhome/user-config.json";
 cpuType = config.my.configs.hardware.cpuType or "none";
 ramGB = config.my.configs.hardware.ramGB or 0;
in {
 options.my.meta.symbiosis = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for symbiosis module";
 };

 config = {
 hardware.cpu.intel.updateMicrocode = lib.mkForce (lib.mkIf (cpuType == "intel") true);
 hardware.cpu.amd.updateMicrocode = lib.mkForce (lib.mkIf (cpuType == "amd") true);
 warnings = lib.optional (ramGB < 4) " [HARDWARE-WARNUNG] Weniger als 4GB RAM erkannt (${toString ramGB}GB).";
 environment.etc."nixhome-hw-age-check".source = pkgs.writeShellScript "hw-check" "if [ -f '${userConfigFile}' ]; then AGE=$(( $(date +%s) - $(stat -c %Y '${userConfigFile}') )); if [ $AGE -gt 2592000 ]; then echo ' Hardware-Profil ist älter als 30 Tage. Ausführen: nixhome-detect-hw'; fi; fi";
 environment.systemPackages = [(pkgs.writeShellScriptBin "nixhome-detect-hw" "set -euo pipefail; echo ' Hardware-Discovery...'; RAM=$(free -g | awk '/^Speicher:/ {print $2}'); echo '{\"ram_gb\": '$RAM'}';")];
 };
}

``n---

* Pfad: modules\core\system-stability.nix | Format: .nix | Größe: 2,59 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-034";
 title = "System Stability (SRE Guard)";
 description = "Proactive maintenance and fail-safe logic (Watchdogs, Kernel-Panic, EFI-Cleanup).";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/maintenance" "safety/watchdog" "safety/recovery"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.system_stability = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 systemd.watchdog.runtimeTime = "30s";
 systemd.watchdog.rebootTime = "10min";

 boot.kernel.sysctl = {
 "kernel.panic" = 10; # Reboot nach 10 Sek bei Panic
 "kernel.panic_on_oops" = 1;
 "vm.panic_on_oom" = 0; # OOM-Killer bevorzugt vor Reboot
 };

 system.activationScripts.cleanEfiEntries = {
 text = ''
 echo " hardened: Bereinige verwaiste EFI-Boot-Einträge..."
 ${pkgs.efibootmgr}/bin/efibootmgr | grep "Boot[0-9]" | grep -vE "systemd-boot|NixOS|Linux|USB|Hard Drive|Network" | \
 ${pkgs.gawk}/bin/awk '{print $1}' | ${pkgs.gnused}/bin/sed 's/Boot//;s/\*//' | \
 xargs -I{} ${pkgs.efibootmgr}/bin/efibootmgr -b {} -B 2>/dev/null || true
 '';
 };

 systemd.services.nixhome-emergency = {
 description = "NixOS Home Emergency Recovery Info";
 serviceConfig = {
 Type = "oneshot";
 StandardOutput = "tty";
 TTYPath = "/dev/tty1";
 };
 script = ''
 echo ""
 echo " NIXHOME v4.2 SYSTEM STABILITY ALERT"
 echo "Manual Recovery: Use SSH Rescue Port 2222"
 echo "" > /dev/tty1
 '';
 };
 };
}

``n---

* Pfad: modules\core\system.nix | Format: .nix | Größe: 2,56 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-035";
 title = "Stateless System (Wipe-on-Boot)";
 description = "Stateless root on tmpfs with declarative persistence via Impermanence. ADR 852 compliant.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["system/stateless" "impermanence/active" "kernel/hardening"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.system = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 fileSystems."/" = lib.mkForce {
 device = "none";
 fsType = "tmpfs";
 options = [ "defaults" "size=4G" "mode=755" ];
 };

 environment.persistence."/persist" = {
 hideMounts = true;
 directories = [
 "/var/lib/sops-nix"
 "/var/lib/nixos"
 "/etc/nixos"
 "/var/lib/tailscale"
 "/var/lib/bluetooth"
 "/var/lib/pocket-id"
 "/var/log"
 ];
 files = [
 "/etc/machine-id"
 "/etc/ssh/ssh_host_ed25519_key"
 "/etc/ssh/ssh_host_ed25519_key.pub"
 ];
 };

 boot.loader = {
 systemd-boot = {
 enable = lib.mkForce true;
 configurationLimit = lib.mkForce 15;
 editor = false;
 };
 efi.canTouchEfiVariables = lib.mkForce true;
 grub.enable = lib.mkForce false;
 timeout = lib.mkForce 3;
 };

 boot.kernel.sysctl = {
 "net.ipv4.conf.all.rp_filter" = lib.mkForce 1;
 "net.ipv4.tcp_syncookies" = lib.mkForce 1;
 "kernel.kptr_restrict" = lib.mkForce 2;
 "kernel.unprivileged_bpf_disabled" = lib.mkForce 1;
 };

 nixpkgs.config.allowUnfree = true;
 programs.nix-ld.enable = true;

 documentation.nixos.enable = false;

 environment.systemPackages = with pkgs; [
 nodejs_22
 alejandra
 git
 htop
 wget
 curl
 tree
 unzip
 file
 nix-output-monitor
 rsync
 hdparm
 pciutils
 usbutils
 ];

 environment.sessionVariables = {
 PATH = "/home/${config.my.configs.identity.user}/.npm-global/bin:$PATH";
 };
 };
}

``n---

* Pfad: modules\core\tty-info.nix | Format: .nix | Größe: 2,47 KB
``nix
{
 config,
 pkgs,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-036";
 title = "Tty Info";
 description = "Service to display critical system information like IP addresses on the physical console (TTY1).";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/observability" "hardware/console-info"];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in {
 options.my.meta.tty_info = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for tty-info module";
 };

 config = {
 systemd.services.tty-ip-info = {
 description = "Display IP Address on TTY1";
 after = ["network-online.target"];
 wants = ["network-online.target"];
 wantedBy = ["multi-user.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 StandardOutput = "tty";
 TTYPath = "/dev/tty1";

 Restart = "always";
 RestartSec = "10s";
 OOMScoreAdjust = -1000;
 };
 script = ''
 sleep 2
 echo -e "\n\033[1;32m\033[0m"
 echo -e "\033[1;32m NIXHOME SYSTEM STATUS\033[0m"
 echo -e "\033[1;32m\033[0m"
 echo -e "\n\033[1;34m IPv4 Adressen:\033[0m"
 ${pkgs.iproute2}/bin/ip -4 -o addr show | ${pkgs.gnugrep}/bin/grep -v 'lo' | ${pkgs.gawk}/bin/awk '{print " " $2 ": " $4}' | ${pkgs.gnused}/bin/sed 's|/[0-9]*||'
 echo -e "\n\033[1;34m Lokale URLs:\033[0m"
 echo -e " http://nixhome.local\n http://10.254.0.1 (Notfall-Anker)\n http://$(hostname).local"
 echo -e "\n\033[1;33m SSH Zugang:\033[0m"
 echo -e " ssh ${config.my.configs.identity.user}@10.254.0.1 -p ${toString config.my.ports.ssh}"
 echo -e "\n\033[1;32m\033[0m\n"
 '';
 };
 };
}

``n---

* Pfad: modules\core\zram-swap.nix | Format: .nix | Größe: 1,45 KB
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-040";
 title = "Zram Swap (AI Optimized)";
 description = "Optimized compressed RAM swap for AI workloads (Ollama/Claude). High swappiness for CPU-efficient memory management.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/performance" "hardware/ram-optimization" "ai/optimization"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 ramGB = config.my.configs.hardware.ramGB or 16;
in {
 options.my.meta.zram_swap = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for zram-swap module";
 };

 config = {
 zramSwap = {
 enable = true;
 algorithm = "zstd"; # hardened standard for best ratio
 priority = 100;
 memoryPercent =
 if ramGB <= 4 then 75
 else if ramGB <= 8 then 60
 else 40; # 40% of RAM for ZRAM to buffer AI models
 };

 boot.kernel.sysctl = {

 "vm.swappiness" = lib.mkForce 180; # Kernels move pages aggressively to ZRAM
 "vm.page-cluster" = 0; # Skip expensive read-ahead on ZRAM
 "vm.vfs_cache_pressure" = 50; # Keep directory entries in RAM longer
 };
 };
}

``n---

* Pfad: modules\logging\vector-tier-b.nix | Format: .nix | Größe: 3,21 KB
``nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.logging.vector;
 srePaths = config.my.configs.paths;
 logDir = "${srePaths.tierB}/logs/vector";
 maxTotalSizeMB = 1024; # 1 GB
in
{
 options.my.logging.vector = {
 enable = lib.mkEnableOption "Vector logging to Tier B";
 retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
 maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 200; };
 };

 config = lib.mkIf cfg.enable {

 services.journald.extraConfig = ''Storage=volatile'';

 services.vector = {
 enable = true;
 config = {
 sources.journald = {
 type = "journald";
 current_boot_only = false;
 };
 transforms.mask_sensitive = {
 type = "remap";
 inputs = [ "journald" ];
 source = ''

 .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
 .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
 '';
 };
 sinks.file = {
 type = "file";
 inputs = [ "mask_sensitive" ];
 path = "${logDir}/journal-%Y-%m-%d.log";
 encoding.codec = "ndjson";
 compression = "gzip";
 batch.max_bytes = cfg.maxFileSizeMB * 1024 * 1024;
 healthcheck = true;
 };
 };
 };

 systemd.services.rotate-vector-logs = {
 description = "Rotate and delete old Vector logs (size/age based)";
 serviceConfig = {
 Type = "oneshot";
 Nice = 19;
 IOSchedulingClass = "idle";
 ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
 set -euo pipefail

 find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete

 total=0
 while IFS= read -r file; do
 size=$(stat -c %s "$file")
 total=$((total + size))
 done < <(find ${logDir} -name "*.gz" -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)
 totalMB=$((total / 1024 / 1024))
 if [ $totalMB -gt ${toString maxTotalSizeMB} ]; then
 find ${logDir} -name "*.gz" -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2- | while read -r file; do
 [ $totalMB -le ${toString maxTotalSizeMB} ] && break
 rm "$file"
 total=0
 for f in $(find ${logDir} -name "*.gz" -type f); do
 s=$(stat -c %s "$f")
 total=$((total + s))
 done
 totalMB=$((total / 1024 / 1024))
 done
 fi
 '';
 };
 };
 systemd.timers.rotate-vector-logs = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };

 systemd.tmpfiles.rules = [ "d ${logDir} 0750 root root - -" ];
 };
}

``n---

* Pfad: modules\security\binary-only.nix | Format: .nix | Größe: 857 B
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-90-POL-001";
 title = "Binary-Only Policy";
 description = "Enforces a strict download-only workflow by forbidding local compilation to protect system resources.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "system/stability" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.binary_only = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for binary-only module";
 };

 config = {
 nix.settings.max-jobs = lib.mkForce 0;
 assertions = [ { assertion = config.nix.settings.max-jobs == 0; message = " [POLICY-VIOLATION] Lokales Kompilieren ist verboten!"; } ];
 };
}

``n---

* Pfad: modules\security\flat-layout.nix | Format: .nix | Größe: 1,58 KB
``nix
{ lib, ... }:
let
 nms = {
 id = "NIXH-01-SEC-FLAT-001";
 title = "Flat Layout Enforcement (Horizontal)";
 description = "Enforces zero-depth directory structure for modular silos.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "architecture/integrity" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 layersToCheck = [
 ../core
 ../services
 ../apps
 ../security
 ];

 hasSubdirs = dir: 
 let

 contents = if builtins.pathExists dir then builtins.readDir dir else {};
 dirs = lib.filterAttrs (n: v: v == "directory") contents;
 in
 (builtins.length (builtins.attrNames dirs)) > 0;

 offendingLayers = lib.filter (dir: hasSubdirs dir) layersToCheck;
in
{
 options.my.meta.flat_layout = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config.assertions = [
 {
 assertion = (builtins.length offendingLayers) == 0;
 message = " NIXHOME HORIZONTAL VIOLATION: Subdirectories in modules/ silos are strictly forbidden! (hardened Rule)";
 }
 ];
}

``n---

* Pfad: modules\security\no-legacy.nix | Format: .nix | Größe: 1,24 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-90-POL-003";
 title = "No Legacy";
 description = "Blocks legacy services and insecure protocols.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "security/hardening" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
 msg = prefix: alt: " [LEGACY-BLOCK] ${prefix} ist veraltet. Nutze ${alt}.";
in
{
 options.my.meta.no_legacy = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
 assertions = [
 { assertion = !config.boot.loader.grub.enable; message = msg "GRUB" "systemd-boot"; }
 { assertion = !config.services.cron.enable; message = msg "Cron" "systemd.timers"; }
 { assertion = !config.networking.networkmanager.enable; message = msg "NetworkManager" "systemd-networkd"; }
 ];
 services.samba.settings.global."server min protocol" = "SMB2_10";
 boot.blacklistedKernelModules = [ "ext2" "ext3" "jfs" "reiserfs" "hfs" "hfsplus" "ntfs" ];
 networking.nftables.enable = true;
 networking.firewall.enable = lib.mkForce true;
 boot.initrd.compressor = "zstd";
 };
}

``n---

* Pfad: modules\security\security-assertions.nix | Format: .nix | Größe: 1,11 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-90-POL-004";
 title = "Security Assertions";
 description = "Global security assertions to ensure critical hardening settings are active in production.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "security/hardening" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
 bastelmodus = config.my.configs.bastelmodus;
 must = assertion: message: { inherit assertion message; };
 sshSettings = config.services.openssh.settings;
in
{
 options.my.meta.security_assertions = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for security-assertions module";
 };

 config.assertions = lib.optionals (!bastelmodus) [
 (must (config.networking.firewall.enable == true) "[SEC-NET-001] Firewall aktiv.")
 (must (config.networking.nftables.enable == true) "[SEC-NET-002] NFTables aktiv.")
 (must (sshSettings.PermitRootLogin == "no") "[SEC-SSH-002] No Root SSH.")
 ];
}

``n---

* Pfad: modules\services\caddy.nix | Format: .nix | Größe: 5,46 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-SRV-CAD-001";
 title = "Caddy (M1 Abrams v2)";
 description = "Hardened Edge Proxy with GeoIP, mTLS, SSO and Rate-Limiting. Decoupled horizontal architecture.";
 layer = 10;
 nixpkgs.category = "servers/proxy";
 capabilities = ["network/ingress" "security/waf" "security/mtls" "security/geoip" "automation/dns-01"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.services.caddy;
 sreConfig = config.my.configs;

 trustedIPs = lib.concatStringsSep " " (
 ["127.0.0.1" "173.245.48.0/20" "103.21.244.0/22" "103.22.200.0/22" "103.31.4.0/22" "141.101.64.0/18" "108.162.192.0/18" "190.93.240.0/20" "188.114.96.0/20" "197.234.240.0/22" "198.41.128.0/17" "162.158.0.0/15" "104.16.0.0/13" "104.24.0.0/14" "172.64.0.0/13" "131.0.72.0/22"]
 ++ sreConfig.network.tailnetCidrs
 ++ sreConfig.network.lanCidrs
 );

in {
 options.my.meta.caddy = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.caddy.enable {

 boot.kernel.sysctl = {
 "net.core.rmem_max" = 8388608;
 "net.core.wmem_max" = 8388608;
 "net.ipv4.tcp_fastopen" = 3;
 };

 services.caddy = {
 enable = true;

 globalConfig = ''
 admin localhost:2019

 order rate_limit before reverse_proxy

 servers {
 trusted_proxies static ${trustedIPs}

 trusted_proxies_strict
 }

 acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
 '';

 extraConfig = ''

 (security_headers) {
 header {
 X-Content-Type-Options nosniff
 X-Frame-Options DENY
 Referrer-Policy no-referrer-when-downgrade
 Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
 }
 }

 (geoblock) {
 @geoblock {

 not remote_ip ${trustedIPs}
 }
 }

 (mtls_auth) {
 tls {
 client_auth {
 mode require_and_verify
 trust_pool file /etc/nixos/secrets/mtls/ca.crt
 }
 }
 import security_headers
 }

 (sso_auth) {
 @needs_auth {
 not remote_ip ${trustedIPs}
 }
 forward_auth @needs_auth localhost:${toString config.my.ports.pocketId} {
 uri /api/auth/verify
 copy_headers X-Forwarded-User
 }
 import security_headers
 }

 (proxy_stream) {
 reverse_proxy {args[0]} {
 flush_interval -1
 }
 }

 *.${sreConfig.identity.subdomain}.${sreConfig.identity.domain} {
 tls {
 dns cloudflare {env.CLOUDFLARE_API_TOKEN}
 }

 handle /certs

``n---

* Pfad: modules\services\clamav.nix | Format: .nix | Größe: 1,28 KB
``nix
{ lib, pkgs, config, ... }:
let
 nms = {
 id = "NIXH-20-INF-001";
 title = "ClamAV (SRE Exhausted)";
 description = "Professional antivirus protection.";
 layer = 10;
 nixpkgs.category = "services/security";
 capabilities = [ "security/antivirus" "system/protection" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.clamav = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.clamav.enable or true) {
 services.clamav = {
 daemon.enable = true;
 updater.enable = true;
 scanner = {
 enable = true;
 interval = "Sat *-*-* 03:00:00";
 scanDirectories = [ "/home" "/var/lib" "/etc" ];
 };
 daemon.settings = {
 LogTime = true;
 LogVerbose = false;
 MaxScanSize = "100M";
 MaxFileSize = "50M";

 ExcludePath = [ "^/mnt/media" "^/mnt/fast-pool/downloads" ];
 };
 };

 systemd.services.clamdscan.serviceConfig = {
 CPUWeight = 20; IOWeight = 20; CPUSchedulingPolicy = "idle"; IOSchedulingClass = "idle";
 };
 };
}

``n---

* Pfad: modules\services\cloudflared-tunnel.nix | Format: .nix | Größe: 2,41 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-003";
 title = "Cloudflared Tunnel (SRE Exhausted)";
 description = "Secure Ingress bridge using Cloudflare Tunnels for zero-port-forwarding connectivity.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/ingress" "security/tunnel" "cloudflare/integration" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 cfg = config.my.cloudflare.tunnel;
 creds = config.my.secrets.files.cloudflaredTunnelCredentials;
 proxyUrl = if config.my.profiles.networking.reverseProxy == "caddy"
 then "https://127.0.0.1:443"
 else "https://127.0.0.1:${toString config.my.ports.edgeHttps}";
in
{
 options.my.meta.cloudflared_tunnel = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for cloudflared-tunnel module";
 };

 options.my.cloudflare.tunnel = {
 enable = lib.mkEnableOption "Cloudflare Tunnel Ingress bridge";
 tunnelId = lib.mkOption { type = lib.types.str; default = ""; };
 domain = lib.mkOption { type = lib.types.str; default = config.my.configs.identity.domain; };
 wildcardPrefix = lib.mkOption { type = lib.types.str; default = "*.nix"; };
 };

 config = lib.mkIf cfg.enable {
 assertions = [ { assertion = cfg.tunnelId != ""; message = "cloudflared: tunnelId muss gesetzt sein."; } ];
 systemd.services."cloudflared-tunnel-${cfg.tunnelId}" = {
 preStart = "if [ ! -f '${creds}' ]; then echo 'FEHLER: Credentials fehlen.'; exit 1; fi";
 serviceConfig = {
 ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
 CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ]; AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
 OOMScoreAdjust = -500;
 };
 };
 services.cloudflared = {
 enable = true;
 tunnels.${cfg.tunnelId} = {
 credentialsFile = creds;
 ingress = {
 "${cfg.wildcardPrefix}.${cfg.domain}" = {
 service = proxyUrl;
 originRequest = { noTLSVerify = false; originServerName = "${cfg.wildcardPrefix}.${cfg.domain}"; http2Origin = true; keepAliveConnections = 8; };
 };
 };
 default = "http_status:404";
 };
 };
 };
}

``n---

* Pfad: modules\services\cockpit.nix | Format: .nix | Größe: 883 B
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-80-MON-001"; title = "Cockpit"; description = "Web admin."; layer = 80; nixpkgs.category = "tools/admin"; capabilities = [ "system/administration" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 1; };
 cfg = config.my.services.cockpit;
 domain = config.my.configs.identity.domain;
 port = config.my.ports.cockpit;
in
{
 options.my.meta.cockpit = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf cfg.enable {
 services.cockpit = { enable = true; port = port; package = pkgs.cockpit; settings = { WebService = { AllowUnencrypted = true; ProtocolHeader = "X-Forwarded-Proto"; }; Session = { IdleTimeout = 15; }; }; };
 services.caddy.virtualHosts."admin.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 };
}

``n---

* Pfad: modules\services\ddns-updater.nix | Format: .nix | Größe: 1,04 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-004";
 title = "Ddns Updater";
 description = "Automated Dynamic DNS updates for Cloudflare and other providers.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/ddns" "cloudflare/integration" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 domain = config.my.configs.identity.domain;
 port = config.my.ports.ddnsUpdater;
in
{
 options.my.meta.ddns_updater = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for ddns-updater module";
 };

 config = lib.mkIf config.my.services.ddnsUpdater.enable {
 services.ddns-updater = {
 enable = true;
 environment = { LISTENING_ADDRESS = ":${toString port}"; PERIOD = "10m"; };
 };
 services.caddy.virtualHosts."nix-ddns.${domain}" = {
 extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}";
 };
 };
}

``n---

* Pfad: modules\services\dns-automation.nix | Format: .nix | Größe: 2,42 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-005";
 title = "Dns Automation";
 description = "Check Cloudflare for DNS conflicts and update runtime map for dynamic routing.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/dns-automation" "cloudflare/api" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 runtimeDnsMap = "/var/lib/nixhome/dns-map-runtime.json";
 domain = config.my.configs.identity.domain;
 cfTokenFile = config.sops.secrets.cloudflare_token.path;
in
{
 options.my.meta.dns_automation = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for dns-automation module";
 };

 config = lib.mkIf config.my.services.dnsAutomation.enable {
 systemd.services.dns-guard = {
 description = "Check Cloudflare for DNS conflicts";
 after = [ "network-online.target" "sops-install-secrets.service" ];
 requires = [ "network-online.target" ];
 serviceConfig = {
 Type = "oneshot";
 StateDirectory = "nixhome";
 ExecStart = pkgs.writeShellScript "dns-guard-runtime" ''
 set -euo pipefail
 TOKEN=$(cat "${cfTokenFile}")
 ZONE_DATA=$(${pkgs.curl}/bin/curl -sf -X GET "https://api.cloudflare.com/client/v4/zones" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json")
 ZONE_ID=$(echo "$ZONE_DATA" | ${pkgs.jq}/bin/jq -r ".result[0].id")
 if [ -z "$ZONE_ID" ] || [ "$ZONE_ID" = "null" ]; then exit 1; fi
 EXISTING_RECORDS=$(${pkgs.curl}/bin/curl -sf "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?per_page=100" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" | ${pkgs.jq}/bin/jq -r ".result[].name")
 GLOBAL_CONFLICT=false
 for record in $EXISTING_RECORDS; do if [[ "$record" == "*.${domain}" ]]; then GLOBAL_CONFLICT=true; break; fi; done
 ${pkgs.jq}/bin/jq -n --argjson conflict "$GLOBAL_CONFLICT" --arg domain "${domain}" '{useNixSubdomain: $conflict, baseDomain: $domain}' > "${runtimeDnsMap}"
 '';
 };
 path = with pkgs; [ curl jq coreutils gnugrep ];
 };
 systemd.timers.dns-guard = { wantedBy = [ "timers.target" ]; timerConfig = { OnBootSec = "1min"; OnUnitActiveSec = "30min"; RandomizedDelaySec = "60"; }; };
 };
}

``n---

* Pfad: modules\services\dns-map.nix | Format: .nix | Größe: 946 B
``nix
let
 baseDomain = "m7c5.de";
 sub = "nix";
 d = "${sub}.${baseDomain}";
in
{
 useNixSubdomain = true;
 baseDomain = baseDomain;
 sub = sub;
 dnsMapping = {
 jellyfin = "jellyfin.${d}"; sonarr = "sonarr.${d}"; radarr = "radarr.${d}"; prowlarr = "prowlarr.${d}"; readarr = "readarr.${d}"; lidarr = "lidarr.${d}";
 audiobookshelf = "audiobookshelf.${d}"; sabnzbd = "sabnzbd.${d}"; jellyseerr = "jellyseerr.${d}";
 vault = "vault.${d}"; paperless = "paperless.${d}"; n8n = "n8n.${d}"; miniflux = "miniflux.${d}"; monica = "monica.${d}"; readeck = "readeck.${d}"; matrix = "matrix.${d}";
 auth = "auth.${d}"; dashboard = "dash.${d}"; adguard = "dns.${d}"; olivetin = "olivetin.local"; status = "status.${d}"; netdata = "netdata.${d}"; scrutiny = "scrutiny.${d}";
 filebrowser = "filebrowser.${d}"; homeassistant = "home.${d}"; openwebui = "openwebui.${d}"; cockpit = "admin.${d}"; ddns = "nix-ddns.${d}";
 };
}

``n---

* Pfad: modules\services\homepage.nix | Format: .nix | Größe: 3,03 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-007";
 title = "Homepage Dashboard";
 description = "Highly customizable application dashboard, fully declarative.";
 layer = 10;
 nixpkgs.category = "services/misc";
 capabilities = [ "web/dashboard" "observability/ui" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 dnsMap = import ./dns-map.nix;
 host = dnsMap.dnsMapping.dashboard or "nixhome.${dnsMap.baseDomain}";
in
{
 options.my.meta.homepage = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for homepage module";
 };

 config = lib.mkIf config.my.services.homepage.enable {
 services.homepage-dashboard = {
 enable = true;
 environmentFile = config.my.secrets.files.sharedEnv;
 widgets = [ { resources = { cpu = true; memory = true; disk = "/"; uptime = true; }; } { search = { provider = "duckduckgo"; target = "_blank"; }; } ];
 services = [
 { "Media" = [ { "Jellyfin" = { icon = "jellyfin.png"; href = "https://${dnsMap.dnsMapping.jellyfin}"; }; } { "Sonarr" = { icon = "sonarr.png"; href = "https://${dnsMap.dnsMapping.sonarr}"; }; } { "Radarr" = { icon = "radarr.png"; href = "https://${dnsMap.dnsMapping.radarr}"; }; } { "Prowlarr" = { icon = "prowlarr.png"; href = "https://${dnsMap.dnsMapping.prowlarr}"; }; } { "Readarr" = { icon = "readarr.png"; href = "https://${dnsMap.dnsMapping.readarr}"; }; } { "Audiobookshelf" = { icon = "audiobookshelf.png"; href = "https://${dnsMap.dnsMapping.audiobookshelf}"; }; } ]; }
 { "Tools" = [ { "Vaultwarden" = { icon = "vaultwarden.png"; href = "https://${dnsMap.dnsMapping.vault}"; }; } { "Paperless" = { icon = "paperless.png"; href = "https://${dnsMap.dnsMapping.paperless}"; }; } { "n8n" = { icon = "n8n.png"; href = "https://${dnsMap.dnsMapping.n8n}"; }; } { "Miniflux" = { icon = "miniflux.png"; href = "https://${dnsMap.dnsMapping.miniflux}"; }; } { "Monica" = { icon = "monica.png"; href = "https://${dnsMap.dnsMapping.monica}"; }; } ]; }
 { "Infrastructure" = [ { "OliveTin" = { icon = "olivetin.png"; href = "https://${dnsMap.dnsMapping.olivetin or "olivetin.m7c5.de"}"; }; } { "Pocket-ID" = { icon = "pocket-id.png"; href = "https://${dnsMap.dnsMapping.auth}"; }; } { "Netdata" = { icon = "netdata.png"; href = "https://netdata.${config.my.configs.identity.domain}"; }; } { "AdGuard" = { icon = "adguard-home.png"; href = "https://${dnsMap.dnsMapping.adguard or "adguard.m7c5.de"}"; }; } ]; }
 ];
 settings = { title = "nixhome dashboard"; layout = { Media = { style = "grid"; columns = 3; }; Tools = { style = "grid"; columns = 3; }; Infrastructure = { style = "grid"; columns = 2; }; }; };
 };
 services.caddy.virtualHosts."${host}" = {
 extraConfig = "@tailscale remote_ip 100.64.0.0/10\nhandle @tailscale { reverse_proxy 127.0.0.1:${toString config.my.ports.homepage} }\nimport sso_auth\nreverse_proxy 127.0.0.1:${toString config.my.ports.homepage}";
 };
 };
}

``n---

* Pfad: modules\services\landing-zone-ui.nix | Format: .nix | Größe: 807 B
``nix
{ config, pkgs, lib, ... }:
let
 nms = { id = "NIXH-10-GTW-008"; title = "Landing Zone Ui"; description = "Static landing page."; layer = 10; nixpkgs.category = "web/apps"; capabilities = [ "web/landing-page" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 1; };
 domain = config.my.configs.identity.domain;
 lanIP = config.my.configs.network.lanIP;
 rescueHtml = pkgs.writeTextDir "index.html" "<html><body>Rettungsweg</body></html>";
in
{
 options.my.meta.landing_zone_ui = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf (config.my.services.landingZone.enable or true) {
 systemd.tmpfiles.rules = [ "d /var/www/landing-zone 0755 caddy caddy -" "L+ /var/www/landing-zone/index.html - - - - ${rescueHtml}/index.html" ];
 };
}

``n---

* Pfad: modules\services\pocket-id.nix | Format: .nix | Größe: 2,00 KB
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-10-GTW-009";
 title = "Pocket-ID (OIDC Provider)";
 description = "Self-hosted OIDC identity provider for secure SSO with Caddy integration.";
 layer = 10;
 nixpkgs.category = "services/security";
 capabilities = ["security/oidc" "identity/provider"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 cfg = config.my.services.pocketId;
 domain = config.my.configs.identity.domain;
 subdomain = config.my.configs.identity.subdomain;
 port = config.my.ports.pocketId;
in {

 options.my.meta.pocketId = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {

 assertions = [
 {
 assertion = config.my.profiles.networking.reverseProxy == "caddy";
 message = "Pocket-ID requires Caddy as reverseProxy.";
 }
 ];

 warnings = ["pocket-id: public_registration = true ist aktiv!"];

 services.pocket-id = {
 enable = true;
 dataDir = "/var/lib/pocket-id";
 settings = {
 issuer = lib.mkForce "https://auth.${subdomain}.${domain}";
 title = "NixHome Identity";
 public_registration = true; # Für erste Einrichtung OK
 };
 };

 systemd.services.pocket-id.serviceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 Restart = "always";
 RestartSec = "5s";
 OOMScoreAdjust = -100;
 };

 services.caddy.virtualHosts."auth.${subdomain}.${domain}" = {
 extraConfig = "reverse_proxy 127.0.0.1:${toString port}";
 };
 };
}

``n---

* Pfad: modules\services\postgresql.nix | Format: .nix | Größe: 2,21 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-20-INF-002";
 title = "PostgreSQL (SRE Optimized)";
 description = "Optimized database cluster with automated backups and strict sandboxing.";
 layer = 10;
 nixpkgs.category = "services/databases";
 capabilities = [ "database/postgresql" "system/persistence" "maintenance/auto-backup" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.postgresql = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for postgresql module";
 };

 config = lib.mkIf config.my.services.postgresql.enable {
 services.postgresql = {
 enable = true;
 package = pkgs.postgresql_17;
 initdbArgs = [ "--data-checksums" ];
 ensureDatabases = [ "miniflux" "paperless" "n8n" ];
 ensureUsers = [ { name = "miniflux"; ensureDBOwnership = true; } { name = "paperless"; ensureDBOwnership = true; } { name = "n8n"; ensureDBOwnership = true; } ];
 enableJIT = true;
 settings = {
 shared_buffers = "512MB"; effective_cache_size = "4GB"; maintenance_work_mem = "128MB"; checkpoint_completion_target = 0.9;
 wal_buffers = "16MB"; default_statistics_target = 100; random_page_cost = 1.1; effective_io_concurrency = 200;
 work_mem = "8MB"; min_wal_size = "512MB"; max_wal_size = "2GB"; huge_pages = "try";
 log_min_duration_statement = 250; log_checkpoints = "on"; log_connections = "on"; log_disconnections = "on"; log_lock_waits = "on";
 };
 };
 services.postgresqlBackup = { enable = true; databases = [ "miniflux" "paperless" "n8n" ]; location = "/data/state/backups/postgresql"; startAt = "01:30"; };
 systemd.services.postgresql.serviceConfig = { ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true; SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ]; OOMScoreAdjust = -900; };
 systemd.services.miniflux.after = [ "postgresql.service" ];
 systemd.services.n8n.after = [ "postgresql.service" ];
 systemd.services.paperless-web.after = [ "postgresql.service" ];
 };
}

``n---

* Pfad: modules\services\secret-ingest.nix | Format: .nix | Größe: 1,21 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-20-INF-003";
 title = "Secret Ingest";
 description = "Watcher for secret landing zone.";
 layer = 10;
 nixpkgs.category = "services/admin";
 capabilities = [ "automation/secrets" "security/ingest" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
 python = pkgs.python311;
in
{
 options.my.meta.secret_ingest = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.secretIngest.enable or true) {
 systemd.paths.secret-ingest = {
 description = "Wächter für Secret Landing Zone";
 wantedBy = [ "multi-user.target" ];
 pathConfig = { DirectoryNotEmpty = "/etc/nixos/secret-landing-zone"; MakeDirectory = true; };
 };

 systemd.services.secret-ingest = {
 description = "Secret Ingest Agent";
 path = with pkgs; [ sops coreutils ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = pkgs.writeScript "ingest-run" "#!${python}/bin/python\nimport os, re, subprocess, glob\n..."; # Shortened
 User = "root";
 };
 };
 };
}

``n---

* Pfad: modules\services\service-app-zigbee-stack.nix | Format: .nix | Größe: 5,03 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-SRV-ZIG-001";
 title = "Zigbee Stack (Mosquitto & Z2M)";
 description = "Hardened Zigbee infrastructure with Mosquitto Broker and Zigbee2MQTT.";
 layer = 20;
 nixpkgs.category = "services/home-automation";
 capabilities = ["iot/zigbee" "iot/mqtt" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.services.zigbeeStack;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

 isUsbDevice = lib.hasPrefix "/dev/" cfg.zigbeeDevice;

in
{
 options.my.meta.zigbee_stack = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.services.zigbeeStack = {
 enable = lib.mkEnableOption "Zigbee Stack (Mosquitto + Zigbee2MQTT)";

 mqttPort = lib.mkOption { 
 type = lib.types.port; 
 default = config.my.ports.mqtt or 1883; 
 description = "Internal MQTT Broker Port";
 };

 zigbeePort = lib.mkOption { 
 type = lib.types.port; 
 default = config.my.ports.zigbee2mqtt or 8080; 
 description = "Zigbee2MQTT Frontend Port";
 };

 zigbeeDevice = lib.mkOption { 
 type = lib.types.str; 
 default = "socket://192.168.2.46:6638"; 
 description = "Zigbee adapter path (e.g. /dev/ttyUSB0) or socket (SLZB-06)";
 };

 adapter = lib.mkOption {
 type = lib.types.enum [ "ember" "zstack" "deconz" "ezsp" ];
 default = "ember";
 description = "Zigbee adapter type (ember for modern SLZB-06/Sonoff P)";
 };

 dataDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/zigbee2mqtt"; 
 description = "State directory for Zigbee2MQTT (Tier A/Persist)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "zigbee2mqtt";
 port = cfg.zigbeePort;
 useSSO = true;
 description = "Zigbee2MQTT Frontend";
 persist = true;
 readWritePaths = [ cfg.dataDir ];
 })

 {

 services.mosquitto = {
 enable = true;
 listeners = [{
 port = cfg.mqttPort;
 address = "127.0.0.1"; # hardened: Only local access
 acl = [ "pattern readwrite #" ];
 settings.allow_anonymous = true;
 }];
 };

 systemd.services.mosquitto.serviceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 ReadWritePaths = [ "/var/lib/mosquitto" ];
 };

 services.zigbee2mqtt = {
 enable = true;
 dataDir = cfg.dataDir;
 settings = {
 homeassistant = true;
 permit_join = false;
 mqtt = {
 base_topic = "zigbee2mqtt";
 server = "mqtt://127.0.0.1:${toString cfg.mqttPort}";
 };
 serial = {
 port = cfg.zigbeeDevice;
 adapter = cfg.adapter;
 };
 frontend = {
 port = cfg.zigbeePort;
 host = "127.0.0.1";
 };
 advanced = {
 log_directory = "${cfg.dataDir}/log";
 pan_id = 0x1a2b; # hardened: Custom PAN-ID (Source: Fragment 18968)
 };
 };
 };

 systemd.services.zigbee2mqtt = {
 after = [ "mosquitto.service" ];
 wants = [ "mosquitto.service" ];

 serviceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 PrivateDevices = if isUsbDevice then lib.mkForce false else true;
 DeviceAllow = lib.optional isUsbDevice "${cfg.zigbeeDevice} rw";

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.dataDir} 0750 zigbee2mqtt mqtt -"
 "d /var/lib/mosquitto 0750 mosquitto mqtt -"
 ];

 environment.persistence."/persist" = {
 directories = [ 
 "/var/lib/mosquitto"
 "/var/lib/zigbee2mqtt"
 ];
 };

 users.groups.mqtt = {};
 users.users.zigbee2mqtt.extraGroups = [ "mqtt" "dialout" ];
 users.users.mosquitto.extraGroups = [ "mqtt" ];
 }
 ]);
}

``n---

* Pfad: modules\services\service-netdata.nix | Format: .nix | Größe: 1,77 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-80-MON-002";
 title = "Netdata (SRE Exhausted)";
 description = "Real-time performance monitoring with high-retention dbengine and strict sandboxing.";
 layer = 80;
 nixpkgs.category = "services/monitoring";
 capabilities = [ "monitoring/real-time" "observability/metrics" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.netdata;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.netdata = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for netdata module";
 };

 config = lib.mkIf config.my.services.netdata.enable {
 services.netdata = {
 enable = true;
 config = {
 global = { "memory mode" = "dbengine"; "page cache size" = "256"; "dbengine disk space" = "4096"; "history" = 86400; };
 web = { "allow connections from" = "localhost 127.0.0.1"; "default port" = toString port; "mode" = "static-threaded"; };
 db = { "dbengine tier 1 retention days" = 30; };
 health.enabled = "yes";
 };
 };
 services.caddy.virtualHosts."netdata.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.netdata.serviceConfig = {
 ProtectSystem = lib.mkForce "full"; ProtectHome = lib.mkForce true; PrivateTmp = lib.mkForce true; PrivateDevices = lib.mkForce true;
 NoNewPrivileges = true; CapabilityBoundingSet = [ "CAP_DAC_READ_SEARCH" "CAP_SYS_PTRACE" "CAP_NET_RAW" ]; AmbientCapabilities = [ "CAP_DAC_READ_SEARCH" "CAP_SYS_PTRACE" "CAP_NET_RAW" ];
 MemoryMax = "1G"; CPUWeight = 50; OOMScoreAdjust = 1000;
 };
 };
}

``n---

* Pfad: modules\services\service-scrutiny.nix | Format: .nix | Größe: 1,32 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-80-MON-003";
 title = "Scrutiny (SRE Hardened)";
 description = "Hard drive S.M.A.R.T monitoring with automated collection and InfluxDB trends.";
 layer = 80;
 nixpkgs.category = "services/monitoring";
 capabilities = [ "monitoring/smart" "hardware/health" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.scrutiny;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.scrutiny = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for scrutiny module";
 };

 config = lib.mkIf config.my.services.scrutiny.enable {
 services.scrutiny = { enable = true; settings = { web.listen.port = port; web.listen.host = "127.0.0.1"; log.level = "INFO"; }; influxdb.enable = true; collector = { enable = true; schedule = "daily"; }; };
 services.caddy.virtualHosts."scrutiny.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.scrutiny.serviceConfig = { DynamicUser = true; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; OOMScoreAdjust = 800; };
 services.smartd.enable = true;
 };
}

``n---

* Pfad: modules\services\sso.nix | Format: .nix | Größe: 1,22 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-10-GTW-010"; title = "SSO"; description = "SSO config."; layer = 10; nixpkgs.category = "services/security"; capabilities = [ "security/sso" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 2; };
 cfg = config.my.services.pocketId;
 domain = config.my.configs.identity.domain;
 pocketIdPort = config.my.ports.pocketId;
 dnsMap = import ./dns-map.nix;
 allUrls = (map (h: "https://${h}") (lib.attrValues dnsMap.dnsMapping)) ++ [ "https://auth.${domain}/callback" ];
in
{
 options.my.meta.sso = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf cfg.enable {
 services.pocket-id.settings = { issuer = "https://auth.${domain}"; title = "m7c5 Login"; allowed_redirect_urls = lib.concatStringsSep "," allUrls; session_ttl_seconds = 86400; };
 systemd.services.pocket-id-bootstrap = {
 description = "Pocket-ID Bootstrap"; after = [ "pocket-id.service" ]; wantedBy = [ "multi-user.target" ]; unitConfig.ConditionPathExists = "!/var/lib/pocket-id/.bootstrapped";
 serviceConfig = { Type = "oneshot"; RemainAfterExit = true; };
 script = "sleep 2; touch /var/lib/pocket-id/.bootstrapped";
 };
 };
}

``n---

* Pfad: modules\services\tailscale.nix | Format: .nix | Größe: 1,68 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-10-GTW-011";
 title = "Tailscale (Zero-Touch)";
 description = "Declarative VPN with autoconnect pattern and SOPS-nix secret integration.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/vpn" "security/tailscale" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.tailscale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for tailscale module";
 };

 config = lib.mkIf config.my.services.tailscale.enable {
 services.tailscale = { enable = true; openFirewall = false; useRoutingFeatures = "client"; extraUpFlags = [ "--ssh" "--accept-dns=true" "--accept-routes=true" ]; permitCertUid = config.services.caddy.user; };
 systemd.services.tailscale-autoconnect = {
 description = "Automatic Tailscale Login";
 after = [ "tailscaled.service" "network-online.target" ]; wants = [ "tailscaled.service" "network-online.target" ]; wantedBy = [ "multi-user.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = pkgs.writeShellScript "tailscale-auth" "sleep 2; status=$(${pkgs.tailscale}/bin/tailscale status --json | ${pkgs.jq}/bin/jq -r .BackendState); if [ '$status' = 'NeedsLogin' ] || [ '$status' = 'Stopped' ]; then ${pkgs.tailscale}/bin/tailscale up --authkey='$(cat ${config.sops.secrets.tailscale_token.path})'; fi";
 };
 };
 systemd.services.tailscaled = { stopIfChanged = false; serviceConfig = { Restart = "always"; RestartSec = "2s"; OOMScoreAdjust = -1000; }; };
 };
}

``n---

* Pfad: modules\services\uptime-kuma.nix | Format: .nix | Größe: 1,31 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-80-MON-004";
 title = "Uptime Kuma (SRE Exhausted)";
 description = "Self-hosted monitoring tool, tightly sandboxed with resource limits.";
 layer = 80;
 nixpkgs.category = "services/monitoring";
 capabilities = [ "monitoring/uptime" "web/dashboard" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 port = config.my.ports.uptimeKuma;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.uptime_kuma = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for uptime-kuma module";
 };

 config = lib.mkIf config.my.services.uptimeKuma.enable {
 services.uptime-kuma = { enable = true; settings.PORT = toString port; };
 services.caddy.virtualHosts."status.${domain}" = {
 extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}";
 };
 systemd.services.uptime-kuma.serviceConfig = {
 ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
 CapabilityBoundingSet = [ "CAP_NET_RAW" ]; AmbientCapabilities = [ "CAP_NET_RAW" ];
 MemoryMax = "512M"; CPUWeight = 30; OOMScoreAdjust = 500;
 };
 };
}

``n---

* Pfad: modules\services\valkey.nix | Format: .nix | Größe: 1,36 KB
``nix
{ pkgs, lib, config, ... }:
let

 nms = {
 id = "NIXH-20-INF-006";
 title = "Valkey (SRE Exhausted)";
 description = "High-performance Valkey (Redis fork) with memory caps and hardened sandboxing.";
 layer = 10;
 nixpkgs.category = "services/databases";
 capabilities = [ "database/key-value" "caching/redis" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.valkey = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for valkey module";
 };

 config = lib.mkIf config.my.services.valkey.enable {
 services.redis.package = pkgs.valkey;
 services.redis.servers.valkey = {
 enable = true; bind = "127.0.0.1"; port = 6379; openFirewall = false;
 settings = {
 maxmemory = "512mb"; maxmemory-policy = "allkeys-lru";
 save = [ "900 1" "300 10" "60 10000" ];
 unixsocket = "/run/redis-valkey/redis.sock"; unixsocketperm = lib.mkForce "770";
 };
 };
 systemd.services.redis-valkey.serviceConfig = {
 ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
 MemoryDenyWriteExecute = true; RestrictAddressFamilies = [ "AF_INET" "AF_UNIX" ]; OOMScoreAdjust = -500;
 };
 };
}

``n---

* Pfad: modules\services\vpn-confinement.nix | Format: .nix | Größe: 3,90 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-SRV-VPN-001";
 title = "VPN Confinement (Maroka-chan based)";
 description = "Isolated network namespaces for VPN-bound services with kill-switch protection.";
 layer = 10;
 nixpkgs.category = "network/vpn";
 capabilities = ["network/isolation" "network/vpn" "security/kill-switch"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.services.vpnConfinement;
 srePaths = config.my.configs.paths;

in {
 options.my.meta.vpn_confinement = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.services.vpnConfinement = {
 enable = lib.mkEnableOption "VPN Confinement for services";

 namespaces = lib.mkOption {
 type = lib.types.attrsOf (lib.types.submodule {
 options = {
 wgConf = lib.mkOption { 
 type = lib.types.path; 
 description = "Path to WireGuard config (via Sops, absolute path)";
 };
 killSwitch = lib.mkOption { 
 type = lib.types.bool; 
 default = true; 
 description = "Strictly block non-VPN traffic in this namespace";
 };
 };
 });
 default = {};
 description = "Definitions of isolated VPN namespaces";
 };
 };

 config = lib.mkIf cfg.enable {

 systemd.services = lib.mapAttrs' (name: nsCfg: (
 let nsName = name; in
 lib.nameValuePair "netns-${nsName}" {
 description = "Network Namespace ${nsName}";
 before = [ "network.target" ];
 wantedBy = [ "multi-user.target" ];

 path = with pkgs; [ iproute2 wireguard-tools nftables ];

 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 ExecStart = pkgs.writeShellScript "netns-${nsName}-up" ''

 ip netns add ${nsName} || true
 ip netns exec ${nsName} ip link set lo up

 ip link add wg0 type wireguard
 ip link set wg0 netns ${nsName}
 ip netns exec ${nsName} wg setconf wg0 ${nsCfg.wgConf}
 ip netns exec ${nsName} ip link set wg0 up

 ip netns exec ${nsName} ip route add default dev wg0

 ${lib.optionalString nsCfg.killSwitch ''
 ip netns exec ${nsName} nft -f ${pkgs.writeText "killswitch-${nsName}.nft" ''
 table inet filter {
 chain output {
 type filter hook output priority 0; policy drop;
 oifname "lo" accept
 oifname "wg0" accept
 }
 chain input {
 type filter hook input priority 0; policy drop;
 iifname "lo" accept
 iifname "wg0" accept
 ct state established,related accept
 }
 }
 ''}
 ''}
 '';
 ExecStop = pkgs.writeShellScript "netns-${nsName}-down" ''
 ip netns del ${nsName} || true
 '';
 };
 }
 )) cfg.namespaces;

 };
}

``n---

* Pfad: modules\services\vpn-live-config.nix | Format: .nix | Größe: 885 B
``nix
{ lib, ... }:
let

 nms = {
 id = "NIXH-20-INF-008";
 title = "Vpn Live Config";
 description = "Dynamic runtime configuration for VPN credentials and endpoints.";
 layer = 10;
 nixpkgs.category = "data/networking";
 capabilities = [ "network/vpn-config" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.vpn_live_config = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for vpn-live-config module";
 };

 config = {
 my.configs.vpn.privado = {
 publicKey = lib.mkForce "KgTUh3KLijVluDvNpzDCJJfrJ7EyLzYLmdHCksG4sRg=";
 endpoint = lib.mkForce "91.148.237.38:51820";
 address = lib.mkForce "100.64.3.155/32";
 dns = lib.mkForce ["198.18.0.1" "198.18.0.2"];
 };
 };
}

``n---

* Pfad: modules\storage\storage-mover.nix | Format: .nix | Größe: 2,99 KB
``nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;

 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail

 SOURCE="${cfg.ssdDir}"
 TARGET="${cfg.hddDir}"
 DRY_RUN=${if cfg.dryRun then "1" else "0"}
 AGE_DAYS=${toString cfg.minAgeDays}
 THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}

 echo "--- Starting Smart Mover [DryRun: $DRY_RUN, Age: $AGE_DAYS, Threshold: $THRESHOLD_GB GB] ---"

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))

 FORCE_MOVE=0
 if [ "$FREE_GB" -lt "$THRESHOLD_GB" ]; then
 echo " Low space detected ($FREE_GB GB < $THRESHOLD_GB GB). Forcing move of older files."
 FORCE_MOVE=1
 fi

 FIND_AGE=$AGE_DAYS
 [ "$FORCE_MOVE" -eq 1 ] && FIND_AGE=7

 echo " Scanning for files older than $FIND_AGE days..."

 find "$SOURCE" -type f -mtime +"$FIND_AGE" | while read -r file; do
 if ${pkgs.lsof}/bin/lsof "$file" > /dev/null 2>&1; then
 echo " Skipping active file: $file"
 continue
 fi

 REL_PATH=''${file#"$SOURCE/"}
 DEST_DIR=$(dirname "$TARGET/$REL_PATH")

 if [ "$DRY_RUN" -eq 1 ]; then
 echo "[DRY-RUN] Would move: $REL_PATH"
 else
 echo " Moving: $REL_PATH"
 mkdir -p "$DEST_DIR"
 ${pkgs.rsync}/bin/rsync -a --remove-source-files "$file" "$TARGET/$REL_PATH"
 fi
 done

 if [ "$DRY_RUN" -eq 0 ]; then
 find "$SOURCE" -type d -empty -delete
 echo " Cleaned up empty directories."
 if systemctl is-active --quiet update-metadata-db.service; then
 systemctl start update-metadata-db.service
 echo " Metadata DB update triggered."
 fi
 fi

 echo "--- Mover finished ---"
 '';

in
{
 options.my.storage.mover = {
 enable = lib.mkEnableOption "Smart Storage Tiering Mover";
 ssdDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/media"; };
 hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/media"; };
 minAgeDays = lib.mkOption { type = lib.types.int; default = 30; };
 lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 100; };
 dryRun = lib.mkOption { type = lib.types.bool; default = false; };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.storage-mover = {
 description = "hardened Smart Mover (SSD -> HDD)";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = moverScript;
 Nice = 19;
 IOSchedulingClass = "idle";
 CPUSchedulingPolicy = "idle";
 };
 };

 systemd.timers.storage-mover = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "*-*-* 04:00:00";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };
 };
}

``n---

* Pfad: profiles\automation-apps.nix | Format: .nix | Größe: 633 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-app-n8n.nix
 ../modules/apps/service-app-home-assistant.nix
 ../modules/apps/service-app-olivetin.nix
 ../modules/apps/service-app-semaphore.nix
 ../modules/services/service-app-zigbee-stack.nix
 ];

 my.meta.profile_automation = {
 id = "NIXH-PROF-AUTO-001";
 title = "Automation Apps Profile";
 layer = 30;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---

* Pfad: profiles\base-server.nix | Format: .nix | Größe: 1,01 KB
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/core/system.nix
 ../modules/core/impermanence.nix
 ../modules/core/nix-tuning.nix
 ../modules/core/network.nix
 ../modules/core/ssh.nix
 ../modules/core/firewall.nix
 ../modules/core/fail2ban.nix
 ../modules/core/zram-swap.nix
 ../modules/logging/vector-tier-b.nix
 ../modules/core/shell-premium.nix
 ../modules/core/system-stability.nix
 ../modules/core/principles.nix

 ../modules/services/caddy.nix
 ../modules/services/postgresql.nix
 ../modules/services/tailscale.nix
 ];

 my.logging.vector.enable = true;

 my.meta.profile_base_server = {
 id = "NIXH-PROF-BASE-001";
 title = "Base Server Profile";
 layer = 0; # Core-Mission
 audit.last_reviewed = "2026-04-27";
 };
}

``n---

* Pfad: profiles\extra-apps.nix | Format: .nix | Größe: 675 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-app-vaultwarden.nix
 ../modules/apps/service-app-matrix-conduit.nix
 ../modules/apps/service-app-monica.nix
 ../modules/apps/service-app-karakeep.nix
 ../modules/apps/service-app-filebrowser.nix
 ../modules/apps/service-app-couchdb.nix
 ];

 my.meta.profile_extra = {
 id = "NIXH-PROF-EXTR-001";
 title = "Extra Apps Profile";
 layer = 60;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---

* Pfad: profiles\knowledge-apps.nix | Format: .nix | Größe: 622 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-app-paperless.nix
 ../modules/apps/service-app-linkwarden.nix
 ../modules/apps/service-app-miniflux.nix
 ../modules/apps/service-app-readeck.nix
 ../modules/apps/service-app-linkding.nix
 ];

 my.meta.profile_knowledge = {
 id = "NIXH-PROF-KNOW-001";
 title = "Knowledge Apps Profile";
 layer = 50;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---

* Pfad: profiles\media-beast.nix | Format: .nix | Größe: 1,23 KB
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-media-jellyfin.nix
 ../modules/apps/service-media-jellyseerr.nix
 ../modules/apps/service-media-sonarr.nix
 ../modules/apps/service-media-sonarr-setup.nix # API-Setup PoC
 ../modules/apps/service-media-radarr.nix
 ../modules/apps/service-media-radarr-setup.nix # API-Setup PoC
 ../modules/apps/service-media-prowlarr.nix
 ../modules/apps/service-media-prowlarr-setup.nix # Indexer-Sync
 ../modules/apps/service-media-readarr.nix
 ../modules/apps/service-media-lidarr.nix
 ../modules/apps/service-media-sabnzbd.nix
 ../modules/apps/service-media-recyclarr.nix
 ../modules/apps/service-app-audiobookshelf.nix
 ../modules/apps/service-app-navidrome.nix
 ../modules/apps/media-stack.nix
 ../modules/core/storage.nix
 ];

 my.meta.profile_media_beast = {
 id = "NIXH-PROF-MED-001";
 title = "Media Beast Profile";
 layer = 30;
 audit.last_reviewed = "2026-04-27";
 };

 my.apps.navidrome.enable = true;
}

``n---

* Pfad: profiles\security-hardened.nix | Format: .nix | Größe: 563 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/security/security-assertions.nix
 ../modules/security/binary-only.nix
 ../modules/security/no-legacy.nix
 ../modules/security/flat-layout.nix
 ];

 my.meta.profile_security = {
 id = "NIXH-PROF-SEC-001";
 title = "Security Hardened Profile";
 layer = 90;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---

* Pfad: secrets\secrets.yaml | Format: .yaml | Größe: 5,69 KB
``yaml
github_token: ENC[AES256_GCM,data:lkDIr9UNvJXqLymNgmhfmtWkpD0v5uUhkuOx+0+QuMLblBvWWJuFGA==,iv:X4eabYYa3QzaP8MHtxUZ9TQxPjPFW6XVC+0rSOsuoOk=,tag:ndV1J5q2k1ktA9oAPTWYjg==,type:str]
cloudflare_token: ENC[AES256_GCM,data:mGGSfei1XleTNHfHhMe1HLUkjxFJAzzMIH8sjugoSxvwBP68TeR3Zg==,iv:t/IWbq9G2RXxm3nYt3tMTW3j91MeF+txg/seRUHDN90=,tag:gSkgacPXGHiCdOvIWoAacA==,type:str]
tailscale_token: ENC[AES256_GCM,data:G4y7ht13fmbGCggGYRzn9vLloOl1l09lNcO4wBEFHA==,iv:71rjwB80I1JhQ/dqiUc0f8Go4Cyq6RWEgbl6tmq9Qco=,tag:UWNdWlAyhdXIeGOglLo7SQ==,type:str]
wg_privado_private_key: ENC[AES256_GCM,data:sR7g47+rkYzEeIUwaCvX6BTdaZRVRo8+0/CbplyHNfA4BiYdtyWETrMncLQ=,iv:ti9AFj0/53DLfmCcE9rHYEHCTyLF/XK2iafGdFsEnaQ=,tag:fGy+/wx8Jmr49OYXw99AIA==,type:str]
sonarr_api_key: ENC[AES256_GCM,data:RPHxzFD7Ni/dsbgZU0eKAyzzR3r/Mirh4moP4jnhIjw=,iv:nFr+OOvcdU5J6DUVAou8P7k9+YQKg6cHYJhh07c2wh4=,tag:1oFfr2Zw3v3vI+9RntUBlA==,type:str]
radarr_api_key: ENC[AES256_GCM,data:3T17QEV48CNT7yGA+6997RCSIsIfDYsIw+cqwPoDoQs=,iv:IPxwfId2fKBKq3DmupESTAo/4GrEZiq+4jF60ploAfE=,tag:Q/fa5vTxFuVfNwZxmuwRrQ==,type:str]
readarr_api_key: ENC[AES256_GCM,data:mtBexyPGZ+eBRNQR2OiNbyOhyL2UPeieWHHL4VKAPdg=,iv:M61bzbST2yVmSzb6U68No2dl3SHLgoumUJ8p8yZq3y4=,tag:hK9mZ6lH2FX1hUakETq1mA==,type:str]
homepage_sonarr_key: ENC[AES256_GCM,data:QsdCRmYlVJsPxQxLecLDiZEM7OJBpM6eLiPG7wOi034=,iv:bM17p7FHnn8JjPXGuy2iGz4IXQccvJdo1AxaG9DeRFI=,tag:bgMUXPVlFAf7efHuCLRc9A==,type:str]
homepage_radarr_key: ENC[AES256_GCM,data:St9OtttpP+wANDjkuFLjrPjfSeRiTe1eDOLOOiKyHTI=,iv:WzvElCGnVf16juOX+kCWAFDh4R/9sY2yNny2Xs1wQqU=,tag:kYZMrZIuXPChHeX9cPhN4Q==,type:str]
google_ai_key: ENC[AES256_GCM,data:95TUz0teNy6AznuOQXXhFUPEf3yeSPIuojjTXkm2w+XCTU102eCo,iv:E8WgpLBm0Ykv6pya/j5oH6SwUjxQ1bWu2Mngr8/eB34=,tag:HFYEkKrNdlMQSpbkDVw/gg==,type:str]
groq_key: ENC[AES256_GCM,data:16ATKKKYe2cGfcoTL7QJ8ITzknu6Ve6TN8nABxoKnZenGU/c+36bUP7stsGU+5cITqbP83BZEdw=,iv:RRhX0ymfj+6f/WOf5WdFHyIIntOm8RfGMI2U3zOBNKk=,tag:drlRqVoItQnchl3QgPMLEA==,type:str]
xai_key: ENC[AES256_GCM,data:4u3rGzMYI0zNnfhKUuIVOTw3pCEwlnXgxIkEK1t+HHLQjCG6hxRQ7NI9TBBCkThVbG+3JjhpukwqeXtt3kW+P8qa5kzwhK+q5W2E5HgdVWIYz5na,iv:H9RMMwxJ+ZnwGUauWblgbe3Nhf3941mNt+JOGRxB/5M=,tag:BrsnYjWo+5v4nec4r4xFFA==,type:str]
unraid_root_password: ENC[AES256_GCM,data:DHc2/dfbKNsk3LbTCe1K2nhCRQ8nVDp+1GLmh9OtkOE=,iv:sSVIpUV1JWr8x9OWi4IRJ+rxbEd2Z1tOC5My9Y+nnSs=,tag:HbwcqFADJXYO9SqAFtPsAQ==,type:str]
ssh_github_key: ENC[AES256_GCM,data:WoXswIkKQW1eS6zQfsXZbxkdwnR8Zk0jgVBFQRt2vJ4197rkl3E5KGrK+2hFZ/yI4GvLIW2ifiBEAWpLRL4wBLxelM2nMky7j/R6ruMxlkDuFXFFXTLr3OPBPLHuDgxWfP6ewIXZEJAHS2oekPTvzXghIttle6JCx6QWKMBDKNmMo21zD7q9mQywqwDHx6280limQvxLllXMURtXg4cczD/suf1gERx99HfMWzzfimIfmaXXl9aUtB6f49h34X8IuRIEsByDT+EftlZLyjC/SLNFa1/7yPdkJlx1iPQA9YzyyQj43JBU/8p7d+U0UZX+3QFp+I9LZsbMSuqJQcB04RD+ptj1RbHEGBfr6f67Pi/I4Fi4jC4Ak3TL351AyzB3uj1X+or89XzUe0pzhGHwmmspP7en/nl1+asiji9p1NYG1R5CFvIzhcn5ga3Pv9SHbI/GVNlXar4KM0hR+Rc1HfBJl8F2rhZhNq/hdeq9l+LXSYHI26Lxcr4V/5bizPj8ZOmL6zUBLLJnA2xgDYexN4uJAhRlcmb8S/zo,iv:tKF+yXqJnteSsHltrFUCbvKGbFhj83j6zq/g6ChEqP4=,tag:5g1RuHvbLSCEDcRticx1Kg==,type:str]
ssh_unraid_key: ENC[AES256_GCM,data:CzEbH4HoAic0q1kqmO4dbXZu30JayAZUifRmaCUxmdwTZLGgLSELTh9zahdScs+qIDz1CKi9Rx6AHjJpjj+CY/jaHioB4d+uF0aC5FUAdY+CckIq40JynfkWKXBHFO4DQ0odePmliWLu/uhrN1Fthe0NsiUnFrIhFHAFqYoZZkEoQil+0N1mSKA/NYVvYXbt1DJNxLOBqXah3Nq1iBF3Oy0LeBSbNtCa5UTwJlQoimlHVA5dAlzwBKLizmsKhVqMiMLnTjrHL0zEmpTtJnJRXQf9NeN+VxPlv10kHrvU8H0G7Nr6nGupLbiPPOR/ThITkFU70Li0GehtmRSbgQQypm1TpvKityHHZ4P2pRYSquJCXHCMsjDFo+nci2or/gyHZSqaOp+GdpAuS3v4kFLNaHcrR6qO13AlR8V2c+fyZETlK8zbujXtiUOm0hZoqgPGIYharFCkagpvvCXOro6vUMT3put+r0I7xL5dPmfUfMSYCvksgHkTTL5JS+ySOjQ0t2aIaCyi2SY74Mv2w2Ak,iv:jkffOwDoYucqgWH2HZAA7ITMKarpnSMjLCqmvYEwL9Q=,tag:2xnWX1dql6k7MglfjpNqQA==,type:str]
n8n_enc_key: ENC[AES256_GCM,data:MYeBc7h1xoM=,iv:wFiJH4C4/GS5tp2ummHTW3s/nFpGcsJZ0NVr12GxMZc=,tag:bmmQZVG3Wn4WEqYi3VVrCQ==,type:str]
vaultwarden_env: ENC[AES256_GCM,data:vGPAN8qlNbVBb7KbUyzIfKRBIyc=,iv:JbP+YnsnxIgqD+l/2jdRexnvyJjKVq7vGOoCLTfCRe0=,tag:EtQBggs5wu1MY016zVTBpQ==,type:str]
miniflux_admin_password: ENC[AES256_GCM,data:Vd1EBpa+Ff8=,iv:jGRJsuelDyt2Zno00W5Z9oP4Jd+4R9LQTb4sZ94YnGM=,tag:nlWXXOKitQiTP7VgV+Mhew==,type:str]
paperless_secret_key: ENC[AES256_GCM,data:J7uOF7HB0+M=,iv:3FMF+heOJ6z4pb/pdesenStQyEyb3Vfu/D96H9VmV1M=,tag:XZcSyxFCq7IYT14JiBw7TQ==,type:str]
sops:
 age:
 - recipient: age1pjl6xt8zu80p4dpp6yqnk5u53ratgc58sdtnf7c2krlxyt8msgvs9s763s
 enc: |

 YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBjRWJJcTVsNEFPYkgvN1hV
 N1hXWnY2ODRTV0VPNkprTGZRZjVsSTI1Z1RJClVSd3hFWkFhcEdVQnByTTJLVnU4
 RWtJVWpBaDF2OC9ZZFRQWEcrRU1Lb0UKLS0tIEF1NzRjUUwzbjExNDYxZ3lQN3d6
 SUZ1K2NlZFRJdytQMkhxb3NHTWRxR1UKThaRnqw7tIo6fpasOWpMk9+Qhpr2PJc5
 PAxKrOQfvQMQEdGDQmiSNOcrGkJepWTRQpWO76TbeaR4z59RQ76Lrg==

 - recipient: age1t2uu2un4trvvyhg7ryp8h8tqjxl5vnd0qd48dq4s8yvhc6jwtd4smyet95
 enc: |

 YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSA4YlFVeHE0SDU4WWNCMEM2
 Q2FjZVM5alNOM051cnRQbmUrZng2UVpjVWtFCm9vRnNwNUNFM3JQRkxITC9MeTdG
 VEpFem5aSWl3UUo4MGdQMzQxUnozWGsKLS0tIDZFSXFPSVdUVVg1YW9yOHBVTDRw
 UnZrQmM2dmZ3ZDdMR0djNGR5VTJ1SkkKYxU9VaodMBUdVobnWFvWvj7EQWqcyuIA
 0qn5K8B4hUYcfw24v/VNZ8SE8FIjsJhYrErt7pmoovCh8k6pnp2kVA==

 lastmodified: "2026-03-01T18:51:55Z"
 mac: ENC[AES256_GCM,data:B0u9kA6/NjTgfQSgs4V/6S5QLSWmCcyeBcbwgnDPK9bGY/RGs1jcdL4gCPFWMy7CB3txOJycWtP0fBYEZc9g0Z++zvJN0phMwrTiqJA88TRRruG01aRu6Jqn3CHKDYdy+W6E7iyLDW3gqYWMGwztmPFBcaEfcNzF8I4mFUFfahk=,iv:KbBkG1HHUG/+NYZQ3zLkG2ST3KDpixAV6d+sDQJICKU=,tag:ghkrOVyykbz+6b91Y6ZbhA==,type:str]
 unencrypted_suffix: _unencrypted
 version: 3.11.0

``n---

* Pfad: users\freund\default.nix | Format: .nix | Größe: 923 B
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-USR-FREUND-001";
 title = "User (Freund)";
 description = "Isolated user profile for collaboration. Demonstration of horizontal decoupling.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
in {
 config = {
 users.users.freund = {
 isNormalUser = true;
 description = "Collaborator (Freund)";
 extraGroups = ["video" "render" "media"]; # Kein 'wheel' für den Freund

 hashedPasswordFile = config.sops.secrets.freund_password.path;

 openssh.authorizedKeys.keys = [
 "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...PLACEHOLDER..." 
 ];

 shell = pkgs.bashInteractive;
 };

 sops.secrets.freund_password.neededForUsers = true;
 };
}

``n---

* Pfad: users\freund\home.nix | Format: .nix | Größe: 319 B
``nix
{ config, lib, pkgs, ... }: {

 home.stateVersion = "25.11";

 programs.git = {
 enable = true;
 userName = "Freund";
 userEmail = "freund@${config.my.configs.identity.domain}";
 };

 programs.bash.enable = true;
}

``n---

* Pfad: users\moritz\default.nix | Format: .nix | Größe: 1,65 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-039";
 title = "Users (Declarative & Hardened)";
 description = "Strictly immutable user management. Passwords managed via Sops-Nix. Unified media group.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["system/users" "security/no-mutable-users" "security/sops-integration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.users = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [ ./locale.nix ];

 config = {

 users.mutableUsers = false;

 users.users.${user} = {
 isNormalUser = true;
 description = "Primary Admin (${user})";
 extraGroups = ["wheel" "video" "render" "media" "networkmanager"];

 hashedPasswordFile = config.sops.secrets.user_password.path;

 openssh.authorizedKeys.keys = [
 "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJRDbyFjT4SEL8yxNwZuEBPORD82qlJJhdr2r4qz1vCX" # Main Key
 ];

 shell = pkgs.bashInteractive;
 };

 users.groups.media = {
 gid = 169;
 };

 sops.secrets.user_password.neededForUsers = true;
 };
}

``n---

* Pfad: users\moritz\home-manager-config.nix | Format: .nix | Größe: 1,25 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-037";
 title = "User Moritz Home";
 description = "Personalized user environment configuration via Home-Manager for user 'moritz'.";
 layer = 0;
 nixpkgs.category = "tools/admin";
 capabilities = ["user/dotfiles" "home-manager/config"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };
in {
 options.my.meta.user_moritz_home = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for user-moritz-home module";
 };

 config = {
 home.stateVersion = "24.11";
 home.packages = with pkgs; [ micro neofetch htop ncdu btop dust ];
 programs.bash = { enable = true; historySize = 50000; historyFileSize = 100000; historyControl = [ "ignoredups" "ignorespace" ]; };
 programs.htop = { enable = true; settings = { color_scheme = 0; delay = 15; highlight_base_name = 1; highlight_megabytes = 1; highlight_threads = 1; show_program_path = 0; }; };
 programs.micro = { enable = true; settings = { colorscheme = "simple"; tabsize = 2; mouse = true; }; };
 programs.bat = { enable = true; config = { theme = "base16"; italic-text = "always"; }; };
 };
}

``n---

* Pfad: users\moritz\home.nix | Format: .nix | Größe: 1,98 KB
``nix
{
 config,
 lib,
 pkgs,
 inputs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-013";
 title = "Home Manager (User Cockpit)";
 description = "Hardened user environment. Git SSoT and Shell-Secret integration.";
 layer = 00;
 nixpkgs.category = "tools/admin";
 capabilities = ["user/environment" "shell/hardening" "git/configuration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.home_manager = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [ inputs.home-manager.nixosModules.home-manager ];

 config = {
 home-manager = {
 useGlobalPkgs = true;
 useUserPackages = true;
 backupFileExtension = "hm-backup";

 users.${user} = { pkgs, ... }: {
 home.stateVersion = "24.05"; # Stable anchor

 imports = [ ./home-manager-config.nix ./preferences.nix ];

 programs.git = {
 enable = true;
 userName = "Moritz";
 userEmail = "git@${config.my.configs.identity.domain}";
 extraConfig = {
 init.defaultBranch = "main";
 pull.rebase = true;
 core.editor = "micro";
 };
 aliases = {
 st = "status";
 co = "checkout";
 br = "branch";
 up = "pull --rebase";
 };
 };

 programs.bash = {
 enable = true;
 shellAliases = {

 godmode = "gemini --yolo --include-directories /etc/nixos,$(pwd)";
 };
 };
 };
 };
 };
}

``n---

* Pfad: users\moritz\locale.nix | Format: .nix | Größe: 1,15 KB
``nix
{ config, lib, myLib, ... }: {

 i18n.defaultLocale = myLib.mkTracedOption "SRC-CHAT-LOCALE-001" (lib.mkOption {
 type = lib.types.str;
 default = "de_DE.UTF-8";
 description = "System default locale [Source: Fragment 002]";
 }).default;

 time.timeZone = myLib.mkTracedOption "SRC-CHAT-LOCALE-002" (lib.mkOption {
 type = lib.types.str;
 default = "Europe/Berlin";
 description = "System timezone [Source: Fragment 002]";
 }).default;

 console.keyMap = myLib.mkTracedOption "SRC-CHAT-LOCALE-003" (lib.mkOption {
 type = lib.types.str;
 default = "de-latin1";
 description = "Console keymap [Source: Fragment 002]";
 }).default;

 i18n.extraLocaleSettings = {
 LC_ADDRESS = "de_DE.UTF-8";
 LC_IDENTIFICATION = "de_DE.UTF-8";
 LC_MEASUREMENT = "de_DE.UTF-8";
 LC_MONETARY = "de_DE.UTF-8";
 LC_NAME = "de_DE.UTF-8";
 LC_NUMERIC = "de_DE.UTF-8";
 LC_PAPER = "de_DE.UTF-8";
 LC_TELEPHONE = "de_DE.UTF-8";
 LC_TIME = "de_DE.UTF-8";
 };
}

``n---

* Pfad: users\moritz\preferences.nix | Format: .nix | Größe: 674 B
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-038";
 title = "User Preferences";
 description = "Customized user preferences and personal system adjustments.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["user/preferences"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.user_preferences = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for user-preferences module";
 };

 config = {

 };
}

``n---

[F-001]
[F-002]
[F-003]
[F-004]
[F-005]
[F-006]
[F-007]
[F-008]
[F-009]
[F-010]
[F-011]
[F-012]
[F-013]
[F-014]
[F-015]
[F-016]
[F-017]
[F-018]
[F-019]
[F-020]
[F-021]
[F-022]
[F-023]
[F-024]
[F-025]
[F-026]
[F-027]
[F-028]
[F-029]
[F-030]
[F-031]
[F-032]
[F-033]
[F-034]
[F-035]
[F-036]
[F-037]
[F-038]
[F-039]
[F-040]
[F-041]
[F-042]
[F-043]
[F-044]
[F-045]
[F-046]
[F-047]
[F-048]
[F-049]
[F-050]
[F-051]
[F-052]
[F-053]
[F-054]
[F-055]
[F-056]
[F-057]
[F-058]
[F-059]
[F-060]
[F-061]
[F-062]
[F-063]
[F-064]
[F-065]
[F-066]
[F-067]
[F-068]
[F-069]
[F-070]
[F-071]
[F-072]
[F-073]
[F-074]
[F-075]
[F-076]
[F-077]
[F-078]
[F-079]
[F-080]
[F-081]
[F-082]
[F-083]
[F-084]
[F-085]
[F-086]
[F-087]
[F-088]
[F-089]
[F-090]
[F-091]
[F-092]
[F-093]
[F-094]
[F-095]
[F-096]
[F-097]
[F-098]
[F-099]
[F-100]
[F-101]
[F-102]
[F-103]
[F-104]
[F-105]
[F-106]
[F-107]
[F-108]
[F-109]
[F-110]
[F-111]
[F-112]
[F-113]
[F-114]
[F-115]
[F-116]
[F-117]
[F-118]
[F-119]
[F-120]
[F-121]
[F-122]
[F-123]
[F-124]
[F-125]
[F-126]
[F-127]
[F-128]
[F-129]
[F-130]
[F-131]
[F-132]
[F-133]
[F-134]
[F-135]
[F-136]
[F-137]
[F-138]
[F-139]
[F-140]
[F-141]

``n---
### [F-009] .legacy_folders\10-infrastructure\tailscale-policy.current.hujson
* Pfad: .legacy_folders\10-infrastructure\tailscale-policy.current.hujson | Format: .hujson | Größe: 2,55 KB
``hujson
{

	"grants": [

		{
			"src": ["*"],
			"dst": ["*"],
			"ip": ["*"],
		},

	],

	"ssh": [

		{
			"action": "check",
			"src": ["autogroup:member"],
			"dst": ["autogroup:self"],
			"users": ["autogroup:nonroot", "root"],
		},
	],
	"nodeAttrs": [
		{

			"target": ["autogroup:member"],
			"attr": ["funnel"],
		},
	],

}

``n---
### [F-010] .legacy_folders\10-infrastructure\tailscale-policy.target.hujson
* Pfad: .legacy_folders\10-infrastructure\tailscale-policy.target.hujson | Format: .hujson | Größe: 1,05 KB
``hujson
{
 "tagOwners": {
 "tag:infra": ["autogroup:admin"],
 "tag:media": ["autogroup:admin"],
 "tag:admin": ["autogroup:admin"]
 },

 "grants": [
 {
 "src": ["autogroup:member"],
 "dst": ["autogroup:self"],
 "ip": ["*"]
 },
 {
 "src": ["moritz.baumeister@gmail.com"],
 "dst": ["tag:infra"],
 "ip": ["*"]
 },
 {
 "src": ["autogroup:admin"],
 "dst": ["tag:admin"],
 "ip": ["*"]
 }
 ],

 "ssh": [
 {
 "action": "check",
 "src": ["autogroup:member"],
 "dst": ["autogroup:self"],
 "users": ["autogroup:nonroot", "root"]
 }
 ],

 "tests": [
 {
 "src": "moritz.baumeister@gmail.com",
 "accept": ["tag:infra:22", "tag:infra:443"]
 },
 {
 "src": "not-allowed@example.com",
 "deny": ["tag:infra:22"]
 }
 ]
}

``n---
### [F-011] .legacy_folders\10-infrastructure\_imports.nix
* Pfad: .legacy_folders\10-infrastructure\_imports.nix | Format: .nix | Größe: 440 B
``nix
{ ... }:
{
 imports = [
 ./adguardhome.nix
 ./caddy.nix
 ./clamav.nix
 ./cloudflared-tunnel.nix
 ./cockpit.nix
 ./ddns-updater.nix
 ./dns-automation.nix
 ./homepage.nix
 ./landing-zone-ui.nix
 ./pocket-id.nix
 ./postgresql.nix
 ./secret-ingest.nix
 ./sso.nix
 ./tailscale.nix
 ./uptime-kuma.nix
 ./valkey.nix
 ./vpn-confinement.nix
 ./vpn-live-config.nix
 ];
}

``n---
### [F-012] .legacy_folders\20-automation\service-app-open-webui.nix
* Pfad: .legacy_folders\20-automation\service-app-open-webui.nix | Format: .nix | Größe: 1,43 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-20-SRV-011";
 title = "Open WebUI (SRE Hardened)";
 description = "User-friendly WebUI for LLMs, tightly sandboxed with DynamicUser.";
 layer = 20;
 nixpkgs.category = "services/misc";
 capabilities = [ "ai/ui" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.openWebui;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.open_webui = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for open-webui module";
 };

 config = lib.mkIf config.my.services.openWebui.enable {
 services.open-webui = {
 enable = true; host = "127.0.0.1"; port = port;
 environment = { OLLAMA_API_BASE_URL = "http://127.0.0.1:${toString config.my.ports.ollama}"; SCARF_NO_ANALYTICS = "True"; DO_NOT_TRACK = "True"; ANONYMIZED_TELEMETRY = "False"; };
 };
 services.caddy.virtualHosts."ai.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.open-webui.serviceConfig = { DynamicUser = true; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; SupplementaryGroups = [ "render" "video" ]; SystemCallFilter = [ "@system-service" "~@privileged" ]; OOMScoreAdjust = 200; };
 };
}

``n---
### [F-013] .legacy_folders\20-automation\_imports.nix
* Pfad: .legacy_folders\20-automation\_imports.nix | Format: .nix | Größe: 324 B
``nix
{ ... }:
{
 imports = [
 ./automation.nix
 ./service-app-ai-agents.nix
 ./service-app-home-assistant.nix
 ./service-app-karakeep.nix
 ./service-app-n8n.nix
 ./service-app-olivetin.nix
 ./service-app-open-webui.nix
 ./service-app-semaphore.nix
 ./service-app-zigbee-stack.nix
 ];
}

``n---
### [F-014] docs\MetaBibliothek
* Pfad: docs\MetaBibliothek | Format: .txt | Größe: 37 B
``txt
/home/moritz/documents/MetaBibliothek

``n---
### [F-015] docs\SPEC_REGISTRY.md
* Pfad: docs\SPEC_REGISTRY.md | Format: .md | Größe: 27,09 KB
``md
Dieses Dokument ist die zentrale Master-Source für Traceability und Inspirationen.

> [!warning] SRE Audit Befunde (Stand 2026-03-02)
> * **CRITICAL BUG:** `PrivateDevices = true` in `jellyfin.nix` bricht das Hardware-Transcoding. (BEHOBEN in v4.0)
> * **ARCHITECTURAL GAP:** Fehlendes `mkEnableOption` Pattern. (BEHOBEN in v4.0 via registry.nix)
> * **DEPRECATION:** Deprecated Intel-Treiber entfernt. (BEHOBEN in v4.0)

| ID | Nix-Modul | Dokumentation (MetaBib) | Inspiration / Vorbild |
|---|---|---|---|
| NIXH-00-COR-001 | `00-core/.secrets-local.nix` | [.secrets-local.nix](../../home/moritz/documents/MetaBibliothek/00-core/.secrets-local.md) | [Link unten](#NIXH-00-COR-001) |
| NIXH-00-COR-002 | `00-core/ai-tools.nix` | [ai-tools.nix](../../home/moritz/documents/MetaBibliothek/00-core/ai-tools.md) | [Link unten](#NIXH-00-COR-002) |
| NIXH-00-COR-003 | `00-core/auto-locale.nix` | [auto-locale.nix](../../home/moritz/documents/MetaBibliothek/00-core/auto-locale.md) | [Link unten](#NIXH-00-COR-003) |
| NIXH-00-COR-004 | `00-core/backup.nix` | [backup.nix](../../home/moritz/documents/MetaBibliothek/00-core/backup.md) | [Link unten](#NIXH-00-COR-004) |
| NIXH-00-COR-005 | `00-core/boot-safeguard.nix` | [boot-safeguard.nix](../../home/moritz/documents/MetaBibliothek/00-core/boot-safeguard.md) | [Link unten](#NIXH-00-COR-005) |
| NIXH-00-COR-006 | `00-core/central-configs-plan.nix` | [central-configs-plan.nix](../../home/moritz/documents/MetaBibliothek/00-core/central-configs-plan.md) | [Link unten](#NIXH-00-COR-006) |
| NIXH-00-COR-007 | `00-core/config-merger.nix` | [config-merger.nix](../../home/moritz/documents/MetaBibliothek/00-core/config-merger.md) | [Link unten](#NIXH-00-COR-007) |
| NIXH-00-COR-008 | `00-core/configs.nix` | [configs.nix](../../home/moritz/documents/MetaBibliothek/00-core/configs.md) | [Link unten](#NIXH-00-COR-008) |
| NIXH-00-COR-009 | `00-core/defaults.nix` | [defaults.nix](../../home/moritz/documents/MetaBibliothek/00-core/defaults.md) | [Link unten](#NIXH-00-COR-009) |
| NIXH-00-COR-010 | `00-core/fail2ban.nix` | [fail2ban.nix](../../home/moritz/documents/MetaBibliothek/00-core/fail2ban.md) | [Link unten](#NIXH-00-COR-010) |
| NIXH-00-COR-011 | `00-core/firewall.nix` | [firewall.nix](../../home/moritz/documents/MetaBibliothek/00-core/firewall.md) | [Link unten](#NIXH-00-COR-011) |
| NIXH-00-COR-012 | `00-core/hardware-configuration.nix` | [hardware-configuration.nix](../../home/moritz/documents/MetaBibliothek/00-core/hardware-configuration.md) | [Link unten](#NIXH-00-COR-012) |
| NIXH-00-COR-013 | `00-core/home-manager.nix` | [home-manager.nix](../../home/moritz/documents/MetaBibliothek/00-core/home-manager.md) | [Link unten](#NIXH-00-COR-013) |
| NIXH-00-COR-014 | `00-core/host-q958-hardware-configuration.nix` | [host-q958-hardware-configuration.nix](../../home/moritz/documents/MetaBibliothek/00-core/host-q958-hardware-configuration.md) | [Link unten](#NIXH-00-COR-014) |
| NIXH-00-COR-015 | `00-core/host-q958-hardware-profile.nix` | [host-q958-hardware-profile.nix](../../home/moritz/documents/MetaBibliothek/00-core/host-q958-hardware-profile.md) | [Link unten](#NIXH-00-COR-015) |
| NIXH-00-COR-016 | `00-core/host.nix` | [host.nix](../../home/moritz/documents/MetaBibliothek/00-core/host.md) | [Link unten](#NIXH-00-COR-016) |
| NIXH-00-COR-017 | `00-core/kernel-slim.nix` | [kernel-slim.nix](../../home/moritz/documents/MetaBibliothek/00-core/kernel-slim.md) | [Link unten](#NIXH-00-COR-017) |
| NIXH-00-COR-018 | `00-core/lib-helpers-meta.nix` | [lib-helpers-meta.nix](../../home/moritz/documents/MetaBibliothek/00-core/lib-helpers-meta.md) | [Link unten](#NIXH-00-COR-018) |
| NIXH-00-COR-019 | `00-core/lib-helpers.nix` | [lib-helpers.nix](../../home/moritz/documents/MetaBibliothek/00-core/lib-helpers.md) | [Link unten](#NIXH-00-COR-019) |
| NIXH-00-COR-020 | `00-core/locale.nix` | [locale.nix](../../home/moritz/documents/MetaBibliothek/00-core/locale.md) | [Link unten](#NIXH-00-COR-020) |
| NIXH-00-COR-021 | `00-core/logging.nix` | [logging.nix](../../home/moritz/documents/MetaBibliothek/00-core/logging.md) | [Link unten](#NIXH-00-COR-021) |
| NIXH-00-COR-022 | `00-core/motd.nix` | [motd.nix](../../home/moritz/documents/MetaBibliothek/00-core/motd.md) | [Link unten](#NIXH-00-COR-022) |
| NIXH-00-COR-023 | `00-core/network.nix` | [network.nix](../../home/moritz/documents/MetaBibliothek/00-core/network.md) | [Link unten](#NIXH-00-COR-023) |
| NIXH-00-COR-024 | `00-core/nix-tuning.nix` | [nix-tuning.nix](../../home/moritz/documents/MetaBibliothek/00-core/nix-tuning.md) | [Link unten](#NIXH-00-COR-024) |
| NIXH-00-COR-025 | `00-core/ports.nix` | [ports.nix](../../home/moritz/documents/MetaBibliothek/00-core/ports.md) | [Link unten](#NIXH-00-COR-025) |
| NIXH-00-COR-026 | `00-core/principles.nix` | [principles.nix](../../home/moritz/documents/MetaBibliothek/00-core/principles.md) | [Link unten](#NIXH-00-COR-026) |
| NIXH-00-COR-027 | `00-core/registry.nix` | [registry.nix](../../home/moritz/documents/MetaBibliothek/00-core/registry.md) | [Link unten](#NIXH-00-COR-027) |
| NIXH-00-COR-028 | `00-core/secrets.nix` | [secrets.nix](../../home/moritz/documents/MetaBibliothek/00-core/secrets.md) | [Link unten](#NIXH-00-COR-028) |
| NIXH-00-COR-029 | `00-core/shell-premium.nix` | [shell-premium.nix](../../home/moritz/documents/MetaBibliothek/00-core/shell-premium.md) | [Link unten](#NIXH-00-COR-029) |
| NIXH-00-COR-030 | `00-core/shell.nix` | [shell.nix](../../home/moritz/documents/MetaBibliothek/00-core/shell.md) | [Link unten](#NIXH-00-COR-030) |
| NIXH-00-COR-031 | `00-core/ssh-rescue.nix` | [ssh-rescue.nix](../../home/moritz/documents/MetaBibliothek/00-core/ssh-rescue.md) | [Link unten](#NIXH-00-COR-031) |
| NIXH-00-COR-032 | `00-core/ssh.nix` | [ssh.nix](../../home/moritz/documents/MetaBibliothek/00-core/ssh.md) | [Link unten](#NIXH-00-COR-032) |
| NIXH-00-COR-033 | `00-core/symbiosis.nix` | [symbiosis.nix](../../home/moritz/documents/MetaBibliothek/00-core/symbiosis.md) | [Link unten](#NIXH-00-COR-033) |
| NIXH-00-COR-034 | `00-core/system-stability.nix` | [system-stability.nix](../../home/moritz/documents/MetaBibliothek/00-core/system-stability.md) | [Link unten](#NIXH-00-COR-034) |
| NIXH-00-COR-035 | `00-core/system.nix` | [system.nix](../../home/moritz/documents/MetaBibliothek/00-core/system.md) | [Link unten](#NIXH-00-COR-035) |
| NIXH-00-COR-036 | `00-core/tty-info.nix` | [tty-info.nix](../../home/moritz/documents/MetaBibliothek/00-core/tty-info.md) | [Link unten](#NIXH-00-COR-036) |
| NIXH-00-COR-037 | `00-core/user-moritz-home.nix` | [user-moritz-home.nix](../../home/moritz/documents/MetaBibliothek/00-core/user-moritz-home.md) | [Link unten](#NIXH-00-COR-037) |
| NIXH-00-COR-038 | `00-core/user-preferences.nix` | [user-preferences.nix](../../home/moritz/documents/MetaBibliothek/00-core/user-preferences.md) | [Link unten](#NIXH-00-COR-038) |
| NIXH-00-COR-039 | `00-core/users.nix` | [users.nix](../../home/moritz/documents/MetaBibliothek/00-core/users.md) | [Link unten](#NIXH-00-COR-039) |
| NIXH-00-COR-040 | `00-core/zram-swap.nix` | [zram-swap.nix](../../home/moritz/documents/MetaBibliothek/00-core/zram-swap.md) | [Link unten](#NIXH-00-COR-040) |
| NIXH-10-GTW-001 | `10-gateway/adguardhome.nix` | [adguardhome.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/adguardhome.md) | [Link unten](#NIXH-10-GTW-001) |
| NIXH-10-GTW-002 | `10-gateway/caddy.nix` | [caddy.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/caddy.md) | [Link unten](#NIXH-10-GTW-002) |
| NIXH-10-GTW-003 | `10-gateway/cloudflared-tunnel.nix` | [cloudflared-tunnel.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/cloudflared-tunnel.md) | [Link unten](#NIXH-10-GTW-003) |
| NIXH-10-GTW-004 | `10-gateway/ddns-updater.nix` | [ddns-updater.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/ddns-updater.md) | [Link unten](#NIXH-10-GTW-004) |
| NIXH-10-GTW-005 | `10-gateway/dns-automation.nix` | [dns-automation.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/dns-automation.md) | [Link unten](#NIXH-10-GTW-005) |
| NIXH-10-GTW-006 | `10-gateway/dns-map.nix` | [dns-map.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/dns-map.md) | [Link unten](#NIXH-10-GTW-006) |
| NIXH-10-GTW-007 | `10-gateway/homepage.nix` | [homepage.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/homepage.md) | [Link unten](#NIXH-10-GTW-007) |
| NIXH-10-GTW-008 | `10-gateway/landing-zone-ui.nix` | [landing-zone-ui.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/landing-zone-ui.md) | [Link unten](#NIXH-10-GTW-008) |
| NIXH-10-GTW-009 | `10-gateway/pocket-id.nix` | [pocket-id.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/pocket-id.md) | [Link unten](#NIXH-10-GTW-009) |
| NIXH-10-GTW-010 | `10-gateway/sso.nix` | [sso.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/sso.md) | [Link unten](#NIXH-10-GTW-010) |
| NIXH-10-GTW-011 | `10-gateway/tailscale.nix` | [tailscale.nix](../../home/moritz/documents/MetaBibliothek/10-gateway/tailscale.md) | [Link unten](#NIXH-10-GTW-011) |
| NIXH-20-INF-001 | `20-infrastructure/clamav.nix` | [clamav.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/clamav.md) | [Link unten](#NIXH-20-INF-001) |
| NIXH-20-INF-002 | `20-infrastructure/postgresql.nix` | [postgresql.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/postgresql.md) | [Link unten](#NIXH-20-INF-002) |
| NIXH-20-INF-003 | `20-infrastructure/secret-ingest.nix` | [secret-ingest.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/secret-ingest.md) | [Link unten](#NIXH-20-INF-003) |
| NIXH-20-INF-004 | `20-infrastructure/service-app-zigbee-stack.nix` | [service-app-zigbee-stack.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/service-app-zigbee-stack.md) | [Link unten](#NIXH-20-INF-004) |
| NIXH-20-INF-005 | `20-infrastructure/storage.nix` | [storage.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/storage.md) | [Link unten](#NIXH-20-INF-005) |
| NIXH-20-INF-006 | `20-infrastructure/valkey.nix` | [valkey.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/valkey.md) | [Link unten](#NIXH-20-INF-006) |
| NIXH-20-INF-007 | `20-infrastructure/vpn-confinement.nix` | [vpn-confinement.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/vpn-confinement.md) | [Link unten](#NIXH-20-INF-007) |
| NIXH-20-INF-008 | `20-infrastructure/vpn-live-config.nix` | [vpn-live-config.nix](../../home/moritz/documents/MetaBibliothek/20-infrastructure/vpn-live-config.md) | [Link unten](#NIXH-20-INF-008) |
| NIXH-30-AUT-001 | `30-automation/automation.nix` | [automation.nix](../../home/moritz/documents/MetaBibliothek/30-automation/automation.md) | [Link unten](#NIXH-30-AUT-001) |
| NIXH-30-AUT-002 | `30-automation/service-app-ai-agents.nix` | [service-app-ai-agents.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-ai-agents.md) | [Link unten](#NIXH-30-AUT-002) |
| NIXH-30-AUT-003 | `30-automation/service-app-home-assistant.nix` | [service-app-home-assistant.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-home-assistant.md) | [Link unten](#NIXH-30-AUT-003) |
| NIXH-30-AUT-004 | `30-automation/service-app-n8n.nix` | [service-app-n8n.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-n8n.md) | [Link unten](#NIXH-30-AUT-004) |
| NIXH-30-AUT-005 | `30-automation/service-app-olivetin.nix` | [service-app-olivetin.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-olivetin.md) | [Link unten](#NIXH-30-AUT-005) |
| NIXH-30-AUT-006 | `30-automation/service-app-semaphore.nix` | [service-app-semaphore.nix](../../home/moritz/documents/MetaBibliothek/30-automation/service-app-semaphore.md) | [Link unten](#NIXH-30-AUT-006) |
| NIXH-40-MED-001 | `40-media/media-stack.nix` | [media-stack.nix](../../home/moritz/documents/MetaBibliothek/40-media/media-stack.md) | [Link unten](#NIXH-40-MED-001) |
| NIXH-40-MED-002 | `40-media/service-app-audiobookshelf.nix` | [service-app-audiobookshelf.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-app-audiobookshelf.md) | [Link unten](#NIXH-40-MED-002) |
| NIXH-40-MED-003 | `40-media/service-media-_lib.nix` | [service-media-_lib.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-_lib.md) | [Link unten](#NIXH-40-MED-003) |
| NIXH-40-MED-004 | `40-media/service-media-_servarr-factory.nix` | [service-media-_servarr-factory.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-_servarr-factory.md) | [Link unten](#NIXH-40-MED-004) |
| NIXH-40-MED-005 | `40-media/service-media-arr-wire.nix` | [service-media-arr-wire.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-arr-wire.md) | [Link unten](#NIXH-40-MED-005) |
| NIXH-40-MED-006 | `40-media/service-media-default.nix` | [service-media-default.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-default.md) | [Link unten](#NIXH-40-MED-006) |
| NIXH-40-MED-007 | `40-media/service-media-jellyfin.nix` | [service-media-jellyfin.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-jellyfin.md) | [Link unten](#NIXH-40-MED-007) |
| NIXH-40-MED-008 | `40-media/service-media-jellyseerr.nix` | [service-media-jellyseerr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-jellyseerr.md) | [Link unten](#NIXH-40-MED-008) |
| NIXH-40-MED-009 | `40-media/service-media-lidarr.nix` | [service-media-lidarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-lidarr.md) | [Link unten](#NIXH-40-MED-009) |
| NIXH-40-MED-010 | `40-media/service-media-media-stack.nix` | [service-media-media-stack.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-media-stack.md) | [Link unten](#NIXH-40-MED-010) |
| NIXH-40-MED-011 | `40-media/service-media-prowlarr.nix` | [service-media-prowlarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-prowlarr.md) | [Link unten](#NIXH-40-MED-011) |
| NIXH-40-MED-012 | `40-media/service-media-radarr.nix` | [service-media-radarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-radarr.md) | [Link unten](#NIXH-40-MED-012) |
| NIXH-40-MED-013 | `40-media/service-media-readarr.nix` | [service-media-readarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-readarr.md) | [Link unten](#NIXH-40-MED-013) |
| NIXH-40-MED-014 | `40-media/service-media-recyclarr.nix` | [service-media-recyclarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-recyclarr.md) | [Link unten](#NIXH-40-MED-014) |
| NIXH-40-MED-015 | `40-media/service-media-sabnzbd.nix` | [service-media-sabnzbd.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-sabnzbd.md) | [Link unten](#NIXH-40-MED-015) |
| NIXH-40-MED-016 | `40-media/service-media-services-common.nix` | [service-media-services-common.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-services-common.md) | [Link unten](#NIXH-40-MED-016) |
| NIXH-40-MED-017 | `40-media/service-media-sonarr.nix` | [service-media-sonarr.nix](../../home/moritz/documents/MetaBibliothek/40-media/service-media-sonarr.md) | [Link unten](#NIXH-40-MED-017) |
| NIXH-50-KNW-001 | `50-knowledge/service-app-linkding.nix` | [service-app-linkding.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-linkding.md) | [Link unten](#NIXH-50-KNW-001) |
| NIXH-50-KNW-002 | `50-knowledge/service-app-miniflux.nix` | [service-app-miniflux.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-miniflux.md) | [Link unten](#NIXH-50-KNW-002) |
| NIXH-50-KNW-003 | `50-knowledge/service-app-paperless.nix` | [service-app-paperless.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-paperless.md) | [Link unten](#NIXH-50-KNW-003) |
| NIXH-50-KNW-004 | `50-knowledge/service-app-readeck.nix` | [service-app-readeck.nix](../../home/moritz/documents/MetaBibliothek/50-knowledge/service-app-readeck.md) | [Link unten](#NIXH-50-KNW-004) |
| NIXH-60-APP-001 | `60-apps/SERVICE_TEMPLATE.nix` | [SERVICE_TEMPLATE.nix](../../home/moritz/documents/MetaBibliothek/60-apps/SERVICE_TEMPLATE.md) | [Link unten](#NIXH-60-APP-001) |
| NIXH-60-APP-002 | `60-apps/service-app-couchdb.nix` | [service-app-couchdb.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-couchdb.md) | [Link unten](#NIXH-60-APP-002) |
| NIXH-60-APP-003 | `60-apps/service-app-filebrowser.nix` | [service-app-filebrowser.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-filebrowser.md) | [Link unten](#NIXH-60-APP-003) |
| NIXH-60-APP-004 | `60-apps/service-app-karakeep.nix` | [service-app-karakeep.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-karakeep.md) | [Link unten](#NIXH-60-APP-004) |
| NIXH-60-APP-005 | `60-apps/service-app-matrix-conduit.nix` | [service-app-matrix-conduit.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-matrix-conduit.md) | [Link unten](#NIXH-60-APP-005) |
| NIXH-60-APP-006 | `60-apps/service-app-monica.nix` | [service-app-monica.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-monica.md) | [Link unten](#NIXH-60-APP-006) |
| NIXH-60-APP-007 | `60-apps/service-app-vaultwarden.nix` | [service-app-vaultwarden.nix](../../home/moritz/documents/MetaBibliothek/60-apps/service-app-vaultwarden.md) | [Link unten](#NIXH-60-APP-007) |
| NIXH-80-MON-001 | `80-monitoring/cockpit.nix` | [cockpit.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/cockpit.md) | [Link unten](#NIXH-80-MON-001) |
| NIXH-80-MON-002 | `80-monitoring/service-netdata.nix` | [service-netdata.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/service-netdata.md) | [Link unten](#NIXH-80-MON-002) |
| NIXH-80-MON-003 | `80-monitoring/service-scrutiny.nix` | [service-scrutiny.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/service-scrutiny.md) | [Link unten](#NIXH-80-MON-003) |
| NIXH-80-MON-004 | `80-monitoring/uptime-kuma.nix` | [uptime-kuma.nix](../../home/moritz/documents/MetaBibliothek/80-monitoring/uptime-kuma.md) | [Link unten](#NIXH-80-MON-004) |
| NIXH-90-POL-001 | `90-policy/binary-only.nix` | [binary-only.nix](../../home/moritz/documents/MetaBibliothek/90-policy/binary-only.md) | [Link unten](#NIXH-90-POL-001) |
| NIXH-90-POL-002 | `90-policy/flat-layout.nix` | [flat-layout.nix](../../home/moritz/documents/MetaBibliothek/90-policy/flat-layout.md) | [Link unten](#NIXH-90-POL-002) |
| NIXH-90-POL-003 | `90-policy/no-legacy.nix` | [no-legacy.nix](../../home/moritz/documents/MetaBibliothek/90-policy/no-legacy.md) | [Link unten](#NIXH-90-POL-003) |
| NIXH-90-POL-004 | `90-policy/security-assertions.nix` | [security-assertions.nix](../../home/moritz/documents/MetaBibliothek/90-policy/security-assertions.md) | [Link unten](#NIXH-90-POL-004) |

- [ryan4yin/nix-config (Secrets)](https://github.com/ryan4yin/nix-config/tree/main/hosts/common/core/sops.nix)
- [Mic92/sops-nix](https://github.com/Mic92/sops-nix)

- [NixOS Search: ai-tools](https://search.nixos.org/packages?query=ollama)

- [NixOS Manual: Localization](https://nixos.org/manual/nixos/stable/#ch-localization)

- [NixOS Search: restic](https://search.nixos.org/options?query=services.restic)
- [ironicbadger/infra (Backup)](https://github.com/ironicbadger/infra/blob/master/nixos/backup.nix)

- [mitchellh/nixos-config (Boot)](https://github.com/mitchellh/nixos-config/blob/main/system/boot.nix)

- [Architecture Blueprint](https://nixos.wiki/wiki/Module)

- [JSON Nix Integration](https://nixos.org/manual/nix/stable/expressions/builtins.html#builtins-fromJSON)

- [Global Options Pattern](https://nixos.wiki/wiki/NixOS_modules#Options)

- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)

- [NixOS Search: fail2ban](https://search.nixos.org/options?query=services.fail2ban)

- [NixOS Manual: Firewall](https://nixos.org/manual/nixos/stable/#sec-firewall)

- [NixOS Hardware (GitHub)](https://github.com/NixOS/nixos-hardware)

- [nix-community/home-manager](https://github.com/nix-community/home-manager)

- [IronicBadger: Kernel Hardening](https://github.com/ironicbadger/infra/blob/master/nixos/kernel.nix)

- [NixOS Manual: Networkd](https://nixos.org/manual/nixos/stable/#sec-systemd-networkd)

- [NixOS Wiki: Storage optimization](https://nixos.wiki/wiki/Storage_optimization)

- [Modular Design Patterns](https://github.com/ryan4yin/nix-config)

- [Mic92/sops-nix Examples](https://github.com/Mic92/sops-nix/tree/master/examples)

- [ryan4yin/nix-config (Shell)](https://github.com/ryan4yin/nix-config/tree/main/modules/nixos/base/shell)

- [NixOS Search: adguardhome](https://search.nixos.org/options?query=services.adguardhome)

- [ironicbadger/infra (Caddy)](https://github.com/ironicbadger/infra/blob/master/nixos/caddy.nix)
- [Caddy Docs: Docker Proxy Pattern](https://caddyserver.com/docs/quick-start/reverse-proxy)

- [NixOS Search: cloudflared](https://search.nixos.org/options?query=services.cloudflared)

- [Upstream: qdm12/ddns-updater](https://github.com/qdm12/ddns-updater)

- [gethomepage/homepage](https://github.com/gethomepage/homepage)

- [pocket-id/pocket-id](https://github.com/pocket-id/pocket-id)

- [tailscale/tailscale](https://github.com/tailscale/tailscale)
- [NixOS Wiki: Tailscale](https://nixos.wiki/wiki/Tailscale)

- [NixOS Manual: PostgreSQL](https://nixos.org/manual/nixos/stable/#module-services-postgres)

- [zigbee2mqtt/zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt)

- [mergerfs GitHub](https://github.com/trapexit/mergerfs)
- [IronicBadger: Perfect Media Server](https://github.com/ironicbadger/book-perfectmediaserver)

- [valkey-io/valkey](https://github.com/valkey-io/valkey)

- [Maroka-chan/VPN-Confinement](https://github.com/Maroka-chan/VPN-Confinement)

- [home-assistant/core](https://github.com/home-assistant/core)

- [n8n-io/n8n](https://github.com/n8n-io/n8n)

- [OliveTin/OliveTin](https://github.com/OliveTin/OliveTin)

- [ansible-semaphore/semaphore](https://github.com/ansible-semaphore/semaphore)

- [nix-media-server/nixarr](https://github.com/nix-media-server/nixarr)
- [kiriwalawren/nixflix](https://github.com/kiriwalawren/nixflix)

- [advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf)

- [jellyfin/jellyfin](https://github.com/jellyfin/jellyfin)

- [Fallenbagel/jellyseerr](https://github.com/Fallenbagel/jellyseerr)

- [Lidarr/Lidarr](https://github.com/Lidarr/Lidarr)

- [Prowlarr/Prowlarr](https://github.com/Prowlarr/Prowlarr)

- [Radarr/Radarr](https://github.com/Radarr/Radarr)

- [Readarr/Readarr](https://github.com/Readarr/Readarr)

- [recyclarr/recyclarr](https://github.com/recyclarr/recyclarr)

- [sabnzbd/sabnzbd](https://github.com/sabnzbd/sabnzbd)

- [Sonarr/Sonarr](https://github.com/Sonarr/Sonarr)

- [sissis/linkding](https://github.com/sissis/linkding)

- [miniflux/v2](https://github.com/miniflux/v2)

- [paperless-ngx/paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)

- [readeck/readeck](https://github.com/readeck/readeck)

- [karakeep-app/karakeep](https://github.com/karakeep-app/karakeep)

- [girlbossceo/conduit](https://github.com/girlbossceo/conduit)

- [monicahq/monica](https://github.com/monicahq/monica)

- [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)

- [cockpit-project/cockpit](https://github.com/cockpit-project/cockpit)

- [netdata/netdata](https://github.com/netdata/netdata)

- [AnalogJ/scrutiny](https://github.com/AnalogJ/scrutiny)

- [louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)

- [NixOS Wiki: Binary Cache](https://nixos.wiki/wiki/Binary_Cache)

- [NixOS Wiki: Hardening](https://nixos.wiki/wiki/Hardening)

``n---
### [F-016] docs\superpowers\plans\2026-04-27-00-core-refactoring.md
* Pfad: docs\superpowers\plans\2026-04-27-00-core-refactoring.md | Format: .md | Größe: 6,44 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Konsolidierung des `00-core` Layers (Hardware, SSoT-Register, mkService-Fabrik und Traceability), um eine unerschütterliche Basis für alle höheren Layer zu schaffen.

**Architecture:** Refactoring der Basis-Nix-Module. Zentralisierung von Ports in `ports.nix`, globaler Settings in `configs.nix` und Ausbau von `lib-helpers.nix` (`mkService`), um Boilerplate in Layern 10-90 zu eliminieren. Hardware-Profile werden vereinfacht.

**Tech Stack:** NixOS, Nix Language, Systemd

**Files:**
- Modify: `temp_mynixos/00-core/host-q958-hardware-profile.nix`
- Modify: `temp_mynixos/00-core/boot-safeguard.nix`

- [ ] **Step 1: Clean up hardware profile**

Optimiere das Hardware-Profile für den Q958. Entferne veraltete oder doppelte Einträge und stelle sicher, dass Intel QuickSync/VA-API geladen werden.

```nix

{ config, lib, pkgs, ... }:
{
 hardware.graphics = {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver
 intel-vaapi-driver
 libvdpau-va-gl
 ];
 };
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```

- [ ] **Step 2: Streamline boot safeguard**

Sorge dafür, dass `boot-safeguard.nix` nur die allernötigsten Boot-Parameter enthält, ohne das System zu überladen.

```nix

{ config, lib, ... }:
{
 boot.loader.systemd-boot.enable = true;
 boot.loader.efi.canTouchEfiVariables = true;
 boot.kernelParams = [ "quiet" "loglevel=3" ];
 boot.tmp.cleanOnBoot = true;
}
```

- [ ] **Step 3: Test evaluation**

Run: `nix-instantiate --eval -E 'with import <nixpkgs> { }; 1'` (Or run `nix flake check` if a flake is present, just a basic syntax check).
Expected: No syntax errors in the modified files.

- [ ] **Step 4: Commit**

```bash
git add temp_mynixos/00-core/host-q958-hardware-profile.nix temp_mynixos/00-core/boot-safeguard.nix
git commit -m "refactor(core): consolidate hardware and boot configurations"
```

**Files:**
- Modify: `temp_mynixos/00-core/ports.nix`
- Modify: `temp_mynixos/00-core/configs.nix`

- [ ] **Step 1: Enforce complete port registry**

Stelle sicher, dass `ports.nix` alle Ports als SSoT exportiert.

```nix

{ lib, ... }:
{
 options.my.ports = lib.mkOption {
 type = lib.types.attrsOf lib.types.port;
 default = {
 vaultwarden = 8222;
 jellyfin = 8096;
 paperless = 28981;

 };
 description = "Central port registry (SSoT)";
 };
}
```

- [ ] **Step 2: Define global configs**

Zentralisiere Domain und LAN-IPs in `configs.nix`.

```nix

{ lib, ... }:
{
 options.my.configs = {
 identity = {
 domain = lib.mkOption { type = lib.types.str; default = "m7c5.de"; };
 subdomain = lib.mkOption { type = lib.types.str; default = "nix"; };
 };
 server = {
 lanIP = lib.mkOption { type = lib.types.str; default = "192.168.2.73"; };
 };
 };
}
```

- [ ] **Step 3: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/ports.nix temp_mynixos/00-core/configs.nix`
Expected: Silent return (no errors).

- [ ] **Step 4: Commit**

```bash
git add temp_mynixos/00-core/ports.nix temp_mynixos/00-core/configs.nix
git commit -m "feat(core): centralize SSoT registries for ports and configs"
```

**Files:**
- Modify: `temp_mynixos/00-core/lib-helpers.nix`

- [ ] **Step 1: Enhance mkService for standard reverse proxy routing**

Erweitere `mkService` so, dass es Systemd-Sandboxing und Caddy-Reverse-Proxy-Logik nahtlos kapselt.

```nix

{ lib, ... }:
let

 getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
in {
 mkService = { config, name, port ? null, useSSO ? true, description ? "Managed Service", netns ? null }:
 let
 finalPort = if port != null then port else config.my.ports.${name};
 targetUrl = "http://${if netns != null then "10.200.1.2" else "127.0.0.1"}:${toString finalPort}";
 hostName = getDomain config name;
 in {
 systemd.services.${name}.serviceConfig = {
 Description = description;
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 };

 services.caddy.virtualHosts.${hostName}.extraConfig = ''
 ${lib.optionalString useSSO "import sso_auth"}
 reverse_proxy ${targetUrl}
 '';
 };
}
```

- [ ] **Step 2: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/lib-helpers.nix`
Expected: Silent return (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/00-core/lib-helpers.nix
git commit -m "feat(core): expand mkService factory for unified service definitions"
```

**Files:**
- Modify: `temp_mynixos/00-core/lib-helpers-meta.nix`

- [ ] **Step 1: Define NMS metadata schema**

Implementiere das NMS (NixOS Management System) Metadaten-Schema, um Traceability für Audits sicherzustellen.

```nix

{ lib, ... }:
{
 options.my.meta = lib.mkOption {
 type = lib.types.attrsOf (lib.types.submodule {
 options = {
 id = lib.mkOption { type = lib.types.str; };
 title = lib.mkOption { type = lib.types.str; };
 layer = lib.mkOption { type = lib.types.int; };
 audit.last_reviewed = lib.mkOption { type = lib.types.str; };
 };
 });
 default = {};
 description = "NMS Traceability Metadata";
 };
}
```

- [ ] **Step 2: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/lib-helpers-meta.nix`
Expected: Silent return (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/00-core/lib-helpers-meta.nix
git commit -m "feat(core): implement NMS metadata schema for traceability"
```

``n---
### [F-017] docs\superpowers\plans\2026-04-28-advanced-storage-tiering.md
* Pfad: docs\superpowers\plans\2026-04-28-advanced-storage-tiering.md | Format: .md | Größe: 7,48 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Maximize SSD efficiency and endurance by distributing data across NVMe (Tier A), SATA SSD (Tier B), HDD (Tier C), and RAM.

**Architecture:** 
1. `configs.nix`: SSoT for Tiered paths.
2. `storage-mover.nix`: Capacity-based evacuation script.
3. `jellyfin.nix`: RAM-based transcoding.

**Files:**
- Modify: `temp_mynixos/modules/core/configs.nix`

- [ ] **Step 1: Update paths in configs.nix**

```nix

 paths = {
 stateDir = lib.mkOption { type = lib.types.str; default = "/var/lib"; };
 tierA = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/persist"; description = "NVMe: Persistent State"; });
 tierB = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/cache"; description = "SSD: Cache & Transcodes"; });
 tierC = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; description = "HDD: Bulk Media Archive"; });

 appData = lib.mkOption { type = lib.types.str; default = "/persist/app-data"; description = "Tier A: High-IOPS (Databases, Configs)"; };
 appCache = lib.mkOption { type = lib.types.str; default = "/mnt/cache/app-cache"; description = "Tier B: High-Volume (Images, Thumbnails)"; };
 downloads = lib.mkOption { type = lib.types.str; default = "/mnt/cache/downloads"; description = "Tier B: High-Write (Active SABnzbd)"; };

 mediaLibrary = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool/media"; };
 storagePool = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; };
 };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/configs.nix
git commit -m "feat(storage): finalize ABC-Tiering path definitions"
```

**Files:**
- Modify: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Rewrite the mover script and options**

```nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;

 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail

 SOURCE_DIR="${cfg.ssdDir}"
 TARGET_DIR="${cfg.hddDir}"
 LOW_THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
 TARGET_FREE_GB=${toString cfg.targetFreeGB}
 DRY_RUN=${if cfg.dryRun then "1" else "0"}

 echo "--- Starting Capacity-Based Smart Mover ---"

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))

 echo " Current free space on Tier B ($SOURCE_DIR): ''${FREE_GB} GB"

 if [ "$FREE_GB" -ge "$LOW_THRESHOLD_GB" ]; then
 echo " Sufficient space available. No action required."
 exit 0
 fi

 echo " Low space detected (''${FREE_GB} GB < ''${LOW_THRESHOLD_GB} GB). Evacuating oldest files..."

 while [ "$FREE_GB" -lt "$TARGET_FREE_GB" ]; do

 OLDEST=$(find "$SOURCE_DIR" -type f -printf '%T@ %p\n' | sort -n | head -1 | cut -d' ' -f2-)

 if [ -z "$OLDEST" ]; then
 echo " No more files found to move."
 break
 fi

 if ${pkgs.lsof}/bin/lsof "$OLDEST" > /dev/null 2>&1; then
 echo " Skipping active file: $OLDEST"

 touch "$OLDEST"
 continue
 fi

 REL_PATH=''${OLDEST#"$SOURCE_DIR/"}
 DEST_DIR=$(dirname "$TARGET_DIR/$REL_PATH")

 if [ "$DRY_RUN" -eq 1 ]; then
 echo "[DRY-RUN] Would move: $REL_PATH"

 FREE_GB=$((FREE_GB + 1)) 
 else
 echo " Moving: $REL_PATH"
 mkdir -p "$DEST_DIR"
 mv "$OLDEST" "$TARGET_DIR/$REL_PATH"

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))
 fi
 done

 if [ "$DRY_RUN" -eq 0 ]; then
 find "$SOURCE_DIR" -type d -empty -delete
 echo " Cleaned up empty directories."
 fi

 echo "--- Mover finished. Current free space: ''${FREE_GB} GB ---"
 '';

in
{
 options.my.storage.mover = {
 enable = lib.mkEnableOption "Smart Storage Tiering Mover";
 ssdDir = lib.mkOption { type = lib.types.str; default = srePaths.downloads; };
 hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/downloads"; };
 lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 20; };
 targetFreeGB = lib.mkOption { type = lib.types.int; default = 50; };
 dryRun = lib.mkOption { type = lib.types.bool; default = false; };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.storage-mover = {
 description = "Capacity-Based Smart Mover (SSD -> HDD)";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = moverScript;
 Nice = 19;
 IOSchedulingClass = "idle";
 CPUSchedulingPolicy = "idle";
 };
 };

 systemd.timers.storage-mover = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };
 };
}
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "refactor(storage): rewrite mover to capacity-based logic"
```

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-jellyfin.nix`

- [ ] **Step 1: Set RuntimeDirectory and environment variables**

```nix
{ config, pkgs, lib, myLib, ... }:

{

 config = lib.mkIf cfg.enable (lib.mkMerge [
 (myLib.mkStreamer {

 })
 {
 systemd.services.jellyfin = {
 serviceConfig = {

 RuntimeDirectory = "jellyfin-transcode"; # creates /run/jellyfin-transcode (tmpfs)
 RuntimeDirectoryMode = "0750";
 Environment = [
 "FFMPEG_TRANSCODING_TEMP_DIR=/run/jellyfin-transcode"
 ];
 };
 };

 }
 ]);
}
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/apps/service-media-jellyfin.nix
git commit -m "perf(jellyfin): move transcoding to RAM disk (tmpfs)"
```

- [ ] **Step 1: Check lib-helpers.nix**
Verify that `appDataDir` is actually on Tier A and used for state. (Done in previous turn, just confirm).

- [ ] **Step 2: Final Verification**
Run `nix-instantiate --parse` (simulated check) or verify file structure.

``n---
### [F-018] docs\superpowers\plans\2026-04-28-emergency-logging-ntfy.md
* Pfad: docs\superpowers\plans\2026-04-28-emergency-logging-ntfy.md | Format: .md | Größe: 4,77 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rename the logging module to reflect its new HDD target and add an `ntfy` emergency sink for `ERROR` level logs.

**Architecture:** 
1. `vector-hdd.nix`: Renamed from `vector-tier-b.nix`.
2. **Emergency Sink:** Vector `http` sink targeting an `ntfy` topic for high-priority alerts.

**Files:**
- Create: `temp_mynixos/modules/logging/vector-hdd.nix`
- Remove: `temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 1: Create the new module with ntfy sink**

```nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.logging.vector;
 srePaths = config.my.configs.paths;
 logDir = "${srePaths.tierC}/logs/system";
 maxTotalSizeMB = 1024; # 1 GB
in
{
 options.my.logging.vector = {
 enable = lib.mkEnableOption "Vector logging to HDD (Tier C)";
 retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
 maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 200; };
 ntfyTopic = lib.mkOption { 
 type = lib.types.nullOr lib.types.str; 
 default = "nixhome-alerts"; 
 description = "Ntfy topic for emergency alerts (ERROR level).";
 };
 };

 config = lib.mkIf cfg.enable {

 services.journald.extraConfig = ''Storage=volatile'';

 services.vector = {
 enable = true;
 config = {
 sources.journald = {
 type = "journald";
 current_boot_only = false;
 };

 transforms.mask_sensitive = {
 type = "remap";
 inputs = [ "journald" ];
 source = ''

 .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
 .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
 '';
 };

 transforms.error_filter = {
 type = "filter";
 inputs = [ "mask_sensitive" ];
 condition = ''includes(["err", "crit", "alert", "emerg"], .priority) || .level == "error" || .level == "critical" '';
 };

 sinks.file = {
 type = "file";
 inputs = [ "mask_sensitive" ];
 path = "${logDir}/journal-%Y-%m-%d.log";
 encoding.codec = "ndjson";
 compression = "gzip";
 batch.max_bytes = 50 * 1024 * 1024; # 50MB for HDD efficiency
 batch.timeout_secs = 300; # 5 minutes
 healthcheck = true;
 };

 sinks.ntfy = lib.mkIf (cfg.ntfyTopic != null) {
 type = "http";
 inputs = [ "error_filter" ];
 uri = "https://ntfy.sh/${cfg.ntfyTopic}";
 method = "post";
 encoding.codec = "text";

 batch.max_events = 1;
 };
 };
 };

 systemd.services.rotate-vector-logs = {
 description = "Rotate and delete old Vector logs (size/age based)";
 serviceConfig = {
 Type = "oneshot";
 Nice = 19;
 IOSchedulingClass = "idle";
 ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
 set -euo pipefail
 find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete

 '';
 };
 };

 systemd.timers.rotate-vector-logs = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };

 systemd.tmpfiles.rules = [ "d ${logDir} 0750 root root - -" ];
 };
}
```

- [ ] **Step 2: Commit new file**

```bash
git add temp_mynixos/modules/logging/vector-hdd.nix
git commit -m "feat(logging): add vector-hdd module with ntfy emergency sink"
```

- [ ] **Step 3: Remove old file**

```bash
git rm temp_mynixos/modules/logging/vector-tier-b.nix
git commit -m "chore(logging): remove deprecated vector-tier-b module"
```

**Files:**
- Modify: `temp_mynixos/profiles/base-server.nix`

- [ ] **Step 1: Change import from vector-tier-b to vector-hdd**

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/profiles/base-server.nix
git commit -m "refactor(profile): use vector-hdd logging module"
```

``n---
### [F-019] docs\superpowers\plans\2026-04-28-hdd-ghosting-refinement.md
* Pfad: docs\superpowers\plans\2026-04-28-hdd-ghosting-refinement.md | Format: .md | Größe: 2,53 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Eliminate HDD spin-ups for non-media tasks and protect SSD from high-write metadata.

**Architecture:**
1. **Jellyfin:** Metadata -> Tier B SSD via Bind-Mount.
2. **HDD Policy:** Udev-based hdparm spindown (10 min).
3. **Ghosting:** Refined Inode-Warmer for RAM-caching directory trees.

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-jellyfin.nix`

- [ ] **Step 1: Define SSD Metadata Path and Bind Mount**

```nix
{ config, pkgs, lib, myLib, ... }:
let
 srePaths = config.my.configs.paths;
 ssdMetadataDir = "${srePaths.tierB}/metadata/jellyfin";
in
{

 config = lib.mkIf cfg.enable (lib.mkMerge [
 {

 systemd.tmpfiles.rules = [
 "d ${ssdMetadataDir} 0775 jellyfin media - -"
 ];

 fileSystems."/var/lib/jellyfin/metadata" = {
 device = ssdMetadataDir;
 options = [ "bind" "noatime" ];
 depends = [ "${srePaths.tierB}" ];
 };
 }
 ]);
}
```

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(jellyfin): move metadata (thumbnails/fanart) to SSD Tier B"
```

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Add Udev rules for hdparm**

```nix
services.udev.extraRules = ''

 ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 120 /dev/%k"
'';
```

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(storage): add global HDD spindown policy via udev"
```

- [ ] **Step 1: Update the hdd-inode-warmer service**
Make it read enough metadata to keep the tree in RAM.

```nix
systemd.services.hdd-inode-warmer = {
 description = "Refined Inode Warmer for HDD Ghost-Tree";
 serviceConfig = {
 Type = "oneshot";
 ExecStart = "${pkgs.findutils}/bin/find /mnt/hdd_pool -mindepth 1 -maxdepth 5 -exec stat {} +";
 };
};
```

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(storage): refine inode-warmer for better metadata ghosting"
```

``n---
### [F-020] docs\superpowers\plans\2026-04-28-hdd-silence-protocol.md
* Pfad: docs\superpowers\plans\2026-04-28-hdd-silence-protocol.md | Format: .md | Größe: 1,90 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prevent HDD spin-ups for metadata and deletion tasks. Queue operations until the disk is active.

**Architecture:**
1. **Metadata Caching:** Optimize MergerFS and add a "Kernel Inode Warmer" service.
2. **Deferred Deletes:** Script to manage a `delete_queue` directory on SSD.
3. **Smart Mover v2:** Status-aware execution.

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Update MergerFS options for extreme caching**

```nix
options = "allow_other,use_ino,cache.files=auto-full,cache.entry=3600,cache.attr=3600,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,dropcacheonclose=true";
```

- [ ] **Step 2: Add Inode-Warmer Service**
This service runs `find /mnt/hdd_pool -maxdepth 3` once every 6 hours to keep the top-level structure in RAM.

**Files:**
- Create: `temp_mynixos/modules/storage/deferred-ops.nix`

- [ ] **Step 1: Create the 'Ghost Trash' logic**
Instead of `rm`, apps should move to `${srePaths.tierB}/delete_queue`.

- [ ] **Step 2: Create the Queue-Processor Script**
The script checks if `/dev/disk/by-id/...` is spinning (via `hdparm -C`). If spinning, it executes the deletes.

**Files:**
- Modify: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Inject 'Disk-Status' check into mover script**

```bash

IS_AWAKE=$(hdparm -C /dev/sdX | grep -c "active/idle" || true)

if [ "$FREE_GB" -ge "$LOW_THRESHOLD_GB" ] && [ "$IS_AWAKE" -eq 0 ]; then
 echo "Disk is sleeping and space is OK. Sleeping too."
 exit 0
fi
```

``n---
### [F-021] docs\superpowers\plans\2026-04-28-metadata-injection-resumed.md
* Pfad: docs\superpowers\plans\2026-04-28-metadata-injection-resumed.md | Format: .md | Größe: 786 B
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add NMS v2.3 Metadata Headers to all service-app-*.nix files for RAG/Obsidian compatibility.

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-*.nix`

- [ ] **Step 1: Process Jellyfin**
- [ ] **Step 2: Process Audiobookshelf**
- [ ] **Step 3: Process Navidrome**
- [ ] **Step 4: Process Arr-Stack (Sonarr, Radarr, etc.)**
- [ ] **Step 5: Process Paperless & n8n**

- [ ] **Step 6: Commit all changes**

```bash
git commit -m "docs: complete NMS v2.3 metadata headers for all app modules"
```

``n---
### [F-022] docs\superpowers\plans\2026-04-28-navidrome-integration.md
* Pfad: docs\superpowers\plans\2026-04-28-navidrome-integration.md | Format: .md | Größe: 4,55 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate Navidrome music server using the `mkStreamer` factory with ABC-Tiering and SSO.

**Architecture:** Horizontal module pattern (v5.0). Uses `myLib.mkStreamer` for standard hardening, Caddy reverse proxy, and systemd sandboxing.

**Tech Stack:** NixOS, Navidrome, Caddy.

**Files:**
- Create: `temp_mynixos/modules/apps/service-app-navidrome.nix`

- [ ] **Step 1: Write the module code**

```nix
{ config, lib, pkgs, myLib, ... }:
let
 nms = {
 id = "NIXH-01-APP-NAV-001";
 title = "Navidrome (hardened Music Server)";
 layer = 40;
 audit.last_reviewed = "2026-04-28";
 };
 cfg = config.my.apps.navidrome;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;
in
{
 options.my.apps.navidrome = {
 enable = lib.mkEnableOption "Navidrome Music Server";
 user = lib.mkOption { type = lib.types.str; default = "navidrome"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.navidrome or 4533; };
 stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/navidrome"; };
 cacheDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/cache/navidrome"; };
 musicDir = lib.mkOption { type = lib.types.str; default = "${srePaths.mediaLibrary}/music"; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "navidrome";
 port = cfg.port;
 useGPU = false;
 memoryMax = "1G";
 cpuWeight = 60;
 description = "Navidrome Music Streaming";
 })

 {
 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };

 services.navidrome = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 address = "127.0.0.1";
 port = cfg.port;
 musicFolder = cfg.musicDir;
 dataFolder = cfg.stateDir;
 cacheFolder = cfg.cacheDir;
 settings.EnableSubsonicApi = true;
 };

 services.caddy.virtualHosts."music.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" =
 config.services.caddy.virtualHosts."navidrome.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.navidrome.serviceConfig.ReadOnlyPaths = [ cfg.musicDir ];

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist".directories = [
 "/var/lib/navidrome"
 ];
 }
 ]);
}
```

- [ ] **Step 2: Verify syntax (Dry Run)**

Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-navidrome.nix`
Expected: File content printed (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/apps/service-app-navidrome.nix
git commit -m "feat(apps): add navidrome service module with mkStreamer"
```

**Files:**
- Modify: `temp_mynixos/modules/apps/media-stack.nix`

- [ ] **Step 1: Add navidrome to media group members**

Add `"navidrome"` to the list in `users.groups.media.members`.

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/apps/media-stack.nix
git commit -m "chore(media): add navidrome user to shared media group"
```

**Files:**
- Modify: `temp_mynixos/profiles/media-beast.nix`

- [ ] **Step 1: Add import for navidrome module**

Add `../modules/apps/service-app-navidrome.nix` to `imports`.

- [ ] **Step 2: Enable the service**

Add `my.apps.navidrome.enable = true;` to the config.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/profiles/media-beast.nix
git commit -m "feat(profile): activate navidrome in media-beast profile"
```

- [ ] **Step 1: Run Flake Check**

Run: `nix flake check temp_mynixos/`
Expected: SUCCESS

- [ ] **Step 2: Update Project Log**

Update `GEMINI.md` to mark Navidrome as DONE.

``n---
### [F-023] docs\superpowers\plans\2026-04-28-persist-backup-implementation.md
* Pfad: docs\superpowers\plans\2026-04-28-persist-backup-implementation.md | Format: .md | Größe: 2,31 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a secondary Restic job for `/persist` targeting Backblaze B2.

**Architecture:** Extended `restic.backups` with Sops secret injection.

**Tech Stack:** NixOS, Restic, Sops, Backblaze B2.

**Files:**
- Modify: `temp_mynixos/modules/core/secrets.nix`

- [ ] **Step 1: Add secret definitions**

Add `restic_password`, `backblaze_access_key`, and `backblaze_secret_key` to `sops.secrets`.

- [ ] **Step 2: Add Sops Template for Restic Env**

Add `templates."backblaze-restic.env"` to provide `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

```nix
 templates."backblaze-restic.env" = {
 owner = "root";
 mode = "0400";
 content = ''
 AWS_ACCESS_KEY_ID="${config.sops.placeholder.backblaze_access_key}"
 AWS_SECRET_ACCESS_KEY="${config.sops.placeholder.backblaze_secret_key}"
 '';
 };
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/secrets.nix
git commit -m "chore(secrets): add backblaze and restic secret definitions"
```

**Files:**
- Modify: `temp_mynixos/modules/core/backup.nix`

- [ ] **Step 1: Add the 'persist' job**

```nix
 services.restic.backups.persist = {
 initialize = true;
 repository = "s3:https://s3.eu-central-003.backblazeb2.com/nixhome-persist";
 passwordFile = config.sops.secrets.restic_password.path;
 environmentFile = config.sops.templates."backblaze-restic.env".path;

 paths = [ "/persist" ];
 exclude = [ "**/.cache" "**/tmp" ];

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];

 timerConfig = {
 OnCalendar = "03:00";
 Persistent = true;
 };

 extraOptions = [ "--compression=max" ];
 };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/backup.nix
git commit -m "feat(backup): add secondary restic job for /persist to cloud"
```

- [ ] **Step 1: Update ROADMAP.md**

Mark P2 as DONE.

``n---
### [F-024] docs\superpowers\plans\2026-04-28-phase4-init.md
* Pfad: docs\superpowers\plans\2026-04-28-phase4-init.md | Format: .md | Größe: 1,37 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Initialize Obsidian directory structure and fix mcp-nixos connection.

- [ ] **Step 1: Create folders individually (PowerShell safe)**
```powershell
New-Item -ItemType Directory -Force -Path "C:\Users\morit\Documents\Obsidian_Main\NixOS\00_Meta"
New-Item -ItemType Directory -Force -Path "C:\Users\morit\Documents\Obsidian_Main\NixOS\10_Services"
New-Item -ItemType Directory -Force -Path "C:\Users\morit\Documents\Obsidian_Main\NixOS\20_Storage"
New-Item -ItemType Directory -Force -Path "C:\Users\morit\Documents\Obsidian_Main\NixOS\90_Security"
```

- [ ] **Step 2: Create Master-Index in Obsidian**
Create `C:\Users\morit\Documents\Obsidian_Main\NixOS\00_Meta\NixHome_Master.md`.

- [ ] **Step 1: Locate Claude Desktop Config**
Check `C:\Users\morit\AppData\Roaming\Claude\claude_desktop_config.json`.

- [ ] **Step 2: Update 'uvx' to full path**
Replace `"command": "uvx"` with the absolute path to your uvx executable (likely in `%USERPROFILE%\.local\bin\uvx.exe` or where `uv` was installed).

- [ ] **Step 3: Test mcp-nixos manually**
Run `uvx mcp-nixos` in CMD to see if it starts a JSON-RPC session.

``n---
### [F-025] docs\superpowers\plans\2026-04-28-ssd-endurance-hardening.md
* Pfad: docs\superpowers\plans\2026-04-28-ssd-endurance-hardening.md | Format: .md | Größe: 2,01 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Protect Tier A/B SSDs by moving high-write operations (SABnzbd temp, Logs) to RAM and HDD.

**Architecture:**
1. **SABnzbd:** `incomplete` directory -> `/run/sabnzbd-tmp` (tmpfs).
2. **Vector:** Sink -> Tier C (HDD).
3. **Mounts:** Apply `noatime`.

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-sabnzbd.nix`

- [ ] **Step 1: Configure tmpfs for incomplete downloads**

```nix
systemd.services.sabnzbd = {
 serviceConfig = {

 RuntimeDirectory = "sabnzbd-tmp";
 RuntimeDirectoryMode = "0750";
 };
};
```

- [ ] **Step 2: Update SABnzbd config to use /run/sabnzbd-tmp**
(Assuming the module handles the config file or allows overrides).

- [ ] **Step 3: Commit**

```bash
git commit -m "perf(sabnzbd): move incomplete downloads to RAM disk"
```

**Files:**
- Modify: `temp_mynixos/modules/logging/vector-tier-b.nix` (rename or move logic)

- [ ] **Step 1: Change log directory to Tier C**

```nix
let
 logDir = "${srePaths.tierC}/logs/system";
in

```

- [ ] **Step 2: Add RAM buffering to Vector**
Ensure Vector collects logs in RAM and flushes to HDD every 5 minutes to reduce IO.

- [ ] **Step 3: Commit**

```bash
git commit -m "chore(logging): move system logs from SSD to HDD (Tier C)"
```

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Add 'noatime' to all relevant mounts**
Ensure `fileSystems` or `systemd.mounts` include the `noatime` option.

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(storage): apply noatime to all mounts for SSD endurance"
```

``n---
### [F-026] docs\superpowers\plans\2026-04-28-storage-mover-implementation.md
* Pfad: docs\superpowers\plans\2026-04-28-storage-mover-implementation.md | Format: .md | Größe: 4,83 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement an intelligent "Unraid-style" mover that shifts files from Tier B (SSD) to Tier C (HDD) safely.

**Architecture:** Custom module `modules/storage/storage-mover.nix`. Uses `rsync` for atomic moves and `lsof` for safety.

**Tech Stack:** NixOS, Bash, Rsync.

**Files:**
- Create: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Write the module code**

```nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;

 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail

 SOURCE="${cfg.ssdDir}"
 TARGET="${cfg.hddDir}"
 DRY_RUN=${if cfg.dryRun then "1" else "0"}
 AGE_DAYS=${toString cfg.minAgeDays}
 THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}

 echo "--- Starting Smart Mover [DryRun: $DRY_RUN, Age: $AGE_DAYS, Threshold: $THRESHOLD_GB GB] ---"

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))

 FORCE_MOVE=0
 if [ "$FREE_GB" -lt "$THRESHOLD_GB" ]; then
 echo " Low space detected ($FREE_GB GB < $THRESHOLD_GB GB). Forcing move of older files."
 FORCE_MOVE=1
 fi

 FIND_AGE=$AGE_DAYS
 [ "$FORCE_MOVE" -eq 1 ] && FIND_AGE=7

 echo " Scanning for files older than $FIND_AGE days..."

 find "$SOURCE" -type f -mtime +"$FIND_AGE" | while read -r file; do

 if ${pkgs.lsof}/bin/lsof "$file" > /dev/null 2>&1; then
 echo " Skipping active file: $file"
 continue
 fi

 REL_PATH=''${file#"$SOURCE/"}
 DEST_DIR=$(dirname "$TARGET/$REL_PATH")

 if [ "$DRY_RUN" -eq 1 ]; then
 echo "[DRY-RUN] Would move: $REL_PATH"
 else
 echo " Moving: $REL_PATH"
 mkdir -p "$DEST_DIR"

 ${pkgs.rsync}/bin/rsync -a --remove-source-files "$file" "$TARGET/$REL_PATH"
 fi
 done

 if [ "$DRY_RUN" -eq 0 ]; then
 find "$SOURCE" -type d -empty -delete
 echo " Cleaned up empty directories."

 if systemctl is-active --quiet update-metadata-db.service; then
 systemctl start update-metadata-db.service
 echo " Metadata DB update triggered."
 fi
 fi

 echo "--- Mover finished ---"
 '';

in
{
 options.my.storage.mover = {
 enable = lib.mkEnableOption "Smart Storage Tiering Mover";
 ssdDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/media"; };
 hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/media"; };
 minAgeDays = lib.mkOption { type = lib.types.int; default = 30; };
 lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 100; };
 dryRun = lib.mkOption { type = lib.types.bool; default = false; };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.storage-mover = {
 description = "hardened Smart Mover (SSD -> HDD)";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = moverScript;
 Nice = 19;
 IOSchedulingClass = "idle";
 CPUSchedulingPolicy = "idle";
 };
 };

 systemd.timers.storage-mover = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "*-*-* 04:00:00";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };
 };
}
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "feat(storage): add smart storage tiering mover module"
```

**Files:**
- Modify: `temp_mynixos/hardware/q958/hardware-profile.nix` (or similar)

- [ ] **Step 1: Check hardware profile imports**

- [ ] **Step 2: Add import and activation**

```nix
imports = [
 ../../modules/storage/storage-mover.nix
];

my.storage.mover.enable = true;
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/hardware/q958/hardware-profile.nix
git commit -m "feat(hardware): enable smart storage mover for Q958"
```

- [ ] **Step 1: Update ROADMAP.md**

Mark P3 as DONE.

``n---
### [F-027] docs\superpowers\plans\2026-04-28-tier-synergy-metadata.md
* Pfad: docs\superpowers\plans\2026-04-28-tier-synergy-metadata.md | Format: .md | Größe: 1,56 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Allow non-wear data from Tier B to use free space on Tier A (NVMe) while strictly excluding movies and high-write downloads. Start NMS v2.3 metadata tagging.

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Configure a Synergy-Pool for App-Data**
Create a mergerfs pool `/mnt/app-synergy` that combines Tier A (NVMe) and Tier B (SSD).
Policy: `mfs` (Most Free Space) but with a `minfreespace` of 50GB on Tier A to ensure system-critical operations always have room.

- [ ] **Step 2: Exclude High-Wear Categories**
Ensure that `downloads` and `logs` are EXPLICITLY hardcoded to Tier B or Tier C, bypassing the synergy pool.

- [ ] **Step 3: Commit**

```bash
git commit -m "perf(storage): implement opportunistic Tier A/B synergy for app data"
```

**Files:**
- Modify: All `service-app-*.nix` files.

- [ ] **Step 1: Add YAML-style headers as comments**
Each file gets a header like:
```nix

```

- [ ] **Step 2: Commit**

```bash
git commit -m "docs: add NMS v2.3 metadata headers for RAG indexing"
```

``n---
### [F-028] docs\superpowers\plans\2026-04-28-vector-logging-implementation.md
* Pfad: docs\superpowers\plans\2026-04-28-vector-logging-implementation.md | Format: .md | Größe: 4,07 KB
``md
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement persistent logging via Vector to Tier B (SSD) with 14-day rotation.

**Architecture:** Custom module leveraging `services.vector` and `systemd.timers`.

**Tech Stack:** NixOS, Vector.

**Files:**
- Create: `temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 1: Write the module code**

```nix

{ config, lib, pkgs, ... }:
let
 cfg = config.my.logging.vector;
 srePaths = config.my.configs.paths;
 logDir = "${srePaths.tierB}/logs/vector";
in
{
 options.my.logging.vector = {
 enable = lib.mkEnableOption "Vector logging to Tier B";
 retentionDays = lib.mkOption { type = lib.types.int; default = 14; };
 };

 config = lib.mkIf cfg.enable {

 services.journald.extraConfig = ''
 Storage=volatile
 Compress=yes
 RateLimitIntervalSec=30
 RateLimitBurst=1000
 '';

 services.vector = {
 enable = true;
 config = {
 sources.journald = {
 type = "journald";
 current_boot_only = false;
 include_units = [
 "*.service"
 "*.socket"
 "systemd-journald"
 "kernel"
 ];
 };
 transforms.mask_sensitive = {
 type = "remap";
 inputs = [ "journald" ];
 source = ''

 .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
 .message = replace(.message, r'\b[\w\s\-\.]+\.(mkv|mp4|avi|m4b|epub|pdf|nzb)\b', "[FILENAME]")
 .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
 '';
 };
 sinks.file = {
 type = "file";
 inputs = [ "mask_sensitive" ];
 path = "${logDir}/journal-%Y-%m-%d.log";
 encoding.codec = "json";
 compression = "gzip";
 batch.max_bytes = 104857600;
 healthcheck = true;
 };
 };
 };

 systemd.services.rotate-vector-logs = {
 description = "Delete old Vector log files from Tier B";
 serviceConfig = {
 Type = "oneshot";
 Nice = 19;
 IOSchedulingClass = "idle";
 ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
 set -euo pipefail
 find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete
 '';
 };
 };
 systemd.timers.rotate-vector-logs = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };

 systemd.tmpfiles.rules = [
 "d ${logDir} 0750 root root - -"
 ];
 };
}
```

- [ ] **Step 2: Verify syntax**

Run: `nix-instantiate --parse temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/logging/vector-tier-b.nix
git commit -m "feat(logging): add vector tier-b logging module with masking"
```

**Files:**
- Modify: `temp_mynixos/profiles/base-server.nix`

- [ ] **Step 1: Swap logging imports**

Replace `../modules/core/logging.nix` with `../modules/logging/vector-tier-b.nix`.

- [ ] **Step 2: Enable Vector logging**

Add `my.logging.vector.enable = true;` to the configuration block.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/profiles/base-server.nix
git commit -m "feat(profile): switch base-server to persistent vector logging"
```

- [ ] **Step 1: Remove old logging module (Optional)**

If no longer needed, remove `temp_mynixos/modules/core/logging.nix`.

- [ ] **Step 2: Update ROADMAP.md**

Mark P1 as DONE.

``n---
### [F-029] docs\superpowers\specs\2026-04-27-00-core-foundation-design.md
* Pfad: docs\superpowers\specs\2026-04-27-00-core-foundation-design.md | Format: .md | Größe: 2,53 KB
``md
Das Ziel ist die absolute Festigung des `00-core` Layers (Das Fundament). Bevor höhere Layer (wie Media, Apps oder Gateway) konfiguriert werden, muss die Basis zu 100 % verlässlich, nachvollziehbar und zentralisiert sein. Alle höheren Layer sind reine Konsumenten der hier definierten Schnittstellen und Standards.

Die Hardware-Abstraktion für den Q958 wird konsolidiert, damit das System deterministisch bootet und alle nötigen Treiber (z.B. für Transcoding) bereitstellt.
* **Betroffene Dateien:** `host-q958-hardware-profile.nix`, `boot-safeguard.nix`, `kernel-slim.nix`.
* **Funktion:** Sicheres Booten, Microcode-Updates, Intel QuickSync/VA-API Treiber-Init.

Dies ist das Herzstück der Automatisierung. Die Funktion `mkService` wird zur universellen Schnittstelle für alle Dienste in den Layern 10-90 ausgebaut.
* **Betroffene Dateien:** `lib-helpers.nix`.
* **Funktion:** Ein einziger Aufruf (`mkService { name = "vaultwarden"; port = 8080; }`) generiert automatisch:
 * Systemd Hardening & Sandboxing (ProtectSystem, PrivateTmp, etc.).
 * Caddy Reverse Proxy VirtualHosts (inkl. SSO/mTLS Routing).
 * Optional: Firewall-Regeln und Persistenz-Pfade.

Zentrale Verwaltung aller "Magic Strings" und Nummern, um Konfigurationsdrift zu vermeiden.
* **Betroffene Dateien:** `ports.nix`, `configs.nix`, `registry.nix`.
* **Funktion:**
 * `ports.nix`: Eindeutige Zuweisung aller Ports. Kein Dienst darf seinen Port selbst definieren.
 * `configs.nix`: Globale Variablen (Domain `nix.m7c5.de`, Admin-Mail, LAN-IPs).
 * `registry.nix`: Feature-Toggles (z.B. globale Aktivierung von Backups oder mTLS).

Metadaten-Tracking für jede Konfiguration, um bei Fehlern in zz.B. `80-monitoring` den Ursprung in `00-core` sofort lokalisieren zu können.
* **Betroffene Dateien:** `lib-helpers-meta.nix`.
* **Funktion:** Definition und Durchsetzung des `nms` (NixOS Management System) Metadaten-Standards für Audits und Versionierung.

1. **Bottom-Up:** `configs.nix` und `ports.nix` werden zuerst geladen.
2. **Middle:** `lib-helpers.nix` nutzt die SSoT-Werte, um die `mkService` Logik zu bauen.
3. **Top-Down:** Alle Dateien in Layern >00 importieren `lib-helpers.nix` und rufen `mkService` auf.

``n---
### [F-030] docs\superpowers\specs\2026-04-28-navidrome-integration-design.md
* Pfad: docs\superpowers\specs\2026-04-28-navidrome-integration-design.md | Format: .md | Größe: 1,96 KB
``md
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Approved (User)

Integrate Navidrome as the primary audio streaming server into the NixOS home lab environment. This completes the "Media Beast" profile by providing a dedicated music streaming solution alongside Jellyfin and Audiobookshelf.

- **Architecture:** Horizontal Responsibility (v5.0).
- **Hardening:** hardened (SSO, LAN Bypass, Systemd hardening).
- **Storage:** ABC-Tiering (Tier A for State, Tier B for Cache, Tier C for Bulk Media).
- **Patterns:** Use `myLib.mkStreamer` factory.
- **Port:** 4533 (Already registered in `ports.nix`).

- **Options:** `my.apps.navidrome.enable`, paths (Tier A/B/C), user/group settings.
- **Factory Integration:** Calls `mkStreamer` with `useGPU = false`.
- **Hardening:** `ReadOnlyPaths` for music library, systemd sandbox (via factory).
- **Caddy:** Subdomain `music.nix.m7c5.de` aliased to the auto-generated `navidrome` host.
- **Persistence:** Mount `/var/lib/navidrome` to `/persist`.

- Add `navidrome` to `users.groups.media.members` to ensure consistent GID-based access to shared media folders.

- Import `service-app-navidrome.nix`.
- Enable the service: `my.apps.navidrome.enable = true`.

1. Create the Navidrome module.
2. Update `media-stack.nix` members list.
3. Update `media-beast.nix` imports and toggles.
4. Validation via `nixos-rebuild test`.

- Navidrome runs as a system user.
- Network confinement: Restricted to localhost + Caddy proxy.
- File system: Restricted writes to state and cache dirs only.
- Resource limits: 1G RAM, 60 CPU weight.

``n---
### [F-031] docs\superpowers\specs\2026-04-28-persist-backup-design.md
* Pfad: docs\superpowers\specs\2026-04-28-persist-backup-design.md | Format: .md | Größe: 1,18 KB
``md
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Approved

Implement a direct-to-cloud backup for the `/persist` directory (Tier A) using Restic and Backblaze B2 (S3 API). This provides offsite redundancy for the system's most critical data.

- **New Secrets:**
 - `restic_password`: Master encryption key.
 - `backblaze_access_key`: B2 Key ID.
 - `backblaze_secret_key`: B2 Application Key.
- **New Template:** `backblaze-restic.env` providing `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for Restic.

- **New Job:** `services.restic.backups.persist`.
- **Target:** S3 endpoint (Backblaze B2).
- **Retention:**
 - Daily: 7 snapshots.
 - Weekly: 4 snapshots.
 - Monthly: 6 snapshots.
- **Timer:** Daily at 03:00.

1. Update `modules/core/secrets.nix` to include new secrets and the environment template.
2. Update `modules/core/backup.nix` to include the `persist` Restic job.
3. Verify syntax and dependencies.

``n---
### [F-032] docs\superpowers\specs\2026-04-28-vector-logging-design.md
* Pfad: docs\superpowers\specs\2026-04-28-vector-logging-design.md | Format: .md | Größe: 1,68 KB
``md
- **Date:** 2026-04-28
- **Author:** Gemini CLI
- **Status:** Draft

Implement a persistent logging pipeline that survives reboots (surmounting the current `volatile` journald restriction) while maintaining high system performance.

- **Architecture:** Horizontal Responsibility (v5.0).
- **Hardening:** hardened (Sensitive data masking).
- **Storage:** Tier B (SSD) for log archives to avoid NVMe wear and RAM usage.
- **Framework:** Vector (Lightweight, Go/Rust-based).

- **Source:** Pulls from `journald`.
- **Transform:** 
 - Masking of `/mnt/media`, `/mnt/hdd_pool`, `/mnt/tierC`.
 - Masking of filenames (mkv, mp4, etc.).
 - Masking of API keys (32+ chars).
- **Sink:** 
 - Local file on Tier B (`${srePaths.tierB}/logs/vector/journal-%Y-%m-%d.log.gz`).
 - Format: NDJSON.
 - Compression: GZIP.
- **Rotation:** 14-day retention via `find` script and `systemd.timer`.

- **Profile:** `profiles/base-server.nix`.
- **Action:** Replace `modules/core/logging.nix` import with `modules/logging/vector-tier-b.nix`.
- **Toggle:** `my.logging.vector.enable = true;`.

1. Create `modules/logging` directory.
2. Create `vector-tier-b.nix` with the approved code.
3. Update `profiles/base-server.nix` imports.
4. Enable the service in `profiles/base-server.nix`.
5. Run `nix-instantiate` to verify.

- S3 Sink for long-term offsite archiving.
- Gatus integration for log-based health alerts.

``n---
### [F-033] hardware\q958\hardware-configuration.nix
* Pfad: hardware\q958\hardware-configuration.nix | Format: .nix | Größe: 2,07 KB
``nix
{
 config,
 lib,
 pkgs,
 modulesPath,
 myLib,
 ...
}: let

 nms = {
 id = "NIXH-01-HW-Q958-CFG";
 title = "Hardware Configuration (Fujitsu Q958)";
 description = "Physical identity and board-specific settings for Fujitsu Esprimo Q958.";
 layer = 1;
 nixpkgs.category = "system/boot";
 capabilities = ["system/hardware" "hardware/q958" "sensors/nct6775"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.host_q958_hardware_configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [(modulesPath + "/installer/scan/not-detected.nix")];

 config = {

 boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "nvme"];
 boot.initrd.kernelModules = [];

 boot.kernelModules = [ 
 "kvm-intel" 
 "nct6775" # Mainboard Sensors (Fan/Temp)
 "coretemp" # CPU Sensors
 ];

 boot.kernelParams = [

 "acpi_enforce_resources=lax"
 ];

 boot.extraModulePackages = [];

 fileSystems."/" = {
 device = "/dev/disk/by-uuid/8d1d5128-6413-4b5b-bd96-e55851ae5dc2";
 fsType = "ext4";
 };

 fileSystems."/boot" = {
 device = "/dev/disk/by-uuid/B413-DB53";
 fsType = "vfat";
 options = ["fmask=0077" "dmask=0077"];
 };

 swapDevices = [];

 nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}

``n---
### [F-034] hardware\q958\hardware-profile.nix
* Pfad: hardware\q958\hardware-profile.nix | Format: .nix | Größe: 3,22 KB
``nix
{ config, lib, pkgs, myLib, ... }: 
let
 cfg = config.my.hardware;
in
{

 imports = [
 ../../modules/storage/storage-mover.nix
 ];

 config = lib.mkIf (cfg.profile == "q958") {

 my.storage.mover.enable = true;

 boot.kernelPackages = pkgs.linuxPackages_latest; # Latest kernel for best CFL support

 boot.kernelParams = [
 "quiet"
 "mitigations=auto"

 "acpi_osi=Linux" # Better power management (Fragment 975)
 "i915.enable_guc=3" # GuC/HuC Firmware for QSV/HEVC (Fragment 2272)
 "i915.enable_fbc=1" # Frame Buffer Compression (Saves power)
 "i915.fastboot=1" # Cleaner boot transition
 "intel_idle.max_cstate=4" # Balance between power saving and C-state exit latency stability
 "ibt=off" # Disable Indirect Branch Tracking (Workaround for some CFL issues)
 "intel_pstate=passive" # Use passive mode to allow TLP/thermald better control
 ];

 boot.kernelModules = [ "kvm_intel" ];

 hardware.graphics = {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver # Modern VAAPI for Broadwell+ (Fragment 4899)
 vpl-gpu-rt # OneVPL runtime for QSV
 libvdpau-va-gl # VDPAU to VAAPI bridge
 ];
 };

 environment.variables.LIBVA_DRIVER_NAME = "iHD"; # Fragment 2272

 services.thermald.enable = true; # Intel Thermal Daemon (Fragment 2291)

 services.tlp = {
 enable = true; # Fragment 2292
 settings = {

 CPU_SCALING_GOVERNOR_ON_AC = "powersave";
 CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
 PCIE_ASPM_ON_AC = "performance"; # Prioritize I/O stability on AC
 START_CHARGE_THRESH_BAT8 = 75; # Not relevant for Q958 desktop but good practice in profiles
 STOP_CHARGE_THRESH_BAT8 = 80;
 };
 };

 boot.kernel.sysctl = {
 "vm.swappiness" = myLib.mkTracedOption "NIXH-HW-001" (lib.mkOption { 
 type = lib.types.int; default = 10; 
 }).default;

 "kernel.nmi_watchdog" = 0; # Save power by disabling NMI watchdog

 "fs.protected_symlinks" = 1;
 "fs.protected_hardlinks" = 1;

 "kernel.kptr_restrict" = 2;
 };

 zramSwap.enable = true; # Fragment 4937
 swapDevices = []; # Prefer ZRAM over SSD wear (Fragment 731)

 hardware.cpu.intel.updateMicrocode = true;
 };
}

``n---
### [F-035] hardware\q958\README.md
* Pfad: hardware\q958\README.md | Format: .md | Größe: 2,19 KB
``md
This directory contains the "Hardware-Geist" (Physical Identity) of the Fujitsu Esprimo Q958 system.

- **CPU:** Intel Core i3-9100 (Coffee Lake / 4 Cores / 4 Threads)
- **GPU:** Intel UHD Graphics 630 (9.5th Gen)
- **Chipset:** Intel Q370
- **NIC:** Intel I219-LM (Gigabit)
- **Storage:** NVMe SSD + SATA AHCI
- **Sensor Chip:** Nuvoton NCT6775

In accordance with **ADR-001 (Hardware-Geist Separation)**, all physical identifiers (UUIDs, PCIe paths, firmware) are isolated here. The Core logic (Layer 00) remains "pure" and hardware-agnostic.

- **Driver:** Using `intel-media-driver` (iHD) instead of the older `vaapi-intel` (i965) for modern Gen 9 support.
- **Firmware:** `i915.enable_guc=3` enables GuC/HuC loading, required for low-power HEVC decoding/encoding and hardware-accelerated scheduling.
- **Environment:** `LIBVA_DRIVER_NAME=iHD` is forced globally to ensure applications like Jellyfin use the modern VAAPI path.

- **TLP & Thermald:** TLP handles the power profiles (set to `powersave` governor for intel_pstate), while Thermald prevents thermal throttling on the small form factor (SFF) chassis.
- **C-States:** `intel_idle.max_cstate=4` is used as a stability compromise. Deep C-states (C6/C7) can sometimes cause hangs on these Fujitsu boards during idle.
- **ASPM:** PCIe ASPM is enabled but set to `performance` on AC to prevent network/storage latency spikes.

- **Module:** `nct6775` provides fan speed and voltage monitoring.
- **Kernel Fix:** `acpi_enforce_resources=lax` is required because the BIOS/ACPI reserves the sensor address space, preventing the Linux kernel driver from accessing it. This is safe on this specific Fujitsu hardware.

- **ZRAM:** Prioritized over physical swap to reduce SSD wear and improve responsiveness under OOM conditions.
- **Sysctl:** `vm.swappiness=10` ensures the system only swaps to ZRAM when absolutely necessary.

*Last Audit: 2026-04-27 | Status: hardened*

``n---
### [F-036] hardware\q958\registry.nix
* Pfad: hardware\q958\registry.nix | Format: .nix | Größe: 218 B
``nix
{ lib, ... }: {
 options.my.profiles.hardware = {
 q958.enable = lib.mkOption {
 type = lib.types.bool;
 default = true;
 description = "Enable Fujitsu Q958 hardware profile";
 };
 };
}

``n---
### [F-037] modules\apps\automation.nix
* Pfad: modules\apps\automation.nix | Format: .nix | Größe: 1,08 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-30-AUT-001";
 title = "Automation";
 description = "Core automation settings, including sudo rules for rebuilds and maintenance.";
 layer = 20;
 nixpkgs.category = "system/settings";
 capabilities = [ "system/maintenance" "security/sudo-rules" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 bastelmodus = config.my.configs.bastelmodus;
 user = config.my.configs.identity.user;
in
{
 options.my.meta.automation = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for automation module";
 };

 config = {
 security.sudo.extraRules = [
 {
 users = [ user ];
 commands = [
 { command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
 { command = "${pkgs.nix}/bin/nix"; options = [ "NOPASSWD" ]; }
 { command = "ALL"; options = lib.mkIf bastelmodus [ "NOPASSWD" ]; }
 ];
 }
 ];
 };
}

``n---
### [F-038] modules\apps\media-stack.nix
* Pfad: modules\apps\media-stack.nix | Format: .nix | Größe: 1,67 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-40-MED-001";
 title = "Media Stack (Exhausted Layout)";
 description = "Canonical data/state layout with ABC-tiering enforcement and global media permissions.";
 layer = 40;
 nixpkgs.category = "system/storage";
 capabilities = [ "storage/layout" "security/permissions" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 srePaths = config.my.configs.paths;
in
{
 options.my.meta.media_stack = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for media-stack module";
 };

 config = lib.mkIf config.my.services.mediaStack.enable {
 users.groups.media = { gid = 169; };
 users.groups.media.members = [ "jellyfin" "sabnzbd" "audiobookshelf" "sonarr" "radarr" "lidarr" "readarr" "prowlarr" "navidrome" ];
 systemd.tmpfiles.rules = [
 "d ${srePaths.mediaLibrary} 0775 root media -"
 "d ${srePaths.mediaLibrary}/movies 0775 radarr media -"
 "d ${srePaths.mediaLibrary}/tv 0775 sonarr media -"
 "d ${srePaths.mediaLibrary}/music 0775 lidarr media -"
 "d ${srePaths.mediaLibrary}/books 0775 readarr media -"
 "d ${srePaths.mediaLibrary}/documents 0775 paperless media -"
 "d ${srePaths.storagePool}/downloads 0775 root media -"
 "d ${srePaths.storagePool}/downloads/torrents 0775 prowlarr media -"
 "d ${srePaths.storagePool}/downloads/usenet 0775 sabnzbd media -"
 "d ${srePaths.stateDir} 0755 root root -"
 "d /mnt/fast-pool/metadata 0775 root media -"
 "d /mnt/fast-pool/cache 0775 root media -"
 ];
 };
}

``n---
### [F-039] modules\apps\service-app-ai-agents.nix
* Pfad: modules\apps\service-app-ai-agents.nix | Format: .nix | Größe: 1,57 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-30-AUT-002";
 title = "Ai Agents (Ollama & Claude)";
 description = "Local AI orchestration with Ollama (GPU-accelerated) and Claude Code.";
 layer = 20;
 nixpkgs.category = "services/misc";
 capabilities = [ "ai/ollama" "ai/claude-code" "gpu/acceleration" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 kimiClaudeScript = pkgs.writeShellScriptBin "kimi-claude" "echo ' Starting AI...'; ${pkgs.ollama}/bin/ollama run kimi-k2.5:cloud; ${pkgs.nodejs_22}/bin/npx -y @anthropic-ai/claude-code --model kimi-k2.5:cloud";
in
{
 options.my.meta.ai_agents = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for ai-agents module";
 };

 config = lib.mkIf config.my.services.aiAgents.enable {
 services.ollama = {
 enable = true;
 package = if config.my.configs.hardware.intelGpu then pkgs.ollama-vulkan else pkgs.ollama;
 loadModels = [ "kimi-k2.5:cloud" ];
 };
 environment.systemPackages = [ kimiClaudeScript pkgs.ollama pkgs.nodejs_22 ];
 programs.bash.shellAliases.kimi = "kimi-claude";
 systemd.services.ollama.serviceConfig = { DeviceAllow = [ "/dev/dri/renderD128 rw" ]; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; OOMScoreAdjust = 500; };
 };
}

``n---
### [F-040] modules\apps\service-app-ai-tools.nix
* Pfad: modules\apps\service-app-ai-tools.nix | Format: .nix | Größe: 1,96 KB
``nix
{ pkgs, lib, config, ... }:
let

 nms = {
 id = "NIXH-00-COR-002";
 title = "AI Tools (SRE Assisted)";
 description = "Optimized terminal environment for AI-assisted development and SRE tasks.";
 layer = 00;
 nixpkgs.category = "tools/admin";
 capabilities = [ "ai/workflow" "shell/enhancement" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.ai_tools = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for ai-tools module";
 };

 options.my.tools.ai.enable = lib.mkEnableOption "AI Tools (aider, uv, etc.)";

 config = lib.mkIf config.my.tools.ai.enable {

 environment.systemPackages = with pkgs; [
 aider-chat uv python3 blesh inshellisense fzf jq curl
 ];

 programs.bash.interactiveShellInit = ''

 if [[ -f ${pkgs.blesh}/share/blesh/ble.sh ]]; then
 source ${pkgs.blesh}/share/blesh/ble.sh
 bleopt edit_multi_line=0 2>/dev/null || true
 fi

 if command -v inshellisense > /dev/null; then
 alias gemini-hint='inshellisense bind gemini -- gemini'

 alias p-graph='python3 /etc/nixos/scripts/generate-mermaid.py'
 fi
 '';
 };
}

``n---
### [F-041] modules\apps\service-app-audiobookshelf.nix
* Pfad: modules\apps\service-app-audiobookshelf.nix | Format: .nix | Größe: 3,88 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-ABS-001";
 title = "Audiobookshelf (hardened)";
 description = "Hardened Audiobook & Podcast server with ABC-Tiering and specialized cache.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/audiobooks" "media/podcasts" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.apps.audiobookshelf;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

in
{
 options.my.meta.audiobookshelf = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.audiobookshelf = {
 enable = lib.mkEnableOption "Audiobookshelf media server";
 user = lib.mkOption { type = lib.types.str; default = "audiobookshelf"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.audiobookshelf or 20081; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/audiobookshelf"; 
 description = "Database and metadata (Tier A/Persist)";
 };
 audiobookDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.mediaLibrary}/audiobooks";
 description = "Audiobook library (Tier C)";
 };
 podcastDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.mediaLibrary}/podcasts";
 description = "Podcast library (Tier C)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "audiobookshelf";
 port = cfg.port;
 useGPU = false; # Audiobookshelf uses CPU for transcoding
 memoryMax = "2G";
 cpuWeight = 70;
 oomScoreAdjust = 350;
 description = "Audiobookshelf Instance";
 })

 {

 services.caddy.virtualHosts."abs.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" = 
 config.services.caddy.virtualHosts."audiobookshelf.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 services.audiobookshelf = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 dataDir = cfg.stateDir;
 port = cfg.port;
 host = "127.0.0.1";
 };

 systemd.services.audiobookshelf = {

 serviceConfig = {

 ReadWritePaths = [
 cfg.stateDir
 cfg.audiobookDir
 cfg.podcastDir
 ];

 MemoryDenyWriteExecute = false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.audiobookDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${cfg.podcastDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/audiobookshelf" ];
 };
 }
 ]);
}

``n---
### [F-042] modules\apps\service-app-couchdb.nix
* Pfad: modules\apps\service-app-couchdb.nix | Format: .nix | Größe: 1,42 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-60-APP-002";
 title = "CouchDB (hardened)";
 description = "Hardened NoSQL database for Obsidian LiveSync.";
 layer = 60;
 nixpkgs.category = "services/databases";
 capabilities = [ "database/nosql" "obsidian/sync" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };

 cfg = config.my.services.couchdb;
 port = 5984; # CouchDB standard port

in
{
 options.my.meta.couchdb = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config port;
 name = "couchdb";
 description = "CouchDB NoSQL Database";
 useSSO = true; # Protected via SSO for web access (Fauxton)
 persist = true;
 })

 {
 services.couchdb = {
 enable = true;
 bindAddress = "127.0.0.1";
 };
 }
 ]);
}

``n---
### [F-043] modules\apps\service-app-filebrowser.nix
* Pfad: modules\apps\service-app-filebrowser.nix | Format: .nix | Größe: 1,30 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-60-APP-003";
 title = "Filebrowser (SRE Hardened)";
 description = "Web-based file manager with strict path restrictions and sandboxing.";
 layer = 60;
 nixpkgs.category = "services/web-apps";
 capabilities = [ "web/file-management" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.filebrowser;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.filebrowser = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for filebrowser module";
 };

 config = lib.mkIf config.my.services.filebrowser.enable {
 services.filebrowser = { enable = true; settings = { port = port; address = "127.0.0.1"; root = "/mnt/storage"; }; };
 services.caddy.virtualHosts."files.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.filebrowser.serviceConfig = { ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; ReadWritePaths = [ "/var/lib/filebrowser" "/mnt/storage" ]; NoNewPrivileges = true; SystemCallFilter = [ "@system-service" "~@privileged" ]; };
 };
}

``n---
### [F-044] modules\apps\service-app-home-assistant.nix
* Pfad: modules\apps\service-app-home-assistant.nix | Format: .nix | Größe: 6,11 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-HASS-001";
 title = "Home Assistant (hardened)";
 description = "Hardened Home Automation with ABC-Tiering and Secret-Isolation.";
 layer = 30;
 nixpkgs.category = "services/home-automation";
 capabilities = ["home-automation/hass" "iot/mqtt" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.home-assistant;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

 isUsbDevice = lib.hasPrefix "/dev/" cfg.zigbeeDevice;

in
{
 options.my.meta.home_assistant = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.home-assistant = {
 enable = lib.mkEnableOption "Home Assistant (IoT)";
 user = lib.mkOption { type = lib.types.str; default = "hass"; };
 group = lib.mkOption { type = lib.types.str; default = "hass"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.home-assistant or 8123; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/home-assistant"; 
 description = "Configuration and primary DB (Tier A/Persist)";
 };
 cacheDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/cache/home-assistant";
 description = "Python bytecode and temp cache (Tier B)";
 };
 mediaDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.mediaLibrary}/home-assistant";
 description = "Media archive for recordings/snapshots (Tier C)";
 };

 zigbeeDevice = lib.mkOption { 
 type = lib.types.str; 
 default = "socket://192.168.2.46:6638"; 
 description = "Zigbee adapter path or socket";
 };
 bluetooth = lib.mkOption { type = lib.types.bool; default = false; };

 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to HA Secrets (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "home-assistant";
 port = cfg.port;
 useSSO = true;
 description = "Home Assistant Core";
 persist = true;
 readWritePaths = [ cfg.stateDir cfg.cacheDir cfg.mediaDir ];
 })

 {

 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "dialout" "video" "media" ] ++ (lib.optional cfg.bluetooth "bluetooth");
 };
 users.groups.${cfg.group} = {};

 services.home-assistant = {
 enable = true;
 configDir = cfg.stateDir;
 extraComponents = [ 
 "default_config" "met" "esphome" "prometheus" "mobile_app" 
 "sun" "radio_browser" "google_translate" "mqtt" 
 ];
 config = {
 homeassistant = {
 name = "NixHome";
 unit_system = "metric";
 time_zone = sreConfig.locale.timezone;
 external_url = "https://home.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";
 internal_url = "http://localhost:${toString cfg.port}";
 };

 mqtt = {
 broker = "127.0.0.1";
 port = config.my.ports.mqtt or 1883;
 };
 http = {
 use_x_forwarded_for = true;
 trusted_proxies = [ "127.0.0.1" "::1" ] ++ sreConfig.network.tailnetCidrs;
 };
 };
 };

 systemd.services.home-assistant = {
 description = "Home Assistant Core (hardened)";

 environment.PYTHONPYCACHEPREFIX = "${cfg.cacheDir}/pycache";

 serviceConfig = {

 LoadCredential = lib.optional (cfg.secretFile != null) "HA_SECRET:${toString cfg.secretFile}";

 MemoryMax = "2G";
 CPUWeight = 70;
 OOMScoreAdjust = 300;

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 PrivateDevices = if isUsbDevice || cfg.bluetooth then lib.mkForce false else true;
 DeviceAllow = (lib.optional isUsbDevice "${cfg.zigbeeDevice} rw")
 ++ (lib.optional cfg.bluetooth "/dev/rfkill rw")
 ++ [ "/dev/dri/renderD128 rw" ]; # Hardware Transcoding (selten gebraucht)

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir}/pycache 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.mediaDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/home-assistant" ];
 };
 }
 ]);
}

``n---
### [F-045] modules\apps\service-app-karakeep.nix
* Pfad: modules\apps\service-app-karakeep.nix | Format: .nix | Größe: 1,44 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-60-APP-004";
 title = "Karakeep (hardened)";
 description = "Hardened bookmark management tool with SRE sandboxing.";
 layer = 60;
 nixpkgs.category = "web/apps";
 capabilities = [ "web/bookmarks" "security/sandboxing" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };

 cfg = config.my.services.karakeep;
 port = config.my.ports.karakeep;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.karakeep = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config port;
 name = "karakeep";
 description = "Karakeep Bookmark Manager";
 useSSO = true;
 persist = true;
 readWritePaths = [ 
 "${srePaths.stateDir}/karakeep"
 "${srePaths.tierB}/cache/karakeep"
 ];
 })

 {
 services.karakeep = {
 enable = true;
 extraEnvironment = {
 PORT = toString port;
 DISABLE_SIGNUPS = "true";
 };
 };
 }
 ]);
}

``n---
### [F-046] modules\apps\service-app-linkding.nix
* Pfad: modules\apps\service-app-linkding.nix | Format: .nix | Größe: 821 B
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-50-KNW-001";
 title = "Linkding";
 description = "Bookmark manager (Placeholder - Not yet implemented).";
 layer = 50;
 nixpkgs.category = "web/apps";
 capabilities = [ "web/bookmarks" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.linkding = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for linkding module";
 };

 config = lib.mkIf config.my.services.linkding.enable {

 };
}

``n---
### [F-047] modules\apps\service-app-linkwarden.nix
* Pfad: modules\apps\service-app-linkwarden.nix | Format: .nix | Größe: 2,03 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let
 nms = {
 id = "NIXH-50-KNW-005";
 title = "Linkwarden (SRE Hardened)";
 description = "Collaborative bookmark manager with automatic archiving and DynamicUser sandboxing.";
 layer = 50;
 nixpkgs.category = "services/web-apps";
 capabilities = ["web/bookmarks" "archive/offline" "security/sandboxing"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 port = config.my.ports.linkwarden or 3000;
 domain = config.my.configs.identity.domain;

in {
 options.my.meta.linkwarden = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for linkwarden module";
 };

 options.my.services.linkwarden = {
 enable = lib.mkEnableOption "Linkwarden";
 };

 config = lib.mkIf config.my.services.linkwarden.enable {
 services.linkwarden = {
 enable = true;
 environment = {
 NEXTAUTH_URL = "https://links.${domain}/api/v1/auth";
 };
 };

 services.caddy.virtualHosts."links.${domain}" = {
 extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}";
 };

 systemd.services.linkwarden = {
 serviceConfig = {
 DynamicUser = true;
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 SystemCallFilter = ["@system-service" "~@privileged"];
 OOMScoreAdjust = 300;
 StateDirectory = "linkwarden";
 };
 };
 };
}

``n---
### [F-048] modules\apps\service-app-matrix-conduit.nix
* Pfad: modules\apps\service-app-matrix-conduit.nix | Format: .nix | Größe: 1,99 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-60-APP-005";
 title = "Matrix Conduit";
 description = "Lightweight Matrix homeserver (Conduit) written in Rust.";
 layer = 60;
 nixpkgs.category = "services/matrix";
 capabilities = [ "communication/matrix" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 myLib = import ../core/lib-helpers.nix { inherit lib; };
 port = config.my.ports.matrix;
 domain = config.my.configs.identity.domain;
 subdomain = config.my.configs.identity.subdomain;
 serverName = "matrix.${subdomain}.${domain}";
 serviceBase = myLib.mkService { inherit config; name = "matrix"; port = port; useSSO = false; description = "Matrix Homeserver (Conduit)"; };
in
{
 options.my.meta.matrix_conduit = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for matrix-conduit module";
 };

 config = lib.mkIf config.my.services.matrixConduit.enable (lib.mkMerge [
 (lib.filterAttrs (n: v: n != "systemd") serviceBase)
 {
 services.matrix-conduit = { enable = true; settings.global = { server_name = serverName; port = port; address = "127.0.0.1"; database_backend = "rocksdb"; allow_registration = true; }; };
 systemd.services.conduit = { serviceConfig = lib.mkMerge [ serviceBase.systemd.services.matrix.serviceConfig { StateDirectory = lib.mkForce "matrix-conduit"; ReadWritePaths = lib.mkForce [ "/var/lib/matrix-conduit" ]; MemoryDenyWriteExecute = lib.mkForce false; CPUWeight = lib.mkForce 50; MemoryMax = lib.mkForce "1G"; } ]; };
 services.caddy.virtualHosts."${serverName}".extraConfig = lib.mkAfter "handle /.well-known/matrix/server { ... } handle /.well-known/matrix/client { ... }"; # Shortened
 }
 ]);
}

``n---
### [F-049] modules\apps\service-app-miniflux.nix
* Pfad: modules\apps\service-app-miniflux.nix | Format: .nix | Größe: 1,64 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-50-KNW-002";
 title = "Miniflux (SRE Exhausted)";
 description = "Minimalist RSS reader with Wake-on-Access (Socket Activation).";
 layer = 50;
 nixpkgs.category = "services/web-apps";
 capabilities = [ "web/rss" "security/socket-activation" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.miniflux;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.miniflux = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for miniflux module";
 };

 config = lib.mkIf config.my.services.miniflux.enable {
 services.miniflux = {
 enable = true; config = { LISTEN_ADDR = "fd://3"; WATCHDOG = 1; RUN_MIGRATIONS = 1; ADMIN_USERNAME = "admin"; };
 createDatabaseLocally = true; adminCredentialsFile = config.sops.secrets.miniflux_admin_password.path;
 };
 systemd.sockets.miniflux = { description = "Miniflux Socket"; wantedBy = [ "sockets.target" ]; listenStreams = [ (toString port) ]; };
 systemd.services.miniflux = {
 wantedBy = lib.mkForce [ ]; requires = [ "miniflux.socket" ]; after = [ "miniflux.socket" ];
 serviceConfig = { DynamicUser = true; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; SystemCallFilter = [ "@system-service" "~@privileged" ]; OOMScoreAdjust = 500; };
 };
 };
}

``n---
### [F-050] modules\apps\service-app-monica.nix
* Pfad: modules\apps\service-app-monica.nix | Format: .nix | Größe: 1,44 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-60-APP-006"; title = "Monica"; description = "Personal CRM."; layer = 60; nixpkgs.category = "services/web-apps"; capabilities = [ "web/crm" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 3; };
 port = config.my.ports.monica;
 domain = config.my.configs.identity.domain;
 appKeyFile = "/var/lib/monica/app-key";
in
{
 options.my.meta.monica = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf config.my.services.monica.enable {
 services.monica = { enable = true; hostname = "monica.${domain}"; appURL = "https://monica.${domain}"; inherit appKeyFile; nginx.listen = [ { addr = "127.0.0.1"; port = port; ssl = false; } ]; database.createLocally = true; };
 services.caddy.virtualHosts."monica.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 system.activationScripts.monicaAppKeyFile.text = "install -d -m 0750 -o monica -g monica /var/lib/monica; if [ ! -s ${appKeyFile} ]; then head -c 32 /dev/urandom | base64 > ${appKeyFile}; fi";
 systemd.services.phpfpm-monica.serviceConfig = { ProtectSystem = lib.mkForce "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; ReadWritePaths = [ "/var/lib/monica" ]; };
 };
}

``n---
### [F-051] modules\apps\service-app-n8n.nix
* Pfad: modules\apps\service-app-n8n.nix | Format: .nix | Größe: 5,95 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-N8N-001";
 title = "n8n Workflow Automation (hardened)";
 description = "Hardened n8n instance with Postgres backend and Secret-Isolation.";
 layer = 30;
 nixpkgs.category = "services/misc";
 capabilities = ["automation/workflows" "security/sandboxing" "database/postgres"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.n8n;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

in
{
 options.my.meta.n8n = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.n8n = {
 enable = lib.mkEnableOption "n8n Workflow Automation";
 user = lib.mkOption { type = lib.types.str; default = "n8n"; };
 group = lib.mkOption { type = lib.types.str; default = "n8n"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.n8n or 20017; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/n8n"; 
 description = "Database and binary state (Tier A/Persist)";
 };
 cacheDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/cache/n8n";
 description = "Workflow execution cache (Tier B)";
 };

 database = {
 type = lib.mkOption { 
 type = lib.types.enum [ "sqlite" "postgres" ]; 
 default = "postgres"; 
 description = "Backend database engine";
 };
 };

 encryptionKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to n8n Encryption Key (via Sops)";
 };

 memoryMax = lib.mkOption { type = lib.types.str; default = "2G"; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "n8n";
 port = cfg.port;
 useSSO = true;
 description = "n8n Workflow Automation";
 persist = true;
 readWritePaths = [ cfg.stateDir cfg.cacheDir ];
 })

 {

 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };
 users.groups.${cfg.group} = {};

 services.n8n = {
 enable = true;

 };

 systemd.services.n8n = {
 description = "n8n Workflow Engine (hardened)";
 after = [ "network.target" ] ++ (lib.optional (cfg.database.type == "postgres") "postgresql.service");

 environment = {
 N8N_PORT = toString cfg.port;
 N8N_HOST = "127.0.0.1";
 N8N_EDITOR_BASE_URL = "https://n8n.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";
 N8N_NODE_OPTIONS = "--max-old-space-size=2048";

 EXECUTIONS_DATA_PRUNE = "true";
 EXECUTIONS_DATA_MAX_AGE = "336"; # 14 days

 N8N_USER_FOLDER = cfg.stateDir;
 } // (lib.optionalAttrs (cfg.database.type == "postgres") {
 DB_TYPE = "postgresdb";
 DB_POSTGRESDB_DATABASE = "n8n";
 DB_POSTGRESDB_HOST = "/run/postgresql";
 DB_POSTGRESDB_USER = "n8n";
 });

 serviceConfig = {
 User = cfg.user;
 Group = cfg.group;

 LoadCredential = lib.optional (cfg.encryptionKeyFile != null) "N8N_ENCRYPTION_KEY:${toString cfg.encryptionKeyFile}";

 MemoryMax = cfg.memoryMax;
 CPUWeight = 50;
 OOMScoreAdjust = 300;

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 NoNewPrivileges = true;

 MemoryDenyWriteExecute = false; # Needed for Node.js JIT

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
 };
 };

 services.postgresql = lib.mkIf (cfg.database.type == "postgres") {
 ensureDatabases = [ "n8n" ];
 ensureUsers = [ {
 name = "n8n";
 ensureDBOwnership = true;
 } ];
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/n8n" ];
 };
 }
 ]);
}

``n---
### [F-052] modules\apps\service-app-navidrome.nix
* Pfad: modules\apps\service-app-navidrome.nix | Format: .nix | Größe: 2,60 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let
 nms = {
 id = "NIXH-01-APP-NAV-001";
 title = "Navidrome (hardened Music Server)";
 layer = 40;
 audit.last_reviewed = "2026-04-28";
 };
 cfg = config.my.apps.navidrome;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;
in
{
 options.my.apps.navidrome = {
 enable = lib.mkEnableOption "Navidrome Music Server";
 user = lib.mkOption { type = lib.types.str; default = "navidrome"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.navidrome or 4533; };
 stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/navidrome"; };
 cacheDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/cache/navidrome"; };
 musicDir = lib.mkOption { type = lib.types.str; default = "${srePaths.mediaLibrary}/music"; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "navidrome";
 port = cfg.port;
 useGPU = false;
 memoryMax = "1G";
 cpuWeight = 60;
 description = "Navidrome Music Streaming";
 })

 {
 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };

 services.navidrome = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 address = "127.0.0.1";
 port = cfg.port;
 musicFolder = cfg.musicDir;
 dataFolder = cfg.stateDir;
 cacheFolder = cfg.cacheDir;
 settings.EnableSubsonicApi = true;
 };

 services.caddy.virtualHosts."music.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" =
 config.services.caddy.virtualHosts."navidrome.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.navidrome.serviceConfig.ReadOnlyPaths = [ cfg.musicDir ];

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist".directories = [
 "/var/lib/navidrome"
 ];
 }
 ]);
}

``n---
### [F-053] modules\apps\service-app-olivetin.nix
* Pfad: modules\apps\service-app-olivetin.nix | Format: .nix | Größe: 3,39 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-30-AUT-005";
 title = "OliveTin (SRE Exhausted)";
 description = "Web-based control panel with Wake-on-Access (Socket Activation) and secure command pinning.";
 layer = 30;
 nixpkgs.category = "web/apps";
 capabilities = ["automation/shell" "system/control-panel" "security/socket-activation"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 port = config.my.ports.olivetin;
 mtlsGenScript = "/etc/nixos/00-core/scripts/mtls-generator.sh";
 sopsScript = "/etc/nixos/00-core/scripts/add-sops-secret.sh";
in {
 options.my.meta.olivetin = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for olivetin module";
 };

 config = lib.mkIf config.my.services.olivetin.enable {
 services.olivetin = {
 enable = true;
 path = with pkgs; [
 bash
 openssl
 jq
 coreutils
 gnused
 systemd
 nixos-rebuild
 nix-output-monitor
 curl
 sops
 ];
 settings = {
 ListenAddressSingleHTTPFrontend = "127.0.0.1:${toString port}";
 actions = [
 {
 title = "SOPS: Neues Secret";
 shell = "sudo ${sopsScript} '{{ secret_key }}' '{{ secret_value }}'";
 icon = "&#128272;";
 arguments = [
 {
 name = "secret_key";
 type = "ascii";
 }
 {
 name = "secret_value";
 type = "ascii";
 }
 ];
 }
 {
 title = "mTLS: Client Zertifikat erstellen";
 shell = "sudo ${mtlsGenScript} '{{ client_name }}'";
 icon = "";
 arguments = [
 {
 name = "client_name";
 type = "ascii";
 }
 ];
 }
 {
 title = "System Update";
 shell = "sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch 2>&1 | ${pkgs.nix-output-monitor}/bin/nom";
 icon = "&#128259;";
 }
 ];
 };
 };

 systemd.sockets.olivetin = {
 description = "OliveTin Socket";
 wantedBy = ["sockets.target"];
 listenStreams = [(toString port)];
 };

 systemd.services.olivetin = {
 wantedBy = lib.mkForce [];
 requires = ["olivetin.socket"];
 after = ["olivetin.socket"];
 };

 security.sudo.extraRules = [
 {
 users = ["olivetin"];
 commands = [
 {
 command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
 options = ["NOPASSWD"];
 }
 {
 command = mtlsGenScript;
 options = ["NOPASSWD"];
 }
 ];
 }
 ];

 systemd.tmpfiles.rules = [
 "d /var/www/landing-zone/certs 0755 caddy caddy -"
 ];
 };
}

``n---
### [F-054] modules\apps\service-app-paperless.nix
* Pfad: modules\apps\service-app-paperless.nix | Format: .nix | Größe: 3,38 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-PAP-002";
 title = "Paperless-ngx (hardened)";
 description = "Hardened document management system with Valkey and PostgreSQL.";
 layer = 50;
 nixpkgs.category = "services/misc";
 capabilities = ["knowledge/documents" "security/sandboxing" "database/postgres" "caching/valkey"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.paperless;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.paperless = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.paperless = {
 enable = lib.mkEnableOption "Paperless-ngx Document Management";
 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Paperless Secret Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkDocumentApp {
 inherit config;
 name = "paperless";
 port = config.my.ports.paperless or 20981;
 description = "Paperless-ngx Document Management";
 useValkey = true; # Nutzt die Open-Source Alternative zu Redis
 usePostgres = true;
 inherit (cfg) secretFile;
 ocrLanguages = [ "deu" "eng" ];
 })

 {
 services.paperless = {
 enable = true;
 user = "paperless";
 address = "127.0.0.1";
 port = config.my.ports.paperless or 20981;
 };

 systemd.services.paperless-web = {
 environment = {
 PAPERLESS_URL = "https://paperless.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
 PAPERLESS_TIME_ZONE = config.my.configs.locale.timezone;
 PAPERLESS_OCR_LANGUAGE = "deu+eng";

 PAPERLESS_DATA_DIR = "${srePaths.stateDir}/paperless";
 PAPERLESS_MEDIA_ROOT = "${srePaths.mediaLibrary}/documents/paperless";
 PAPERLESS_CONSUMPTION_DIR = "${srePaths.tierC}/consume/paperless";

 PAPERLESS_DBHOST = "/run/postgresql";
 PAPERLESS_DBNAME = "paperless";
 PAPERLESS_DBUSER = "paperless";

 PAPERLESS_REDIS = "unix://${config.services.redis.servers.paperless.unixSocket}";
 };

 serviceConfig.EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;
 };

 systemd.services.paperless-worker.environment = config.systemd.services.paperless-web.environment;
 }
 ]);
}

``n---
### [F-055] modules\apps\service-app-readeck.nix
* Pfad: modules\apps\service-app-readeck.nix | Format: .nix | Größe: 1,45 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-50-KNW-004";
 title = "Readeck (SRE Hardened)";
 description = "Self-hosted 'read-it-later' service, tightly sandboxed with DynamicUser.";
 layer = 50;
 nixpkgs.category = "services/web-apps";
 capabilities = [ "web/read-it-later" "security/sandboxing" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.readeck;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.readeck = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for readeck module";
 };

 config = lib.mkIf config.my.services.readeck.enable {
 services.readeck = { enable = true; settings = { server.host = "127.0.0.1"; server.port = port; log.level = "info"; }; environmentFile = config.sops.secrets.readeck_env.path; };
 services.caddy.virtualHosts."read.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.readeck.serviceConfig = { DynamicUser = true; ProtectSystem = "full"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; SystemCallFilter = [ "@system-service" "~@privileged" ]; OOMScoreAdjust = 300; };
 };
}

``n---
### [F-056] modules\apps\service-app-seerr.nix
* Pfad: modules\apps\service-app-seerr.nix | Format: .nix | Größe: 4,40 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-SEE-001";
 title = "Seerr (hardened Requests)";
 description = "Hardened Media Request Management (Seerr/Jellyseerr) with ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/requests" "security/sandboxing" "identity/sso"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.apps.seerr;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

in
{
 options.my.meta.seerr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.apps.seerr = {
 enable = lib.mkEnableOption "Seerr Media Request Service";
 user = lib.mkOption { type = lib.types.str; default = "seerr"; };
 group = lib.mkOption { type = lib.types.str; default = "seerr"; };
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.seerr or 5055; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/seerr"; 
 description = "Database and config (Tier A/Persist)";
 };
 cacheDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/cache/seerr";
 description = "Image and session cache (Tier B)";
 };

 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Seerr environment file containing API keys (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "seerr";
 port = cfg.port;
 useSSO = true;
 description = "Seerr Media Request Manager";
 persist = true;
 readWritePaths = [ cfg.stateDir cfg.cacheDir ];
 })

 {

 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };
 users.groups.${cfg.group} = {};

 services.caddy.virtualHosts."requests.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" = 
 config.services.caddy.virtualHosts."seerr.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.seerr = {
 description = "Seerr Media Request Service (hardened)";
 after = [ "network.target" "jellyfin.service" ];

 serviceConfig = {
 User = cfg.user;
 Group = cfg.group;
 ExecStart = "${pkgs.jellyseerr}/bin/jellyseerr"; # Using jellyseerr package as Seerr base
 WorkingDirectory = cfg.stateDir;

 EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;

 MemoryMax = "1G";
 CPUWeight = 30;
 OOMScoreAdjust = 400;

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 MemoryDenyWriteExecute = false; 

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/seerr" ];
 };
 }
 ]);
}

``n---
### [F-057] modules\apps\service-app-semaphore.nix
* Pfad: modules\apps\service-app-semaphore.nix | Format: .nix | Größe: 836 B
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-30-AUT-006";
 title = "Semaphore";
 description = "Ansible Web UI (Placeholder - Not yet implemented).";
 layer = 20;
 nixpkgs.category = "services/admin";
 capabilities = [ "automation/ansible" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.semaphore = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for semaphore module";
 };

 config = lib.mkIf config.my.services.semaphore.enable {

 };
}

``n---
### [F-058] modules\apps\service-app-vaultwarden.nix
* Pfad: modules\apps\service-app-vaultwarden.nix | Format: .nix | Größe: 2,33 KB
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-60-APP-007";
 title = "Vaultwarden (SRE Exhausted)";
 description = "Tightly sandboxed password manager with Wake-on-Access (Socket Activation).";
 layer = 60;
 nixpkgs.category = "services/security";
 capabilities = ["security/passwords" "security/socket-activation"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 port = config.my.ports.vaultwarden;

 secretEnv = config.sops.secrets.vaultwarden_env.path;
in {
 options.my.meta.vaultwarden = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for vaultwarden module";
 };

 config = lib.mkIf config.my.services.vaultwarden.enable {
 services.vaultwarden = {
 enable = true;
 config = {
 ROCKET_ADDRESS = "127.0.0.1";
 ROCKET_PORT = port;
 SIGNUPS_ALLOWED = false;
 INVITATIONS_ALLOWED = true;
 SHOW_PASSWORD_HINT = false;
 DATABASE_MAX_CONNS = 10;
 };
 environmentFile = secretEnv;
 };

 systemd.sockets.vaultwarden = {
 description = "Vaultwarden Socket";
 wantedBy = ["sockets.target"];
 listenStreams = [(toString port)];
 };

 systemd.services.vaultwarden = {
 wantedBy = lib.mkForce [];
 requires = ["vaultwarden.socket"];
 after = ["vaultwarden.socket"];
 serviceConfig = {
 ProtectSystem = lib.mkForce "strict";
 ReadWritePaths = ["/var/lib/vaultwarden"];
 MemoryDenyWriteExecute = lib.mkForce true;
 RestrictAddressFamilies = lib.mkForce ["AF_INET" "AF_UNIX"];
 SystemCallFilter = lib.mkForce ["@system-service" "~@privileged" "~@resources"];
 NoNewPrivileges = lib.mkForce true;
 PrivateDevices = lib.mkForce true;
 PrivateTmp = lib.mkForce true;
 OOMScoreAdjust = 200;
 };
 };
 };
}

``n---
### [F-059] modules\apps\service-media-arr-wire.nix
* Pfad: modules\apps\service-media-arr-wire.nix | Format: .nix | Größe: 1,59 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-ARR-WIR";
 title = "Arr-Wire (VPN Orchestration)";
 description = "Wires downloader services into specialized VPN namespaces.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["network/vpn" "automation/wiring"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

in {
 options.my.meta.arr_wire = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.vpnConfinement.enable {

 my.services.vpnConfinement.namespaces.media-vault = {
 wgConf = "/etc/nixos/secrets/vpn/privado-de.conf"; # Sops-Pfad
 killSwitch = true;
 };

 my.media.sabnzbd.useVPN = true;
 my.media.sonarr.useVPN = true;
 my.media.radarr.useVPN = true;

 };
}

``n---
### [F-060] modules\apps\service-media-default.nix
* Pfad: modules\apps\service-media-default.nix | Format: .nix | Größe: 1,00 KB
``nix
{ lib, ... }:
let
 nms = {
 id = "NIXH-40-MED-006";
 title = "Default Media Services";
 description = "Master import module for the entire media stack.";
 layer = 40;
 nixpkgs.category = "system/settings";
 capabilities = [ "media/stack" "architecture/imports" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.service_media_default = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [

 ./service-media-arr-wire.nix
 ./service-media-jellyfin.nix
 ./service-media-jellyseerr.nix
 ./service-media-sonarr.nix
 ./service-media-radarr.nix
 ./service-media-lidarr.nix
 ./service-media-readarr.nix
 ./service-media-prowlarr.nix
 ./service-media-sabnzbd.nix
 ./service-media-recyclarr.nix
 ];
}

``n---
### [F-061] modules\apps\service-media-jellyfin.nix
* Pfad: modules\apps\service-media-jellyfin.nix | Format: .nix | Größe: 3,75 KB
``nix
{ lib, pkgs, config, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-JEL-001";
 title = "Jellyfin (hardened)";
 description = "Hardware-accelerated media server with QuickSync and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = [ "media/jellyfin" "gpu/qsv" "security/sandboxing" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.media.jellyfin;
 srePaths = config.my.configs.paths;
 ssdMetadataDir = "${srePaths.tierB}/metadata/jellyfin";

 encodingXml = pkgs.writeText "encoding.xml" ''
 <?xml version="1.0" encoding="utf-8"?><EncodingOptions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><EncodingThreadCount>-1</EncodingThreadCount><TranscodingTempPath>${srePaths.tierB}/cache/jellyfin-transcode</TranscodingTempPath><EnableHardwareAcceleration>true</EnableHardwareAcceleration><HardwareAccelerationType>qsv</HardwareAccelerationType></EncodingOptions>
 '';

in
{
 options.my.meta.jellyfin = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.jellyfin.enable = lib.mkEnableOption "Jellyfin Media Server";

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkStreamer {
 inherit config;
 name = "jellyfin";
 port = config.my.ports.jellyfin;
 useGPU = true; # QuickSync / UHD 630 Zugriff
 memoryMax = "4G";
 cpuWeight = 80;
 description = "Jellyfin hardened Instance";
 })

 {
 services.jellyfin = {
 enable = true;
 group = "media";
 };

 systemd.services.jellyfin = {

 environment = {
 OCL_ICD_VENDORS = "intel";
 LIBVA_DRIVER_NAME = "iHD"; # Force modern Intel Driver
 FFMPEG_TRANSCODING_TEMP_DIR = "/run/jellyfin-transcode";
 };

 preStart = ''
 mkdir -p ${srePaths.stateDir}/jellyfin/config
 cp -f ${encodingXml} ${srePaths.stateDir}/jellyfin/config/encoding.xml
 '';

 serviceConfig = {
 RuntimeDirectory = "jellyfin-transcode";
 RuntimeDirectoryMode = "0750";

 IPAddressAllow = [ "127.0.0.1/8" "::1/128" ] 
 ++ config.my.configs.network.lanCidrs
 ++ config.my.configs.network.tailnetCidrs;
 };
 };

 systemd.tmpfiles.rules = [
 "d ${ssdMetadataDir} 0775 jellyfin media -"
 ];

 fileSystems."/var/lib/jellyfin/metadata" = {
 device = ssdMetadataDir;
 options = [ "bind" ];
 dependsOn = [ srePaths.tierB ];
 };
 }
 ]);
}

``n---
### [F-062] modules\apps\service-media-jellyseerr.nix
* Pfad: modules\apps\service-media-jellyseerr.nix | Format: .nix | Größe: 1,53 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-40-MED-008"; title = "Jellyseerr"; description = "Media requests."; layer = 40; nixpkgs.category = "services/media"; capabilities = [ "media/requests" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 2; };
 myLib = import ../core/lib-helpers.nix { inherit lib; };
 cfg = config.my.media.jellyseerr;
 defs = config.my.defaults;
in
{
 options.my.meta.jellyseerr = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 options.my.media.jellyseerr = { enable = lib.mkEnableOption "Jellyseerr"; stateDir = lib.mkOption { type = lib.types.str; default = "${config.my.configs.paths.stateDir}/jellyseerr"; }; port = lib.mkOption { type = lib.types.port; default = 5055; }; user = lib.mkOption { type = lib.types.str; default = "jellyseerr"; }; group = lib.mkOption { type = lib.types.str; default = "media"; }; netns = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; }; };
 config = lib.mkIf cfg.enable (lib.mkMerge [
 (myLib.mkService { inherit config; name = "jellyseerr"; port = cfg.port; useSSO = true; description = "Jellyseerr"; netns = cfg.netns; })
 {
 services.jellyseerr = { enable = true; port = cfg.port; };
 systemd.services.jellyseerr = {
 environment.CONFIG_DIRECTORY = lib.mkForce cfg.stateDir;
 serviceConfig = { User = cfg.user; Group = cfg.group; ReadWritePaths = [ cfg.stateDir ]; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; };
 };
 }
 ]);
}

``n---
### [F-063] modules\apps\service-media-lidarr.nix
* Pfad: modules\apps\service-media-lidarr.nix | Format: .nix | Größe: 4,34 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-LID-001";
 title = "Lidarr (hardened)";
 description = "Music downloader with sandboxing and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/music" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.lidarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.lidarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.lidarr = {
 enable = lib.mkEnableOption "Lidarr Music Downloader";
 user = lib.mkOption { type = lib.types.str; default = "lidarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/lidarr/.config/Lidarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/lidarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "lidarr" 8686;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Lidarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "lidarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Lidarr Music Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.lidarr = {
 description = "Lidarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "LIDARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.lidarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "LIDARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/lidarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/music 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/lidarr" ];
 };
 }
 ]);
}

``n---
### [F-064] modules\apps\service-media-media-stack.nix
* Pfad: modules\apps\service-media-media-stack.nix | Format: .nix | Größe: 1003 B
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-40-MED-010";
 title = "Media Stack Activation";
 description = "Central toggle for activating the entire media stack and its default profiles.";
 layer = 40;
 nixpkgs.category = "system/settings";
 capabilities = [ "system/media-activation" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.service_media_media_stack = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for service-media-media-stack module";
 };

 config = {
 my.media = {
 defaults.domain = config.my.configs.identity.domain;
 defaults.netns = "media-vault";
 jellyfin.enable = true;
 sonarr.enable = true;
 radarr.enable = true;
 readarr.enable = true;
 prowlarr.enable = true;
 sabnzbd.enable = true;
 jellyseerr.enable = true;
 };
 };
}

``n---
### [F-065] modules\apps\service-media-prowlarr-setup.nix
* Pfad: modules\apps\service-media-prowlarr-setup.nix | Format: .nix | Größe: 4,83 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-PRO-SET";
 title = "Prowlarr Indexer Sync";
 description = "Idempotent API configuration for Prowlarr: Registering Radarr and Sonarr.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/indexer-management" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 prowlarrCfg = config.my.media.prowlarr;
 radarrCfg = config.my.media.radarr;
 sonarrCfg = config.my.media.sonarr;

in
{
 options.my.meta.prowlarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf prowlarrCfg.enable {
 systemd.services.prowlarr-setup = {
 description = "Prowlarr Indexer Sync (hardened)";
 after = [ "prowlarr.service" "radarr.service" "sonarr.service" "network.target" ];
 requires = [ "prowlarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = prowlarrCfg.user;
 Group = prowlarrCfg.group;

 LoadCredential = lib.flatten [
 (lib.optional (prowlarrCfg.apiKeyFile != null) "prowlarr-api-key:${toString prowlarrCfg.apiKeyFile}")
 (lib.optional (radarrCfg.apiKeyFile != null) "radarr-api-key:${toString radarrCfg.apiKeyFile}")
 (lib.optional (sonarrCfg.apiKeyFile != null) "sonarr-api-key:${toString sonarrCfg.apiKeyFile}")
 ];

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ExecStart = pkgs.writeShellScript "prowlarr-setup-script" ''
 set -euo pipefail

 get_key() {
 if [ -f "$CREDENTIALS_DIRECTORY/$1" ]; then cat "$CREDENTIALS_DIRECTORY/$1"; else echo ""; fi
 }

 PROWLARR_KEY=$(get_key "prowlarr-api-key")
 RADARR_KEY=$(get_key "radarr-api-key")
 SONARR_KEY=$(get_key "sonarr-api-key")

 if [ -z "$PROWLARR_KEY" ]; then
 echo " ERROR: Prowlarr API key missing."
 exit 1
 fi

 PROWLARR_URL="http://127.0.0.1:${toString prowlarrCfg.settings.server.port}/api/v1"

 echo " Waiting for Prowlarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $PROWLARR_KEY" "$PROWLARR_URL/system/status" > /dev/null; then
 echo " Prowlarr API is online."
 break
 fi
 sleep 5
 done

 register_app() {
 local name=$1
 local port=$2
 local key=$3
 local implementation=$4

 if [ -z "$key" ]; then
 echo " Skipping $name: No API key provided."
 return
 fi

 echo " Checking $name integration..."
 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $PROWLARR_KEY" "$PROWLARR_URL/applications" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$name\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 echo " Registering $name in Prowlarr..."
 ${pkgs.curl}/bin/curl -s -X POST "$PROWLARR_URL/applications" \
 -H "X-Api-Key: $PROWLARR_KEY" \
 -H "Content-Type: application/json" \
 -d "{
 \"name\": \"$name\",
 \"configContract\": \"$implementation\",
 \"implementation\": \"$implementation\",
 \"fields\": [
 {\"name\": \"baseUrl\", \"value\": \"http://127.0.0.1:$port\"},
 {\"name\": \"apiKey\", \"value\": \"$key\"}
 ],
 \"syncLevel\": \"fullAndIndexers\"
 }" > /dev/null
 echo " $name registered."
 else
 echo " $name already registered (ID: $EXISTING)."
 fi
 }

 register_app "Radarr" "${toString radarrCfg.settings.server.port}" "$RADARR_KEY" "Radarr"
 register_app "Sonarr" "${toString sonarrCfg.settings.server.port}" "$SONARR_KEY" "Sonarr"

 echo " Prowlarr Indexer Sync setup completed."
 '';

 RemainAfterExit = true;
 };
 };
 };
}

``n---
### [F-066] modules\apps\service-media-prowlarr.nix
* Pfad: modules\apps\service-media-prowlarr.nix | Format: .nix | Größe: 4,28 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-PRO-001";
 title = "Prowlarr (hardened)";
 description = "Indexer manager for *arr apps with sandboxing.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/indexer-management" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.prowlarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.prowlarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.prowlarr = {
 enable = lib.mkEnableOption "Prowlarr Indexer Manager";
 user = lib.mkOption { type = lib.types.str; default = "prowlarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/prowlarr/.config/Prowlarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/prowlarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "prowlarr" 9696;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Prowlarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "prowlarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Prowlarr Indexer Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 ];
 })

 {
 systemd.services.prowlarr = {
 description = "Prowlarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "PROWLARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.prowlarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "PROWLARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "1G"; # Prowlarr needs less than Sonarr/Radarr
 CPUWeight = 20; 
 OOMScoreAdjust = 700;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/prowlarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/prowlarr" ];
 };
 }
 ]);
}

``n---
### [F-067] modules\apps\service-media-radarr-setup.nix
* Pfad: modules\apps\service-media-radarr-setup.nix | Format: .nix | Größe: 3,93 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-RAD-SET";
 title = "Radarr API Setup";
 description = "Idempotent API configuration for Radarr: Root Folders, Quality Profiles.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/movies" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.media.radarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.radarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {
 systemd.services.radarr-setup = {
 description = "Radarr API Configuration (hardened)";
 after = [ "radarr.service" "network.target" ];
 requires = [ "radarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = cfg.user;
 Group = cfg.group;

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "radarr-api-key:${toString cfg.apiKeyFile}";

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ExecStart = pkgs.writeShellScript "radarr-setup-script" ''
 set -euo pipefail

 if [ -d "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/radarr-api-key" ]; then
 API_KEY=$(cat "$CREDENTIALS_DIRECTORY/radarr-api-key")
 else
 echo " ERROR: Radarr API key not found in credentials directory."
 exit 1
 fi

 URL="http://127.0.0.1:${toString cfg.settings.server.port}/api/v3"

 echo " Waiting for Radarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $API_KEY" "$URL/system/status" > /dev/null; then
 echo " Radarr API is online."
 break
 fi
 if [ $i -eq 12 ]; then
 echo " ERROR: Radarr API timed out."
 exit 1
 fi
 sleep 5
 done

 ROOT_PATH="${srePaths.mediaLibrary}/movies"
 echo " Checking root folder: $ROOT_PATH"

 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $API_KEY" "$URL/rootfolder" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.path == \"$ROOT_PATH\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 ${pkgs.curl}/bin/curl -s -X POST "$URL/rootfolder" \
 -H "X-Api-Key: $API_KEY" \
 -H "Content-Type: application/json" \
 -d "{\"path\":\"$ROOT_PATH\"}" > /dev/null
 echo " Created root folder $ROOT_PATH"
 else
 echo " Root folder $ROOT_PATH already exists (ID: $EXISTING)"
 fi

 echo " API Setup for Radarr completed successfully."
 '';

 RemainAfterExit = true;
 };
 };
 in {

 };
}

``n---
### [F-068] modules\apps\service-media-radarr.nix
* Pfad: modules\apps\service-media-radarr.nix | Format: .nix | Größe: 4,21 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-RAD-001";
 title = "Radarr (hardened)";
 description = "Movie downloader with sandboxing and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/movies" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.radarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.radarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.radarr = {
 enable = lib.mkEnableOption "Radarr Movie Downloader";
 user = lib.mkOption { type = lib.types.str; default = "radarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/radarr/.config/Radarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/radarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "radarr" 7878;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Radarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "radarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Radarr Movie Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.radarr = {
 description = "Radarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "RADARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = "${pkgs.radarr}/bin/Radarr -nobrowser -data='${cfg.stateDir}'";
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "RADARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30; # Lower than Sabnzbd
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/radarr/MediaCover"
 ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/movies 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/radarr" ];
 };
 }
 ]);
}

``n---
### [F-069] modules\apps\service-media-readarr.nix
* Pfad: modules\apps\service-media-readarr.nix | Format: .nix | Größe: 4,35 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-REA-001";
 title = "Readarr (hardened)";
 description = "Book management and downloader with sandboxing.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/books" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.readarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.readarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.readarr = {
 enable = lib.mkEnableOption "Readarr Book Manager";
 user = lib.mkOption { type = lib.types.str; default = "readarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/readarr/.config/Readarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/readarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "readarr" 8787;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Readarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "readarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Readarr Book Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.readarr = {
 description = "Readarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "READARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.readarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "READARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/readarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/books 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/readarr" ];
 };
 }
 ]);
}

``n---
### [F-070] modules\apps\service-media-recyclarr.nix
* Pfad: modules\apps\service-media-recyclarr.nix | Format: .nix | Größe: 1,65 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-40-MED-014";
 title = "Recyclarr (SRE Declarative)";
 description = "Declarative management of Radarr/Sonarr quality profiles and custom formats.";
 layer = 40;
 nixpkgs.category = "services/misc";
 capabilities = [ "media/quality-profiles" "automation/declarative-config" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.recyclarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for recyclarr module";
 };

 config = lib.mkIf config.my.services.recyclarr.enable {
 services.recyclarr = {
 enable = true;
 configuration = {
 sonarr.tv = { base_url = "https://sonarr.${config.my.configs.identity.domain}"; api_key = "!env_var SONARR_API_KEY"; include = [ { template = "v3-sonarr-web-dl-1080p-v2-remux-720p"; } ]; };
 radarr.movies = { base_url = "https://radarr.${config.my.configs.identity.domain}"; api_key = "!env_var RADARR_API_KEY"; include = [ { template = "v3-radarr-web-dl-1080p-v2-remux-720p"; } ]; };
 };
 };
 systemd.services.recyclarr.serviceConfig = {
 LoadCredential = [ "sonarr_api:${config.sops.secrets.sonarr_api_key.path}" "radarr_api:${config.sops.secrets.radarr_api_key.path}" ];
 Environment = [ "SONARR_API_KEY_FILE=/run/credentials/recyclarr.service/sonarr_api" "RADARR_API_KEY_FILE=/run/credentials/recyclarr.service/radarr_api" ];
 ProtectSystem = "strict"; PrivateTmp = true; NoNewPrivileges = true; MemoryMax = "512M"; OOMScoreAdjust = 1000;
 };
 };
}

``n---
### [F-071] modules\apps\service-media-sabnzbd.nix
* Pfad: modules\apps\service-media-sabnzbd.nix | Format: .nix | Größe: 4,69 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-SAB-001";
 title = "SABnzbd (hardened)";
 description = "Hardened Usenet download client with ABC-Tiering and Secret-Isolation.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/usenet" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.media.sabnzbd;
 srePaths = config.my.configs.paths;
in
{
 options.my.meta.sabnzbd = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.sabnzbd = {
 enable = lib.mkEnableOption "SABnzbd Usenet Downloader";
 user = lib.mkOption { type = lib.types.str; default = "sabnzbd"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };
 port = lib.mkOption { type = lib.types.port; default = 8080; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/sabnzbd"; 
 description = "State directory (Tier A/Persist)";
 };
 incompleteDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.tierB}/incomplete/sabnzbd"; 
 description = "Staging area for active downloads (Tier B SATA SSD for large 4K payloads)";
 };
 downloadDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.tierC}/downloads/usenet"; 
 description = "Final storage for downloads (Tier C)";
 };

 apiKeyFile = lib.mkOption { 
 type = lib.types.nullOr lib.types.path; 
 default = null; 
 description = "Path to the SABnzbd API Key (via Sops)";
 };
 nzbKeyFile = lib.mkOption { 
 type = lib.types.nullOr lib.types.path; 
 default = null; 
 description = "Path to the SABnzbd NZB Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "sabnzbd";
 port = cfg.port;
 useSSO = true;
 description = "SABnzbd Usenet Client";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.incompleteDir 
 cfg.downloadDir 
 ];
 })

 {
 services.sabnzbd = {
 enable = true;
 user = cfg.user;
 group = cfg.group;
 };

 systemd.services.sabnzbd = {

 environment.SAB_CONFIG_FILE = "${cfg.stateDir}/sabnzbd.ini";

 serviceConfig = {

 RuntimeDirectory = "sabnzbd-tmp";
 RuntimeDirectoryMode = "0750";

 LoadCredential = lib.flatten [
 (lib.optional (cfg.apiKeyFile != null) "SAB_API_KEY:${toString cfg.apiKeyFile}")
 (lib.optional (cfg.nzbKeyFile != null) "SAB_NZB_KEY:${toString cfg.nzbKeyFile}")
 ];

 MemoryMax = "2G";
 CPUWeight = 40; # Lower priority than Jellyfin
 OOMScoreAdjust = 500; # Kill SABnzbd before Core services

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 NoNewPrivileges = true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.downloadDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/sabnzbd" ];
 };
 }
 ]);
}

``n---
### [F-072] modules\apps\service-media-services-common.nix
* Pfad: modules\apps\service-media-services-common.nix | Format: .nix | Größe: 1,05 KB
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-40-MED-016";
 title = "Services Common";
 description = "Common media service defaults and global configuration attributes.";
 layer = 40;
 nixpkgs.category = "system/settings";
 capabilities = [ "media/defaults" "architecture/common" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.service_media_services_common = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for service-media-services-common module";
 };

 options.my.media.defaults = {
 domain = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; };
 hostPrefix = lib.mkOption { type = lib.types.str; default = "nix"; };
 netns = lib.mkOption { type = lib.types.nullOr lib.types.str; default = null; };
 };

 config.assertions = [ { assertion = config.my.media.defaults.domain != null; message = "my.media.defaults.domain must be set."; } ];
}

``n---
### [F-073] modules\apps\service-media-sonarr-setup.nix
* Pfad: modules\apps\service-media-sonarr-setup.nix | Format: .nix | Größe: 3,61 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-APP-SON-SET";
 title = "Sonarr API Setup";
 description = "Idempotent API configuration for Sonarr: Root Folders, Quality Profiles.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/tv" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.media.sonarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.sonarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {
 systemd.services.sonarr-setup = {
 description = "Sonarr API Configuration (hardened)";
 after = [ "sonarr.service" "network.target" ];
 requires = [ "sonarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = cfg.user;
 Group = cfg.group;

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "sonarr-api-key:${toString cfg.apiKeyFile}";

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ExecStart = pkgs.writeShellScript "sonarr-setup-script" ''
 set -euo pipefail

 if [ -d "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/sonarr-api-key" ]; then
 API_KEY=$(cat "$CREDENTIALS_DIRECTORY/sonarr-api-key")
 else
 echo " ERROR: Sonarr API key not found in credentials directory."
 exit 1
 fi

 URL="http://127.0.0.1:${toString cfg.settings.server.port}/api/v3"

 echo " Waiting for Sonarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $API_KEY" "$URL/system/status" > /dev/null; then
 echo " Sonarr API is online."
 break
 fi
 if [ $i -eq 12 ]; then
 echo " ERROR: Sonarr API timed out."
 exit 1
 fi
 sleep 5
 done

 ROOT_PATH="${srePaths.mediaLibrary}/tv"
 echo " Checking root folder: $ROOT_PATH"

 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $API_KEY" "$URL/rootfolder" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.path == \"$ROOT_PATH\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 ${pkgs.curl}/bin/curl -s -X POST "$URL/rootfolder" \
 -H "X-Api-Key: $API_KEY" \
 -H "Content-Type: application/json" \
 -d "{\"path\":\"$ROOT_PATH\"}" > /dev/null
 echo " Created root folder $ROOT_PATH"
 else
 echo " Root folder $ROOT_PATH already exists (ID: $EXISTING)"
 fi

 echo " API Setup for Sonarr completed successfully."
 '';

 RemainAfterExit = true;
 };
 };
 };
}

``n---
### [F-074] modules\apps\service-media-sonarr.nix
* Pfad: modules\apps\service-media-sonarr.nix | Format: .nix | Größe: 4,34 KB
``nix
{ config, lib, pkgs, utils, myLib, ... }:
let

 nms = {
 id = "NIXH-01-APP-SON-001";
 title = "Sonarr (hardened)";
 description = "TV series downloader with sandboxing and ABC-Tiering.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["media/tv" "security/sandboxing" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 factory = import ./service-media-_servarr-factory.nix { inherit lib pkgs; };
 cfg = config.my.media.sonarr;
 srePaths = config.my.configs.paths;

in
{
 options.my.meta.sonarr = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.media.sonarr = {
 enable = lib.mkEnableOption "Sonarr TV Series Downloader";
 user = lib.mkOption { type = lib.types.str; default = "sonarr"; };
 group = lib.mkOption { type = lib.types.str; default = "media"; };

 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/sonarr/.config/NzbDrone"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool/metadata/sonarr";
 description = "Fast metadata cache (Tier B)";
 };

 settings = factory.mkServarrSettingsOptions "sonarr" 8989;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Sonarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "sonarr";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Sonarr TV Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 (srePaths.tierC + "/downloads")
 ];
 })

 {
 systemd.services.sonarr = {
 description = "Sonarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];

 environment = factory.mkServarrSettingsEnvVars "SONARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;

 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.sonarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 LoadCredential = lib.optional (cfg.apiKeyFile != null) "SONARR_API_KEY:${toString cfg.apiKeyFile}";

 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;

 BindPaths = [
 "${cfg.metadataDir}:/var/lib/sonarr/MediaCover"
 ];

 RestrictNamespaces = lib.mkForce false; 
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/tv 0775 ${cfg.user} ${cfg.group} -"
 ];

 environment.persistence."/persist" = {
 directories = [ "/var/lib/sonarr" ];
 };
 }
 ]);
}

``n---
### [F-075] modules\apps\service-media-_lib.nix
* Pfad: modules\apps\service-media-_lib.nix | Format: .nix | Größe: 3,66 KB
``nix
{ lib, pkgs, ... }:
{ name, port, stateOption, defaultStateDir, supportsUserGroup ? true, defaultUser ? name, defaultGroup ? "media", statePathSuffix ? null, useVpn ? false, extraServiceConfig ? {} }:
{ config, ... }:
let
 myLib = import ../core/lib-helpers.nix { inherit lib; };
 cfg = config.my.media.${name};
 sreConfig = config.my.configs;
 srePaths = config.my.configs.paths;

 nativePort = if name == "sonarr" then 8989 
 else if name == "radarr" then 7878 
 else if name == "prowlarr" then 9696 
 else if name == "readarr" then 8787 
 else if name == "lidarr" then 8686 
 else if name == "sabnzbd" then 8080 
 else if name == "jellyfin" then 8096 
 else if name == "jellyseerr" then 5055 
 else port;

 stateValue = if statePathSuffix == null 
 then "${srePaths.stateDir}/${name}" 
 else "${srePaths.stateDir}/${name}/${statePathSuffix}";

 vpnConfig = lib.optionalAttrs useVpn { 
 requires = [ "wireguard-vault.service" ]; 
 after = [ "wireguard-vault.service" ]; 
 serviceConfig = { 
 NetworkNamespacePath = "/var/run/netns/media-vault"; 
 RestrictAddressFamilies = lib.mkForce [ "AF_INET" "AF_INET6" "AF_UNIX" "AF_NETLINK" ]; 
 }; 
 };

 serviceBase = myLib.mkService { 
 inherit config; 
 name = name; 
 port = nativePort; 
 useSSO = true; 
 description = "${name} Service (hardened)"; 
 netns = if useVpn then "media-vault" else null;
 isStream = (name == "jellyfin"); # PROXY_STREAM PIPELINE AKTIVIEREN
 };
in
{
 options.my.media.${name} = {
 enable = lib.mkEnableOption "the ${name} service";
 stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/${name}"; };
 user = lib.mkOption { type = lib.types.str; default = defaultUser; };
 group = lib.mkOption { type = lib.types.str; default = defaultGroup; };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 serviceBase
 {
 services.${name} = { 
 enable = true; 
 openFirewall = lib.mkForce false; 
 ${stateOption} = stateValue; 
 } // lib.optionalAttrs supportsUserGroup { 
 user = cfg.user; 
 group = cfg.group; 
 } // lib.optionalAttrs (name == "jellyfin") { 
 cacheDir = "/mnt/fast-pool/cache/jellyfin"; 
 };

 systemd.services.${name} = lib.mkMerge [ 
 vpnConfig 
 { 
 serviceConfig = { 
 ProtectSystem = lib.mkForce "full"; 
 ProtectHome = true; 
 PrivateTmp = true; 
 NoNewPrivileges = true; 
 MemoryMax = "${toString sreConfig.resourceLimits.maxMediaRamMB}M"; 
 CPUWeight = 50; 
 OOMScoreAdjust = 500; 
 ReadWritePaths = [ 
 cfg.stateDir 
 srePaths.mediaLibrary 
 "${srePaths.storagePool}/downloads" 
 "/mnt/fast-pool/cache" 
 "/mnt/fast-pool/metadata" 
 ]; 
 BindPaths = lib.mkIf (name == "sonarr" || name == "radarr" || name == "readarr" || name == "prowlarr" || name == "lidarr") [ 
 "/mnt/fast-pool/metadata/${name}:/var/lib/${name}/MediaCover" 
 ]; 
 }; 
 } 
 extraServiceConfig 
 ];

 systemd.tmpfiles.rules = [ 
 "d ${cfg.stateDir} 0750 ${cfg.user} media -" 
 "d /mnt/fast-pool/metadata/${name} 0775 ${cfg.user} media -" 
 "d /mnt/fast-pool/cache/${name} 0775 ${cfg.user} media -" 
 ];
 }
 ]);
}

``n---
### [F-076] modules\apps\service-media-_servarr-factory.nix
* Pfad: modules\apps\service-media-_servarr-factory.nix | Format: .nix | Größe: 2,20 KB
``nix
{ lib, pkgs }:
let
 servarrHardening = { CapabilityBoundingSet = ""; NoNewPrivileges = true; ProtectHome = true; ProtectClock = true; ProtectKernelLogs = true; PrivateTmp = true; PrivateDevices = true; PrivateUsers = true; ProtectKernelTunables = true; ProtectKernelModules = true; ProtectControlGroups = true; RestrictSUIDSGID = true; RemoveIPC = true; UMask = "0022"; ProtectHostname = true; ProtectProc = "invisible"; ProcSubset = "pid"; RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ]; RestrictNamespaces = true; RestrictRealtime = true; LockPersonality = true; SystemCallArchitectures = "native"; SystemCallFilter = [ "@system-service" "~@privileged" "~@debug" "~@mount" "@chown" ]; };
in
{
 mkServarrSettingsOptions = name: port: lib.mkOption { type = lib.types.submodule { freeformType = (pkgs.formats.ini { }).type; options = { update = { mechanism = lib.mkOption { type = with lib.types; nullOr (enum [ "external" "builtIn" "script" ]); default = "external"; }; automatically = lib.mkOption { type = lib.types.bool; default = false; }; }; server = { port = lib.mkOption { type = lib.types.port; default = port; }; bindAddress = lib.mkOption { type = lib.types.str; default = "127.0.0.1"; }; }; log = { analyticsEnabled = lib.mkOption { type = lib.types.bool; default = false; }; }; }; }; default = { }; };
 mkServarrEnvironmentFiles = name: lib.mkOption { type = lib.types.listOf lib.types.path; default = [ ]; };
 mkServarrSettingsEnvVars = name: settings: lib.pipe settings [ (lib.mapAttrsRecursive (path: value: lib.optionalAttrs (value != null) { name = lib.toUpper "${name}__${lib.concatStringsSep "__" path}"; value = toString (if lib.isBool value then lib.boolToString value else value); })) (lib.collect (x: lib.isString x.name or false && lib.isString x.value or false)) lib.listToAttrs ];
 mkServarrHardening = servarrHardening;
 mkServarrTmpfiles = name: cfg: { "10-${name}".${cfg.stateDir}.d = { inherit (cfg) user group; mode = "0700"; }; };
 mkServarrUserGroup = name: cfg: defaultGroup: { users.users.${cfg.user} = lib.mkIf (cfg.user == name) { group = cfg.group; home = cfg.stateDir; isSystemUser = true; description = "${name} service user"; }; users.groups.${cfg.group} = lib.mkDefault { }; };
}

``n---
### [F-077] modules\apps\SERVICE_TEMPLATE.nix
* Pfad: modules\apps\SERVICE_TEMPLATE.nix | Format: .nix | Größe: 1,47 KB
``nix
{ config, lib, pkgs, ... }:

let
 domain = config.my.configs.identity.domain;

 serviceName = "<service-name>";
in
{
 services.${serviceName} = {
 enable = true;
 };

 systemd.services.${serviceName}.serviceConfig = {
 NoNewPrivileges = lib.mkForce true;
 PrivateTmp = lib.mkForce true;
 PrivateDevices = lib.mkForce true;
 ProtectHome = lib.mkForce true;
 ProtectSystem = lib.mkForce "strict";
 ProtectKernelTunables = lib.mkForce true;
 ProtectKernelModules = lib.mkForce true;
 ProtectControlGroups = lib.mkForce true;
 RestrictRealtime = lib.mkForce true;
 RestrictSUIDSGID = lib.mkForce true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
}

``n---
### [F-078] modules\core\auto-locale.nix
* Pfad: modules\core\auto-locale.nix | Format: .nix | Größe: 2,25 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-003";
 title = "Auto Locale (Zero-Touch)";
 description = "Intelligent geolocation-based system localization with robust fallbacks and state persistence.";
 layer = 00;
 nixpkgs.category = "system/localization";
 capabilities = ["automation/geolocate" "system/boot-optimization"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 cfg = config.my.autoLocale;

 geolocateScript = pkgs.writeShellScript "geolocate" ''
 set -euo pipefail

 COUNTRY=$(${pkgs.curl}/bin/curl -sf --max-time 5 "http://ip-api.com/json/?fields=countryCode" | ${pkgs.jq}/bin/jq -r '.countryCode' 2>/dev/null || echo "")

 if [ -z "$COUNTRY" ] || [ "$COUNTRY" == "null" ]; then
 COUNTRY=$(${pkgs.curl}/bin/curl -sf --max-time 5 "https://ipapi.co/country_name/" 2>/dev/null || echo "Germany")
 [[ "$COUNTRY" == "Germany" ]] && COUNTRY="DE"
 fi

 echo "''${COUNTRY:-DE}"
 '';

 cacheFile = "/var/lib/auto-locale/state.json";
in {
 options.my.meta.auto_locale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf (cfg.enable or false) {

 time.timeZone = lib.mkDefault "Europe/Berlin";
 i18n.defaultLocale = lib.mkDefault "de_DE.UTF-8";

 systemd.services.auto-locale-sync = {
 description = "Auto-Locale: Sync System State with Geolocation";
 wantedBy = ["multi-user.target"];
 after = ["network-online.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 };
 script = ''
 mkdir -p "$(dirname ${cacheFile})"
 COUNTRY=$(${geolocateScript})
 echo "{\"country\": \"$COUNTRY\", \"last_sync\": \"$(date -Iseconds)\"}" > ${cacheFile}
 logger -t auto-locale "hardened Sync: System localized to $COUNTRY"
 '';
 };

 environment.systemPackages = with pkgs; [ curl jq ];
 };
}

``n---
### [F-079] modules\core\backup.nix
* Pfad: modules\core\backup.nix | Format: .nix | Größe: 3,02 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-004";
 title = "Backup (Restic edition)";
 description = "Hardened Restic backup logic with atomical Cloud-Sync and failure-safe ExecConditions.";
 layer = 00;
 nixpkgs.category = "services/backup";
 capabilities = ["backup/restic" "cloud/sync" "security/integrity-check"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 localRepo = "/mnt/archive/.restic-vault";
 maxSizeGB = 20; # Erhöht für Media-Metadaten
in {
 options.my.meta.backup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.backup.enable {
 services.restic.backups.daily = {
 initialize = true;
 repository = localRepo;
 passwordFile = config.sops.secrets.restic_password.path; # Sops Integration

 paths = [
 "/data/state"
 "/data/metadata"
 "/etc/nixos"
 "/var/lib/pocket-id"
 "/persist" # Impermanence Support
 ];

 exclude = [ "**/.cache" "**/tmp" "**/node_modules" "*.log" ];

 createWrapper = true;
 runCheck = true;
 checkOpts = ["--with-cache"];

 extraOptions = [ "--exclude-caches" "--compression=max" ];
 inhibitsSleep = true;

 backupPrepareCommand = ''
 DATA_SIZE=$(${pkgs.coreutils}/bin/du -sb /data/state /etc/nixos | ${pkgs.gawk}/bin/awk '{sum+=$1} END {print sum}')
 LIMIT=$(( ${toString maxSizeGB} * 1024 * 1024 * 1024 ))
 if [ "$DATA_SIZE" -gt "$LIMIT" ]; then
 echo " BACKUP ABGEBROCHEN: Datenmenge ($DATA_SIZE) > Limit ($LIMIT)!"
 exit 1
 fi
 '';

 backupCleanupCommand = ''
 echo " Starte Cloud-Sync..."
 ${pkgs.rclone}/bin/rclone sync ${localRepo} cloud-backup:nixhome-vault --bwlimit 5M
 echo " Cloud-Sync abgeschlossen."
 '';

 timerConfig = {
 OnCalendar = "02:00";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];
 };

 services.restic.backups.persist = {
 initialize = true;
 repository = "s3:https://s3.eu-central-003.backblazeb2.com/nixhome-persist";
 passwordFile = config.sops.secrets.restic_password.path;
 environmentFile = config.sops.templates."backblaze-restic.env".path;

 paths = [ "/persist" ];
 exclude = [ "**/.cache" "**/tmp" ];

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];

 timerConfig = {
 OnCalendar = "03:00";
 Persistent = true;
 };

 extraOptions = [ "--compression=max" ];
 };

 environment.systemPackages = with pkgs; [restic rclone];
 };
}

``n---
### [F-080] modules\core\boot-safeguard.nix
* Pfad: modules\core\boot-safeguard.nix | Format: .nix | Größe: 648 B
``nix
{
 config,
 lib,
 ...
}: let
 nms = {
 id = "NIXH-00-COR-001";
 title = "Boot Safeguard";
 description = "Hardened boot configuration with UEFI focus and systemd-boot.";
 layer = 00;
 };
in {
 boot.loader.systemd-boot = {
 enable = true;
 configurationLimit = 10; # Gegen Speicherüberlauf in /boot
 consoleMode = "max";
 };

 boot.loader.efi.canTouchEfiVariables = true;

 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "rd.udev.log_level=3"
 ];

 boot.tmp.cleanOnBoot = true;
 boot.initrd.verbose = false;
}

``n---
### [F-081] modules\core\central-configs-plan.nix
* Pfad: modules\core\central-configs-plan.nix | Format: .nix | Größe: 697 B
``nix
{ lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-006";
 title = "Central Configs Plan";
 description = "Roadmap and architectural planning for centralized configuration management.";
 layer = 0;
 nixpkgs.category = "documentation/architecture";
 capabilities = ["architecture/roadmap"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.central_configs_plan = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for central-configs-plan module";
 };

 config = {

 };
}

``n---
### [F-082] modules\core\config-merger.nix
* Pfad: modules\core\config-merger.nix | Format: .nix | Größe: 2,79 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-007";
 title = "Config Merger";
 description = "Dynamic bridge between NixOS declarations and user-managed JSON overrides for runtime services.";
 layer = 0;
 nixpkgs.category = "tools/admin";
 capabilities = ["config/merger" "system/runtime-config"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 runDir = "/run/nixhome";
 userConfig = "/var/lib/nixhome/user-config.json";
 finalConfig = "${runDir}/config.json";

 nixDefaults = pkgs.writeText "nix-defaults.json" (builtins.toJSON {
 domain = config.my.configs.identity.domain;
 email = config.my.configs.identity.email;
 lanIP = config.my.configs.network.lanIP;
 hostName = config.my.configs.identity.host;
 bastelmodus = config.my.configs.bastelmodus;
 });

 mergerScript = pkgs.writeShellScript "nixhome-config-merger" ''
 set -euo pipefail
 mkdir -p ${runDir}
 if [ ! -f "${userConfig}" ]; then
 echo "{}" > "${userConfig}"
 chown root:root "${userConfig}"
 chmod 644 "${userConfig}"
 fi
 ${pkgs.jq}/bin/jq -s '.[0] * .[1]' "${nixDefaults}" "${userConfig}" > "${finalConfig}.tmp"
 mv "${finalConfig}.tmp" "${finalConfig}"
 chmod 644 "${finalConfig}"
 '';

 applyScript = pkgs.writeShellScriptBin "nixhome-apply" ''
 set -euo pipefail
 echo " Merging configuration..."
 systemctl start nixhome-config-merger.service
 echo " Reloading services..."
 if systemctl is-active caddy >/dev/null 2>&1; then systemctl reload caddy; fi
 if systemctl is-active pocket-id >/dev/null 2>&1; then systemctl restart pocket-id; fi
 echo " Fertig!"
 '';
in {
 options.my.meta.config_merger = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for config-merger module";
 };

 config = lib.mkIf config.my.services.configMerger.enable {
 systemd.services.nixhome-config-merger = {
 description = "Merge Nix Defaults with User JSON Config";
 before = ["caddy.service" "pocket-id.service" "landing-zone-ui.service"];
 wantedBy = ["multi-user.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 ExecStart = mergerScript;

 Restart = "always";
 RestartSec = "10s";
 OOMScoreAdjust = -1000;
 };
 };
 environment.systemPackages = [applyScript pkgs.jq];
 systemd.tmpfiles.rules = ["d /var/lib/nixhome 0755 root root -"];
 };
}

``n---
### [F-083] modules\core\configs.nix
* Pfad: modules\core\configs.nix | Format: .nix | Größe: 4,24 KB
``nix
{ lib, myLib, ... }: {

 options.my.configs = {
 identity = {
 domain = myLib.mkTracedOption "SRC-OBS-220" (lib.mkOption { 
 type = lib.types.str; 
 default = "m7c5.de"; 
 description = "Global base domain (hardened)";
 });
 subdomain = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption { 
 type = lib.types.str; 
 default = "nix"; 
 description = "NixOS specific subdomain";
 });
 user = myLib.mkTracedOption "SRC-CHAT-748" (lib.mkOption {
 type = lib.types.str;
 default = "moritz";
 description = "Primary system administrator user";
 });
 email = lib.mkOption {
 type = lib.types.str;
 default = "git@m7c5.de";
 description = "Global administrator email";
 };
 host = lib.mkOption {
 type = lib.types.str;
 default = "nixhome";
 description = "The target hostname";
 };
 };

 network = {
 lanIP = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption { 
 type = lib.types.str; 
 default = "192.168.2.73"; 
 description = "Primary LAN IP of the target host";
 });
 lanCidr = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
 type = lib.types.str;
 default = "192.168.2.0/24";
 description = "Trusted local network range";
 });
 lanCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
 type = lib.types.listOf lib.types.str;
 default = [ "192.168.2.0/24" ];
 description = "List of trusted LAN ranges";
 });
 tailnetCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
 type = lib.types.listOf lib.types.str;
 default = [ "100.64.0.0/10" ];
 description = "Tailscale network range";
 });
 };

 locale = {
 default = lib.mkOption { type = lib.types.str; default = "de_DE.UTF-8"; };
 timezone = lib.mkOption { type = lib.types.str; default = "Europe/Berlin"; };
 };

 hardware = {
 ramGB = myLib.mkTracedOption "SRC-CHAT-160" (lib.mkOption {
 type = lib.types.int;
 default = 16;
 description = "Physical RAM in GB (for ZRAM tuning)";
 });
 intelGpu = lib.mkOption { type = lib.types.bool; default = true; };
 cpuType = lib.mkOption { type = lib.types.str; default = "intel"; };
 };

 paths = {
 stateDir = lib.mkOption { type = lib.types.str; default = "/var/lib"; };
 tierA = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/persist"; description = "NVMe: Persistent State"; });
 tierB = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/cache"; description = "SSD: Cache & Transcodes"; });
 tierC = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; description = "HDD: Bulk Media Archive"; });

 appData = lib.mkOption { type = lib.types.str; default = "/persist/app-data"; description = "Tier A: High-IOPS (Databases, Configs)"; };
 appCache = lib.mkOption { type = lib.types.str; default = "/mnt/cache/app-cache"; description = "Tier B: High-Volume (Images, Transcodes)"; };
 downloads = lib.mkOption { type = lib.types.str; default = "/mnt/cache/downloads"; description = "Tier B: High-Write (Active SABnzbd)"; };

 mediaLibrary = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool/media"; };
 storagePool = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; };
 };

 bastelmodus = lib.mkOption {
 type = lib.types.bool;
 default = false;
 description = "If true, disables some security assertions for easier debugging.";
 };

 vpn = {
 privado = lib.mkOption {
 type = lib.types.attrs;
 default = {};
 description = "Privado VPN configuration (placeholder)";
 };
 };

 resourceLimits = {
 maxMediaRamMB = lib.mkOption { type = lib.types.int; default = 4096; };
 };
 };
}

``n---
### [F-084] modules\core\defaults.nix
* Pfad: modules\core\defaults.nix | Format: .nix | Größe: 3,89 KB
``nix
{lib, ...}: let

 nms = {
 id = "NIXH-00-COR-009";
 title = "00-defaults";
 description = "Shared global defaults for network namespaces, filesystem prefixes, and security conventions.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["architecture/defaults" "storage/tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };
in {
 options.my.meta.defaults = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for defaults module";
 };

 options.my.defaults = {

 netns = lib.mkOption {
 type = lib.types.nullOr lib.types.str;
 default = null;
 description = "Standard Network-Namespace für alle Dienste.";
 };

 bindAddress = lib.mkOption {
 type = lib.types.str;
 default = "127.0.0.1";
 description = "Standard-Bind-Adresse für alle Dienste.";
 };

 locale = {
 timezone = lib.mkOption {
 type = lib.types.str;
 default = "Europe/Berlin";
 };
 language = lib.mkOption {
 type = lib.types.str;
 default = "de_DE.UTF-8";
 };
 dateOrder = lib.mkOption {
 type = lib.types.enum ["DMY" "MDY" "YMD"];
 default = "DMY";
 };
 };

 ocr = {
 languages = lib.mkOption {
 type = lib.types.listOf lib.types.str;
 default = ["deu" "eng"];
 };
 outputType = lib.mkOption {
 type = lib.types.enum ["pdfa" "pdfa-1" "pdfa-2" "pdfa-3" "pdf" "none"];
 default = "pdfa";
 };
 };

 paths = {
 statePrefix = lib.mkOption {
 type = lib.types.str;
 default = "/data/state";
 };
 mediaRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/media";
 };
 downloadsDir = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/media/downloads";
 };
 fastPoolRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/fast-pool";
 };
 documentRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/documents";
 };
 backupRoot = lib.mkOption {
 type = lib.types.str;
 default = "/mnt/backup";
 };
 };

 security = {
 defaultGroup = lib.mkOption {
 type = lib.types.str;
 default = "media";
 };
 ssoEnable = lib.mkOption {
 type = lib.types.bool;
 default = true;
 };
 };

 observability = {
 logLevel = lib.mkOption {
 type = lib.types.enum ["DEBUG" "INFO" "WARNING" "ERROR"];
 default = "WARNING";
 };
 metricsPortOffset = lib.mkOption {
 type = lib.types.int;
 default = 9000;
 };
 };
 };
}

``n---
### [F-085] modules\core\fail2ban.nix
* Pfad: modules\core\fail2ban.nix | Format: .nix | Größe: 3,28 KB
``nix
{
 config,
 pkgs,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-010";
 title = "Fail2ban (Edge Hardened)";
 description = "Aggressive protection with deep Caddy JSON log inspection and incremental banning logic.";
 layer = 00;
 nixpkgs.category = "services/security";
 capabilities = ["security/bruteforce-protection" "network/hardening" "caddy/security"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 sshPort = toString config.my.ports.ssh;
in {
 options.my.meta.fail2ban = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.fail2ban.enable or true) {
 services.fail2ban = {
 enable = true;

 banaction = "nftables-multiport";
 banaction-allports = "nftables-allports";

 ignoreIP = [
 "127.0.0.1/8" "::1"
 config.my.configs.network.lanCidr
 ];

 bantime = "1h";
 maxretry = 5;

 bantime-increment = {
 enable = true;
 multipliers = "1 2 4 8 16 32 64";
 maxtime = "168h"; # Max 1 Woche
 };

 jails = {
 sshd.settings = {
 enabled = true;
 port = sshPort;
 mode = "aggressive";
 };

 sshd-rescue.settings = {
 enabled = true;
 port = "2222";
 mode = "aggressive";
 maxretry = 3;
 };

 caddy-auth.settings = {
 enabled = true;
 port = "http,https";
 filter = "caddy-json";
 backend = "systemd";
 maxretry = 3;
 findtime = "5m";
 bantime = "24h";
 };

 caddy-scan.settings = {
 enabled = true;
 port = "http,https";
 filter = "caddy-scan";
 backend = "systemd";
 maxretry = 2;
 findtime = "1m";
 bantime = "168h";
 };
 };
 };

 environment.etc = {
 "fail2ban/filter.d/caddy-json.conf".text = ''
 [Definition]
 failregex = ^.*"remote_ip":"<ADDR>".*"status":(401|403).*$
 journalmatch = _SYSTEMD_UNIT=caddy.service
 '';
 "fail2ban/filter.d/caddy-scan.conf".text = ''
 [Definition]

 failregex = ^.*"remote_ip":"<ADDR>".*"uri":".*(?:\.env|\.git|\.config|\.php|\.zip|\.gz|wp-admin|wp-login|xmlrpc)".*"status":404.*$
 journalmatch = _SYSTEMD_UNIT=caddy.service
 '';
 };

 systemd.services.fail2ban.serviceConfig = {
 OOMScoreAdjust = 500;
 ProtectSystem = "strict";
 ReadWritePaths = ["/var/lib/fail2ban" "/var/run/fail2ban"];
 PrivateTmp = true;
 };
 };
}

``n---
### [F-086] modules\core\firewall.nix
* Pfad: modules\core\firewall.nix | Format: .nix | Größe: 2,57 KB
``nix
{
 lib,
 config,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-011";
 title = "Firewall (NFTables Secured)";
 description = "Hardened nftables setup. Only SSoT ports and trusted LAN segments allowed. No legacy port 22.";
 layer = 00;
 nixpkgs.category = "system/networking";
 capabilities = ["network/firewall" "security/nftables"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 sshPort = config.my.ports.ssh;
 lanCidr = config.my.configs.network.lanCidr;
in {
 options.my.meta.firewall = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for firewall module";
 };

 config = {
 networking.nftables.enable = true;
 networking.firewall = {
 enable = true; # hardened: Firewall ALWAYS active.
 trustedInterfaces = [ "lo" "tailscale0" ];

 allowedTCPPorts = [
 443 # HTTPS (Caddy Edge)
 ];

 extraInputRules = ''

 set allowed_countries {
 type ipv4_addr
 flags interval
 elements = { 

 2.16.0.0/13, 2.160.0.0/11, 5.0.0.0/14, 5.144.0.0/13, # DE
 62.178.0.0/15, 77.116.0.0/14, # AT
 78.56.0.0/13, 82.135.128.0/17 # LT
 }
 }

 tcp dport 443 ip saddr != @allowed_countries counter drop

 tcp dport 443 ip6 saddr != { ::1/128, fe80::/10 } counter drop

 ip saddr ${lanCidr} tcp dport 53 accept
 ip saddr ${lanCidr} udp dport 53 accept

 ip saddr ${lanCidr} udp dport 5353 accept

 ip protocol icmp accept
 '';

 logRefusedConnections = true;
 };
 };
}

``n---
### [F-087] modules\core\graphics.nix
* Pfad: modules\core\graphics.nix | Format: .nix | Größe: 1,23 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-00-COR-036";
 title = "Hardware Graphics (Intel QuickSync)";
 description = "Enables VA-API and Intel UHD 630 hardware acceleration for high-performance transcoding.";
 layer = 00;
 capabilities = ["hardware/gpu" "media/transcoding"];
 };
in
{
 options.my.meta.graphics = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 hardware.graphics = {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver # For Broadwell+ (Q958 uses Coffee Lake)
 intel-vaapi-driver # For older apps
 vaapiVdpau
 libvdpau-va-gl
 ];
 };

 environment.variables = {
 LIBVA_DRIVER_NAME = "iHD";
 };

 environment.systemPackages = with pkgs; [
 intel-gpu-tools # For 'intel_gpu_top' diagnostics
 libva-utils # For 'vainfo'
 ];

 users.groups.render.members = [ "jellyfin" "media" ];
 users.groups.video.members = [ "jellyfin" "media" ];
 };
}

``n---
### [F-088] modules\core\hardware-configuration.nix
* Pfad: modules\core\hardware-configuration.nix | Format: .nix | Größe: 1,26 KB
``nix
{ config, lib, pkgs, modulesPath, ... }:
let
 nms = {
 id = "NIXH-00-COR-012";
 title = "Hardware Configuration";
 description = "Auto-generated hardware abstraction layer.";
 layer = 00;
 nixpkgs.category = "system/boot";
 capabilities = [ "system/hardware" "boot/initrd" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.hardware_configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

 config = {
 boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
 boot.initrd.kernelModules = [ ];
 boot.kernelModules = [ "kvm-intel" ];
 boot.extraModulePackages = [ ];
 fileSystems."/" = { device = "/dev/disk/by-uuid/8d1d5128-6413-4b5b-bd96-e55851ae5dc2"; fsType = "ext4"; };
 fileSystems."/boot" = { device = "/dev/disk/by-uuid/1EDF-972E"; fsType = "vfat"; options = [ "fmask=0077" "dmask=0077" ]; };
 swapDevices = [ ];
 nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}

``n---
### [F-089] modules\core\home-manager.nix
* Pfad: modules\core\home-manager.nix | Format: .nix | Größe: 1,96 KB
``nix
{
 config,
 lib,
 pkgs,
 inputs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-013";
 title = "Home Manager (User Cockpit)";
 description = "Hardened user environment. Git SSoT and Shell-Secret integration.";
 layer = 00;
 nixpkgs.category = "tools/admin";
 capabilities = ["user/environment" "shell/hardening" "git/configuration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.home_manager = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [ inputs.home-manager.nixosModules.home-manager ];

 config = {
 home-manager = {
 useGlobalPkgs = true;
 useUserPackages = true;
 backupFileExtension = "hm-backup";

 users.${user} = { pkgs, ... }: {
 home.stateVersion = "24.05"; # Stable anchor

 imports = [ (./user-${user}-home.nix) ];

 programs.git = {
 enable = true;
 userName = "Moritz";
 userEmail = "git@${config.my.configs.identity.domain}";
 extraConfig = {
 init.defaultBranch = "main";
 pull.rebase = true;
 core.editor = "micro";
 };
 aliases = {
 st = "status";
 co = "checkout";
 br = "branch";
 up = "pull --rebase";
 };
 };

 programs.bash = {
 enable = true;
 shellAliases = {

 godmode = "gemini --yolo --include-directories /etc/nixos,$(pwd)";
 };
 };
 };
 };
 };
}

``n---
### [F-090] modules\core\host.nix
* Pfad: modules\core\host.nix | Format: .nix | Größe: 662 B
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-016";
 title = "Host Identity";
 description = "Basic hostname and identity configuration for the server.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["system/identity"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.host = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for host module";
 };

 config = {
 networking.hostName = lib.mkForce config.my.configs.identity.host;
 };
}

``n---
### [F-091] modules\core\impermanence.nix
* Pfad: modules\core\impermanence.nix | Format: .nix | Größe: 1,33 KB
``nix
{ config, lib, ... }: {

 config = {

 environment.persistence."/persist" = {
 hideMounts = true;
 directories = [
 "/var/log"
 "/var/lib/nixos"
 "/var/lib/systemd/coredump"
 "/var/lib/sops-nix"
 "/etc/NetworkManager/system-connections"
 ];
 files = [
 "/etc/machine-id"
 "/etc/ssh/ssh_host_ed25519_key"
 "/etc/ssh/ssh_host_ed25519_key.pub"
 "/etc/ssh/ssh_host_rsa_key"
 "/etc/ssh/ssh_host_rsa_key.pub"
 ];
 };

 fileSystems."/" = {
 device = "none";
 fsType = "tmpfs";
 options = [ "defaults" "size=4G" "mode=755" ];
 };

 swapDevices = [];

 my.meta.impermanence = {
 id = "NIXH-00-COR-IMP";
 title = "Impermanence Core";
 description = "System-wide persistence for stateless root-on-RAM setup.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
 };
}

``n---
### [F-092] modules\core\kernel-slim.nix
* Pfad: modules\core\kernel-slim.nix | Format: .nix | Größe: 3,87 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-017";
 title = "Kernel Slim (Advanced Hardened)";
 description = "hardened optimized and hardened kernel. Max security via slab_nomerge and poison-paging.";
 layer = 00;
 nixpkgs.category = "system/boot";
 capabilities = ["kernel/hardening" "system/performance" "security/sysctl"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 ramBenchmark = pkgs.writeShellScriptBin "ram-benchmark" ''

 echo ""
 echo " Kernel RAM-Footprint Analyse"
 echo ""
 TOTAL=$(free -m | awk 'NR==2 {print $2}')
 USED=$(free -m | awk 'NR==2 {print $3}')
 echo "Gesamt-RAM: ''${TOTAL} MB"
 echo "Verwendet: ''${USED} MB"
 MODULES=$(lsmod | wc -l)
 echo "Geladene Module: $((MODULES - 1))"
 '';
in {
 options.my.meta.kernel_slim = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for kernel-slim module";
 };

 config = lib.mkIf (config.my.services.kernelSlim.enable) {
 boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

 boot.blacklistedKernelModules = [
 "bluetooth" "btusb" "btrtl" "btbcm" "btintel" "bnep" "rfcomm"
 "iwlwifi" "ath9k" "ath10k_core" "ath10k_pci" "rtl8192ce" 
 "rtl8192cu" "rtl8192de" "rtl8188ee" "mt76" "brcmfmac" "brcmutil"
 "nouveau" "radeon" "amdgpu" "mgag200" "ast" "pcspkr" "iTCO_wdt"
 "thunderbolt"
 ];

 boot.kernel.sysctl = {

 "net.ipv4.conf.all.rp_filter" = lib.mkForce 1;
 "net.ipv4.conf.default.rp_filter" = lib.mkForce 1;
 "net.ipv4.tcp_syncookies" = lib.mkForce 1;
 "net.ipv4.icmp_echo_ignore_broadcasts" = true;
 "net.ipv4.conf.all.accept_redirects" = false;
 "net.ipv4.conf.all.secure_redirects" = false;

 "kernel.kptr_restrict" = lib.mkForce 2;
 "kernel.dmesg_restrict" = lib.mkForce 1;
 "kernel.unprivileged_bpf_disabled" = 1; 
 "net.core.bpf_jit_enable" = false; # Against JIT spray
 "kernel.ftrace_enabled" = false;
 "kernel.perf_event_paranoid" = 3;

 "vm.swappiness" = 10;
 "vm.vfs_cache_pressure" = 50;
 };

 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "slab_nomerge" # Prevents heap grooming
 "page_poison=1" # Overwrites free'd pages
 "page_alloc.shuffle=1" # Randomizes page allocation
 "debugfs=off" # Closes debug attack vector
 ];

 boot.initrd.availableKernelModules = lib.mkForce ["ahci" "sd_mod" "xhci_pci" "usbhid" "usb_storage"];

 environment.systemPackages = with pkgs; [
 linuxPackages_latest.perf
 ramBenchmark
 kmod pciutils usbutils
 ];

 programs.bash.shellAliases = { ram-bench = "${ramBenchmark}/bin/ram-benchmark"; };

 systemd.services.kernel-slim-info = {
 description = "Kernel Slim Info Banner";
 wantedBy = ["multi-user.target"];
 serviceConfig = { Type = "oneshot"; RemainAfterExit = true; };
 script = ''
 logger -t kernel-slim "hardened Hardened Kernel loaded"
 MODULES=$(lsmod | wc -l)
 logger -t kernel-slim "Loaded modules: $((MODULES - 1))"
 '';
 };
 };
}

``n---
### [F-093] modules\core\lib-helpers-meta.nix
* Pfad: modules\core\lib-helpers-meta.nix | Format: .nix | Größe: 1,39 KB
``nix
{ lib, ... }: {

 options.my.meta = lib.mkOption {
 type = lib.types.attrsOf (lib.types.submodule {
 options = {
 id = lib.mkOption { 
 type = lib.types.str; 
 description = "Eindeutige ID (z.B. NIXH-60-APP-001)";
 };
 title = lib.mkOption { 
 type = lib.types.str; 
 description = "Anzeigename des Dienstes";
 };
 description = lib.mkOption {
 type = lib.types.str;
 default = "";
 };
 layer = lib.mkOption { 
 type = lib.types.int; 
 description = "Architektur-Layer (00-90)";
 };
 audit = {
 last_reviewed = lib.mkOption { 
 type = lib.types.str; 
 default = "2026-04-27";
 description = "Letztes Audit-Datum";
 };
 complexity = lib.mkOption {
 type = lib.types.int;
 default = 1;
 description = "Komplexitäts-Score (1-5)";
 };
 };
 source_repo = lib.mkOption {
 type = lib.types.str;
 default = "grapefruit89/mynixos";
 description = "Herkunfts-Repository (GitHub)";
 };
 };
 });
 default = {};
 description = "NMS Traceability Metadata Registry";
 };
}

``n---
### [F-094] modules\core\lib-helpers.nix
* Pfad: modules\core\lib-helpers.nix | Format: .nix | Größe: 7,68 KB
``nix
{ lib, pkgs, ... }: 
let

 getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";

 mkTracedOption = src: opt: opt // { 
 description = (opt.description or "") + " [Source: ${src}]"; 
 };

in {
 inherit mkTracedOption;

 mkService = {
 config,
 name,
 port,
 description ? "hardened Service",
 useSSO ? true,
 useVPN ? false, # Neu: VPN-Namespace Support
 netns ? null, # Expliziter Namespace-Name
 isStream ? false,
 readWritePaths ? [],
 persist ? true,
 socket ? false,
 extraServiceConfig ? {},
 }: let
 hostName = getDomain config name;
 targetUrl = if socket then "unix//run/service-sockets/${name}.sock" else "localhost:${toString port}";
 srePaths = config.my.configs.paths;

 appDataDir = "${srePaths.appData}/${name}";
 appCacheDir = "${srePaths.appCache}/${name}";

 finalNetns = if useVPN then (if netns != null then netns else "vpn-${name}") else null;

 in {

 systemd.services."${name}" = {
 inherit description;
 after = [ "network.target" ] ++ (lib.optional (finalNetns != null) "netns-${finalNetns}.service");
 bindsTo = lib.optional (finalNetns != null) "netns-${finalNetns}.service";

 serviceConfig = lib.recursiveUpdate {

 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 ReadWritePaths = readWritePaths ++ [ 
 appDataDir 
 appCacheDir
 "/var/lib/${name}" 
 ];

 NetworkNamespacePath = lib.mkIf (finalNetns != null) "/var/run/netns/${finalNetns}";
 } extraServiceConfig;
 };

 services.caddy.virtualHosts."${hostName}" = {
 extraConfig = let
 proxyCommand = if isStream then "import proxy_stream ${targetUrl}" else "reverse_proxy ${targetUrl}";
 in ''

 ${lib.optionalString useSSO "import sso_auth"}
 ${proxyCommand}
 '';
 };

 environment.persistence."/persist" = lib.mkIf persist {
 directories = [ "/var/lib/${name}" ];
 };

 my.meta.${name} = {
 id = "NIXH-AUTO-${name}";
 title = description;
 layer = 60;
 audit.last_reviewed = "2026-04-27";
 };
 };

 mkStreamer = {
 config,
 name,
 port,
 useGPU ? false,
 persist ? true,
 memoryMax ? "2G",
 cpuWeight ? 80,
 oomScoreAdjust ? 400,
 description ? "Streaming Service",
 useVPN ? false,
 }: let
 srePaths = config.my.configs.paths;
 stateDir = "${srePaths.stateDir}/${name}";
 cacheDir = "${srePaths.tierB}/cache/${name}";
 mediaDir = srePaths.mediaLibrary;
 in (lib.mkMerge [
 (config.myLib.mkService {
 inherit config name port description persist useVPN;
 isStream = true;
 readWritePaths = [ cacheDir mediaDir ];
 extraServiceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];

 MemoryMax = memoryMax;
 MemoryHigh = "85%"; # Gentle throttling before hard kill
 CPUWeight = cpuWeight;
 OOMScoreAdjust = oomScoreAdjust;
 PrivateDevices = if useGPU then lib.mkForce false else true;
 DeviceAllow = if useGPU then [ "/dev/dri/renderD128 rw" ] else [];
 };
 })
 {
 systemd.tmpfiles.rules = [
 "d ${stateDir} 0750 ${name} media -"
 "d ${cacheDir} 0775 ${name} media -"
 ];
 services.${name} = lib.optionalAttrs (name == "jellyfin") {
 dataDir = stateDir;
 inherit cacheDir;
 };
 }
 ]);

 mkDocumentApp = {
 config,
 name,
 port,
 description ? "Document Management Service",
 useValkey ? false,
 usePostgres ? true,
 memoryMax ? "2G",
 cpuWeight ? 50,
 oomScoreAdjust ? 400,
 persist ? true,
 ocrLanguages ? ["deu" "eng"],
 workerCount ? 2,
 secretFile ? null,
 }: let
 srePaths = config.my.configs.paths;
 stateDir = "${srePaths.stateDir}/${name}";
 consumeDir = "${srePaths.tierC}/consume/${name}";
 mediaDir = "${srePaths.mediaLibrary}/documents/${name}";
 cacheDir = "${srePaths.tierB}/cache/${name}";
 pythonHardening = {
 MemoryDenyWriteExecute = false;
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 in (lib.mkMerge [
 (config.myLib.mkService {
 inherit config name port description persist;
 useSSO = true;
 readWritePaths = [ stateDir consumeDir mediaDir cacheDir ];
 extraServiceConfig = pythonHardening // {
 inherit MemoryMax oomScoreAdjust;
 CPUWeight = cpuWeight;
 LoadCredential = lib.optional (secretFile != null) "${lib.toUpper name}_SECRET_KEY:${toString secretFile}";
 };
 })
 {
 systemd.services."${name}-worker" = {
 inherit description;
 after = [ "network.target" "redis-${name}.service" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];
 serviceConfig = lib.recursiveUpdate pythonHardening {
 User = name;
 Group = "media";
 ExecStart = "${config.services.${name}.package}/bin/celery -A ${name} worker -l info -c ${toString workerCount}";
 Restart = "always";
 ReadWritePaths = [ stateDir consumeDir mediaDir cacheDir ];
 };
 };
 systemd.services."${name}-beat" = {
 description = "${description} Scheduler";
 after = [ "network.target" "${name}-worker.service" ];
 wantedBy = [ "multi-user.target" ];
 serviceConfig = lib.recursiveUpdate pythonHardening {
 User = name;
 Group = "media";
 ExecStart = "${config.services.${name}.package}/bin/celery -A ${name} beat -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler";
 Restart = "always";
 ReadWritePaths = [ stateDir ];
 };
 };
 services.postgresql = lib.mkIf usePostgres {
 ensureDatabases = [ name ];
 ensureUsers = [ { name = name; ensureDBOwnership = true; } ];
 };
 services.redis.servers.${name} = lib.mkIf useValkey {
 enable = true;
 package = pkgs.valkey;
 port = 0;
 unixSocket = "/run/redis-${name}/redis.sock";
 unixSocketPerm = 660;
 };
 systemd.tmpfiles.rules = [
 "d ${stateDir} 0750 ${name} media -"
 "d ${consumeDir} 0775 ${name} media -"
 "d ${mediaDir} 0775 ${name} media -"
 "d ${cacheDir} 0750 ${name} media -"
 ];
 }
 ]);
}

``n---
### [F-095] modules\core\locale.nix
* Pfad: modules\core\locale.nix | Format: .nix | Größe: 1,30 KB
``nix
{ lib, config, ... }:
let

 nms = {
 id = "NIXH-00-COR-020";
 title = "Locale (SRE Refactored)";
 description = "Centralized localization settings using the Master Source of Truth.";
 layer = 0;
 nixpkgs.category = "system/localization";
 capabilities = ["system/localization" "ssot/locale"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };

 tz = config.my.configs.locale.timezone;
 loc = config.my.configs.locale.default;
in {
 options.my.meta.locale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for locale module";
 };

 config = {
 time.timeZone = lib.mkForce tz;
 i18n.defaultLocale = lib.mkForce loc;
 i18n.supportedLocales = lib.mkForce ["de_DE.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];

 console.keyMap = lib.mkForce "de-latin1";
 services.xserver.xkb = {
 layout = lib.mkForce "de";
 variant = "";
 };

 networking.timeServers = lib.mkForce [
 "0.de.pool.ntp.org"
 "1.de.pool.ntp.org"
 "2.de.pool.ntp.org"
 "3.de.pool.ntp.org"
 ];

 services.resolved = {
 enable = true;
 dnssec = "true";
 dnsovertls = "opportunistic";
 domains = [ "~." ];
 };
 };
}

``n---
### [F-096] modules\core\motd.nix
* Pfad: modules\core\motd.nix | Format: .nix | Größe: 1,45 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-022";
 title = "MOTD & Shell UI";
 description = "Dynamic login dashboard and interactive shell initialization.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["shell/ui" "system/status-reminders"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
 domain = config.my.configs.identity.domain;
 host = config.my.configs.identity.host;
 firewallReminder = if config.networking.firewall.enable then "Firewall: ACTIVE" else "WARNING: Firewall is DISABLED.";
in
{
 options.my.meta.motd = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
 environment.etc."motd".text = ''
 ${host}.${domain} (NMS v2.3 SRE Edition)
 ${firewallReminder}
 Standard Port: ${toString config.my.ports.ssh}
 Local Proxy: Caddy (Edge)
 '';
 programs.bash.interactiveShellInit = ''
 if [[ $- == *i* ]] && [[ -t 1 ]]; then
 IP=$(hostname -I | awk '{print $1}')
 echo -e "\e[1;32mWelcome back, ${config.my.configs.identity.user}!\e[0m"
 echo -e "\e[1;34mSystem IP:\e[0m $IP"
 if timeout 0.2 systemctl is-active --quiet sshd-recovery.service 2>/dev/null; then
 echo -e "\e[1;31m RECOVERY WINDOW ACTIVE (Port 2222)\e[0m"
 fi
 fi
 '';
 };
}

``n---
### [F-097] modules\core\network.nix
* Pfad: modules\core\network.nix | Format: .nix | Größe: 2,45 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-023";
 title = "Network (SRE Optimized)";
 description = "systemd-networkd configuration with DNS hardening, TCP BBR tuning and fast-boot optimization.";
 layer = 0;
 nixpkgs.category = "system/networking";
 capabilities = ["network/systemd-networkd" "performance/tcp-bbr" "security/dns-over-tls"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };
 cfg = config.my.profiles.networking.systemd-networkd;
in {
 options.my.meta.network = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf cfg.enable {
 networking.useNetworkd = true;
 networking.useDHCP = false;
 networking.networkmanager.enable = lib.mkForce false;

 systemd.network = {
 enable = true;
 config.networkConfig.IPv6PrivacyExtensions = "kernel";
 networks."10-lan" = {
 matchConfig.Name = "en*";
 networkConfig = {
 DHCP = "yes";
 IPv6AcceptRA = true;
 IPv4Forwarding = true;
 IPv6Forwarding = true;
 MulticastDNS = "yes";
 LLMNR = "no";
 };
 linkConfig.RequiredForOnline = "yes";
 };

 wait-online.anyInterface = true;
 };

 services.resolved = {
 enable = true;
 dnssec = lib.mkForce "allow-downgrade";
 domains = ["~."];
 fallbackDns = ["1.1.1.1" "8.8.8.8"];
 extraConfig = ''
 DNSOverTLS=yes
 Cache=yes
 CacheMaxAgeSec=86400
 '';
 };

 boot.kernel.sysctl = {
 "net.core.default_qdisc" = lib.mkForce "fq";
 "net.ipv4.tcp_congestion_control" = lib.mkForce "bbr";
 "net.core.netdev_max_backlog" = lib.mkForce 10000;
 "net.ipv4.tcp_slow_start_after_idle" = lib.mkForce 0;
 "net.ipv4.tcp_fastopen" = lib.mkForce 3;
 };

 services.avahi = {
 enable = true;
 nssmdns4 = true;
 publish = {
 enable = true;
 addresses = true;
 workstation = false; # M-03: No info leakage
 userServices = false;
 };
 };
 };
}

``n---
### [F-098] modules\core\nix-tuning.nix
* Pfad: modules\core\nix-tuning.nix | Format: .nix | Größe: 2,17 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-024";
 title = "Nix Tuning (Pure Binary Policy)";
 description = "Optimized nix-daemon settings. Strict binary-only enforcement to prevent local compilation wear.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["nix/tuning" "policy/binary-only" "maintenance/auto-gc" "impermanence/bash-fix"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.nix_tuning = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {
 nix.settings = {

 substituters = [
 "https://cache.nixos.org"
 "https://nix-community.cachix.org"
 ];
 trusted-public-keys = [
 "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
 "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
 ];

 max-jobs = lib.mkForce 0;
 builders-use-substitutes = true;
 fallback = false;

 auto-optimise-store = true;
 connect-timeout = 5;
 experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];

 sandbox = true;
 trusted-users = ["root" config.my.configs.identity.user];
 };

 nix.daemonCPUSchedPolicy = "idle";
 nix.daemonIOSchedClass = "idle";

 nix.gc = {
 automatic = true;
 dates = "weekly";
 options = "--delete-older-than 14d";
 };

 programs.bash.interactiveShellInit = "trap 'history -a' EXIT";

 environment.systemPackages = with pkgs; [
 cachix
 nix-tree
 nix-diff
 nix-output-monitor
 ];
 };
}

``n---
### [F-099] modules\core\ports.nix
* Pfad: modules\core\ports.nix | Format: .nix | Größe: 1,00 KB
``nix
{ lib, ... }: {

 options.my.ports = lib.mkOption {
 type = lib.types.attrsOf lib.types.port;
 default = {

 ssh = 53844;
 pocket-id = 8080;
 postgres = 5432;
 adguard = 3001; # Web UI

 home-assistant = 8123;
 n8n = 5678;
 ollama = 11434;

 jellyfin = 8096;
 sonarr = 8989;
 radarr = 7878;
 bazarr = 6767;
 prowlarr = 9696;
 sabnzbd = 8080;
 navidrome = 4533;
 audiobookshelf = 8000;

 paperless = 28981;

 vaultwarden = 8222;
 monica = 8080;
 karakeep = 20003;
 couchdb = 5984;

 netdata = 19999;
 scrutiny = 8080;
 uptime-kuma = 3001;
 gatus = 8111;
 };
 description = "Central port registry (SSoT)";
 };
}

``n---
### [F-100] modules\core\principles.nix
* Pfad: modules\core\principles.nix | Format: .nix | Größe: 1,46 KB
``nix
{ lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-026";
 title = "Architectural Principles";
 description = "The core manifesto of the NixHome project. Defines SRE standards and isomorphism.";
 layer = 00;
 nixpkgs.category = "documentation/architecture";
 capabilities = [ "architecture/manifesto" "system/standards" "sre/best-practices" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 source_repo = "grapefruit89/mynixos";
 };
in
{
 options.my.meta.principles = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 assertions = [
 {
 assertion = true; # Placeholder for future logic check
 message = "NMS v4.2: Architectural Integrity Check passed.";
 }
 ];
 };
}

``n---
### [F-101] modules\core\registry.nix
* Pfad: modules\core\registry.nix | Format: .nix | Größe: 3,09 KB
``nix
{lib, ...}: let

 nms = {
 id = "NIXH-00-COR-027";
 title = "Registry (Master Switch)";
 description = "Global feature-toggles for all layers. Single Source of Truth for service enablement.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/feature-flags" "ssot/registry"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.registry = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my = {
 profiles = {
 hardware.q958.enable = lib.mkOption { type = lib.types.bool; default = true; };
 networking.reverseProxy = lib.mkOption {
 type = lib.types.enum ["caddy" "none"];
 default = "caddy";
 };
 };

 services = {

 adguardhome.enable = lib.mkEnableOption "AdGuard Home";
 pocketId.enable = lib.mkEnableOption "Pocket-ID (OIDC)";
 postgresql.enable = lib.mkEnableOption "PostgreSQL Cluster";

 aiAgents.enable = lib.mkEnableOption "AI (Ollama/Claude)";
 homeAssistant.enable = lib.mkEnableOption "Home Assistant";
 n8n.enable = lib.mkEnableOption "n8n Workflows";

 jellyfin.enable = lib.mkEnableOption "Jellyfin";
 navidrome.enable = lib.mkEnableOption "Navidrome (Music)";
 audiobookshelf.enable = lib.mkEnableOption "Audiobookshelf";
 sonarr.enable = lib.mkEnableOption "Sonarr";
 radarr.enable = lib.mkEnableOption "Radarr";
 prowlarr.enable = lib.mkEnableOption "Prowlarr";
 sabnzbd.enable = lib.mkEnableOption "SABnzbd";
 storagePool.enable = lib.mkEnableOption "MergerFS Pool";

 paperless.enable = lib.mkEnableOption "Paperless-ngx";
 miniflux.enable = lib.mkEnableOption "Miniflux RSS";

 vaultwarden.enable = lib.mkEnableOption "Vaultwarden";
 monica.enable = lib.mkEnableOption "Monica CRM";

 netdata.enable = lib.mkEnableOption "Netdata";
 uptimeKuma.enable = lib.mkEnableOption "Uptime Kuma";
 scrutiny.enable = lib.mkEnableOption "Scrutiny";

 backup.enable = lib.mkEnableOption "Restic Backup";
 kernelSlim.enable = lib.mkEnableOption "Kernel Slim";
 shell.premium.enable = lib.mkEnableOption "Shell Premium";
 };
 };

 config.my.services = {

 adguardhome.enable = lib.mkDefault true;
 aiAgents.enable = lib.mkDefault true;
 audiobookshelf.enable = lib.mkDefault true;
 backup.enable = lib.mkDefault true;
 jellyfin.enable = lib.mkDefault true;
 navidrome.enable = lib.mkDefault true;
 paperless.enable = lib.mkDefault true;
 postgresql.enable = lib.mkDefault true;
 sonarr.enable = lib.mkDefault true;
 radarr.enable = lib.mkDefault true;
 vaultwarden.enable = lib.mkDefault true;
 shell.premium.enable = lib.mkDefault true;
 };
}

``n---
### [F-102] modules\core\secrets.nix
* Pfad: modules\core\secrets.nix | Format: .nix | Größe: 2,91 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-028";
 title = "Secrets (Sops Master Vault)";
 description = "Centralized secret-to-module mapping with NIXH-ID traceability. Uses age with SSH-hostkey backing.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["security/secrets" "sops/mapping" "age/encryption"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 secretMap = {
 "NIXH-40-MED-017" = "sonarr_api_key";
 "NIXH-40-MED-012" = "radarr_api_key";
 "NIXH-60-APP-007" = "vaultwarden_env";
 "NIXH-10-GTW-002" = "cloudflare_token";
 };
in {
 options.my.meta.secrets = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {
 sops = {
 defaultSopsFile = ../secrets.yaml;
 defaultSopsFormat = "yaml";

 age = {
 sshKeyPaths = [ 
 "/etc/ssh/ssh_host_ed25519_key"
 "/persist/etc/ssh/ssh_host_ed25519_key"

 "${config.my.configs.paths.tierB}/secrets/emergency_age_key.txt" 
 ];
 keyFile = "/var/lib/sops-nix/key.txt";
 generateKey = true;
 };

 secrets = {

 cloudflare_token = {};
 github_token = {};
 tailscale_token = {};
 unraid_root_password = {};

 n8n_enc_key = {};
 vaultwarden_env = {};
 paperless_secret_key = {};

 sonarr_api_key = {};
 radarr_api_key = {};
 readarr_api_key = {};

 restic_password = {};
 backblaze_access_key = {};
 backblaze_secret_key = {};
 };

 templates."media-stack.env" = {
 owner = "root";
 group = "media"; # Ermöglicht sonarr/radarr Zugriff
 mode = "0440";
 content = ''
 SONARR_API_KEY="${config.sops.placeholder.sonarr_api_key}"
 RADARR_API_KEY="${config.sops.placeholder.radarr_api_key}"
 '';
 };

 templates."caddy-env" = {
 owner = "caddy";
 mode = "0400";
 content = ''
 CLOUDFLARE_API_TOKEN="${config.sops.placeholder.cloudflare_token}"
 '';
 };

 templates."backblaze-restic.env" = {
 owner = "root";
 mode = "0400";
 content = ''
 AWS_ACCESS_KEY_ID="${config.sops.placeholder.backblaze_access_key}"
 AWS_SECRET_ACCESS_KEY="${config.sops.placeholder.backblaze_secret_key}"
 '';
 };
 };

 environment.systemPackages = [ pkgs.sops pkgs.age ];
 };
}

``n---
### [F-103] modules\core\shell-premium.nix
* Pfad: modules\core\shell-premium.nix | Format: .nix | Größe: 4,46 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-00-COR-029";
 title = "Shell Premium (M1 Abrams Edition)";
 description = "Hardened and optimized shell environment with Caddy health-checks and fastfetch reporting.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = [ "shell/premium" "observability/motd" "system/status-checker" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
 domain = config.my.configs.identity.domain;

 fastfetchConfig = pkgs.writeText "fastfetch-homelab.jsonc" (builtins.toJSON {
 logo = { source = "nixos"; padding = { top = 1; left = 2; }; };
 display = { separator = " "; color = { keys = "blue"; title = "green"; }; };
 modules = [
 { type = "title"; format = "{user-name}@{host-name}"; } "separator"
 { type = "os"; key = "OS"; } { type = "kernel"; key = "Kernel"; } { type = "uptime"; key = "Uptime"; }
 { type = "packages"; key = "Pkgs"; } { type = "shell"; key = "Shell"; } "break"
 { type = "cpu"; key = "CPU"; } { type = "gpu"; key = "GPU"; } { type = "memory"; key = "Mem"; }
 { type = "disk"; key = "Disk (/)"; folders = "/"; } "break"
 { type = "localip"; key = "LAN"; compact = true; }
 { type = "custom"; format = "https://${domain}"; key = "Base"; }
 { type = "custom"; format = "https://admin.${domain}"; key = "Admin"; } "break" "colors"
 ];
 });

 serviceStatusScript = pkgs.writeShellScriptBin "check-services" ''

 CRITICAL_SERVICES=("sshd:SSH" "caddy:Proxy" "tailscaled:VPN" "jellyfin:Jellyfin" "postgres:Database")
 echo -e "\n hardened Service Status:\n"
 for entry in "''${CRITICAL_SERVICES[@]}"; do
 service="''${entry%%:*}"; label="''${entry##*:}"
 if systemctl is-active --quiet "$service"; then
 echo -e " \e[32m$label\e[0m"
 else
 echo -e " \e[31m$label (DOWN!)\e[0m"
 fi
 done
 echo ""
 '';
in
{
 options.my.meta.shell_premium = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for shell-premium module";
 };

 config = lib.mkIf (config.my.shell.premium.enable && user == "moritz") {

 programs.bash.shellAliases = {

 nsw = "sudo nixos-rebuild switch --flake .#default";
 ntest = "sudo nixos-rebuild test --flake .#default";
 ndry = "sudo nixos-rebuild dry-run --flake .#default";

 nup = "nix flake update";
 nclean = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3 && sudo nix-store --gc";
 nopt = "sudo nix-store --optimise";
 nlog = "journalctl -xef";

 ls = "${pkgs.eza}/bin/eza --icons";
 ll = "${pkgs.eza}/bin/eza -la --icons --git";
 tree = "${pkgs.eza}/bin/eza --tree --icons";
 cat = "${pkgs.bat}/bin/bat --paging=never";
 sysinfo = "${pkgs.fastfetch}/bin/fastfetch --config ${fastfetchConfig}";
 services = "${serviceStatusScript}/bin/check-services";
 ports = "sudo ss -tulpn | grep LISTEN";

 gs = "git status -sb";
 ga = "git add";
 gc = "git commit -m";
 gp = "git push";
 };

 programs.bash.interactiveShellInit = ''

 if [[ $- == *i* ]]; then
 ${pkgs.fastfetch}/bin/fastfetch --config ${fastfetchConfig}
 ${serviceStatusScript}/bin/check-services
 echo " Hint: 'nsw' to rebuild, 'nlog' for logs, 'services' for health."
 fi
 '';

 environment.systemPackages = with pkgs; [
 bat eza ripgrep fd duf dust htop btop
 nix-tree nix-diff nixfmt-classic nix-output-monitor
 fastfetch micro git curl wget tree serviceStatusScript
 ];
 };
}

``n---
### [F-104] modules\core\shell.nix
* Pfad: modules\core\shell.nix | Format: .nix | Größe: 1,98 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-00-COR-030";
 title = "Shell";
 description = "Standardized Bash environment with productivity tools and basic maintenance aliases.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = [ "shell/bash" "tools/productivity" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 user = config.my.configs.identity.user;
in
{
 options.my.meta.shell = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for shell module";
 };

 config = lib.mkIf (user == "moritz") {
 programs.bash.shellAliases = {
 nsw = "sudo nixos-rebuild switch"; ntest = "sudo nixos-rebuild test"; ndry = "sudo nixos-rebuild dry-run"; nboot = "sudo nixos-rebuild boot";
 nclean = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-store --gc";
 nopt = "sudo nix-store --optimise"; ngen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
 ncfg = "cd /etc/nixos"; ngit = "cd /etc/nixos && git status -sb"; nlog = "journalctl -xef";
 ls = "${pkgs.eza}/bin/eza --icons"; ll = "${pkgs.eza}/bin/eza -la --icons --git"; tree = "${pkgs.eza}/bin/eza --tree --icons";
 cat = "${pkgs.bat}/bin/bat --paging=never"; less = "${pkgs.bat}/bin/bat"; top = "${pkgs.htop}/bin/htop";
 df = "${pkgs.duf}/bin/duf"; du = "${pkgs.dust}/bin/dust"; ports = "sudo ss -tulpn";
 };

 programs.bash.completion.enable = true;
 environment.systemPackages = with pkgs; [ bat eza ripgrep fd nix-tree nix-diff nixfmt fastfetch duf dust htop ];
 programs.git = { enable = true; config = { user.name = "Moritz Baumeister"; user.email = config.my.configs.identity.email; pull.ff = "only"; init.defaultBranch = "main"; }; };
 programs.bash.shellInit = "export HISTCONTROL=ignoredups:ignorespace\nexport EDITOR='micro'\nexport VISUAL='micro'";
 };
}

``n---
### [F-105] modules\core\ssh-rescue.nix
* Pfad: modules\core\ssh-rescue.nix | Format: .nix | Größe: 1,52 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-031";
 title = "SSH Rescue (Fail-Safe)";
 description = "Isolated emergency SSH instance on port 2222. Auto-terminates after 5 minutes via systemd-timer.";
 layer = 00;
 nixpkgs.category = "system/networking";
 capabilities = ["security/recovery" "ssh/fail-safe"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
 rescuePort = 2222;
in {
 options.my.meta.ssh_rescue = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf (config.my.services.sshRescue.enable or false) {

 systemd.services.sshd-rescue = {
 description = "Emergency SSH Service (Password Auth)";
 serviceConfig = {
 ExecStart = "${pkgs.openssh}/bin/sshd -D -f ${pkgs.writeText "sshd-rescue-config" ''
 Port ${toString rescuePort}
 ListenAddress 127.0.0.1
 ListenAddress 100.64.0.0/10 # Target: Tailscale only
 PasswordAuthentication yes
 PermitRootLogin no
 AllowUsers ${user}
 PidFile /run/sshd-rescue.pid
 ''}";
 KillMode = "process";
 Restart = "no";
 };
 };

 };
}

``n---
### [F-106] modules\core\ssh.nix
* Pfad: modules\core\ssh.nix | Format: .nix | Größe: 3,08 KB
``nix
{
 lib,
 config,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-032";
 title = "SSH (Post-Quantum Hardened)";
 description = "Hardened SSH daemon with Post-Quantum cryptography, strict CIDR-based forwarding and legal protections.";
 layer = 00;
 nixpkgs.category = "system/networking";
 capabilities = ["security/ssh" "network/hardening" "crypto/post-quantum"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 sshPort = config.my.ports.ssh;
 user = config.my.configs.identity.user;
 lanCidr = config.my.configs.network.lanCidr;
in {
 options.my.meta.ssh = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
 services.openssh = {
 enable = true;
 openFirewall = false; # Firewall wird separat in firewall.nix geregelt
 ports = [ sshPort ]; # Nur der Custom Port aus SSoT erlaubt

 banner = ''

 NIXOS hardened COCKPIT [v4.2]
 UNAUTHORIZED ACCESS IS PROHIBITED BY POLICY NIXH-90-POL-001
 System Owner: ${user} | Domain: ${config.my.configs.identity.domain}

 '';

 settings = {
 PermitRootLogin = "no";
 PasswordAuthentication = false;
 KbdInteractiveAuthentication = false;
 AllowUsers = [ user ];
 LogLevel = "VERBOSE";
 LoginGraceTime = 20;
 MaxAuthTries = 2;
 ClientAliveInterval = 300;
 ClientAliveCountMax = 2;
 X11Forwarding = false;

 KexAlgorithms = [
 "sntrup761x25519-sha512@openssh.com" # Post-Quantum champion
 "curve25519-sha256"
 "curve25519-sha256@libssh.org"
 ];
 Ciphers = [
 "chacha20-poly1305@openssh.com"
 "aes256-gcm@openssh.com"
 ];
 };

 extraConfig = ''
 Match Address 127.0.0.1,::1,${lanCidr}
 AllowTcpForwarding yes
 GatewayPorts yes
 '';
 };

 systemd.services.sshd = {
 stopIfChanged = false; # Verhindert SSH-Verlust bei Updates
 serviceConfig = {
 Restart = "always";
 RestartSec = "5s";
 ProtectProc = "invisible";
 ProcSubset = "pid";
 PrivateTmp = true;
 ProtectSystem = "strict";
 ProtectHome = "read-only";
 };
 };
 };
}

``n---
### [F-107] modules\core\storage.nix
* Pfad: modules\core\storage.nix | Format: .nix | Größe: 3,20 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-00-COR-035";
 title = "Storage Foundation";
 description = "Declarative storage paths and mergerfs pool definitions. Foundation for ABC-Tiering.";
 layer = 00;
 nixpkgs.category = "system/storage";
 capabilities = ["storage/mergerfs" "storage/abc-tiering"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 cfg = config.my.services.storagePool;

 srePaths = config.my.configs.paths;
 lanIP = config.my.configs.network.lanIP;
in
{
 options.my.meta.storage = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {

 systemd.mounts = [
 {
 description = "Unified Storage Pool (MergerFS)";
 where = "/storage";
 what = "/mnt/cache:/mnt/hdd1:/mnt/hdd2";
 type = "fuse.mergerfs";
 options = "allow_other,use_ino,cache.files=off,cache.entry=3600,cache.attr=3600,cache.readdir=true,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,noatime";
 wantedBy = [ "multi-user.target" ];
 }
 {
 description = "App Data Synergy Pool (Tier A/B)";
 where = "/mnt/app-data-synergy";
 what = "${srePaths.appData}:${srePaths.tierB}/appdata";
 type = "fuse.mergerfs";
 options = "allow_other,use_ino,cache.files=off,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=app-data-synergy,noatime";
 wantedBy = [ "multi-user.target" ];
 }
 ];

 systemd.services.hdd-inode-warmer = {
 description = "Refined Inode Warmer for HDD Ghost-Tree";
 serviceConfig = {
 Type = "oneshot";
 ExecStart = "${pkgs.findutils}/bin/find /mnt/hdd_pool -mindepth 1 -maxdepth 5 -exec stat {} +";
 };
 };

 systemd.timers.hdd-inode-warmer = {
 description = "Timer for HDD Metadata Cache Warmer";
 timerConfig = {
 OnCalendar = "00/6:00:00";
 Unit = "hdd-inode-warmer.service";
 };
 wantedBy = [ "timers.target" ];
 };

 systemd.services.storage-init = {
 description = "Storage Path Initialization";
 wantedBy = [ "multi-user.target" ];
 serviceConfig.Type = "oneshot";
 script = ''

 mkdir -p /storage/{media,downloads,documents,backups}
 mkdir -p ${srePaths.tierB}/appdata

 chown -R root:media /storage/media /storage/downloads
 chmod -R 775 /storage/media /storage/downloads
 '';
 };

 services.udev.extraRules = ''
 SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -S 120 /dev/%k"
 '';

 environment.systemPackages = with pkgs; [ mergerfs util-linux hdparm ];
 };
}

``n---
### [F-108] modules\core\symbiosis.nix
* Pfad: modules\core\symbiosis.nix | Format: .nix | Größe: 1,60 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-033";
 title = "Symbiosis";
 description = "Hardware abstraction layer with auto-discovery and microcode management.";
 layer = 0;
 nixpkgs.category = "system/hardware";
 capabilities = ["hardware/discovery" "hardware/management"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 userConfigFile = "/var/lib/nixhome/user-config.json";
 cpuType = config.my.configs.hardware.cpuType or "none";
 ramGB = config.my.configs.hardware.ramGB or 0;
in {
 options.my.meta.symbiosis = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for symbiosis module";
 };

 config = {
 hardware.cpu.intel.updateMicrocode = lib.mkForce (lib.mkIf (cpuType == "intel") true);
 hardware.cpu.amd.updateMicrocode = lib.mkForce (lib.mkIf (cpuType == "amd") true);
 warnings = lib.optional (ramGB < 4) " [HARDWARE-WARNUNG] Weniger als 4GB RAM erkannt (${toString ramGB}GB).";
 environment.etc."nixhome-hw-age-check".source = pkgs.writeShellScript "hw-check" "if [ -f '${userConfigFile}' ]; then AGE=$(( $(date +%s) - $(stat -c %Y '${userConfigFile}') )); if [ $AGE -gt 2592000 ]; then echo ' Hardware-Profil ist älter als 30 Tage. Ausführen: nixhome-detect-hw'; fi; fi";
 environment.systemPackages = [(pkgs.writeShellScriptBin "nixhome-detect-hw" "set -euo pipefail; echo ' Hardware-Discovery...'; RAM=$(free -g | awk '/^Speicher:/ {print $2}'); echo '{\"ram_gb\": '$RAM'}';")];
 };
}

``n---
### [F-109] modules\core\system-stability.nix
* Pfad: modules\core\system-stability.nix | Format: .nix | Größe: 2,59 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-034";
 title = "System Stability (SRE Guard)";
 description = "Proactive maintenance and fail-safe logic (Watchdogs, Kernel-Panic, EFI-Cleanup).";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/maintenance" "safety/watchdog" "safety/recovery"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.system_stability = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 systemd.watchdog.runtimeTime = "30s";
 systemd.watchdog.rebootTime = "10min";

 boot.kernel.sysctl = {
 "kernel.panic" = 10; # Reboot nach 10 Sek bei Panic
 "kernel.panic_on_oops" = 1;
 "vm.panic_on_oom" = 0; # OOM-Killer bevorzugt vor Reboot
 };

 system.activationScripts.cleanEfiEntries = {
 text = ''
 echo " hardened: Bereinige verwaiste EFI-Boot-Einträge..."
 ${pkgs.efibootmgr}/bin/efibootmgr | grep "Boot[0-9]" | grep -vE "systemd-boot|NixOS|Linux|USB|Hard Drive|Network" | \
 ${pkgs.gawk}/bin/awk '{print $1}' | ${pkgs.gnused}/bin/sed 's/Boot//;s/\*//' | \
 xargs -I{} ${pkgs.efibootmgr}/bin/efibootmgr -b {} -B 2>/dev/null || true
 '';
 };

 systemd.services.nixhome-emergency = {
 description = "NixOS Home Emergency Recovery Info";
 serviceConfig = {
 Type = "oneshot";
 StandardOutput = "tty";
 TTYPath = "/dev/tty1";
 };
 script = ''
 echo ""
 echo " NIXHOME v4.2 SYSTEM STABILITY ALERT"
 echo "Manual Recovery: Use SSH Rescue Port 2222"
 echo "" > /dev/tty1
 '';
 };
 };
}

``n---
### [F-110] modules\core\system.nix
* Pfad: modules\core\system.nix | Format: .nix | Größe: 2,56 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-035";
 title = "Stateless System (Wipe-on-Boot)";
 description = "Stateless root on tmpfs with declarative persistence via Impermanence. ADR 852 compliant.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["system/stateless" "impermanence/active" "kernel/hardening"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.system = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {

 fileSystems."/" = lib.mkForce {
 device = "none";
 fsType = "tmpfs";
 options = [ "defaults" "size=4G" "mode=755" ];
 };

 environment.persistence."/persist" = {
 hideMounts = true;
 directories = [
 "/var/lib/sops-nix"
 "/var/lib/nixos"
 "/etc/nixos"
 "/var/lib/tailscale"
 "/var/lib/bluetooth"
 "/var/lib/pocket-id"
 "/var/log"
 ];
 files = [
 "/etc/machine-id"
 "/etc/ssh/ssh_host_ed25519_key"
 "/etc/ssh/ssh_host_ed25519_key.pub"
 ];
 };

 boot.loader = {
 systemd-boot = {
 enable = lib.mkForce true;
 configurationLimit = lib.mkForce 15;
 editor = false;
 };
 efi.canTouchEfiVariables = lib.mkForce true;
 grub.enable = lib.mkForce false;
 timeout = lib.mkForce 3;
 };

 boot.kernel.sysctl = {
 "net.ipv4.conf.all.rp_filter" = lib.mkForce 1;
 "net.ipv4.tcp_syncookies" = lib.mkForce 1;
 "kernel.kptr_restrict" = lib.mkForce 2;
 "kernel.unprivileged_bpf_disabled" = lib.mkForce 1;
 };

 nixpkgs.config.allowUnfree = true;
 programs.nix-ld.enable = true;

 documentation.nixos.enable = false;

 environment.systemPackages = with pkgs; [
 nodejs_22
 alejandra
 git
 htop
 wget
 curl
 tree
 unzip
 file
 nix-output-monitor
 rsync
 hdparm
 pciutils
 usbutils
 ];

 environment.sessionVariables = {
 PATH = "/home/${config.my.configs.identity.user}/.npm-global/bin:$PATH";
 };
 };
}

``n---
### [F-111] modules\core\tty-info.nix
* Pfad: modules\core\tty-info.nix | Format: .nix | Größe: 2,47 KB
``nix
{
 config,
 pkgs,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-036";
 title = "Tty Info";
 description = "Service to display critical system information like IP addresses on the physical console (TTY1).";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/observability" "hardware/console-info"];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in {
 options.my.meta.tty_info = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for tty-info module";
 };

 config = {
 systemd.services.tty-ip-info = {
 description = "Display IP Address on TTY1";
 after = ["network-online.target"];
 wants = ["network-online.target"];
 wantedBy = ["multi-user.target"];
 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 StandardOutput = "tty";
 TTYPath = "/dev/tty1";

 Restart = "always";
 RestartSec = "10s";
 OOMScoreAdjust = -1000;
 };
 script = ''
 sleep 2
 echo -e "\n\033[1;32m\033[0m"
 echo -e "\033[1;32m NIXHOME SYSTEM STATUS\033[0m"
 echo -e "\033[1;32m\033[0m"
 echo -e "\n\033[1;34m IPv4 Adressen:\033[0m"
 ${pkgs.iproute2}/bin/ip -4 -o addr show | ${pkgs.gnugrep}/bin/grep -v 'lo' | ${pkgs.gawk}/bin/awk '{print " " $2 ": " $4}' | ${pkgs.gnused}/bin/sed 's|/[0-9]*||'
 echo -e "\n\033[1;34m Lokale URLs:\033[0m"
 echo -e " http://nixhome.local\n http://10.254.0.1 (Notfall-Anker)\n http://$(hostname).local"
 echo -e "\n\033[1;33m SSH Zugang:\033[0m"
 echo -e " ssh ${config.my.configs.identity.user}@10.254.0.1 -p ${toString config.my.ports.ssh}"
 echo -e "\n\033[1;32m\033[0m\n"
 '';
 };
 };
}

``n---
### [F-112] modules\core\zram-swap.nix
* Pfad: modules\core\zram-swap.nix | Format: .nix | Größe: 1,45 KB
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-040";
 title = "Zram Swap (AI Optimized)";
 description = "Optimized compressed RAM swap for AI workloads (Ollama/Claude). High swappiness for CPU-efficient memory management.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/performance" "hardware/ram-optimization" "ai/optimization"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 ramGB = config.my.configs.hardware.ramGB or 16;
in {
 options.my.meta.zram_swap = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for zram-swap module";
 };

 config = {
 zramSwap = {
 enable = true;
 algorithm = "zstd"; # hardened standard for best ratio
 priority = 100;
 memoryPercent =
 if ramGB <= 4 then 75
 else if ramGB <= 8 then 60
 else 40; # 40% of RAM for ZRAM to buffer AI models
 };

 boot.kernel.sysctl = {

 "vm.swappiness" = lib.mkForce 180; # Kernels move pages aggressively to ZRAM
 "vm.page-cluster" = 0; # Skip expensive read-ahead on ZRAM
 "vm.vfs_cache_pressure" = 50; # Keep directory entries in RAM longer
 };
 };
}

``n---
### [F-113] modules\logging\vector-hdd.nix
* Pfad: modules\logging\vector-hdd.nix | Format: .nix | Größe: 3,33 KB
``nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.logging.vector;
 srePaths = config.my.configs.paths;
 logDir = "${srePaths.tierC}/logs/system";
 maxTotalSizeMB = 1024; # 1 GB
in
{
 options.my.logging.vector = {
 enable = lib.mkEnableOption "Vector logging to HDD (Tier C)";
 retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
 maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 200; };
 ntfyTopic = lib.mkOption { 
 type = lib.types.nullOr lib.types.str; 
 default = "nixhome-alerts"; 
 description = "Ntfy topic for emergency alerts (ERROR level).";
 };
 };

 config = lib.mkIf cfg.enable {

 services.journald.extraConfig = ''Storage=volatile'';

 services.vector = {
 enable = true;
 config = {
 sources.journald = {
 type = "journald";
 current_boot_only = false;
 };

 transforms.mask_sensitive = {
 type = "remap";
 inputs = [ "journald" ];
 source = ''

 .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
 .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
 '';
 };

 transforms.error_filter = {
 type = "filter";
 inputs = [ "mask_sensitive" ];
 condition = ''includes(["err", "crit", "alert", "emerg"], .priority) || .level == "error" || .level == "critical" '';
 };

 sinks.file = {
 type = "file";
 inputs = [ "mask_sensitive" ];
 path = "${logDir}/journal-%Y-%m-%d.log";
 encoding.codec = "ndjson";
 compression = "gzip";
 batch.max_bytes = 50 * 1024 * 1024; # 50MB for HDD efficiency
 batch.timeout_secs = 300; # 5 minutes
 healthcheck = true;
 };

 sinks.ntfy = lib.mkIf (cfg.ntfyTopic != null) {
 type = "http";
 inputs = [ "error_filter" ];
 uri = "https://ntfy.sh/${cfg.ntfyTopic}";
 method = "post";
 encoding.codec = "text";

 batch.max_events = 1;
 };
 };
 };

 systemd.services.rotate-vector-logs = {
 description = "Rotate and delete old Vector logs (size/age based)";
 serviceConfig = {
 Type = "oneshot";
 Nice = 19;
 IOSchedulingClass = "idle";
 ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
 set -euo pipefail
 find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete

 '';
 };
 };

 systemd.timers.rotate-vector-logs = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };

 systemd.tmpfiles.rules = [ "d ${logDir} 0750 root root - -" ];
 };
}

``n---
### [F-114] modules\monitoring\gatus.nix
* Pfad: modules\monitoring\gatus.nix | Format: .nix | Größe: 3,49 KB
``nix
{ config, lib, pkgs, myLib, ... }:

let
 cfg = config.my.monitoring.gatus;
 srePaths = config.my.configs.paths;
 identity = config.my.configs.identity;

 gatusConfig = let

 publicUrl = "https://gatus.${identity.subdomain}.${identity.domain}";

 yamlStruct = {
 storage = {
 type = "sqlite";
 path = "${srePaths.stateDir}/gatus/data.db";
 };
 web = {
 port = cfg.port;
 address = "0.0.0.0";
 };
 endpoints = cfg.endpoints ++ [
 { 
 name = "Gatus Self"; 
 url = "http://localhost:${toString cfg.port}/api/v1/health"; 
 interval = "60s"; 
 conditions = [ "[STATUS] == 200" ]; 
 }
 ];
 } // (lib.optionalAttrs cfg.ntfy.enable {
 alerting = {
 ntfy = {
 inherit (cfg.ntfy) url topic priority;
 click = publicUrl;
 };
 };
 });
 in pkgs.writeText "gatus.yaml" (builtins.toJSON yamlStruct);

in {
 options.my.monitoring.gatus = {
 enable = lib.mkEnableOption "Gatus Health Dashboard";
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.gatus; };

 ntfy = lib.mkOption {
 type = lib.types.submodule {
 options = {
 enable = lib.mkEnableOption "ntfy alerting";
 url = lib.mkOption { 
 type = lib.types.str; 
 default = "https://ntfy.sh"; 
 description = "ntfy server URL";
 };
 topic = lib.mkOption { 
 type = lib.types.str; 
 default = "gatus-alerts"; 
 description = "ntfy topic";
 };
 priority = lib.mkOption { 
 type = lib.types.int; 
 default = 3; 
 description = "ntfy priority (1-5)";
 };
 };
 };
 default = {};
 };

 endpoints = lib.mkOption {
 type = lib.types.listOf lib.types.attrs;
 default = [
 { 
 name = "Caddy Local"; 
 url = "http://localhost:2019/config/"; 
 interval = "60s"; 
 conditions = [ "[STATUS] == 200" ]; 
 }
 { 
 name = "Jellyfin"; 
 url = "http://localhost:8096/health"; 
 interval = "60s"; 
 conditions = [ "[STATUS] == 200" ]; 
 }
 { 
 name = "Navidrome"; 
 url = "http://localhost:4533/rest/ping.view"; 
 interval = "60s"; 
 conditions = [ "[STATUS] == 200" ]; 
 }
 { 
 name = "Pocket-ID"; 
 url = "http://localhost:8080/health"; 
 interval = "60s"; 
 conditions = [ "[STATUS] == 200" ]; 
 }
 ];
 description = "List of endpoints to monitor (declarative).";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "gatus";
 port = cfg.port;
 useSSO = true;
 persist = true;
 description = "Gatus Health Dashboard";
 extraServiceConfig = {
 ExecStart = lib.mkForce "${pkgs.gatus}/bin/gatus --config ${gatusConfig}";
 };
 })

 {

 systemd.tmpfiles.rules = [
 "d ${srePaths.stateDir}/gatus 0750 gatus gatus -"
 ];
 }
 ]);
}

``n---
### [F-115] modules\security\binary-only.nix
* Pfad: modules\security\binary-only.nix | Format: .nix | Größe: 857 B
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-90-POL-001";
 title = "Binary-Only Policy";
 description = "Enforces a strict download-only workflow by forbidding local compilation to protect system resources.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "system/stability" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.binary_only = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for binary-only module";
 };

 config = {
 nix.settings.max-jobs = lib.mkForce 0;
 assertions = [ { assertion = config.nix.settings.max-jobs == 0; message = " [POLICY-VIOLATION] Lokales Kompilieren ist verboten!"; } ];
 };
}

``n---
### [F-116] modules\security\flat-layout.nix
* Pfad: modules\security\flat-layout.nix | Format: .nix | Größe: 1,58 KB
``nix
{ lib, ... }:
let
 nms = {
 id = "NIXH-01-SEC-FLAT-001";
 title = "Flat Layout Enforcement (Horizontal)";
 description = "Enforces zero-depth directory structure for modular silos.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "architecture/integrity" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 layersToCheck = [
 ../core
 ../services
 ../apps
 ../security
 ];

 hasSubdirs = dir: 
 let

 contents = if builtins.pathExists dir then builtins.readDir dir else {};
 dirs = lib.filterAttrs (n: v: v == "directory") contents;
 in
 (builtins.length (builtins.attrNames dirs)) > 0;

 offendingLayers = lib.filter (dir: hasSubdirs dir) layersToCheck;
in
{
 options.my.meta.flat_layout = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config.assertions = [
 {
 assertion = (builtins.length offendingLayers) == 0;
 message = " NIXHOME HORIZONTAL VIOLATION: Subdirectories in modules/ silos are strictly forbidden! (hardened Rule)";
 }
 ];
}

``n---
### [F-117] modules\security\hardened-core.nix
* Pfad: modules\security\hardened-core.nix | Format: .nix | Größe: 2,75 KB
``nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.security.hardened;
 nms = {
 id = "NIXH-00-SEC-COR-001";
 title = "Hardened Core (fortress)";
 description = "Master security module implementing kernel lockdown, massive blacklisting, and service slimming.";
 layer = 00;
 audit.last_reviewed = "2026-04-28";
 audit.complexity = 4;
 };
in {
 options.my.security.hardened = {
 enable = lib.mkEnableOption "Hardened Core Hardening";
 lockdownMode = lib.mkOption {
 type = lib.types.enum [ "strict" "permissive" ];
 default = "permissive";
 description = "strict: Kernellock enable, permissive: Kernellock disable";
 };
 };
 config = lib.mkIf cfg.enable (lib.mkMerge [
 {
 boot.kernelPackages = pkgs.linuxPackages_hardened;
 security.lockKernelModules = cfg.lockdownMode == "strict";
 boot.kernelModules = [ "veth" "loop" "nvme" "ahci" "usb_storage" "tun" ];
 security.hideProcessInformation = true;
 boot.kernel.sysctl = {
 "kernel.kptr_restrict" = 2;
 "kernel.dmesg_restrict" = 1;
 "kernel.unprivileged_bpf_disabled" = 1;
 "net.core.bpf_jit_harden" = 2;
 "kernel.yama.ptrace_scope" = 2;
 "kernel.ftrace_enabled" = false;
 "net.ipv4.conf.all.rp_filter" = 1;
 "net.ipv4.conf.default.rp_filter" = 1;
 "net.ipv4.icmp_echo_ignore_broadcasts" = true;
 "net.ipv4.conf.all.accept_redirects" = false;
 "net.ipv4.conf.default.accept_redirects" = false;
 "net.ipv6.conf.all.accept_redirects" = false;
 "net.ipv6.conf.default.accept_redirects" = false;
 "fs.protected_symlinks" = 1;
 "fs.protected_hardlinks" = 1;
 "fs.protected_fifos" = 1;
 "fs.protected_regular" = 1;
 };
 }
 {
 boot.blacklistedKernelModules = [
 "bluetooth" "btusb" "btrtl" "btbcm" "btintel" "bnep" "rfcomm" "thunderbolt"
 "iwlwifi" "ath9k" "ath10k_core" "ath10k_pci" "rtl8192ce" "rtl8192cu" "rtl8192de" "rtl8188ee" "mt76" "brcmfmac" "brcmutil"
 "nouveau" "radeon" "amdgpu" "mgag200" "ast"
 "ax25" "netrom" "rose"
 "ext2" "ext3" "jfs" "reiserfs" "hfs" "hfsplus" "ntfs" "vfat" "cramfs" "freevxfs" "minix" "nilfs2" "sysv" "ufs"
 "pcspkr" "iTCO_wdt"
 ];
 }
 {
 systemd.services = {
 accounts-daemon.enable = false;
 ModemManager.enable = false;
 udisks2.enable = false;
 upower.enable = false;
 cups.enable = false;
 bluetooth.enable = false;
 wpa_supplicant.enable = false;
 pcscd.enable = false;
 };
 systemd.maskedUnits = [ "plymouth-quit-wait.service" "systemd-networkd-wait-online.service" ];
 }
 { my.meta.hardened_core = nms; }
 ]);
}

``n---
### [F-118] modules\security\no-legacy.nix
* Pfad: modules\security\no-legacy.nix | Format: .nix | Größe: 1,24 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-90-POL-003";
 title = "No Legacy";
 description = "Blocks legacy services and insecure protocols.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "security/hardening" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
 msg = prefix: alt: " [LEGACY-BLOCK] ${prefix} ist veraltet. Nutze ${alt}.";
in
{
 options.my.meta.no_legacy = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
 assertions = [
 { assertion = !config.boot.loader.grub.enable; message = msg "GRUB" "systemd-boot"; }
 { assertion = !config.services.cron.enable; message = msg "Cron" "systemd.timers"; }
 { assertion = !config.networking.networkmanager.enable; message = msg "NetworkManager" "systemd-networkd"; }
 ];
 services.samba.settings.global."server min protocol" = "SMB2_10";
 boot.blacklistedKernelModules = [ "ext2" "ext3" "jfs" "reiserfs" "hfs" "hfsplus" "ntfs" ];
 networking.nftables.enable = true;
 networking.firewall.enable = lib.mkForce true;
 boot.initrd.compressor = "zstd";
 };
}

``n---
### [F-119] modules\security\runtime-guard.nix
* Pfad: modules\security\runtime-guard.nix | Format: .nix | Größe: 1,95 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-90-POL-002";
 title = "Runtime Security Watchdog";
 description = "Checks active system state (not just config) and alerts on violations.";
 layer = 90;
 };
in
{
 options.my.security.runtime-guard = {
 enable = lib.mkEnableOption "Runtime Security Monitoring";
 interval = lib.mkOption { type = lib.types.str; default = "hourly"; };
 };

 config = lib.mkIf config.my.security.runtime-guard.enable {
 my.meta.runtime_guard = nms;

 systemd.services.security-watchdog = {
 description = "hardened Runtime Security Check";
 serviceConfig = {
 Type = "oneshot";
 User = "root";
 };
 script = ''
 set -euo pipefail

 if ! ${pkgs.nftables}/bin/nft list tables | grep -q "inet filter"; then
 echo " SECURITY ALERT: nftables filter table is MISSING!"
 exit 1
 fi

 if [ -d /sys/kernel/security/lockdown ]; then
 LOCKDOWN=$(cat /sys/kernel/security/lockdown | grep -o '\[.*\]' | tr -d '[]')
 if [ "$LOCKDOWN" != "confidentiality" ] && [ "$LOCKDOWN" != "integrity" ]; then
 echo " SECURITY ALERT: Kernel Lockdown is NOT effective (Current: $LOCKDOWN)"

 fi
 fi

 if ${pkgs.openssh}/bin/sshd -T | grep -q "permitrootlogin yes"; then
 echo " SECURITY ALERT: sshd allows root login in active config!"
 exit 1
 fi

 echo " Runtime Security Check passed."
 '';
 };

 systemd.timers.security-watchdog = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = config.my.security.runtime-guard.interval;
 Persistent = true;
 };
 };
 };
}

``n---
### [F-120] modules\security\security-assertions.nix
* Pfad: modules\security\security-assertions.nix | Format: .nix | Größe: 2,28 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-90-POL-001";
 title = "security Policy Guard";
 description = "Monitors system integrity. Currently configured for non-blocking warnings.";
 layer = 90;
 audit.last_reviewed = "2026-04-28";
 audit.complexity = 2;
 };

 mkChecks = checks: map (c: {
 assertion = c.cond;
 message = c.msg;
 }) checks;

 securityChecks = [
 {
 cond = config.networking.firewall.enable;
 msg = " [SEC-NET-001]: Firewall is disabled! Not recommended for production use.";
 }
 {
 cond = config.networking.nftables.enable;
 msg = " [SEC-NET-002]: NFTables is disabled! Using legacy iptables is not hardened.";
 }
 {
 cond = config.services.openssh.settings.PermitRootLogin == "no";
 msg = " [SEC-SSH-002]: SSH Root Login is NOT disabled! Huge security risk.";
 }
 {
 cond = config.my.security.hardened.enable;
 msg = " [SEC-COR-001]: hardened Core module is missing or disabled!";
 }
 {
 cond = config.my.configs.bastelmodus || (config.my.security.hardened.lockdownMode == "strict");
 msg = " [SEC-COR-002]: Kernel Lockdown is NOT set to 'strict' (and bastelmodus is off)!";
 }
 {
 cond = lib.hasPrefix "/persist" config.my.configs.paths.tierA;
 msg = " [SEC-STO-001]: Tier A storage is NOT under /persist! Impermanence integrity at risk.";
 }
 ];

in
{
 options.my.security.policy = {
 mode = lib.mkOption {
 type = lib.types.enum [ "warn" "strict" ];
 default = "strict";
 description = "Policy enforcement mode: 'warn' (non-blocking) or 'strict' (fail build).";
 };
 };

 config = {

 my.meta.security_assertions = nms;

 warnings = lib.mkIf (config.my.security.policy.mode == "warn") (mkChecks securityChecks);
 assertions = lib.mkIf (config.my.security.policy.mode == "strict") (mkChecks securityChecks);
 };
}

``n---
### [F-121] modules\services\caddy.nix
* Pfad: modules\services\caddy.nix | Format: .nix | Größe: 9,33 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-SRV-CAD-001";
 title = "Caddy (M1 Abrams v2)";
 description = "Hardened Edge Proxy with GeoIP, mTLS, SSO and Rate-Limiting. Decoupled horizontal architecture.";
 layer = 10;
 nixpkgs.category = "servers/proxy";
 capabilities = ["network/ingress" "security/waf" "security/mtls" "security/geoip" "automation/dns-01"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.services.caddy;
 sreConfig = config.my.configs;

 trustedIPs = lib.concatStringsSep " " (
 ["127.0.0.1" "173.245.48.0/20" "103.21.244.0/22" "103.22.200.0/22" "103.31.4.0/22" "141.101.64.0/18" "108.162.192.0/18" "190.93.240.0/20" "188.114.96.0/20" "197.234.240.0/22" "198.41.128.0/17" "162.158.0.0/15" "104.16.0.0/13" "104.24.0.0/14" "172.64.0.0/13" "131.0.72.0/22"]
 ++ sreConfig.network.tailnetCidrs
 ++ sreConfig.network.lanCidrs
 );

in {
 options.my.meta.caddy = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.caddy.enable {

 boot.kernel.sysctl = {
 "net.core.rmem_max" = 8388608;
 "net.core.wmem_max" = 8388608;
 "net.ipv4.tcp_fastopen" = 3;
 };

 services.caddy = {
 enable = true;

 globalConfig = ''
 admin localhost:2019

 servers {
 trusted_proxies static ${trustedIPs}
 trusted_proxies_strict

 max_header_size 16kb
 }

 acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
 '';

 extraConfig = ''

 (compression) {
 encode br zstd gzip
 }

 (honeypot) {
 @evil_paths {
 not remote_ip private_ranges
 path /.env* /.git* /.vscode* /wp-config* /config.json* /actuator* /phpmyadmin* /.aws* /.ssh* /xmlrpc.php /wp-login* /admin* /setup.php /install.php /shell* /cmd.php /cgi-bin*
 }
 handle @evil_paths {

 header -Server
 abort
 }
 }

 (ddos_shield) {

 @is_auth {
 header_regexp Cookie "pocketid_session="
 }

 @is_human {
 header_regexp Cookie "m7c5_human=verified"
 not remote_ip 127.0.0.1
 not remote_ip ${trustedIPs}
 }
 rate_limit @is_human {
 zone human_limit {
 key {remote_host}
 window 1m
 max_events 500
 }
 }

 @is_unknown {
 not header_regexp Cookie "m7c5_human=verified"
 not header_regexp Cookie "pocketid_session="
 not remote_ip 127.0.0.1
 not remote_ip ${trustedIPs}
 }
 rate_limit @is_unknown {
 zone bot_limit {
 key {remote_host}
 window 1m
 max_events 30
 }
 }
 }

 (human_challenge) {
 @need_challenge {
 not header_regexp Cookie "m7c5_human=verified"
 not header_regexp Cookie "pocketid_session="
 not remote_ip 127.0.0.1
 not remote_ip ${trustedIPs}
 not path /api

``n---
### [F-122] modules\services\clamav.nix
* Pfad: modules\services\clamav.nix | Format: .nix | Größe: 1,28 KB
``nix
{ lib, pkgs, config, ... }:
let
 nms = {
 id = "NIXH-20-INF-001";
 title = "ClamAV (SRE Exhausted)";
 description = "Professional antivirus protection.";
 layer = 10;
 nixpkgs.category = "services/security";
 capabilities = [ "security/antivirus" "system/protection" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.clamav = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.clamav.enable or true) {
 services.clamav = {
 daemon.enable = true;
 updater.enable = true;
 scanner = {
 enable = true;
 interval = "Sat *-*-* 03:00:00";
 scanDirectories = [ "/home" "/var/lib" "/etc" ];
 };
 daemon.settings = {
 LogTime = true;
 LogVerbose = false;
 MaxScanSize = "100M";
 MaxFileSize = "50M";

 ExcludePath = [ "^/mnt/media" "^/mnt/fast-pool/downloads" ];
 };
 };

 systemd.services.clamdscan.serviceConfig = {
 CPUWeight = 20; IOWeight = 20; CPUSchedulingPolicy = "idle"; IOSchedulingClass = "idle";
 };
 };
}

``n---
### [F-123] modules\services\cloudflared-tunnel.nix
* Pfad: modules\services\cloudflared-tunnel.nix | Format: .nix | Größe: 2,41 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-003";
 title = "Cloudflared Tunnel (SRE Exhausted)";
 description = "Secure Ingress bridge using Cloudflare Tunnels for zero-port-forwarding connectivity.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/ingress" "security/tunnel" "cloudflare/integration" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 cfg = config.my.cloudflare.tunnel;
 creds = config.my.secrets.files.cloudflaredTunnelCredentials;
 proxyUrl = if config.my.profiles.networking.reverseProxy == "caddy"
 then "https://127.0.0.1:443"
 else "https://127.0.0.1:${toString config.my.ports.edgeHttps}";
in
{
 options.my.meta.cloudflared_tunnel = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for cloudflared-tunnel module";
 };

 options.my.cloudflare.tunnel = {
 enable = lib.mkEnableOption "Cloudflare Tunnel Ingress bridge";
 tunnelId = lib.mkOption { type = lib.types.str; default = ""; };
 domain = lib.mkOption { type = lib.types.str; default = config.my.configs.identity.domain; };
 wildcardPrefix = lib.mkOption { type = lib.types.str; default = "*.nix"; };
 };

 config = lib.mkIf cfg.enable {
 assertions = [ { assertion = cfg.tunnelId != ""; message = "cloudflared: tunnelId muss gesetzt sein."; } ];
 systemd.services."cloudflared-tunnel-${cfg.tunnelId}" = {
 preStart = "if [ ! -f '${creds}' ]; then echo 'FEHLER: Credentials fehlen.'; exit 1; fi";
 serviceConfig = {
 ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
 CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ]; AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
 OOMScoreAdjust = -500;
 };
 };
 services.cloudflared = {
 enable = true;
 tunnels.${cfg.tunnelId} = {
 credentialsFile = creds;
 ingress = {
 "${cfg.wildcardPrefix}.${cfg.domain}" = {
 service = proxyUrl;
 originRequest = { noTLSVerify = false; originServerName = "${cfg.wildcardPrefix}.${cfg.domain}"; http2Origin = true; keepAliveConnections = 8; };
 };
 };
 default = "http_status:404";
 };
 };
 };
}

``n---
### [F-124] modules\services\cockpit.nix
* Pfad: modules\services\cockpit.nix | Format: .nix | Größe: 883 B
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-80-MON-001"; title = "Cockpit"; description = "Web admin."; layer = 80; nixpkgs.category = "tools/admin"; capabilities = [ "system/administration" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 1; };
 cfg = config.my.services.cockpit;
 domain = config.my.configs.identity.domain;
 port = config.my.ports.cockpit;
in
{
 options.my.meta.cockpit = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf cfg.enable {
 services.cockpit = { enable = true; port = port; package = pkgs.cockpit; settings = { WebService = { AllowUnencrypted = true; ProtocolHeader = "X-Forwarded-Proto"; }; Session = { IdleTimeout = 15; }; }; };
 services.caddy.virtualHosts."admin.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 };
}

``n---
### [F-125] modules\services\ddns-updater.nix
* Pfad: modules\services\ddns-updater.nix | Format: .nix | Größe: 1,04 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-004";
 title = "Ddns Updater";
 description = "Automated Dynamic DNS updates for Cloudflare and other providers.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/ddns" "cloudflare/integration" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 domain = config.my.configs.identity.domain;
 port = config.my.ports.ddnsUpdater;
in
{
 options.my.meta.ddns_updater = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for ddns-updater module";
 };

 config = lib.mkIf config.my.services.ddnsUpdater.enable {
 services.ddns-updater = {
 enable = true;
 environment = { LISTENING_ADDRESS = ":${toString port}"; PERIOD = "10m"; };
 };
 services.caddy.virtualHosts."nix-ddns.${domain}" = {
 extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}";
 };
 };
}

``n---
### [F-126] modules\services\dns-automation.nix
* Pfad: modules\services\dns-automation.nix | Format: .nix | Größe: 2,42 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-005";
 title = "Dns Automation";
 description = "Check Cloudflare for DNS conflicts and update runtime map for dynamic routing.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/dns-automation" "cloudflare/api" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 runtimeDnsMap = "/var/lib/nixhome/dns-map-runtime.json";
 domain = config.my.configs.identity.domain;
 cfTokenFile = config.sops.secrets.cloudflare_token.path;
in
{
 options.my.meta.dns_automation = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for dns-automation module";
 };

 config = lib.mkIf config.my.services.dnsAutomation.enable {
 systemd.services.dns-guard = {
 description = "Check Cloudflare for DNS conflicts";
 after = [ "network-online.target" "sops-install-secrets.service" ];
 requires = [ "network-online.target" ];
 serviceConfig = {
 Type = "oneshot";
 StateDirectory = "nixhome";
 ExecStart = pkgs.writeShellScript "dns-guard-runtime" ''
 set -euo pipefail
 TOKEN=$(cat "${cfTokenFile}")
 ZONE_DATA=$(${pkgs.curl}/bin/curl -sf -X GET "https://api.cloudflare.com/client/v4/zones" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json")
 ZONE_ID=$(echo "$ZONE_DATA" | ${pkgs.jq}/bin/jq -r ".result[0].id")
 if [ -z "$ZONE_ID" ] || [ "$ZONE_ID" = "null" ]; then exit 1; fi
 EXISTING_RECORDS=$(${pkgs.curl}/bin/curl -sf "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?per_page=100" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" | ${pkgs.jq}/bin/jq -r ".result[].name")
 GLOBAL_CONFLICT=false
 for record in $EXISTING_RECORDS; do if [[ "$record" == "*.${domain}" ]]; then GLOBAL_CONFLICT=true; break; fi; done
 ${pkgs.jq}/bin/jq -n --argjson conflict "$GLOBAL_CONFLICT" --arg domain "${domain}" '{useNixSubdomain: $conflict, baseDomain: $domain}' > "${runtimeDnsMap}"
 '';
 };
 path = with pkgs; [ curl jq coreutils gnugrep ];
 };
 systemd.timers.dns-guard = { wantedBy = [ "timers.target" ]; timerConfig = { OnBootSec = "1min"; OnUnitActiveSec = "30min"; RandomizedDelaySec = "60"; }; };
 };
}

``n---
### [F-127] modules\services\dns-map.nix
* Pfad: modules\services\dns-map.nix | Format: .nix | Größe: 1,21 KB
``nix
{ config, ... }: 
let
 identity = config.my.configs.identity;
 domain = identity.domain;
 sub = identity.subdomain;
 d = "${sub}.${domain}";
in
{
 inherit domain sub;
 dnsMapping = {

 jellyfin = "jellyfin.${d}";
 sonarr = "sonarr.${d}";
 radarr = "radarr.${d}";
 prowlarr = "prowlarr.${d}";
 readarr = "readarr.${d}";
 lidarr = "lidarr.${d}";
 audiobookshelf = "audiobookshelf.${d}";
 sabnzbd = "sabnzbd.${d}";
 jellyseerr = "jellyseerr.${d}";

 vault = "vault.${d}";
 auth = "auth.${d}";
 status = "status.${d}";

 paperless = "paperless.${d}";
 n8n = "n8n.${d}";
 miniflux = "miniflux.${d}";
 monica = "monica.${d}";
 readeck = "readeck.${d}";
 matrix = "matrix.${d}";
 filebrowser = "filebrowser.${d}";
 homeassistant = "home.${d}";
 openwebui = "openwebui.${d}";

 dashboard = "dash.${d}";
 adguard = "dns.${d}";
 netdata = "netdata.${d}";
 scrutiny = "scrutiny.${d}";
 cockpit = "admin.${d}";
 ddns = "nix-ddns.${d}";

 olivetin = "olivetin.local";
 };
}

``n---
### [F-128] modules\services\homepage.nix
* Pfad: modules\services\homepage.nix | Format: .nix | Größe: 3,10 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-10-GTW-007";
 title = "Homepage Dashboard";
 description = "Highly customizable application dashboard, fully declarative.";
 layer = 10;
 nixpkgs.category = "services/misc";
 capabilities = [ "web/dashboard" "observability/ui" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 dnsMap = import ./dns-map.nix { inherit config; };
 host = dnsMap.dnsMapping.dashboard or "dash.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
in
{
 options.my.meta.homepage = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for homepage module";
 };

 config = lib.mkIf config.my.services.homepage.enable {
 services.homepage-dashboard = {
 enable = true;
 environmentFile = config.my.secrets.files.sharedEnv;
 widgets = [ { resources = { cpu = true; memory = true; disk = "/"; uptime = true; }; } { search = { provider = "duckduckgo"; target = "_blank"; }; } ];
 services = [
 { "Media" = [ { "Jellyfin" = { icon = "jellyfin.png"; href = "https://${dnsMap.dnsMapping.jellyfin}"; }; } { "Sonarr" = { icon = "sonarr.png"; href = "https://${dnsMap.dnsMapping.sonarr}"; }; } { "Radarr" = { icon = "radarr.png"; href = "https://${dnsMap.dnsMapping.radarr}"; }; } { "Prowlarr" = { icon = "prowlarr.png"; href = "https://${dnsMap.dnsMapping.prowlarr}"; }; } { "Readarr" = { icon = "readarr.png"; href = "https://${dnsMap.dnsMapping.readarr}"; }; } { "Audiobookshelf" = { icon = "audiobookshelf.png"; href = "https://${dnsMap.dnsMapping.audiobookshelf}"; }; } ]; }
 { "Tools" = [ { "Vaultwarden" = { icon = "vaultwarden.png"; href = "https://${dnsMap.dnsMapping.vault}"; }; } { "Paperless" = { icon = "paperless.png"; href = "https://${dnsMap.dnsMapping.paperless}"; }; } { "n8n" = { icon = "n8n.png"; href = "https://${dnsMap.dnsMapping.n8n}"; }; } { "Miniflux" = { icon = "miniflux.png"; href = "https://${dnsMap.dnsMapping.miniflux}"; }; } { "Monica" = { icon = "monica.png"; href = "https://${dnsMap.dnsMapping.monica}"; }; } ]; }
 { "Infrastructure" = [ { "OliveTin" = { icon = "olivetin.png"; href = "https://${dnsMap.dnsMapping.olivetin or "olivetin.m7c5.de"}"; }; } { "Pocket-ID" = { icon = "pocket-id.png"; href = "https://${dnsMap.dnsMapping.auth}"; }; } { "Netdata" = { icon = "netdata.png"; href = "https://netdata.${config.my.configs.identity.domain}"; }; } { "AdGuard" = { icon = "adguard-home.png"; href = "https://${dnsMap.dnsMapping.adguard or "adguard.m7c5.de"}"; }; } ]; }
 ];
 settings = { title = "nixhome dashboard"; layout = { Media = { style = "grid"; columns = 3; }; Tools = { style = "grid"; columns = 3; }; Infrastructure = { style = "grid"; columns = 2; }; }; };
 };
 services.caddy.virtualHosts."${host}" = {
 extraConfig = "@tailscale remote_ip 100.64.0.0/10\nhandle @tailscale { reverse_proxy 127.0.0.1:${toString config.my.ports.homepage} }\nimport sso_auth\nreverse_proxy 127.0.0.1:${toString config.my.ports.homepage}";
 };
 };
}

``n---
### [F-129] modules\services\landing-zone-ui.nix
* Pfad: modules\services\landing-zone-ui.nix | Format: .nix | Größe: 807 B
``nix
{ config, pkgs, lib, ... }:
let
 nms = { id = "NIXH-10-GTW-008"; title = "Landing Zone Ui"; description = "Static landing page."; layer = 10; nixpkgs.category = "web/apps"; capabilities = [ "web/landing-page" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 1; };
 domain = config.my.configs.identity.domain;
 lanIP = config.my.configs.network.lanIP;
 rescueHtml = pkgs.writeTextDir "index.html" "<html><body>Rettungsweg</body></html>";
in
{
 options.my.meta.landing_zone_ui = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf (config.my.services.landingZone.enable or true) {
 systemd.tmpfiles.rules = [ "d /var/www/landing-zone 0755 caddy caddy -" "L+ /var/www/landing-zone/index.html - - - - ${rescueHtml}/index.html" ];
 };
}

``n---
### [F-130] modules\services\pocket-id.nix
* Pfad: modules\services\pocket-id.nix | Format: .nix | Größe: 1,90 KB
``nix
{
 config,
 lib,
 ...
}: let

 nms = {
 id = "NIXH-10-GTW-009";
 title = "Pocket-ID (OIDC Provider)";
 description = "Self-hosted OIDC identity provider for secure SSO with Caddy integration.";
 layer = 10;
 nixpkgs.category = "services/security";
 capabilities = ["security/oidc" "identity/provider"];
 audit.last_reviewed = "2026-03-03";
 audit.complexity = 2;
 };

 cfg = config.my.services.pocketId;
 domain = config.my.configs.identity.domain;
 subdomain = config.my.configs.identity.subdomain;
 port = config.my.ports.pocketId;
in {

 options.my.meta.pocketId = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {

 assertions = [
 {
 assertion = config.my.profiles.networking.reverseProxy == "caddy";
 message = "Pocket-ID requires Caddy as reverseProxy.";
 }
 ];

 services.pocket-id = {
 enable = true;
 dataDir = "/var/lib/pocket-id";
 settings = {
 issuer = lib.mkForce "https://auth.${subdomain}.${domain}";
 title = "NixHome Identity";
 public_registration = false;
 };
 };

 systemd.services.pocket-id.serviceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 PrivateDevices = true;
 Restart = "always";
 RestartSec = "5s";
 OOMScoreAdjust = -100;
 };

 services.caddy.virtualHosts."auth.${subdomain}.${domain}" = {
 extraConfig = "reverse_proxy 127.0.0.1:${toString port}";
 };
 };
}

``n---
### [F-131] modules\services\postgresql.nix
* Pfad: modules\services\postgresql.nix | Format: .nix | Größe: 2,21 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-20-INF-002";
 title = "PostgreSQL (SRE Optimized)";
 description = "Optimized database cluster with automated backups and strict sandboxing.";
 layer = 10;
 nixpkgs.category = "services/databases";
 capabilities = [ "database/postgresql" "system/persistence" "maintenance/auto-backup" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.postgresql = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for postgresql module";
 };

 config = lib.mkIf config.my.services.postgresql.enable {
 services.postgresql = {
 enable = true;
 package = pkgs.postgresql_17;
 initdbArgs = [ "--data-checksums" ];
 ensureDatabases = [ "miniflux" "paperless" "n8n" ];
 ensureUsers = [ { name = "miniflux"; ensureDBOwnership = true; } { name = "paperless"; ensureDBOwnership = true; } { name = "n8n"; ensureDBOwnership = true; } ];
 enableJIT = true;
 settings = {
 shared_buffers = "512MB"; effective_cache_size = "4GB"; maintenance_work_mem = "128MB"; checkpoint_completion_target = 0.9;
 wal_buffers = "16MB"; default_statistics_target = 100; random_page_cost = 1.1; effective_io_concurrency = 200;
 work_mem = "8MB"; min_wal_size = "512MB"; max_wal_size = "2GB"; huge_pages = "try";
 log_min_duration_statement = 250; log_checkpoints = "on"; log_connections = "on"; log_disconnections = "on"; log_lock_waits = "on";
 };
 };
 services.postgresqlBackup = { enable = true; databases = [ "miniflux" "paperless" "n8n" ]; location = "/data/state/backups/postgresql"; startAt = "01:30"; };
 systemd.services.postgresql.serviceConfig = { ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true; SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ]; OOMScoreAdjust = -900; };
 systemd.services.miniflux.after = [ "postgresql.service" ];
 systemd.services.n8n.after = [ "postgresql.service" ];
 systemd.services.paperless-web.after = [ "postgresql.service" ];
 };
}

``n---
### [F-132] modules\services\secret-ingest.nix
* Pfad: modules\services\secret-ingest.nix | Format: .nix | Größe: 1,21 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-20-INF-003";
 title = "Secret Ingest";
 description = "Watcher for secret landing zone.";
 layer = 10;
 nixpkgs.category = "services/admin";
 capabilities = [ "automation/secrets" "security/ingest" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
 python = pkgs.python311;
in
{
 options.my.meta.secret_ingest = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = lib.mkIf (config.my.services.secretIngest.enable or true) {
 systemd.paths.secret-ingest = {
 description = "Wächter für Secret Landing Zone";
 wantedBy = [ "multi-user.target" ];
 pathConfig = { DirectoryNotEmpty = "/etc/nixos/secret-landing-zone"; MakeDirectory = true; };
 };

 systemd.services.secret-ingest = {
 description = "Secret Ingest Agent";
 path = with pkgs; [ sops coreutils ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = pkgs.writeScript "ingest-run" "#!${python}/bin/python\nimport os, re, subprocess, glob\n..."; # Shortened
 User = "root";
 };
 };
 };
}

``n---
### [F-133] modules\services\service-app-zigbee-stack.nix
* Pfad: modules\services\service-app-zigbee-stack.nix | Format: .nix | Größe: 5,03 KB
``nix
{ config, lib, pkgs, myLib, ... }:
let

 nms = {
 id = "NIXH-01-SRV-ZIG-001";
 title = "Zigbee Stack (Mosquitto & Z2M)";
 description = "Hardened Zigbee infrastructure with Mosquitto Broker and Zigbee2MQTT.";
 layer = 20;
 nixpkgs.category = "services/home-automation";
 capabilities = ["iot/zigbee" "iot/mqtt" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.services.zigbeeStack;
 srePaths = config.my.configs.paths;
 sreConfig = config.my.configs;

 isUsbDevice = lib.hasPrefix "/dev/" cfg.zigbeeDevice;

in
{
 options.my.meta.zigbee_stack = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.services.zigbeeStack = {
 enable = lib.mkEnableOption "Zigbee Stack (Mosquitto + Zigbee2MQTT)";

 mqttPort = lib.mkOption { 
 type = lib.types.port; 
 default = config.my.ports.mqtt or 1883; 
 description = "Internal MQTT Broker Port";
 };

 zigbeePort = lib.mkOption { 
 type = lib.types.port; 
 default = config.my.ports.zigbee2mqtt or 8080; 
 description = "Zigbee2MQTT Frontend Port";
 };

 zigbeeDevice = lib.mkOption { 
 type = lib.types.str; 
 default = "socket://192.168.2.46:6638"; 
 description = "Zigbee adapter path (e.g. /dev/ttyUSB0) or socket (SLZB-06)";
 };

 adapter = lib.mkOption {
 type = lib.types.enum [ "ember" "zstack" "deconz" "ezsp" ];
 default = "ember";
 description = "Zigbee adapter type (ember for modern SLZB-06/Sonoff P)";
 };

 dataDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/zigbee2mqtt"; 
 description = "State directory for Zigbee2MQTT (Tier A/Persist)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [

 (myLib.mkService {
 inherit config;
 name = "zigbee2mqtt";
 port = cfg.zigbeePort;
 useSSO = true;
 description = "Zigbee2MQTT Frontend";
 persist = true;
 readWritePaths = [ cfg.dataDir ];
 })

 {

 services.mosquitto = {
 enable = true;
 listeners = [{
 port = cfg.mqttPort;
 address = "127.0.0.1"; # hardened: Only local access
 acl = [ "pattern readwrite #" ];
 settings.allow_anonymous = true;
 }];
 };

 systemd.services.mosquitto.serviceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 ReadWritePaths = [ "/var/lib/mosquitto" ];
 };

 services.zigbee2mqtt = {
 enable = true;
 dataDir = cfg.dataDir;
 settings = {
 homeassistant = true;
 permit_join = false;
 mqtt = {
 base_topic = "zigbee2mqtt";
 server = "mqtt://127.0.0.1:${toString cfg.mqttPort}";
 };
 serial = {
 port = cfg.zigbeeDevice;
 adapter = cfg.adapter;
 };
 frontend = {
 port = cfg.zigbeePort;
 host = "127.0.0.1";
 };
 advanced = {
 log_directory = "${cfg.dataDir}/log";
 pan_id = 0x1a2b; # hardened: Custom PAN-ID (Source: Fragment 18968)
 };
 };
 };

 systemd.services.zigbee2mqtt = {
 after = [ "mosquitto.service" ];
 wants = [ "mosquitto.service" ];

 serviceConfig = {
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;

 PrivateDevices = if isUsbDevice then lib.mkForce false else true;
 DeviceAllow = lib.optional isUsbDevice "${cfg.zigbeeDevice} rw";

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.dataDir} 0750 zigbee2mqtt mqtt -"
 "d /var/lib/mosquitto 0750 mosquitto mqtt -"
 ];

 environment.persistence."/persist" = {
 directories = [ 
 "/var/lib/mosquitto"
 "/var/lib/zigbee2mqtt"
 ];
 };

 users.groups.mqtt = {};
 users.users.zigbee2mqtt.extraGroups = [ "mqtt" "dialout" ];
 users.users.mosquitto.extraGroups = [ "mqtt" ];
 }
 ]);
}

``n---
### [F-134] modules\services\service-netdata.nix
* Pfad: modules\services\service-netdata.nix | Format: .nix | Größe: 1,77 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-80-MON-002";
 title = "Netdata (SRE Exhausted)";
 description = "Real-time performance monitoring with high-retention dbengine and strict sandboxing.";
 layer = 80;
 nixpkgs.category = "services/monitoring";
 capabilities = [ "monitoring/real-time" "observability/metrics" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.netdata;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.netdata = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for netdata module";
 };

 config = lib.mkIf config.my.services.netdata.enable {
 services.netdata = {
 enable = true;
 config = {
 global = { "memory mode" = "dbengine"; "page cache size" = "256"; "dbengine disk space" = "4096"; "history" = 86400; };
 web = { "allow connections from" = "localhost 127.0.0.1"; "default port" = toString port; "mode" = "static-threaded"; };
 db = { "dbengine tier 1 retention days" = 30; };
 health.enabled = "yes";
 };
 };
 services.caddy.virtualHosts."netdata.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.netdata.serviceConfig = {
 ProtectSystem = lib.mkForce "full"; ProtectHome = lib.mkForce true; PrivateTmp = lib.mkForce true; PrivateDevices = lib.mkForce true;
 NoNewPrivileges = true; CapabilityBoundingSet = [ "CAP_DAC_READ_SEARCH" "CAP_SYS_PTRACE" "CAP_NET_RAW" ]; AmbientCapabilities = [ "CAP_DAC_READ_SEARCH" "CAP_SYS_PTRACE" "CAP_NET_RAW" ];
 MemoryMax = "1G"; CPUWeight = 50; OOMScoreAdjust = 1000;
 };
 };
}

``n---
### [F-135] modules\services\service-scrutiny.nix
* Pfad: modules\services\service-scrutiny.nix | Format: .nix | Größe: 1,32 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-80-MON-003";
 title = "Scrutiny (SRE Hardened)";
 description = "Hard drive S.M.A.R.T monitoring with automated collection and InfluxDB trends.";
 layer = 80;
 nixpkgs.category = "services/monitoring";
 capabilities = [ "monitoring/smart" "hardware/health" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };

 port = config.my.ports.scrutiny;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.scrutiny = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for scrutiny module";
 };

 config = lib.mkIf config.my.services.scrutiny.enable {
 services.scrutiny = { enable = true; settings = { web.listen.port = port; web.listen.host = "127.0.0.1"; log.level = "INFO"; }; influxdb.enable = true; collector = { enable = true; schedule = "daily"; }; };
 services.caddy.virtualHosts."scrutiny.${domain}" = { extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}"; };
 systemd.services.scrutiny.serviceConfig = { DynamicUser = true; ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; OOMScoreAdjust = 800; };
 services.smartd.enable = true;
 };
}

``n---
### [F-136] modules\services\sso.nix
* Pfad: modules\services\sso.nix | Format: .nix | Größe: 1,54 KB
``nix
{ config, lib, pkgs, ... }:
let
 nms = { id = "NIXH-10-GTW-010"; title = "SSO"; description = "SSO config."; layer = 10; nixpkgs.category = "services/security"; capabilities = [ "security/sso" ]; audit.last_reviewed = "2026-03-02"; audit.complexity = 2; };
 cfg = config.my.services.pocketId;
 domain = config.my.configs.identity.domain;
 pocketIdPort = config.my.ports.pocketId;
 dnsMap = import ./dns-map.nix { inherit config; };
 allUrls = (map (h: "https://${h}") (lib.attrValues dnsMap.dnsMapping)) ++ [ "https://auth.${domain}/callback" ];
in
{
 options.my.meta.sso = lib.mkOption { type = lib.types.attrs; default = nms; readOnly = true; };
 config = lib.mkIf cfg.enable {
 services.pocket-id.settings = { issuer = "https://auth.${domain}"; title = "m7c5 Login"; allowed_redirect_urls = lib.concatStringsSep "," allUrls; session_ttl_seconds = 86400; };
 systemd.services.pocket-id-bootstrap = {
 description = "Pocket-ID Bootstrap";
 after = [ "pocket-id.service" ];
 wantedBy = [ "multi-user.target" ];
 unitConfig.ConditionPathExists = "!/var/lib/pocket-id/.bootstrapped";
 serviceConfig = { 
 Type = "oneshot"; 
 RemainAfterExit = true; 
 };
 script = ''

 until ${pkgs.curl}/bin/curl -sf http://localhost:${toString pocketIdPort}/ > /dev/null; do
 echo "Waiting for Pocket-ID to become ready..."
 sleep 1
 done
 touch /var/lib/pocket-id/.bootstrapped
 '';
 };
 };
}

``n---
### [F-137] modules\services\tailscale.nix
* Pfad: modules\services\tailscale.nix | Format: .nix | Größe: 1,86 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-10-GTW-011";
 title = "Tailscale (Zero-Touch)";
 description = "Declarative VPN with autoconnect pattern and SOPS-nix secret integration.";
 layer = 10;
 nixpkgs.category = "services/networking";
 capabilities = [ "network/vpn" "security/tailscale" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.tailscale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for tailscale module";
 };

 config = lib.mkIf config.my.services.tailscale.enable {
 services.tailscale = { enable = true; openFirewall = false; useRoutingFeatures = "client"; extraUpFlags = [ "--ssh" "--accept-dns=true" "--accept-routes=true" ]; permitCertUid = config.services.caddy.user; };
 systemd.services.tailscale-autoconnect = {
 description = "Automatic Tailscale Login";
 after = [ "tailscaled.service" "network-online.target" ];
 wants = [ "tailscaled.service" "network-online.target" ];
 wantedBy = [ "multi-user.target" ];
 serviceConfig = {
 Type = "oneshot";

 EnvironmentFile = config.sops.secrets.tailscale_token.path;
 ExecStart = pkgs.writeShellScript "tailscale-auth" ''
 sleep 5
 status=$(${pkgs.tailscale}/bin/tailscale status --json | ${pkgs.jq}/bin/jq -r .BackendState)
 if [ "$status" = "NeedsLogin" ] || [ "$status" = "Stopped" ]; then
 ${pkgs.tailscale}/bin/tailscale up --authkey="$TS_AUTHKEY"
 fi
 '';
 };
 };
 systemd.services.tailscaled = { stopIfChanged = false; serviceConfig = { Restart = "always"; RestartSec = "2s"; OOMScoreAdjust = -1000; }; };
 };
}

``n---
### [F-138] modules\services\uptime-kuma.nix
* Pfad: modules\services\uptime-kuma.nix | Format: .nix | Größe: 1,31 KB
``nix
{ config, lib, ... }:
let

 nms = {
 id = "NIXH-80-MON-004";
 title = "Uptime Kuma (SRE Exhausted)";
 description = "Self-hosted monitoring tool, tightly sandboxed with resource limits.";
 layer = 80;
 nixpkgs.category = "services/monitoring";
 capabilities = [ "monitoring/uptime" "web/dashboard" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };

 port = config.my.ports.uptimeKuma;
 domain = config.my.configs.identity.domain;
in
{
 options.my.meta.uptime_kuma = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for uptime-kuma module";
 };

 config = lib.mkIf config.my.services.uptimeKuma.enable {
 services.uptime-kuma = { enable = true; settings.PORT = toString port; };
 services.caddy.virtualHosts."status.${domain}" = {
 extraConfig = "import sso_auth\nreverse_proxy 127.0.0.1:${toString port}";
 };
 systemd.services.uptime-kuma.serviceConfig = {
 ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
 CapabilityBoundingSet = [ "CAP_NET_RAW" ]; AmbientCapabilities = [ "CAP_NET_RAW" ];
 MemoryMax = "512M"; CPUWeight = 30; OOMScoreAdjust = 500;
 };
 };
}

``n---
### [F-139] modules\services\valkey.nix
* Pfad: modules\services\valkey.nix | Format: .nix | Größe: 1,36 KB
``nix
{ pkgs, lib, config, ... }:
let

 nms = {
 id = "NIXH-20-INF-006";
 title = "Valkey (SRE Exhausted)";
 description = "High-performance Valkey (Redis fork) with memory caps and hardened sandboxing.";
 layer = 10;
 nixpkgs.category = "services/databases";
 capabilities = [ "database/key-value" "caching/redis" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 2;
 };
in
{
 options.my.meta.valkey = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for valkey module";
 };

 config = lib.mkIf config.my.services.valkey.enable {
 services.redis.package = pkgs.valkey;
 services.redis.servers.valkey = {
 enable = true; bind = "127.0.0.1"; port = 6379; openFirewall = false;
 settings = {
 maxmemory = "512mb"; maxmemory-policy = "allkeys-lru";
 save = [ "900 1" "300 10" "60 10000" ];
 unixsocket = "/run/redis-valkey/redis.sock"; unixsocketperm = lib.mkForce "770";
 };
 };
 systemd.services.redis-valkey.serviceConfig = {
 ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
 MemoryDenyWriteExecute = true; RestrictAddressFamilies = [ "AF_INET" "AF_UNIX" ]; OOMScoreAdjust = -500;
 };
 };
}

``n---
### [F-140] modules\services\vpn-confinement.nix
* Pfad: modules\services\vpn-confinement.nix | Format: .nix | Größe: 3,90 KB
``nix
{ config, lib, pkgs, ... }:
let

 nms = {
 id = "NIXH-01-SRV-VPN-001";
 title = "VPN Confinement (Maroka-chan based)";
 description = "Isolated network namespaces for VPN-bound services with kill-switch protection.";
 layer = 10;
 nixpkgs.category = "network/vpn";
 capabilities = ["network/isolation" "network/vpn" "security/kill-switch"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.services.vpnConfinement;
 srePaths = config.my.configs.paths;

in {
 options.my.meta.vpn_confinement = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.services.vpnConfinement = {
 enable = lib.mkEnableOption "VPN Confinement for services";

 namespaces = lib.mkOption {
 type = lib.types.attrsOf (lib.types.submodule {
 options = {
 wgConf = lib.mkOption { 
 type = lib.types.path; 
 description = "Path to WireGuard config (via Sops, absolute path)";
 };
 killSwitch = lib.mkOption { 
 type = lib.types.bool; 
 default = true; 
 description = "Strictly block non-VPN traffic in this namespace";
 };
 };
 });
 default = {};
 description = "Definitions of isolated VPN namespaces";
 };
 };

 config = lib.mkIf cfg.enable {

 systemd.services = lib.mapAttrs' (name: nsCfg: (
 let nsName = name; in
 lib.nameValuePair "netns-${nsName}" {
 description = "Network Namespace ${nsName}";
 before = [ "network.target" ];
 wantedBy = [ "multi-user.target" ];

 path = with pkgs; [ iproute2 wireguard-tools nftables ];

 serviceConfig = {
 Type = "oneshot";
 RemainAfterExit = true;
 ExecStart = pkgs.writeShellScript "netns-${nsName}-up" ''

 ip netns add ${nsName} || true
 ip netns exec ${nsName} ip link set lo up

 ip link add wg0 type wireguard
 ip link set wg0 netns ${nsName}
 ip netns exec ${nsName} wg setconf wg0 ${nsCfg.wgConf}
 ip netns exec ${nsName} ip link set wg0 up

 ip netns exec ${nsName} ip route add default dev wg0

 echo " Testing VPN connectivity in namespace ${nsName}..."
 if ! ip netns exec ${nsName} ${pkgs.iputils}/bin/ping -c 1 -W 5 1.1.1.1 > /dev/null; then
 echo " VPN Healthcheck FAILED! Triggering alert..."

 if [ -f /etc/nixos/secrets/ntfy-sh ]; then
 ${pkgs.curl}/bin/curl -H "Priority: urgent" -H "Tags: skull,fire" \
 -d "VPN Namespace ${nsName} setup failed: No connectivity!" \
 $(cat /etc/nixos/secrets/ntfy-sh)
 fi
 exit 1
 fi
 echo " VPN Namespace ${nsName} is UP and CONNECTED."
 '';
 ExecStop = pkgs.writeShellScript "netns-${nsName}-down" ''
 ip netns del ${nsName} || true
 '';
 };
 }
 )) cfg.namespaces;

 };
}

``n---
### [F-141] modules\services\vpn-live-config.nix
* Pfad: modules\services\vpn-live-config.nix | Format: .nix | Größe: 885 B
``nix
{ lib, ... }:
let

 nms = {
 id = "NIXH-20-INF-008";
 title = "Vpn Live Config";
 description = "Dynamic runtime configuration for VPN credentials and endpoints.";
 layer = 10;
 nixpkgs.category = "data/networking";
 capabilities = [ "network/vpn-config" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.vpn_live_config = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for vpn-live-config module";
 };

 config = {
 my.configs.vpn.privado = {
 publicKey = lib.mkForce "KgTUh3KLijVluDvNpzDCJJfrJ7EyLzYLmdHCksG4sRg=";
 endpoint = lib.mkForce "91.148.237.38:51820";
 address = lib.mkForce "100.64.3.155/32";
 dns = lib.mkForce ["198.18.0.1" "198.18.0.2"];
 };
 };
}

``n---
### [F-142] modules\storage\deferred-ops.nix
* Pfad: modules\storage\deferred-ops.nix | Format: .nix | Größe: 3,94 KB
``nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.deferred;
 srePaths = config.my.configs.paths;

 processScript = pkgs.writeShellScript "process-delete-queue" ''
 set -euo pipefail

 QUEUE_DIR="${cfg.queueDir}"
 MAX_AGE_DAYS=${toString cfg.maxAgeDays}
 HDD_POOL="${srePaths.tierC}"

 echo "--- Starting Deferred Deletion Processor ---"

 mkdir -p "$QUEUE_DIR"

 echo " Detecting HDD devices..."
 DEVICES=$( ${pkgs.util-linux}/bin/lsblk -pno NAME,MOUNTPOINT | grep "/mnt/hdd" | awk '{print $1}' || echo "" )

 if [ -z "$DEVICES" ]; then
 echo " No HDD devices detected under /mnt/hdd*"
 fi

 ANY_ACTIVE=false
 for DEV in $DEVICES; do
 if [ -b "$DEV" ]; then

 STATE=$( ${pkgs.hdparm}/bin/hdparm -C "$DEV" | grep "drive state is" | awk '{print $NF}' || echo "unknown" )
 echo " Drive $DEV state: $STATE"
 if [[ "$STATE" == "active/idle" ]]; then
 ANY_ACTIVE=true
 fi
 fi
 done

 echo " Pool Status: ANY_ACTIVE=$ANY_ACTIVE"

 shopt -s nullglob
 for ENTRY in "$QUEUE_DIR"/*; do
 [ -f "$ENTRY" ] || continue

 FILE_AGE_SECONDS=$(($(date +%s) - $(stat -c %Y "$ENTRY")))
 MAX_AGE_SECONDS=$((MAX_AGE_DAYS * 86400))

 SHOULD_DELETE=false
 if [ "$ANY_ACTIVE" = true ]; then
 SHOULD_DELETE=true
 elif [ "$FILE_AGE_SECONDS" -gt "$MAX_AGE_SECONDS" ]; then
 SHOULD_DELETE=true
 echo " Forcing deletion of $ENTRY due to age ($MAX_AGE_DAYS days)"
 fi

 if [ "$SHOULD_DELETE" = true ]; then
 TARGET_PATH=$(cat "$ENTRY")
 if [ -n "$TARGET_PATH" ] && [ -e "$TARGET_PATH" ]; then

 REAL_TARGET=$(readlink -f "$TARGET_PATH" || echo "$TARGET_PATH")
 if [[ "$REAL_TARGET" == "$HDD_POOL"* ]]; then
 echo " Safely deleting: $REAL_TARGET"
 rm -rf "$REAL_TARGET"
 else
 echo " SECURITY ALERT: Attempted out-of-bounds deletion! Target: $REAL_TARGET"
 exit 1
 fi
 else
 echo " Target path '$TARGET_PATH' not found or empty, skipping."
 fi
 rm -f "$ENTRY"
 else
 echo " Skipping $ENTRY (HDD is standby and file is not old enough)"
 fi
 done

 echo "--- Deferred Deletion Finished ---"
 '';
in
{
 options.my.storage.deferred = {
 enable = lib.mkEnableOption "Deferred Deletion Queue to save HDD spin-ups";
 queueDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/delete_queue";
 description = "Directory on SSD where paths to be deleted are stored";
 };
 maxAgeDays = lib.mkOption {
 type = lib.types.int;
 default = 7;
 description = "Force delete if entry is older than this many days, even if HDD is asleep";
 };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.process-delete-queue = {
 description = "Process Deferred Deletion Queue";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = processScript;
 User = "root";
 Nice = 19;
 IOSchedulingClass = "idle";
 };
 };

 systemd.timers.process-delete-queue = {
 description = "Hourly processing of deferred deletion queue";
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "hourly";
 Persistent = true;
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.queueDir} 0755 root root -"
 ];
 };
}

``n---
### [F-143] modules\storage\storage-mover.nix
* Pfad: modules\storage\storage-mover.nix | Format: .nix | Größe: 4,35 KB
``nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;

 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail

 SOURCE_DIR="${cfg.ssdDir}"
 TARGET_DIR="${cfg.hddDir}"
 LOW_THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
 TARGET_FREE_GB=${toString cfg.targetFreeGB}
 DRY_RUN=${if cfg.dryRun then "1" else "0"}

 echo "--- Starting Capacity-Based Smart Mover ---"

 IS_AWAKE=$(${pkgs.hdparm}/bin/hdparm -C /dev/sd[a-z] | grep -c "active/idle" || true)

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))

 if [ "$FREE_GB" -lt 10 ]; then
 echo " SPACE CRITICAL ($FREE_GB GB). Forcing move regardless of HDD state."
 elif [ "$FREE_GB" -lt 20 ] && [ "$IS_AWAKE" -gt 0 ]; then
 echo " LOW SPACE ($FREE_GB GB) and HDD is AWAKE ($IS_AWAKE active). Starting move."
 else
 echo " Conditions not met for move (Free: $FREE_GB GB, HDD Awake: $IS_AWAKE). Skipping to avoid spin-up."
 exit 0
 fi

 echo " Current free space on Tier B ($SOURCE_DIR): ''${FREE_GB} GB"
 echo " Low space detected (''${FREE_GB} GB < ''${LOW_THRESHOLD_GB} GB). Evacuating oldest files..."

 MAX_ITERATIONS=100
 COUNT=0

 while [ "$FREE_GB" -lt "$TARGET_FREE_GB" ] && [ "$COUNT" -lt "$MAX_ITERATIONS" ]; do
 COUNT=$((COUNT + 1))

 OLDEST=$(find "$SOURCE_DIR" -type f \
 ! -name "*.wal" ! -name "*.db" ! -name "*.sqlite" ! -name "*.db-journal" \
 -printf '%T@ %p\n' | sort -n | head -1 | cut -d' ' -f2-)

 if [ -z "$OLDEST" ]; then
 echo " No more safe files found to move."
 break
 fi

 if ${pkgs.lsof}/bin/lsof "$OLDEST" > /dev/null 2>&1; then
 echo " Skipping active file: $OLDEST (touching to defer)"
 touch "$OLDEST"
 continue
 fi

 REL_PATH=''${OLDEST#"$SOURCE_DIR/"}
 DEST_DIR=$(dirname "$TARGET_DIR/$REL_PATH")

 if [ "$DRY_RUN" -eq 1 ]; then
 echo "[DRY-RUN] Would move: $REL_PATH"
 FREE_GB=$((FREE_GB + 5)) # Estimate move
 else
 echo " Moving: $REL_PATH"
 mkdir -p "$DEST_DIR"

 ${pkgs.rsync}/bin/rsync -a --remove-source-files "$OLDEST" "$TARGET_DIR/$REL_PATH"

 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))
 fi
 done

 if [ "$COUNT" -ge "$MAX_ITERATIONS" ]; then
 echo " Mover reached MAX_ITERATIONS ($MAX_ITERATIONS). Stopping for safety."
 fi

 if [ "$DRY_RUN" -eq 0 ]; then
 find "$SOURCE_DIR" -type d -empty -delete
 echo " Cleaned up empty directories."
 fi

 echo "--- Mover finished. Current free space: ''${FREE_GB} GB ---"
 '';

in
{
 options.my.storage.mover = {
 enable = lib.mkEnableOption "Smart Storage Tiering Mover";
 ssdDir = lib.mkOption { type = lib.types.str; default = srePaths.downloads; };
 hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/downloads"; };
 lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 20; };
 targetFreeGB = lib.mkOption { type = lib.types.int; default = 50; };
 dryRun = lib.mkOption { type = lib.types.bool; default = false; };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.storage-mover = {
 description = "Capacity-Based Smart Mover (SSD -> HDD)";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = moverScript;
 Nice = 19;
 IOSchedulingClass = "idle";
 CPUSchedulingPolicy = "idle";
 };
 };

 systemd.timers.storage-mover = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "daily";
 Persistent = true;
 RandomizedDelaySec = "1h";
 };
 };
 };
}

``n---
### [F-144] profiles\automation-apps.nix
* Pfad: profiles\automation-apps.nix | Format: .nix | Größe: 633 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-app-n8n.nix
 ../modules/apps/service-app-home-assistant.nix
 ../modules/apps/service-app-olivetin.nix
 ../modules/apps/service-app-semaphore.nix
 ../modules/services/service-app-zigbee-stack.nix
 ];

 my.meta.profile_automation = {
 id = "NIXH-PROF-AUTO-001";
 title = "Automation Apps Profile";
 layer = 30;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---
### [F-145] profiles\base-server.nix
* Pfad: profiles\base-server.nix | Format: .nix | Größe: 1,08 KB
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/core/system.nix
 ../modules/core/impermanence.nix
 ../modules/core/nix-tuning.nix
 ../modules/core/network.nix
 ../modules/core/ssh.nix
 ../modules/core/firewall.nix
 ../modules/core/fail2ban.nix
 ../modules/core/zram-swap.nix
 ../modules/logging/vector-hdd.nix
 ../modules/core/shell-premium.nix
 ../modules/core/system-stability.nix
 ../modules/core/principles.nix

 ../modules/services/caddy.nix
 ../modules/services/postgresql.nix
 ../modules/services/tailscale.nix
 ../modules/monitoring/gatus.nix
 ];

 my.logging.vector.enable = true;
 my.monitoring.gatus.enable = true;

 my.meta.profile_base_server = {
 id = "NIXH-PROF-BASE-001";
 title = "Base Server Profile";
 layer = 0; # Core-Mission
 audit.last_reviewed = "2026-04-27";
 };
}

``n---
### [F-146] profiles\extra-apps.nix
* Pfad: profiles\extra-apps.nix | Format: .nix | Größe: 675 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-app-vaultwarden.nix
 ../modules/apps/service-app-matrix-conduit.nix
 ../modules/apps/service-app-monica.nix
 ../modules/apps/service-app-karakeep.nix
 ../modules/apps/service-app-filebrowser.nix
 ../modules/apps/service-app-couchdb.nix
 ];

 my.meta.profile_extra = {
 id = "NIXH-PROF-EXTR-001";
 title = "Extra Apps Profile";
 layer = 60;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---
### [F-147] profiles\knowledge-apps.nix
* Pfad: profiles\knowledge-apps.nix | Format: .nix | Größe: 622 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-app-paperless.nix
 ../modules/apps/service-app-linkwarden.nix
 ../modules/apps/service-app-miniflux.nix
 ../modules/apps/service-app-readeck.nix
 ../modules/apps/service-app-linkding.nix
 ];

 my.meta.profile_knowledge = {
 id = "NIXH-PROF-KNOW-001";
 title = "Knowledge Apps Profile";
 layer = 50;
 audit.last_reviewed = "2026-04-27";
 };
}

``n---
### [F-148] profiles\media-beast.nix
* Pfad: profiles\media-beast.nix | Format: .nix | Größe: 1,23 KB
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/apps/service-media-jellyfin.nix
 ../modules/apps/service-media-jellyseerr.nix
 ../modules/apps/service-media-sonarr.nix
 ../modules/apps/service-media-sonarr-setup.nix # API-Setup PoC
 ../modules/apps/service-media-radarr.nix
 ../modules/apps/service-media-radarr-setup.nix # API-Setup PoC
 ../modules/apps/service-media-prowlarr.nix
 ../modules/apps/service-media-prowlarr-setup.nix # Indexer-Sync
 ../modules/apps/service-media-readarr.nix
 ../modules/apps/service-media-lidarr.nix
 ../modules/apps/service-media-sabnzbd.nix
 ../modules/apps/service-media-recyclarr.nix
 ../modules/apps/service-app-audiobookshelf.nix
 ../modules/apps/service-app-navidrome.nix
 ../modules/apps/media-stack.nix
 ../modules/core/storage.nix
 ];

 my.meta.profile_media_beast = {
 id = "NIXH-PROF-MED-001";
 title = "Media Beast Profile";
 layer = 30;
 audit.last_reviewed = "2026-04-27";
 };

 my.apps.navidrome.enable = true;
}

``n---
### [F-149] profiles\security-hardened.nix
* Pfad: profiles\security-hardened.nix | Format: .nix | Größe: 811 B
``nix
{ config, lib, pkgs, ... }: {

 imports = [
 ../modules/security/security-assertions.nix
 ../modules/security/binary-only.nix
 ../modules/security/no-legacy.nix
 ../modules/security/flat-layout.nix
 ../modules/security/hardened-core.nix
 ];

 my.meta.profile_security = {
 id = "NIXH-PROF-SEC-001";
 title = "Security Hardened Profile";
 layer = 90;
 audit.last_reviewed = "2026-04-27";
 };

 my.security.hardened = {
 enable = true;
 lockdownMode = "permissive"; # Safety first: Log violations, don't kill yet.
 };
}

``n---
### [F-150] secrets\secrets.yaml
* Pfad: secrets\secrets.yaml | Format: .yaml | Größe: 5,69 KB
``yaml
github_token: ENC[AES256_GCM,data:lkDIr9UNvJXqLymNgmhfmtWkpD0v5uUhkuOx+0+QuMLblBvWWJuFGA==,iv:X4eabYYa3QzaP8MHtxUZ9TQxPjPFW6XVC+0rSOsuoOk=,tag:ndV1J5q2k1ktA9oAPTWYjg==,type:str]
cloudflare_token: ENC[AES256_GCM,data:mGGSfei1XleTNHfHhMe1HLUkjxFJAzzMIH8sjugoSxvwBP68TeR3Zg==,iv:t/IWbq9G2RXxm3nYt3tMTW3j91MeF+txg/seRUHDN90=,tag:gSkgacPXGHiCdOvIWoAacA==,type:str]
tailscale_token: ENC[AES256_GCM,data:G4y7ht13fmbGCggGYRzn9vLloOl1l09lNcO4wBEFHA==,iv:71rjwB80I1JhQ/dqiUc0f8Go4Cyq6RWEgbl6tmq9Qco=,tag:UWNdWlAyhdXIeGOglLo7SQ==,type:str]
wg_privado_private_key: ENC[AES256_GCM,data:sR7g47+rkYzEeIUwaCvX6BTdaZRVRo8+0/CbplyHNfA4BiYdtyWETrMncLQ=,iv:ti9AFj0/53DLfmCcE9rHYEHCTyLF/XK2iafGdFsEnaQ=,tag:fGy+/wx8Jmr49OYXw99AIA==,type:str]
sonarr_api_key: ENC[AES256_GCM,data:RPHxzFD7Ni/dsbgZU0eKAyzzR3r/Mirh4moP4jnhIjw=,iv:nFr+OOvcdU5J6DUVAou8P7k9+YQKg6cHYJhh07c2wh4=,tag:1oFfr2Zw3v3vI+9RntUBlA==,type:str]
radarr_api_key: ENC[AES256_GCM,data:3T17QEV48CNT7yGA+6997RCSIsIfDYsIw+cqwPoDoQs=,iv:IPxwfId2fKBKq3DmupESTAo/4GrEZiq+4jF60ploAfE=,tag:Q/fa5vTxFuVfNwZxmuwRrQ==,type:str]
readarr_api_key: ENC[AES256_GCM,data:mtBexyPGZ+eBRNQR2OiNbyOhyL2UPeieWHHL4VKAPdg=,iv:M61bzbST2yVmSzb6U68No2dl3SHLgoumUJ8p8yZq3y4=,tag:hK9mZ6lH2FX1hUakETq1mA==,type:str]
homepage_sonarr_key: ENC[AES256_GCM,data:QsdCRmYlVJsPxQxLecLDiZEM7OJBpM6eLiPG7wOi034=,iv:bM17p7FHnn8JjPXGuy2iGz4IXQccvJdo1AxaG9DeRFI=,tag:bgMUXPVlFAf7efHuCLRc9A==,type:str]
homepage_radarr_key: ENC[AES256_GCM,data:St9OtttpP+wANDjkuFLjrPjfSeRiTe1eDOLOOiKyHTI=,iv:WzvElCGnVf16juOX+kCWAFDh4R/9sY2yNny2Xs1wQqU=,tag:kYZMrZIuXPChHeX9cPhN4Q==,type:str]
google_ai_key: ENC[AES256_GCM,data:95TUz0teNy6AznuOQXXhFUPEf3yeSPIuojjTXkm2w+XCTU102eCo,iv:E8WgpLBm0Ykv6pya/j5oH6SwUjxQ1bWu2Mngr8/eB34=,tag:HFYEkKrNdlMQSpbkDVw/gg==,type:str]
groq_key: ENC[AES256_GCM,data:16ATKKKYe2cGfcoTL7QJ8ITzknu6Ve6TN8nABxoKnZenGU/c+36bUP7stsGU+5cITqbP83BZEdw=,iv:RRhX0ymfj+6f/WOf5WdFHyIIntOm8RfGMI2U3zOBNKk=,tag:drlRqVoItQnchl3QgPMLEA==,type:str]
xai_key: ENC[AES256_GCM,data:4u3rGzMYI0zNnfhKUuIVOTw3pCEwlnXgxIkEK1t+HHLQjCG6hxRQ7NI9TBBCkThVbG+3JjhpukwqeXtt3kW+P8qa5kzwhK+q5W2E5HgdVWIYz5na,iv:H9RMMwxJ+ZnwGUauWblgbe3Nhf3941mNt+JOGRxB/5M=,tag:BrsnYjWo+5v4nec4r4xFFA==,type:str]
unraid_root_password: ENC[AES256_GCM,data:DHc2/dfbKNsk3LbTCe1K2nhCRQ8nVDp+1GLmh9OtkOE=,iv:sSVIpUV1JWr8x9OWi4IRJ+rxbEd2Z1tOC5My9Y+nnSs=,tag:HbwcqFADJXYO9SqAFtPsAQ==,type:str]
ssh_github_key: ENC[AES256_GCM,data:WoXswIkKQW1eS6zQfsXZbxkdwnR8Zk0jgVBFQRt2vJ4197rkl3E5KGrK+2hFZ/yI4GvLIW2ifiBEAWpLRL4wBLxelM2nMky7j/R6ruMxlkDuFXFFXTLr3OPBPLHuDgxWfP6ewIXZEJAHS2oekPTvzXghIttle6JCx6QWKMBDKNmMo21zD7q9mQywqwDHx6280limQvxLllXMURtXg4cczD/suf1gERx99HfMWzzfimIfmaXXl9aUtB6f49h34X8IuRIEsByDT+EftlZLyjC/SLNFa1/7yPdkJlx1iPQA9YzyyQj43JBU/8p7d+U0UZX+3QFp+I9LZsbMSuqJQcB04RD+ptj1RbHEGBfr6f67Pi/I4Fi4jC4Ak3TL351AyzB3uj1X+or89XzUe0pzhGHwmmspP7en/nl1+asiji9p1NYG1R5CFvIzhcn5ga3Pv9SHbI/GVNlXar4KM0hR+Rc1HfBJl8F2rhZhNq/hdeq9l+LXSYHI26Lxcr4V/5bizPj8ZOmL6zUBLLJnA2xgDYexN4uJAhRlcmb8S/zo,iv:tKF+yXqJnteSsHltrFUCbvKGbFhj83j6zq/g6ChEqP4=,tag:5g1RuHvbLSCEDcRticx1Kg==,type:str]
ssh_unraid_key: ENC[AES256_GCM,data:CzEbH4HoAic0q1kqmO4dbXZu30JayAZUifRmaCUxmdwTZLGgLSELTh9zahdScs+qIDz1CKi9Rx6AHjJpjj+CY/jaHioB4d+uF0aC5FUAdY+CckIq40JynfkWKXBHFO4DQ0odePmliWLu/uhrN1Fthe0NsiUnFrIhFHAFqYoZZkEoQil+0N1mSKA/NYVvYXbt1DJNxLOBqXah3Nq1iBF3Oy0LeBSbNtCa5UTwJlQoimlHVA5dAlzwBKLizmsKhVqMiMLnTjrHL0zEmpTtJnJRXQf9NeN+VxPlv10kHrvU8H0G7Nr6nGupLbiPPOR/ThITkFU70Li0GehtmRSbgQQypm1TpvKityHHZ4P2pRYSquJCXHCMsjDFo+nci2or/gyHZSqaOp+GdpAuS3v4kFLNaHcrR6qO13AlR8V2c+fyZETlK8zbujXtiUOm0hZoqgPGIYharFCkagpvvCXOro6vUMT3put+r0I7xL5dPmfUfMSYCvksgHkTTL5JS+ySOjQ0t2aIaCyi2SY74Mv2w2Ak,iv:jkffOwDoYucqgWH2HZAA7ITMKarpnSMjLCqmvYEwL9Q=,tag:2xnWX1dql6k7MglfjpNqQA==,type:str]
n8n_enc_key: ENC[AES256_GCM,data:MYeBc7h1xoM=,iv:wFiJH4C4/GS5tp2ummHTW3s/nFpGcsJZ0NVr12GxMZc=,tag:bmmQZVG3Wn4WEqYi3VVrCQ==,type:str]
vaultwarden_env: ENC[AES256_GCM,data:vGPAN8qlNbVBb7KbUyzIfKRBIyc=,iv:JbP+YnsnxIgqD+l/2jdRexnvyJjKVq7vGOoCLTfCRe0=,tag:EtQBggs5wu1MY016zVTBpQ==,type:str]
miniflux_admin_password: ENC[AES256_GCM,data:Vd1EBpa+Ff8=,iv:jGRJsuelDyt2Zno00W5Z9oP4Jd+4R9LQTb4sZ94YnGM=,tag:nlWXXOKitQiTP7VgV+Mhew==,type:str]
paperless_secret_key: ENC[AES256_GCM,data:J7uOF7HB0+M=,iv:3FMF+heOJ6z4pb/pdesenStQyEyb3Vfu/D96H9VmV1M=,tag:XZcSyxFCq7IYT14JiBw7TQ==,type:str]
sops:
 age:
 - recipient: age1pjl6xt8zu80p4dpp6yqnk5u53ratgc58sdtnf7c2krlxyt8msgvs9s763s
 enc: |

 YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBjRWJJcTVsNEFPYkgvN1hV
 N1hXWnY2ODRTV0VPNkprTGZRZjVsSTI1Z1RJClVSd3hFWkFhcEdVQnByTTJLVnU4
 RWtJVWpBaDF2OC9ZZFRQWEcrRU1Lb0UKLS0tIEF1NzRjUUwzbjExNDYxZ3lQN3d6
 SUZ1K2NlZFRJdytQMkhxb3NHTWRxR1UKThaRnqw7tIo6fpasOWpMk9+Qhpr2PJc5
 PAxKrOQfvQMQEdGDQmiSNOcrGkJepWTRQpWO76TbeaR4z59RQ76Lrg==

 - recipient: age1t2uu2un4trvvyhg7ryp8h8tqjxl5vnd0qd48dq4s8yvhc6jwtd4smyet95
 enc: |

 YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSA4YlFVeHE0SDU4WWNCMEM2
 Q2FjZVM5alNOM051cnRQbmUrZng2UVpjVWtFCm9vRnNwNUNFM3JQRkxITC9MeTdG
 VEpFem5aSWl3UUo4MGdQMzQxUnozWGsKLS0tIDZFSXFPSVdUVVg1YW9yOHBVTDRw
 UnZrQmM2dmZ3ZDdMR0djNGR5VTJ1SkkKYxU9VaodMBUdVobnWFvWvj7EQWqcyuIA
 0qn5K8B4hUYcfw24v/VNZ8SE8FIjsJhYrErt7pmoovCh8k6pnp2kVA==

 lastmodified: "2026-03-01T18:51:55Z"
 mac: ENC[AES256_GCM,data:B0u9kA6/NjTgfQSgs4V/6S5QLSWmCcyeBcbwgnDPK9bGY/RGs1jcdL4gCPFWMy7CB3txOJycWtP0fBYEZc9g0Z++zvJN0phMwrTiqJA88TRRruG01aRu6Jqn3CHKDYdy+W6E7iyLDW3gqYWMGwztmPFBcaEfcNzF8I4mFUFfahk=,iv:KbBkG1HHUG/+NYZQ3zLkG2ST3KDpixAV6d+sDQJICKU=,tag:ghkrOVyykbz+6b91Y6ZbhA==,type:str]
 unencrypted_suffix: _unencrypted
 version: 3.11.0

``n---
### [F-151] users\freund\default.nix
* Pfad: users\freund\default.nix | Format: .nix | Größe: 923 B
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-USR-FREUND-001";
 title = "User (Freund)";
 description = "Isolated user profile for collaboration. Demonstration of horizontal decoupling.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
in {
 config = {
 users.users.freund = {
 isNormalUser = true;
 description = "Collaborator (Freund)";
 extraGroups = ["video" "render" "media"]; # Kein 'wheel' für den Freund

 hashedPasswordFile = config.sops.secrets.freund_password.path;

 openssh.authorizedKeys.keys = [
 "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...PLACEHOLDER..." 
 ];

 shell = pkgs.bashInteractive;
 };

 sops.secrets.freund_password.neededForUsers = true;
 };
}

``n---
### [F-152] users\freund\home.nix
* Pfad: users\freund\home.nix | Format: .nix | Größe: 319 B
``nix
{ config, lib, pkgs, ... }: {

 home.stateVersion = "25.11";

 programs.git = {
 enable = true;
 userName = "Freund";
 userEmail = "freund@${config.my.configs.identity.domain}";
 };

 programs.bash.enable = true;
}

``n---
### [F-153] users\moritz\default.nix
* Pfad: users\moritz\default.nix | Format: .nix | Größe: 1,65 KB
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-039";
 title = "Users (Declarative & Hardened)";
 description = "Strictly immutable user management. Passwords managed via Sops-Nix. Unified media group.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["system/users" "security/no-mutable-users" "security/sops-integration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.users = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [ ./locale.nix ];

 config = {

 users.mutableUsers = false;

 users.users.${user} = {
 isNormalUser = true;
 description = "Primary Admin (${user})";
 extraGroups = ["wheel" "video" "render" "media" "networkmanager"];

 hashedPasswordFile = config.sops.secrets.user_password.path;

 openssh.authorizedKeys.keys = [
 "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJRDbyFjT4SEL8yxNwZuEBPORD82qlJJhdr2r4qz1vCX" # Main Key
 ];

 shell = pkgs.bashInteractive;
 };

 users.groups.media = {
 gid = 169;
 };

 sops.secrets.user_password.neededForUsers = true;
 };
}

``n---
### [F-154] users\moritz\home-manager-config.nix
* Pfad: users\moritz\home-manager-config.nix | Format: .nix | Größe: 1,25 KB
``nix
{ config, pkgs, lib, ... }:
let

 nms = {
 id = "NIXH-00-COR-037";
 title = "User Moritz Home";
 description = "Personalized user environment configuration via Home-Manager for user 'moritz'.";
 layer = 0;
 nixpkgs.category = "tools/admin";
 capabilities = ["user/dotfiles" "home-manager/config"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };
in {
 options.my.meta.user_moritz_home = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for user-moritz-home module";
 };

 config = {
 home.stateVersion = "24.11";
 home.packages = with pkgs; [ micro neofetch htop ncdu btop dust ];
 programs.bash = { enable = true; historySize = 50000; historyFileSize = 100000; historyControl = [ "ignoredups" "ignorespace" ]; };
 programs.htop = { enable = true; settings = { color_scheme = 0; delay = 15; highlight_base_name = 1; highlight_megabytes = 1; highlight_threads = 1; show_program_path = 0; }; };
 programs.micro = { enable = true; settings = { colorscheme = "simple"; tabsize = 2; mouse = true; }; };
 programs.bat = { enable = true; config = { theme = "base16"; italic-text = "always"; }; };
 };
}

``n---
### [F-155] users\moritz\home.nix
* Pfad: users\moritz\home.nix | Format: .nix | Größe: 1,98 KB
``nix
{
 config,
 lib,
 pkgs,
 inputs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-013";
 title = "Home Manager (User Cockpit)";
 description = "Hardened user environment. Git SSoT and Shell-Secret integration.";
 layer = 00;
 nixpkgs.category = "tools/admin";
 capabilities = ["user/environment" "shell/hardening" "git/configuration"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };

 user = config.my.configs.identity.user;
in {
 options.my.meta.home_manager = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 imports = [ inputs.home-manager.nixosModules.home-manager ];

 config = {
 home-manager = {
 useGlobalPkgs = true;
 useUserPackages = true;
 backupFileExtension = "hm-backup";

 users.${user} = { pkgs, ... }: {
 home.stateVersion = "24.05"; # Stable anchor

 imports = [ ./home-manager-config.nix ./preferences.nix ];

 programs.git = {
 enable = true;
 userName = "Moritz";
 userEmail = "git@${config.my.configs.identity.domain}";
 extraConfig = {
 init.defaultBranch = "main";
 pull.rebase = true;
 core.editor = "micro";
 };
 aliases = {
 st = "status";
 co = "checkout";
 br = "branch";
 up = "pull --rebase";
 };
 };

 programs.bash = {
 enable = true;
 shellAliases = {

 godmode = "gemini --yolo --include-directories /etc/nixos,$(pwd)";
 };
 };
 };
 };
 };
}

``n---
### [F-156] users\moritz\locale.nix
* Pfad: users\moritz\locale.nix | Format: .nix | Größe: 1,15 KB
``nix
{ config, lib, myLib, ... }: {

 i18n.defaultLocale = myLib.mkTracedOption "SRC-CHAT-LOCALE-001" (lib.mkOption {
 type = lib.types.str;
 default = "de_DE.UTF-8";
 description = "System default locale [Source: Fragment 002]";
 }).default;

 time.timeZone = myLib.mkTracedOption "SRC-CHAT-LOCALE-002" (lib.mkOption {
 type = lib.types.str;
 default = "Europe/Berlin";
 description = "System timezone [Source: Fragment 002]";
 }).default;

 console.keyMap = myLib.mkTracedOption "SRC-CHAT-LOCALE-003" (lib.mkOption {
 type = lib.types.str;
 default = "de-latin1";
 description = "Console keymap [Source: Fragment 002]";
 }).default;

 i18n.extraLocaleSettings = {
 LC_ADDRESS = "de_DE.UTF-8";
 LC_IDENTIFICATION = "de_DE.UTF-8";
 LC_MEASUREMENT = "de_DE.UTF-8";
 LC_MONETARY = "de_DE.UTF-8";
 LC_NAME = "de_DE.UTF-8";
 LC_NUMERIC = "de_DE.UTF-8";
 LC_PAPER = "de_DE.UTF-8";
 LC_TELEPHONE = "de_DE.UTF-8";
 LC_TIME = "de_DE.UTF-8";
 };
}

``n---
### [F-157] users\moritz\preferences.nix
* Pfad: users\moritz\preferences.nix | Format: .nix | Größe: 674 B
``nix
{
 config,
 lib,
 pkgs,
 ...
}: let

 nms = {
 id = "NIXH-00-COR-038";
 title = "User Preferences";
 description = "Customized user preferences and personal system adjustments.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["user/preferences"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.user_preferences = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for user-preferences module";
 };

 config = {

 };
}

``n---

## 📌 INDEX ALLER ANCHORS

[F-001]
[F-002]
[F-003]
[F-004]
[F-005]
[F-006]
[F-007]
[F-008]
[F-009]
[F-010]
[F-011]
[F-012]
[F-013]
[F-014]
[F-015]
[F-016]
[F-017]
[F-018]
[F-019]
[F-020]
[F-021]
[F-022]
[F-023]
[F-024]
[F-025]
[F-026]
[F-027]
[F-028]
[F-029]
[F-030]
[F-031]
[F-032]
[F-033]
[F-034]
[F-035]
[F-036]
[F-037]
[F-038]
[F-039]
[F-040]
[F-041]
[F-042]
[F-043]
[F-044]
[F-045]
[F-046]
[F-047]
[F-048]
[F-049]
[F-050]
[F-051]
[F-052]
[F-053]
[F-054]
[F-055]
[F-056]
[F-057]
[F-058]
[F-059]
[F-060]
[F-061]
[F-062]
[F-063]
[F-064]
[F-065]
[F-066]
[F-067]
[F-068]
[F-069]
[F-070]
[F-071]
[F-072]
[F-073]
[F-074]
[F-075]
[F-076]
[F-077]
[F-078]
[F-079]
[F-080]
[F-081]
[F-082]
[F-083]
[F-084]
[F-085]
[F-086]
[F-087]
[F-088]
[F-089]
[F-090]
[F-091]
[F-092]
[F-093]
[F-094]
[F-095]
[F-096]
[F-097]
[F-098]
[F-099]
[F-100]
[F-101]
[F-102]
[F-103]
[F-104]
[F-105]
[F-106]
[F-107]
[F-108]
[F-109]
[F-110]
[F-111]
[F-112]
[F-113]
[F-114]
[F-115]
[F-116]
[F-117]
[F-118]
[F-119]
[F-120]
[F-121]
[F-122]
[F-123]
[F-124]
[F-125]
[F-126]
[F-127]
[F-128]
[F-129]
[F-130]
[F-131]
[F-132]
[F-133]
[F-134]
[F-135]
[F-136]
[F-137]
[F-138]
[F-139]
[F-140]
[F-141]
[F-142]
[F-143]
[F-144]
[F-145]
[F-146]
[F-147]
[F-148]
[F-149]
[F-150]
[F-151]
[F-152]
[F-153]
[F-154]
[F-155]
[F-156]
[F-157]
