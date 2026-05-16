{ config, lib, pkgs, utils, myLib, ... }:
let
  arrFactory = import ./_arr-factory.nix { inherit config lib pkgs utils myLib; };
in
arrFactory.mkArr {
  name = "sonarr";
  description = "Sonarr TV Series Downloader";
  id = "NIXH-01-APP-SON-001";
  port = 8989;
  stateDirName = "NzbDrone"; # Sonarr special case
  extraReadWritePaths = [ 
    config.my.configs.paths.mediaLibrary
    config.my.configs.paths.downloads
  ];
}
