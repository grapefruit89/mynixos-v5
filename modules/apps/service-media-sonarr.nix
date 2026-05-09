# ---
# nms_id: APP-MEDIA-SONARR
# title: Sonarr (hardened)
# capabilities: [ "media", "tv", "downloads" ]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, utils, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Sonarr)
 # Fragment-Sourcing:
 # - NIXH-40-MED-017: Basis Sonarr Modul
 # - Fragment 3331: LoadCredential for API Keys
 # - ADR 852: ABC-Tiering Path Strategy
 # - Fragment 3108: hardening
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
 
 # 💾 PATH STRATEGY (ABC-Tiering)
 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/sonarr/.config/NzbDrone"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/metadata/sonarr";
 description = "Fast metadata cache (Tier B)";
 };

 # 🎖️ SETTINGS & SECRETS
 settings = factory.mkServarrSettingsOptions "sonarr" 8989;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Sonarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 # 🏆 Use the hardened Service Factory
 (myLib.mkService {
 inherit config;
 name = "sonarr";
 netns = "media-ns";
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
 
 # 🔗 SETTINGS AS ENV (Source: Factory)
 environment = factory.mkServarrSettingsEnvVars "SONARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;
 
 # Force binary path and data dir
 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.sonarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 # 🔑 SECRET ISOLATION (Source: Fragment 3331)
 LoadCredential = lib.optional (cfg.apiKeyFile != null) "SONARR_API_KEY:${toString cfg.apiKeyFile}";

 # 🛡️ RESOURCE TUNING
 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;
 
 # Path Management
 BindPaths = [
 "${cfg.metadataDir}:/var/lib/sonarr/MediaCover"
 ];
 
 # hardened fix for .NET namespaces
 RestrictNamespaces = lib.mkForce false; 
 };
 };

 # 📁 PERMISSION MANAGEMENT
 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/tv 0775 ${cfg.user} ${cfg.group} -"
 ];

 # 💾 PERSISTENCE (Tier A)
 environment.persistence."/persist" = {
 directories = [ "/var/lib/sonarr" ];
 };
 }
 ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f3\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
