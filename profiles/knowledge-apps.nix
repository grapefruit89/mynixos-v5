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
 # 🚀 hardened MISSION PROFILE: KNOWLEDGE APPS
 # Bündelt Paperless, Linkwarden, Miniflux und Archiv-Systeme.

 imports = [
 ../modules/apps/service-app-paperless.nix
 ../modules/apps/service-app-linkwarden.nix
 ../modules/apps/service-app-miniflux.nix
 ../modules/apps/service-app-readeck.nix
 ../modules/apps/service-app-linkding.nix
 ];

 # 🟢 Aktivierte Dienste
 my.services.linkding.enable = true;

 # Standard-Metadaten für das Profil
 my.meta.profile_knowledge = {
 id = "NIXH-PROF-KNOW-001";
 title = "Knowledge Apps Profile";
 layer = 50;
 audit.last_reviewed = "2026-04-27";
 };
}
