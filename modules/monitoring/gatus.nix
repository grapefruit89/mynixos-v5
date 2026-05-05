{ config, lib, pkgs, myLib, ... }:

let
  cfg = config.my.monitoring.gatus;
  srePaths = config.my.configs.paths;
  identity = config.my.configs.identity;
  
  # 🚀 GATUS CONFIG GENERATOR
  gatusConfig = let
    # Use identity to resolve public domain for alerting click-throughs
    publicUrl = "https://gatus.${identity.subdomain}.${identity.domain}";
    
    yamlStruct = {
      storage = {
        type = "sqlite";
        path = "${srePaths.stateDir}/gatus/data.db";
      };
      web = {
        port = cfg.port;
        address = "127.0.0.1";
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
    
    # 🔥 NTFY ALERTING (ADR 882)
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
    }
  ]);
}
