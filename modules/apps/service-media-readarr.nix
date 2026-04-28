{ config, lib, pkgs, utils, myLib, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Readarr)
  # Fragment-Sourcing:
  # - NIXH-40-MED-013: Basis Readarr Modul
  # - Fragment 3331: LoadCredential for API Keys
  # - ADR 852: ABC-Tiering Path Strategy
  # - Fragment 3108: Titanium Hardening
  nms = {
    id = "NIXH-01-APP-REA-001";
    title = "Readarr (Aviation-Grade)";
    description = "Book management and downloader with Titanium Sandboxing.";
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
    
    # 💾 PATH STRATEGY (ABC-Tiering)
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

    # 🎖️ SETTINGS & SECRETS
    settings = factory.mkServarrSettingsOptions "readarr" 8787;
    apiKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to Readarr API Key (via Sops)";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # 🏆 Use the Aviation-Grade Service Factory
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
        description = "Readarr (Aviation-Grade)";
        after = [ "network.target" "postgresql.service" ];
        wantedBy = [ "multi-user.target" ];
        
        # 🔗 SETTINGS AS ENV (Source: Factory)
        environment = factory.mkServarrSettingsEnvVars "READARR" cfg.settings;

        serviceConfig = lib.recursiveUpdate factory.mkServarrHardening {
          Type = "simple";
          User = cfg.user;
          Group = cfg.group;
          
          # Force binary path and data dir
          ExecStart = utils.escapeSystemdExecArgs [ (lib.getExe pkgs.readarr) "-nobrowser" "-data=${cfg.stateDir}" ];
          Restart = "on-failure";

          # 🔑 SECRET ISOLATION (Source: Fragment 3331)
          LoadCredential = lib.optional (cfg.apiKeyFile != null) "READARR_API_KEY:${toString cfg.apiKeyFile}";

          # 🛡️ RESOURCE TUNING
          MemoryMax = "2G";
          CPUWeight = 30;
          OOMScoreAdjust = 600;
          
          # Path Management
          BindPaths = [
            "${cfg.metadataDir}:/var/lib/readarr/MediaCover"
          ];
          
          # Aviation-Grade fix for .NET namespaces
          RestrictNamespaces = lib.mkForce false; 
        };
      };

      # 📁 PERMISSION MANAGEMENT
      systemd.tmpfiles.rules = [
        "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} -"
        "d ${cfg.metadataDir} 0775 ${cfg.user} ${cfg.group} -"
        "d ${srePaths.mediaLibrary}/books 0775 ${cfg.user} ${cfg.group} -"
      ];

      # 💾 PERSISTENCE (Tier A)
      environment.persistence."/persist" = {
        directories = [ "/var/lib/readarr" ];
      };
    }
  ]);
}
/**
 * ---\n * technical_integrity:\n *   checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f6\n *   eof_marker: NIXHOME_VALID_EOF* ---\n */
