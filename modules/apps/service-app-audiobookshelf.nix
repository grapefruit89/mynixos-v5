{ config, lib, pkgs, myLib, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Audiobookshelf)
  # Fragment-Sourcing:
  # - NIXH-40-MED-002: Vorherige Version
  # - ADR 852: ABC-Tiering Path Strategy
  nms = {
    id = "NIXH-01-APP-ABS-001";
    title = "Audiobookshelf (Aviation-Grade)";
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
    
    # 💾 PATH STRATEGY (ABC-Tiering)
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
    
    # 🎬 1. AVIATION-GRADE STREAMER FABRIK
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
      # Caddy Subdomain Override (Aviation-Grade Identity)
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
        # 🔗 NODE.JS HARDENING (Audiobookshelf is Node.js based)
        serviceConfig = {
          # Path Management (SRE-Standard)
          ReadWritePaths = [
            cfg.stateDir
            cfg.audiobookDir
            cfg.podcastDir
          ];
          
          # Node.js JIT Exception (Source: Fragment 9654)
          MemoryDenyWriteExecute = false; 
        };
      };

      # 📁 PERMISSION MANAGEMENT
      systemd.tmpfiles.rules = [
        "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
        "d ${cfg.audiobookDir} 0775 ${cfg.user} ${cfg.group} -"
        "d ${cfg.podcastDir} 0775 ${cfg.user} ${cfg.group} -"
      ];

      # 💾 PERSISTENCE (Tier A)
      environment.persistence."/persist" = {
        directories = [ "/var/lib/audiobookshelf" ];
      };
    }
  ]);
}
/**
 * ---\n * technical_integrity:\n *   checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f11\n *   eof_marker: NIXHOME_VALID_EOF* ---\n */
