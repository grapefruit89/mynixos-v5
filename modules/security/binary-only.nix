{ config, lib, ... }:
let
 # 🚀 NMS v4.0 Metadaten
 nms = {
 id = "NIXH-90-POL-001";
 title = "Binary-Only Policy";
 description = "Enforces a strict download-only workflow by forbidding local compilation to protect system resources.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "system/stability" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.binary_only = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for binary-only module";
 };

  options.my.policy.allowLocalBuilds = lib.mkEnableOption "local builds (not recommended for production)";

  config = {
    nix.settings.max-jobs = lib.mkForce (if config.my.policy.allowLocalBuilds then 1 else 0);
    
    warnings = lib.optional config.my.policy.allowLocalBuilds "⚠️ [POLICY-WARNING] Local builds are enabled! This should only be used for debugging or non-standard packages.";

    assertions = [ 
      { 
        assertion = config.my.policy.allowLocalBuilds || config.nix.settings.max-jobs == 0; 
        message = "🚫 [POLICY-VIOLATION] Local builds are forbidden by default. Enable my.policy.allowLocalBuilds if absolutely necessary."; 
      } 
    ];
  };
}
