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
    ../modules/apps/service-media-jellyfin.nix
    # Deaktiviert, da service-media-seerr nicht implementiert (siehe LAYER_CONSOLIDATED)
    # ../modules/apps/service-media-seerr.nix
    ../modules/apps/service-media-sonarr.nix
    ../modules/apps/service-media-sonarr-setup.nix # 🔥 API-Setup PoC
    ../modules/apps/service-media-radarr.nix
    ../modules/apps/service-media-radarr-setup.nix # 🔥 API-Setup PoC
    ../modules/apps/service-media-prowlarr.nix
    ../modules/apps/service-media-prowlarr-setup.nix # 🔥 Indexer-Sync
    ../modules/apps/service-media-readarr.nix
    ../modules/apps/service-media-lidarr.nix
    ../modules/apps/service-media-sabnzbd.nix
    # Deaktiviert, da service-media-recyclarr nicht implementiert
    # ../modules/apps/service-media-recyclarr.nix
    # Deaktiviert, da service-app-audiobookshelf nicht implementiert
    # ../modules/apps/service-app-audiobookshelf.nix
    ../modules/apps/service-app-navidrome.nix
    ../modules/apps/media-stack.nix
    # Deaktiviert, da storage.nix durch storage-policy.nix ersetzt wurde
    # ../modules/core/storage.nix
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
