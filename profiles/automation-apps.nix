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
  # 🚀 HARDENED MISSION PROFILE: AUTOMATION APPS
  # Bündelt n8n, Home Assistant und Management-Tools.

  imports = [
    ../modules/apps/service-app-n8n.nix
    ../modules/apps/service-app-home-assistant.nix
    # Auskommentiert – Semaphore ist noch nicht implementiert (siehe NIXH-30-AUT-006)
    # ../modules/apps/service-app-semaphore.nix
    ../modules/services/service-app-zigbee-stack.nix
  ];

 # Standard-Metadaten für das Profil
 my.meta.profile_automation = {
 id = "NIXH-PROF-AUTO-001";
 title = "Automation Apps Profile";
 layer = 30;
 audit.last_reviewed = "2026-04-27";
 };
}
