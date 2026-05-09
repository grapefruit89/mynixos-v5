# ---
# nms_id: APP-MEDIA-LIDARR
# title: Lidarr Music Manager
# capabilities: ["media/management", "media/music"]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, utils, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Lidarr)
 # Fragment-Sourcing:
 # - NIXH-40-MED-009: Basis Lidarr Modul
 # - Fragment 3331: LoadCredential for API Keys
 # - ADR 852: ABC-Tiering Path Strategy
 # - Fragment 3108: hardening
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
 
 # 💾 PATH STRATEGY (ABC-Tiering)
 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/lidarr/.config/Lidarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/metadata/lidarr";
 description = "Fast metadata cache (Tier B)";
 };

 # 🎖️ SETTINGS & SECRETS
 settings = factory.mkServarrSettingsOptions "lidarr" 8686;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Lidarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 # 🏆 Use the hardened Service Factory
 (myLib.mkService {
 inherit config;
 name = "lidarr";
 netns = "media-ns";
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
 
 # 🔗 SETTINGS AS ENV (Source: Factory)
 environment = factory.mkServarrSettingsEnvVars "LIDARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;
 
 # Force binary path and data dir
 ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.lidarr) "-nobrowser" "-data=${cfg.stateDir}" ];
 Restart = "on-failure";

 # 🔑 SECRET ISOLATION (Source: Fragment 3331)
 LoadCredential = lib.optional (cfg.apiKeyFile != null) "LIDARR_API_KEY:${toString cfg.apiKeyFile}";

 # 🛡️ RESOURCE TUNING
 MemoryMax = "2G";
 CPUWeight = 30;
 OOMScoreAdjust = 600;
 
 # Path Management
 BindPaths = [
 "${cfg.metadataDir}:/var/lib/lidarr/MediaCover"
 ];
 
 # hardened fix for .NET namespaces
 RestrictNamespaces = lib.mkForce false; 
 };
 };

 # 📁 PERMISSION MANAGEMENT
 systemd.tmpfiles.rules = [
 "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
 "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
 "d ${srePaths.mediaLibrary}/music 0775 ${cfg.user} ${cfg.group} -"
 ];

 # 💾 PERSISTENCE (Tier A)
 environment.persistence."/persist" = {
 directories = [ "/var/lib/lidarr" ];
 };
 }
 ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f5\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
