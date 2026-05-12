# ---
# nms_id: APP-MEDIA-RADARR
# title: Radarr (hardened)
# capabilities: [ "media", "movies", "downloads" ]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Radarr)
 # Fragment-Sourcing:
 # - NIXH-40-MED-012: Basis Radarr Modul
 # - Fragment 3331: LoadCredential for API Keys
 # - ADR 852: ABC-Tiering Path Strategy
 # - Fragment 3108: hardening
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
 
 # 💾 PATH STRATEGY (ABC-Tiering)
 stateDir = lib.mkOption { 
 type = lib.types.str; 
 default = "${srePaths.stateDir}/radarr/.config/Radarr"; 
 description = "Database and config (Tier A/Persist)";
 };
 metadataDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/metadata/radarr";
 description = "Fast metadata cache (Tier B)";
 };

 # 🎖️ SETTINGS & SECRETS
 settings = factory.mkServarrSettingsOptions "radarr" 7878;
 apiKeyFile = lib.mkOption {
 type = lib.types.nullOr lib.types.path;
 default = null;
 description = "Path to Radarr API Key (via Sops)";
 };
 };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 # 🏆 Use the hardened Service Factory
 (myLib.mkService {
 inherit config;
 name = "radarr";
 netns = "media-ns";
 port = cfg.settings.server.port;
 useSSO = true;
 description = "Radarr Movie Manager";
 persist = true;
 readWritePaths = [ 
 cfg.stateDir 
 cfg.metadataDir
 srePaths.mediaLibrary
 srePaths.downloads
 ];
 })

 {
 systemd.services.radarr = {
 description = "Radarr (hardened)";
 after = [ "network.target" "postgresql.service" ];
 wantedBy = [ "multi-user.target" ];
 
 # 🔗 SETTINGS AS ENV (Source: Factory)
 environment = factory.mkServarrSettingsEnvVars "RADARR" cfg.settings;

 serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
 Type = "simple";
 User = cfg.user;
 Group = cfg.group;
 
 # Force binary path and data dir
 ExecStart = pkgs.writeShellScript "radarr-start" ''
   ${pkgs.radarr}/bin/Radarr -nobrowser -data="${cfg.stateDir}"
 '';
 Restart = "on-failure";

 # 🔑 SECRET ISOLATION (Source: Fragment 3331)
 LoadCredential = lib.optional (cfg.apiKeyFile != null) "RADARR_API_KEY:${toString cfg.apiKeyFile}";

 # 🛡️ RESOURCE TUNING
 MemoryMax = "2G";
 CPUWeight = 30; # Lower than Sabnzbd
 OOMScoreAdjust = 600;
 
 # Path Management
 BindPaths = [
 "${cfg.metadataDir}:/var/lib/radarr/MediaCover"
 ];
 };
 };

      # 📁 PERMISSION MANAGEMENT
      systemd.tmpfiles.rules = [
        "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
        "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
        "d ${srePaths.mediaLibrary}/movies 0775 ${cfg.user} ${cfg.group} -"
      ];
    }
  ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f2\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
