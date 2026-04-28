{ config, lib, pkgs, ... }: {
  # 🚀 AVIATION-GRADE MISSION PROFILE: BASE SERVER
  # Bündelt alle Core-Systeme für ein stabiles Fundament.

  imports = [
    ../modules/core/system.nix
    ../modules/core/impermanence.nix
    ../modules/core/nix-tuning.nix
    ../modules/core/network.nix
    ../modules/core/ssh.nix
    ../modules/core/firewall.nix
    ../modules/core/fail2ban.nix
    ../modules/core/zram-swap.nix
    ../modules/logging/vector-tier-b.nix
    ../modules/core/shell-premium.nix
    ../modules/core/system-stability.nix
    ../modules/core/principles.nix
    
    # Standard Services
    ../modules/services/caddy.nix
    ../modules/services/postgresql.nix
    ../modules/services/tailscale.nix
    ../modules/monitoring/gatus.nix
  ];

  # Persistent Vector Logging
  my.logging.vector.enable = true;
  my.monitoring.gatus.enable = true;

  # Standard-Metadaten für das Profil
  my.meta.profile_base_server = {
    id = "NIXH-PROF-BASE-001";
    title = "Base Server Profile";
    layer = 0; # Core-Mission
    audit.last_reviewed = "2026-04-27";
  };
}
