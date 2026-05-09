# ---
# nms_id: APP-MEDIA-SEERR
# title: Seerr (hardened Requests)
# capabilities: [ "requests", "media" ]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Seerr)
 # Fragment-Sourcing:
 # - NIXH-40-MED-008: Basis Jellyseerr Modul
 # - Fragment 9856: Seerr (Successor of Jellyseerr)
 # - ADR 852: ABC-Tiering Path Strategy
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
 port = lib.mkOption { type = lib.types.port; default = config.my.ports.jellyseerr or 5055; };
 
 # 💾 PATH STRATEGY (ABC-Tiering)
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

 # 🔑 SECRETS
 secretFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Seerr environment file containing API keys (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 # 🏆 Use the hardened Service Factory
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
 # 👥 USER & GROUP
 users.users.${cfg.user} = {
 isSystemUser = true;
 group = cfg.group;
 home = cfg.stateDir;
 extraGroups = [ "media" ];
 };
 users.groups.${cfg.group} = {};

 # Caddy Subdomain Override (hardened Identity)
 services.caddy.virtualHosts."requests.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" = 
 config.services.caddy.virtualHosts."seerr.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

 systemd.services.seerr = {
 description = "Seerr Media Request Service (hardened)";
 after = [ "network.target" "jellyfin.service" ];
 
 # 🔗 NODE.JS HARDENING (Source: Fragment 9654)
 serviceConfig = {
 User = cfg.user;
 Group = cfg.group;
 ExecStart = "${pkgs.jellyseerr}/bin/jellyseerr"; # Using jellyseerr package as Seerr base
 WorkingDirectory = cfg.stateDir;
 
 # 🔑 SECRET ISOLATION
 EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;

 # 🛡️ hardening
 MemoryMax = "1G";
 CPUWeight = 30;
 OOMScoreAdjust = 400;
 
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 
 # Node.js JIT Exception
 MemoryDenyWriteExecute = false; 

 RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
 };
 };

 # 📁 PERMISSION MANAGEMENT
 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
 "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
 ];

 # 💾 PERSISTENCE (Tier A)
 environment.persistence."/persist" = {
 directories = [ "/var/lib/seerr" ];
 };
 }
 ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13a9c7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f10\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
