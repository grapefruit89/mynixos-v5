# ---
# nms_id: APP-TOOLS-MINIFLUX
# title: Miniflux RSS
# capabilities: ["tools/rss"]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, ... }:
let
  # 🚀 NMS v4.0 Metadaten
  nms = {
    id = "NIXH-50-KNW-002";
    title = "Miniflux (SRE Exhausted)";
    description = "Minimalist RSS reader with Wake-on-Access (Socket Activation) and Unix Sockets.";
    layer = 50;
    nixpkgs.category = "services/web-apps";
    capabilities = [ "web/rss" "security/socket-activation" ];
    audit.last_reviewed = "2026-03-02";
    audit.complexity = 2;
  };

  port = config.my.ports.miniflux;
in
{
  options.my.meta.miniflux = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for miniflux module";
  };


  config = lib.mkIf config.my.services.miniflux.enable {
    services.miniflux = {
      enable = true; 
      config = { 
        # 🚀 AVIATION HARDENING: Listen on Socket FD
        LISTEN_ADDR = "fd://3"; 
        WATCHDOG = 1; 
        RUN_MIGRATIONS = 1; 
        ADMIN_USERNAME = "admin"; 
        # Use Postgres Unix Socket
        DATABASE_URL = "user=miniflux host=/run/postgresql dbname=miniflux";
      };
      createDatabaseLocally = true; 
      adminCredentialsFile = config.sops.secrets.miniflux_admin_password.path;
    };

    # 🚀 AVIATION HARDENING: Switch to Unix Socket for reverse proxy
    systemd.sockets.miniflux = { 
      description = "Miniflux Unix Socket"; 
      wantedBy = [ "sockets.target" ]; 
      listenStreams = [ "/run/miniflux/miniflux.sock" ]; 
      socketConfig = {
        SocketUser = "caddy";
        SocketGroup = "miniflux";
        SocketMode = "0660";
      };
    };

    systemd.services.miniflux = {
      wantedBy = lib.mkForce [ ]; 
      requires = [ "miniflux.socket" ]; 
      after = [ "miniflux.socket" "postgresql.service" ];
      serviceConfig = { 
        DynamicUser = true; 
        ProtectSystem = "strict"; 
        ProtectHome = true; 
        PrivateTmp = true; 
        PrivateDevices = true; 
        RuntimeDirectory = "miniflux";
        SystemCallFilter = [ "@system-service" "~@privileged" ]; 
        OOMScoreAdjust = 500; 
      };
    };

    # Update Caddy to use the unix socket
    services.caddy.virtualHosts."miniflux.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}".extraConfig = lib.mkForce ''
      import mtls_auth
      import hardened_headers
      reverse_proxy unix//run/miniflux/miniflux.sock
    '';
  };
}
