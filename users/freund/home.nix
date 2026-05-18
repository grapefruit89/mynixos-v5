{ config, lib, pkgs, ... }: {
 # 🚀 HOME-MANAGER FOR FREUND
 # Völlig getrennt von Moritz' Cockpit.

 home.stateVersion = "25.11"; # see docs/NIXOS_VERSION_INFO.md – this is the current stable channel, not future music.
 
 programs.git = {
 enable = true;
 userName = "Freund";
 userEmail = "freund@${config.my.configs.identity.domain}";
 };

 programs.bash.enable = true;
}
