# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-AUTO-GEN",
#   "title": "Auto Generated",
#   "layer": 99,
#   "category": "auto/gen",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 2,
#   "tags": ["auto-generated"],
#   "description": "Auto-migrated module to NIXMETA 2.0."
# }
# ---ENDNIXMETA

{ config, lib, pkgs, ... }: {
 # 🚀 hardened MISSION PROFILE: BASE SERVER
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
    ../modules/logging/vector-ram.nix
    ../modules/core/shell-premium.nix
    ../modules/core/system-stability.nix
    ../modules/core/principles.nix
    ../modules/core/recovery-usb.nix
    
    # Standard Services
    ../modules/services/caddy.nix
    ../modules/services/blocky.nix
    ../modules/services/postgresql.nix
    ../modules/services/pocket-id.nix
    ../modules/services/service-gatus.nix
    ../modules/services/service-ntfy.nix
    ../modules/core/boot-watchdog.nix
  ];

 # Persistent Vector Logging
 my.logging.vector.enable = true;
 my.logging.s3Sync.enable = true;
 my.monitoring.gatus.enable = true;
 my.services.ntfy.enable = true;
 my.services.pocketId.enable = true;
 my.services.caServer.enable = true;

 # Standard-Metadaten für das Profil
 my.meta.profile_base_server = {
 id = "NIXH-PROF-BASE-001";
 title = "Base Server Profile";
 layer = 0; # Core-Mission
 audit.last_reviewed = "2026-04-27";
 };
}
