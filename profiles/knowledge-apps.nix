{ config, lib, pkgs, ... }: {
  # 🚀 AVIATION-GRADE MISSION PROFILE: KNOWLEDGE APPS
  # Bündelt Paperless, Linkwarden, Miniflux und Archiv-Systeme.

  imports = [
    ../modules/apps/service-app-paperless.nix
    ../modules/apps/service-app-linkwarden.nix
    ../modules/apps/service-app-miniflux.nix
    ../modules/apps/service-app-readeck.nix
    ../modules/apps/service-app-linkding.nix
  ];

  # Standard-Metadaten für das Profil
  my.meta.profile_knowledge = {
    id = "NIXH-PROF-KNOW-001";
    title = "Knowledge Apps Profile";
    layer = 50;
    audit.last_reviewed = "2026-04-27";
  };
}
