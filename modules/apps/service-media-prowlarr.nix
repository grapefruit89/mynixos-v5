{ config, lib, pkgs, utils, myLib, ... }:
let
  arrFactory = import ./_arr-factory.nix { inherit config lib pkgs utils myLib; };
in
arrFactory.mkArr {
  name = "prowlarr";
  description = "Prowlarr Indexer Manager";
  id = "NIXH-01-APP-PRO-001";
  port = 9696;
}
