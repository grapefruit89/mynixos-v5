{ config, lib, pkgs, ... }: {
  # 🚀 AVIATION-GRADE MISSION PROFILE: EXTRA APPS
  # Bündelt Vaultwarden, Matrix, Monica und weitere spezialisierte Dienste.

  imports = [
    ../modules/apps/service-app-vaultwarden.nix
    ../modules/apps/service-app-matrix-conduit.nix
    ../modules/apps/service-app-monica.nix
    ../modules/apps/service-app-karakeep.nix
    ../modules/apps/service-app-filebrowser.nix
    ../modules/apps/service-app-couchdb.nix
    ../modules/apps/service-app-linkding.nix
  ];

  # 🟢 Aktivierte Dienste
  my.services.linkding.enable = true;

  # Standard-Metadaten für das Profil
  my.meta.profile_extra = {
    id = "NIXH-PROF-EXTR-001";
    title = "Extra Apps Profile";
    layer = 60;
    audit.last_reviewed = "2026-04-27";
  };
}
