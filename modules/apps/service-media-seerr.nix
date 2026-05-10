{ config, lib, pkgs, myLib, ... }:

let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-30-MED-005";
    title = "Seerr (Media Requests)";
    description = "Unified media request management for Jellyfin and Arr-stack.";
    layer = 30;
    nixpkgs.category = "services/multimedia";
    capabilities = ["media/requests" "automation/requests"];
    audit.last_reviewed = "2026-05-10";
    audit.complexity = 2;
  };

  name = "seerr";
  port = config.my.ports.seerr;
in {
  options.my.meta.seerr = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = lib.mkIf config.my.services.radarr.enable (lib.mkMerge [
    (myLib.mkService {
      inherit config name port;
      description = "Seerr Media Requests";
      useSSO = true;
    })
    {
      services.jellyseerr = {
        enable = true;
        port = port;
      };
    }
  ]);
}
