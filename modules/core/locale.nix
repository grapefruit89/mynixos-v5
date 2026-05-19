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

{ lib, config, ... }:
let
 # 🚀 NMS v4.2 Metadaten
 nms = {
 id = "NIXH-00-COR-020";
 title = "Locale (SRE Refactored)";
 description = "Centralized localization settings using the Master Source of Truth.";
 layer = 0;
 nixpkgs.category = "system/localization";
 capabilities = ["system/localization" "ssot/locale"];
 audit.last_reviewed = "2026-05-09";
 audit.complexity = 1;
 };

 tz = config.my.configs.locale.timezone;
 loc = config.my.configs.locale.default;
in {
 options.my.meta.locale = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for locale module";
 };

 config = {
 time.timeZone = lib.mkForce tz;
 i18n.defaultLocale = lib.mkForce loc;
 i18n.supportedLocales = lib.mkForce ["de_DE.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];

 console.useXkbConfig = true; # Unify layout
 services.xserver.xkb = {
 layout = lib.mkForce "de";
 variant = "";
 };

 networking.timeServers = lib.mkForce [
 "0.de.pool.ntp.org"
 "1.de.pool.ntp.org"
 "2.de.pool.ntp.org"
 "3.de.pool.ntp.org"
 ];
 };
}
