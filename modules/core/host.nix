{
  config,
  lib,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-016";
    title = "Host Identity";
    description = "Basic hostname and identity configuration for the server.";
    layer = 0;
    nixpkgs.category = "system/settings";
    capabilities = ["system/identity"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 1;
  };
in {
  options.my.meta.host = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for host module";
  };

  config = {
    networking.hostName = lib.mkForce config.my.configs.identity.host;
  };
}
