{ config, lib, pkgs, myLib, ... }:

let
  cfg = config.my.monitoring.gatus;
  srePaths = config.my.configs.paths;
  
  # 🚀 GATUS CONFIG GENERATOR
  # Converts the endpoints list into a YAML file
  # Note: toJSON is used as a proxy for YAML since Gatus supports JSON as well, 
  # but here we generate a clean YAML structure using a helper if available,
  # or just use toJSON as Gatus accepts it if named .json or via --config.
  gatusConfig = pkgs.writeText "gatus.yaml" (builtins.toJSON {
    endpoints = cfg.endpoints;
    storage = {
      type = "sqlite";
      path = "${srePaths.stateDir}/gatus/data.db";
    };
    web = {
      port = cfg.port;
      address = "0.0.0.0";
    };
  });

in {
  options.my.monitoring.gatus = {
    enable = lib.mkEnableOption "Gatus Health Dashboard";
    port = lib.mkOption { type = lib.types.port; default = config.my.ports.gatus; };
    
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
    # 🎬 1. AVIATION-GRADE SERVICE FABRIK
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

    # 🔧 2. GATUS SPECIFICS
    {
      # Permissions for the state directory
      systemd.tmpfiles.rules = [
        "d ${srePaths.stateDir}/gatus 0750 gatus gatus -"
      ];

      # Persistence is already handled by mkService for /var/lib/gatus
    }
  ]);
}
