{ config, lib, pkgs, myLib, ... }:

let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-30-MED-009";
    title = "Read Me A Book";
    description = "Self-hosted audiobook reader and manager (Alternative to ABS).";
    layer = 30;
    nixpkgs.category = "services/multimedia";
    capabilities = ["media/audiobooks"];
    audit.last_reviewed = "2026-05-10";
    audit.complexity = 1;
  };

  name = "readmeabook";
  port = config.my.ports.readmeabook or 20002;
in {
  options.my.meta.readmeabook = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = lib.mkIf (config.my.services.jellyfin.enable or false) (lib.mkMerge [
    (myLib.mkService {
      inherit config name port;
      description = "Read Me A Book Service";
      useSSO = true;
    })
    {
      # Note: Read Me A Book is not currently in nixpkgs, assuming manual package or container-based approach in future.
      # For now, we only reserve the vhost and port mapping.
    }
  ]);
}
