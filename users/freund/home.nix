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
