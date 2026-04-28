{ config, lib, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Security Policy Guard - Warning Edition)
  nms = {
    id = "NIXH-90-POL-001";
    title = "Aviation Security Policy Guard";
    description = "Monitors system integrity. Currently configured for non-blocking warnings.";
    layer = 90;
    audit.last_reviewed = "2026-04-28";
    audit.complexity = 2;
  };

  # Helper: Transform list of checks into either assertions or warnings
  # Current instruction: Primary use is 'warnings' (Soft Mode)
  mkChecks = checks: map (c: {
    assertion = c.cond;
    message = c.msg;
  }) checks;

  # Master List of Security Rules
  securityChecks = [
    {
      cond = config.networking.firewall.enable;
      msg = "⚠️ [SEC-NET-001]: Firewall is disabled! Not recommended for production use.";
    }
    {
      cond = config.networking.nftables.enable;
      msg = "⚠️ [SEC-NET-002]: NFTables is disabled! Using legacy iptables is not Aviation-Grade.";
    }
    {
      cond = config.services.openssh.settings.PermitRootLogin == "no";
      msg = "⚠️ [SEC-SSH-002]: SSH Root Login is NOT disabled! Huge security risk.";
    }
    {
      cond = config.my.security.hardened.enable;
      msg = "⚠️ [SEC-COR-001]: Titanium Hardened Core module is missing or disabled!";
    }
    {
      cond = config.my.configs.bastelmodus || (config.my.security.hardened.lockdownMode == "strict");
      msg = "⚠️ [SEC-COR-002]: Kernel Lockdown is NOT set to 'strict' (and bastelmodus is off)!";
    }
    {
      cond = lib.hasPrefix "/persist" config.my.configs.paths.tierA;
      msg = "⚠️ [SEC-STO-001]: Tier A storage is NOT under /persist! Impermanence integrity at risk.";
    }
  ];

in
{
  options.my.security.policy = {
    mode = lib.mkOption {
      type = lib.types.enum [ "warn" "strict" ];
      default = "strict";
      description = "Policy enforcement mode: 'warn' (non-blocking) or 'strict' (fail build).";
    };
  };

  config = {
    # 📊 Metadata for Traceability
    my.meta.security_assertions = nms;

    # 🛡️ Dynamic Enforcement
    warnings = lib.mkIf (config.my.security.policy.mode == "warn") (mkChecks securityChecks);
    assertions = lib.mkIf (config.my.security.policy.mode == "strict") (mkChecks securityChecks);
  };
}
