{ config, lib, pkgs, ... }: {
  # 🚀 HOME-MANAGER FOR FREUND
  # Völlig getrennt von Moritz' Cockpit.

  home.stateVersion = "25.11";
  
  programs.git = {
    enable = true;
    userName = "Freund";
    userEmail = "freund@${config.my.configs.identity.domain}";
  };

  programs.bash.enable = true;
}
