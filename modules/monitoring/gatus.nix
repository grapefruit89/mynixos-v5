{ config, lib, pkgs, myLib, ... }:
let
  cfg = config.my.monitoring.gatus;
  srePaths = config.my.configs.paths;
  identity = config.my.configs.identity;
  
  # 🚀 GATUS CONFIG GENERATOR
  gatusConfig = let
    yamlStruct = {
      storage = { type = "sqlite"; path = "${srePaths.stateDir}/gatus/data.db"; };
      web = { port = cfg.port; address = "127.0.0.1"; };
      endpoints = cfg.endpoints;
    };
  in pkgs.writeText "gatus.yaml" (builtins.toJSON yamlStruct);

in {
  options.my.monitoring.gatus = {
    enable = lib.mkEnableOption "Gatus Health Dashboard";
    port = lib.mkOption { type = lib.types.port; default = 8080; };
    endpoints = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      description = "List of endpoints to monitor (declarative).";
    };
  };

  config = lib.mkIf cfg.enable {
    # 🎬 hardened SERVICE FACTORY
    systemd.services.gatus = (myLib.mkService {
      inherit config;
      name = "gatus";
      port = cfg.port;
      useSSO = true;
      persist = true;
      description = "Gatus Health Dashboard";
      extraServiceConfig = {
        ExecStart = lib.mkForce "${pkgs.gatus}/bin/gatus --config \"${gatusConfig}\"";
      };
    }).systemd.services.gatus;

    # 🔧 GATUS SPECIFICS
    systemd.tmpfiles.rules = [
      "d ${srePaths.stateDir}/gatus 0750 gatus media -"
    ];
  };
}
