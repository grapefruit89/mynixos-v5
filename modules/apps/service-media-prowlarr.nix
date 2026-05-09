# ---
# nms_id: APP-MEDIA-PROWLARR
# title: Prowlarr Indexer Manager
# capabilities: ["media/indexing"]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, utils, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Prowlarr)
 # Fragment-Sourcing:
 # - NIXH-40-MED-011: Basis Prowlarr Modul
 # - Fragment 3331: LoadCredential for API Keys
 # - ADR 852: ABC-Tiering Path Strategy
 # - Fragment 3108: hardening
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
 
 # 💾 PATH STRATEGY (ABC-Tiering)
 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/prowlarr/.config/Prowlarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/metadata/prowlarr";
 description = "Fast metadata cache (Tier B)";
 };

 # 🎖️ SETTINGS & SECRETS
 settings = factory.mkServarrSettingsOptions "prowlarr" 9696;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Prowlarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 # 🏆 Use the hardened Service Factory
 (myLib.mkService {
 inherit config;
 name = "prowlarr";
 netns = "media-ns";
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
 
 # 🔗 SETTINGS AS ENV (Source: Factory)
 environment = factory.mkServarrSettingsEnvVars "PROWLARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;
 
 # Force binary path and data dir
 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.prowlarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 # 🔑 SECRET ISOLATION (Source: Fragment 3331)
 LoadCredential = lib.optional (cfg.apiKeyFile != null) "PROWLARR_API_KEY:${toString cfg.apiKeyFile}";

 # 🛡️ RESOURCE TUNING
 MemoryMax = "1G"; # Prowlarr needs less than Sonarr/Radarr
 CPUWeight = 20; 
 OOMScoreAdjust = 700;
 
 # Path Management
 BindPaths = [
 "${cfg.metadataDir}:/var/lib/prowlarr/MediaCover"
 ];
 
 # hardened fix for .NET namespaces
 RestrictNamespaces = lib.mkForce false; 
 };
 };

 # 📁 PERMISSION MANAGEMENT
 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 ];

 # 💾 PERSISTENCE (Tier A)
 environment.persistence."/persist" = {
 directories = [ "/var/lib/prowlarr" ];
 };
 }
 ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f4\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
