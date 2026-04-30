{ config, lib, pkgs, ... }: {
 # 🚀 hardened MISSION PROFILE: AUTOMATION APPS
 # Bündelt n8n, Home Assistant, OliveTin und Management-Tools.

 imports = [
 ../modules/apps/service-app-n8n.nix
 ../modules/apps/service-app-home-assistant.nix
 ../modules/apps/service-app-olivetin.nix
 ../modules/apps/service-app-semaphore.nix
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
