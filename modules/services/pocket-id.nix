{ config, lib, pkgs, myLib, ... }: 
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-10-GTW-009";
    title = "Pocket-ID (OIDC Provider)";
    description = "Self-hosted OIDC identity provider for secure SSO with Caddy integration.";
    layer = 10;
    nixpkgs.category = "services/security";
    capabilities = ["security/oidc" "identity/provider"];
    audit.last_reviewed = "2026-03-03";
    audit.complexity = 2;
  };

  cfg = config.my.services.pocketId;
  sreConfig = config.my.configs;
  domain = sreConfig.identity.domain;
  subdomain = sreConfig.identity.subdomain;
  port = config.my.ports.pocket-id;
in {
  # 🧬 Audit-Compliance: Metadaten als echtes Nix-Attribut
  options.my.meta.pocketId = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  # Custom Option for our project
  options.my.services.pocketId.enable = lib.mkEnableOption "Pocket-ID";

  config = lib.mkIf cfg.enable {
    # 🔌 Import the custom provider module (if not imported elsewhere)
    # Note: Usually modules are imported in configuration.nix, 
    # but we can include it here for self-containment if needed, 
    # though it's better to manage imports centrally.
    
    services.pocket-id = {
      enable = true;
      dataDir = "${config.my.configs.paths.stateDir}/pocket-id";
      settings = {
        issuer = lib.mkForce "https://auth.${subdomain}.${domain}";
        title = "NixHome Identity";
        public_registration = false;
      };
    };

    # 🛡️ Hardening via the Factory or manual overrides
    systemd.services.pocket-id.serviceConfig = {
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = true;
      ProtectClock = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      RestrictNamespaces = true;
      MemoryDenyWriteExecute = true;
      LockPersonality = true;
      SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
      Restart = "always";
      RestartSec = config.my.configs.systemd.restartSec;
      OOMScoreAdjust = -900;
      };

      systemd.services.pocket-id.restartTriggers = [
      config.services.pocket-id.package
      (builtins.toJSON config.services.pocket-id.settings)
      ];
  };
}
