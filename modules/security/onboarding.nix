# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-SEC-ONB-001",
#   "title": "System Onboarding Status",
#   "layer": 0,
#   "category": "security",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 1,
#   "tags": ["security", "onboarding", "governance"],
#   "description": "Simple onboarding flag and warning system to ensure production readiness."
# }
# ---ENDNIXMETA

{ lib, config, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-90-SEC-ONB-001";
    title = "System Onboarding Status";
    description = "Onboarding flag and warning system to ensure production readiness and governance compliance.";
    layer = 0;
    nixpkgs.category = "security/governance";
    capabilities = ["security/onboarding" "system/governance"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 1;
  };
in
{
  options.my.meta.onboarding = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

  # 🚀 ONBOARDING STATUS (anchor: onboarding-complete)
  options.my.system.onboardingComplete = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Set to true after initial setup is verified. Disabling this results in a build warning unless bastelmodus is active.";
  };

  config = {
    # 🚩 ONBOARDING STATUS WARNING
    # As per directive: Use a warning instead of a hard assertion or firewall block.
    warnings = lib.optional (!config.my.system.onboardingComplete && !(config.my.configs.bastelmodus or false))
      "⚠️ SYSTEM ONBOARDING INCOMPLETE: Set 'my.system.onboardingComplete = true' in your configuration to signal that the initial setup is verified and production-ready.";
  };
}
