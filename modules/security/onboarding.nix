{ lib, config, ... }:
{
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
