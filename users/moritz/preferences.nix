{
  config,
  lib,
  pkgs,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-038";
    title = "User Preferences";
    description = "Customized user preferences and personal system adjustments.";
    layer = 0;
    nixpkgs.category = "system/settings";
    capabilities = ["user/preferences"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 1;
  };
in {
  options.my.meta.user_preferences = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for user-preferences module";
  };

  config = {
    # Platz für persönliche Anpassungen.
  };
}
