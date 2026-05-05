# ---
# nms_id: APP-TOOLS-LINKDING
# title: Linkding Bookmarks
# capabilities: ["tools/bookmarks"]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ lib, config, myLib, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-50-KNW-001";
    title = "Linkding";
    description = "Hardened bookmark manager with SQLite and SSO integration.";
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
    description = "NMS metadata for linkding module";
  };

  options.my.services.linkding.enable = lib.mkEnableOption "Linkding Bookmark Manager";

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # 🏆 Aviation-Grade Service Factory
    (myLib.mkService {
      inherit config port;
      name = "linkding";
      description = "Linkding Bookmark Service";
      useSSO = true;
      persist = true;
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
