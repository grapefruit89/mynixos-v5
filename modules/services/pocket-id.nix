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
      dataDir = "/var/lib/pocket-id";
      settings = {
        PUBLIC_REGISTRATION = false;
        ISSUER = "https://auth.${subdomain}.${domain}";
        # Socket-First Ingress (Supported by Pocket-ID Go backend)
        UNIX_SOCKET = "/run/pocket-id/pocket-id.sock";
        UNIX_SOCKET_MODE = "0660";
        BACKEND_PORT = 1411; # Fallback port
      };
    };

    # 🛡️ Hardening via the Factory or manual overrides
    systemd.services.pocket-id.serviceConfig = {
      RuntimeDirectory = "pocket-id";
      RuntimeDirectoryMode = "0770";
      # Additional Hardening
      MemoryDenyWriteExecute = true;
      RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
    };

    # Give Caddy access to the pocket-id group to read the socket
    users.users.caddy.extraGroups = [ "pocket-id" ];

    # 🧱 Persistent data
    environment.persistence."/persist".directories = [ "/var/lib/pocket-id" ];
  };
}
