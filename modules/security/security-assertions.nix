{ config, lib, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Security Policy Guard - Warning Edition)
  nms = {
    id = "NIXH-90-POL-001";
    title = "Security Policy Guard";
    description = "Monitors system integrity. Configured for non-blocking warnings by default.";
    layer = 90;
    audit.last_reviewed = "2026-05-05";
    audit.complexity = 2;
  };

  # Master List of Security Rules (v7.1 Strict Enforcement)
  # cond = true means the check passes.
  securityChecks = [
    {
      cond = config.networking.firewall.enable;
      msg = "❌ [SEC-NET-001]: Firewall is disabled! Production build blocked.";
    }
    {
      cond = config.networking.nftables.enable;
      msg = "❌ [SEC-NET-002]: NFTables is disabled! Using legacy iptables is forbidden.";
    }
    {
      cond = config.services.openssh.settings.PermitRootLogin == "no";
      msg = "❌ [SEC-SSH-002]: SSH Root Login is NOT disabled! Critical security risk.";
    }
    {
      cond = config.my.security.hardened.enable;
      msg = "❌ [SEC-COR-001]: Hardened Core module is missing or disabled!";
    }
    {
      cond = config.my.security.hardened.lockdownMode == "strict";
      msg = "❌ [SEC-COR-002]: Kernel Lockdown is NOT set to 'strict'! (Bastelmodus escape-hatch removed)";
    }
    {
      cond = lib.hasPrefix "/persist" config.my.configs.paths.tierA;
      msg = "❌ [SEC-STO-001]: Tier A storage is NOT under /persist! Impermanence integrity at risk.";
    }
    {
      cond = builtins.elem "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvttE1EzwLJpzFc/LuuXZP485Ma0mEJQiu3iMXaO58W" (config.my.configs.identity.sshKeys or []);
      msg = "❌ [SEC-SSH-001]: Primary SSH Key is missing in identity.nix! Rebuild blocked to prevent lockout.";
    }
  ];

in
{
  options.my.security.policy = {
    mode = lib.mkOption {
      type = lib.types.enum [ "warn" "strict" ];
      default = "strict";
      description = "Policy enforcement mode: 'warn' (deprecated) or 'strict' (fail build).";
    };
  };

  config = {
    # 📊 Metadata for Traceability
    my.meta.security_assertions = nms;

    # 🛡️ Hard Policy Enforcement (v7.1 Strict)
    # Zero-tolerance for security misconfigurations in production.
    assertions = (map (c: {
      assertion = c.cond;
      message = c.msg;
    }) securityChecks) ++ [
      {
        assertion = !config.my.configs.bastelmodus;
        message = "⚠️ [SEC-POL-001]: BASTELMODUS is active! This is allowed for debugging but must be disabled for production deployment.";
      }
    ];

    # Legacy warnings support (only for non-critical informational logs)
    warnings = lib.mkIf (config.my.security.policy.mode == "warn") [
      "DEPRECATION: Security policy 'warn' mode is deprecated. All checks are now hard assertions."
    ];
  };
}
