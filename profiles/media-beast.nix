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
 # 🚀 hardened MISSION PROFILE: MEDIA BEAST
 # Bündelt Jellyfin, *arr-Suite und Storage-Pool.

  imports = [
    ../modules/40-media/42-arr-stack.nix
    ../modules/40-media/43-download.nix
    ../modules/40-media/44-streaming.nix
    ../modules/40-media/45-discovery.nix
  ];

 # Standard-Metadaten für das Profil
 my.meta.profile_media_beast = {
 id = "NIXH-PROF-MED-001";
 title = "Media Beast Profile";
 layer = 40;
 audit.last_reviewed = "2026-04-27";
 };

 # 🖥️ GPU Acceleration (Intel QuickSync)
 hardware.graphics = {
   enable = true;
   extraPackages = with pkgs; [ intel-media-driver vaapiIntel ];
 };

 # 🎶 Aktivierung Navidrome
 my.media.navidrome.enable = true;
}
