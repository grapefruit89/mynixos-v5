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

{ config, lib, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-90-SEC-002";
    title = "Binary-Only Policy";
    description = "Enforces a strict download-only workflow by forbidding local compilation to protect system resources.";
    layer = 90;
    nixpkgs.category = "system/policy";
    capabilities = [ "security/binary-only" "system/stability" ];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 1;
  };
in
{
 options.my.meta.binary_only = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

  options.my.policy.allowLocalBuilds = lib.mkEnableOption "local builds (not recommended for production)";

  config = {
    nix.settings.max-jobs = lib.mkForce (if config.my.policy.allowLocalBuilds then 1 else 0);
    
    warnings = [
      (lib.optionalString config.my.policy.allowLocalBuilds "⚠️ [POLICY-WARNING] Local builds are enabled! This should only be used for debugging or non-standard packages.")
      (lib.optionalString (!(config.my.policy.allowLocalBuilds || config.nix.settings.max-jobs == 0)) "🚫 [POLICY-VIOLATION] Local builds are forbidden by default. Enable my.policy.allowLocalBuilds if absolutely necessary.")
    ];
  };
}
