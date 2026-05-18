{ config, lib, pkgs, ... }: {
 # 🚀 hardened MISSION PROFILE: MEDIA BEAST
 # Bündelt Jellyfin, *arr-Suite und Storage-Pool.

  imports = [
    ../modules/apps/service-media-jellyfin.nix
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
    # ../modules/apps/service-media-recyclarr.nix
    # ../modules/apps/service-app-audiobookshelf.nix
    ../modules/apps/service-app-navidrome.nix
    ../modules/apps/media-stack.nix
    # ../modules/core/storage.nix
  ];

 # Standard-Metadaten für das Profil
 my.meta.profile_media_beast = {
 id = "NIXH-PROF-MED-001";
 title = "Media Beast Profile";
 layer = 30;
 audit.last_reviewed = "2026-04-27";
 };

 # 🎶 Aktivierung Navidrome
 my.media.navidrome.enable = true;
}
