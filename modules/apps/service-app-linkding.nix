# ---
# nms_id: APP-TOOLS-LINKDING
# title: Linkding Bookmarks
# capabilities: ["tools/bookmarks"]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ lib, config, myLib, ... }:
let
 nms = {
 id = "NIXH-50-KNW-001";
 title = "Linkding";
 description = "hardened hardened bookmark manager with SQLite and SSO.";
 layer = 50;
 nixpkgs.category = "web/apps";
 capabilities = [ "web/bookmarks" "security/sso" "storage/tier-a" ];
 audit.last_reviewed = "2026-04-30";
 audit.complexity = 2;
 };

 cfg = config.my.services.linkding;
 port = config.my.ports.linkding;
in
{
 options.my.meta.linkding = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my.services.linkding.enable = lib.mkEnableOption "Linkding Bookmark Manager";

 config = lib.mkIf cfg.enable (lib.mkMerge [
 # 🏆 hardened Service Factory
 (myLib.mkService {
 inherit config port;
 name = "linkding";
 description = "Linkding Bookmark Service";
 useSSO = true;
 })

 # 🔧 Linkding Specifics
 {
 services.linkding = {
 enable = true;
 host = "127.0.0.1";
 port = port;
 };

 # Resource Hardening (Systemd-Level)
 systemd.services.linkding.serviceConfig = {
 MemoryMax = "512M";
 CPUWeight = 30;
 };
 }
 ]);
}
