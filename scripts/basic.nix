{ lib, config, ... }: {
  imports = [ ../configuration.nix ];
  assertions = [
    { assertion = config.networking.hostName != ""; message = "Hostname must be set."; }
    { assertion = config.networking.nftables.enable; message = "nftables must be enabled."; }
  ];
}
