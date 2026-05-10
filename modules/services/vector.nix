{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Observability)
  nms = {
    id = "NIXH-10-OBS-001";
    title = "Vector (Log Aggregator)";
    description = "Centralized log pipeline for system and application logs.";
    layer = 10;
    nixpkgs.category = "services/monitoring";
    capabilities = ["logging/aggregator" "observability/pipeline"];
    audit.last_reviewed = "2026-05-10";
    audit.complexity = 2;
  };

  cfg = config.my.services.vector;
  u = config.my.users.registry;
in {
  options.my.services.vector.enable = lib.mkEnableOption "Vector Log Aggregator";

  config = lib.mkIf cfg.enable {
    my.meta.vector = nms;

    services.vector = {
      enable = true;
      journaldAccess = true;
      
      settings = {
        sources = {
          journal = {
            type = "journald";
          };
        };
        
        sinks = {
          file_output = {
            type = "file";
            path = "/var/log/vector/all-logs-%Y-%m-%d.json";
            inputs = [ "journal" ];
            encoding = { codec = "json"; };
            # Rotation, um die Platte nicht vollaufen zu lassen
            max_size = 104857600; # 100MB
          };
        };
      };
    };

    # 👤 IDENTITY BINDING (ADR 005)
    users.users.vector = {
      isSystemUser = true;
      group = "vector";
      uid = u.vector;
    };
    users.groups.vector = {};

    # Systemd Hardening (Aviation-Grade)
    systemd.services.vector.serviceConfig = {
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      MemoryDenyWriteExecute = true;
    };

    # Create target directory for Vector logs
    systemd.tmpfiles.rules = [ "d /var/log/vector 0750 vector vector -" ];
  };
}
