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
 # 🚀 hardened MISSION PROFILE: EXTRA APPS
 # Bündelt Vaultwarden, Matrix, Monica und weitere spezialisierte Dienste.

 imports = [
 ../modules/apps/service-app-vaultwarden.nix
 ../modules/apps/service-app-matrix-conduit.nix
 ../modules/apps/service-app-monica.nix
 ../modules/apps/service-app-karakeep.nix
 ../modules/apps/service-app-filebrowser.nix
 ../modules/apps/service-app-couchdb.nix
 ];

 # Standard-Metadaten für das Profil
 my.meta.profile_extra = {
 id = "NIXH-PROF-EXTR-001";
 title = "Extra Apps Profile";
 layer = 60;
 audit.last_reviewed = "2026-04-27";
 };
}
