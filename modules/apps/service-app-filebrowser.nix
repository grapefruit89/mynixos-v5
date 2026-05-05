{ config, lib, ... }:
let
  # 🚀 NMS v4.0 Metadaten
  nms = {
    id = "NIXH-60-APP-003";
    title = "Filebrowser (SRE Hardened)";
    description = "Web-based file manager with strict path restrictions and sandboxing.";
    layer = 60;
    nixpkgs.category = "services/web-apps";
    capabilities = [ "web/file-management" "security/sandboxing" ];
    audit.last_reviewed = "2026-03-02";
    audit.complexity = 2;
  };

  port = config.my.ports.filebrowser;
  domain = config.my.configs.identity.domain;
in
{
  options.my.meta.filebrowser = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for filebrowser module";
  };


  config = lib.mkIf config.my.services.filebrowser.enable {
    services.filebrowser = { 
      enable = true; 
      settings = { 
        root = "/mnt/storage"; 
      }; 
    };

    # 🚀 SOCKET-FIRST INGRESS
    systemd.services.filebrowser = {
      serviceConfig = { 
        # Override address/port with socket
        ExecStart = lib.mkForce "${pkgs.filebrowser}/bin/filebrowser --socket /run/filebrowser/filebrowser.sock --database /var/lib/filebrowser/filebrowser.db --root /mnt/storage";
        ProtectSystem = "strict"; 
        ProtectHome = true; 
        PrivateTmp = true; 
        PrivateDevices = true; 
        ReadWritePaths = [ "/var/lib/filebrowser" "/mnt/storage" ]; 
        NoNewPrivileges = true; 
        SystemCallFilter = [ "@system-service" "~@privileged" ]; 
        RuntimeDirectory = "filebrowser";
        RuntimeDirectoryMode = "0770";
      };
    };

    # Give Caddy access to the filebrowser group (which is 'filebrowser' by default)
    users.users.caddy.extraGroups = [ "filebrowser" ];

    # Note: Caddy config is now auto-generated from services-spec.nix
  };
}
