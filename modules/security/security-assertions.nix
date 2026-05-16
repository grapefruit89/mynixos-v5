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

  # Master List of Security Rules
  # cond = true means the check passes.
  securityChecks = [
    {
      cond = config.networking.firewall.enable;
      msg = "⚠️ [SEC-NET-001]: Firewall is disabled! Not recommended for production use.";
    }
    {
      cond = config.networking.nftables.enable;
      msg = "⚠️ [SEC-NET-002]: NFTables is disabled! Using legacy iptables is not hardened.";
    }
    {
      cond = config.services.openssh.settings.PermitRootLogin == "no";
      msg = "⚠️ [SEC-SSH-002]: SSH Root Login is NOT disabled! Huge security risk.";
    }
    {
      cond = config.my.security.hardened.enable;
      msg = "⚠️ [SEC-COR-001]: Hardened Core module is missing or disabled!";
    }
    {
      cond = config.my.configs.bastelmodus || (config.my.security.hardened.lockdownMode == "strict");
      msg = "⚠️ [SEC-COR-002]: Kernel Lockdown is NOT set to 'strict' (and bastelmodus is off)!";
    }
    {
      cond = lib.hasPrefix "/persist" config.my.configs.paths.tierA;
      msg = "⚠️ [SEC-STO-001]: Tier A storage is NOT under /persist! Impermanence integrity at risk.";
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
      description = "Policy enforcement mode: 'warn' (non-blocking) or 'strict' (fail build).";
    };
  };

  config = {
    # 📊 Metadata for Traceability
    my.meta.security_assertions = nms;

    # 🛡️ Hard Policy Enforcement (v6.1 Strict)
    # Any violation here will block the build to ensure technical integrity.
    assertions = lib.mkIf (config.my.security.policy.mode == "strict") (map (c: {
      assertion = c.cond;
      message = c.msg;
    }) securityChecks);

    warnings = lib.mkIf (config.my.security.policy.mode == "warn") (map (c: c.msg) securityChecks);
  };
}
