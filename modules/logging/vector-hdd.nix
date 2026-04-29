{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.vector;
  srePaths = config.my.configs.paths;
  logDir = "${srePaths.tierC}/logs/system";
  maxTotalSizeMB = 1024;  # 1 GB
in
{
  options.my.logging.vector = {
    enable = lib.mkEnableOption "Vector logging to HDD (Tier C)";
    retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
    maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 200; };
    ntfyTopic = lib.mkOption { 
      type = lib.types.nullOr lib.types.str; 
      default = "nixhome-alerts"; 
      description = "Ntfy topic for emergency alerts (ERROR level).";
    };
  };

  config = lib.mkIf cfg.enable {
    # 1. Journald remains volatile (RAM only)
    services.journald.extraConfig = ''Storage=volatile'';

    # 2. Vector Service
    services.vector = {
      enable = true;
      config = {
        sources.journald = {
          type = "journald";
          current_boot_only = false;
        };

        # 🛡️ Transformation: Masking & Filtering
        transforms.mask_sensitive = {
          type = "remap";
          inputs = [ "journald" ];
          source = ''
            # Redact paths and keys
            .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
            .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
          '';
        };

        # 🚨 Emergency Filter (Only ERRORS)
        transforms.error_filter = {
          type = "filter";
          inputs = [ "mask_sensitive" ];
          condition = ''includes(["err", "crit", "alert", "emerg"], .priority) || .level == "error" || .level == "critical" '';
        };

        # 📂 Sink 1: HDD (Archive)
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "ndjson";
          compression = "gzip";
          batch.max_bytes = 50 * 1024 * 1024; # 50MB for HDD efficiency
          batch.timeout_secs = 300; # 5 minutes
          healthcheck = true;
        };

        # 📱 Sink 2: NTFY (Emergency)
        sinks.ntfy = lib.mkIf (cfg.ntfyTopic != null) {
          type = "http";
          inputs = [ "error_filter" ];
          uri = "https://ntfy.sh/${cfg.ntfyTopic}";
          method = "post";
          encoding.codec = "text";
          # Simplified message for mobile notification
          batch.max_events = 1;
        };
      };
    };

    # 3. Rotation logic (unchanged from vector-tier-b but using new path)
    systemd.services.rotate-vector-logs = {
      description = "Rotate and delete old Vector logs (size/age based)";
      serviceConfig = {
        Type = "oneshot";
        Nice = 19;
        IOSchedulingClass = "idle";
        ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
          set -euo pipefail
          # 1. Age-based deletion
          find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete
          
          # 2. Size-based deletion (Target: ${toString maxTotalSizeMB}MB)
          CURRENT_SIZE=$(du -sm ${logDir} | cut -f1)
          if [ "$CURRENT_SIZE" -gt ${toString maxTotalSizeMB} ]; then
            echo "Log directory size ($CURRENT_SIZE MB) exceeds limit (${toString maxTotalSizeMB} MB). Cleaning up..."
            # Delete oldest files first until under limit
            ls -tr ${logDir}/*.gz | while read -r file; do
              rm "$file"
              CURRENT_SIZE=$(du -sm ${logDir} | cut -f1)
              [ "$CURRENT_SIZE" -le ${toString maxTotalSizeMB} ] && break
            done
          fi
        '';
      };
    };

    systemd.timers.rotate-vector-logs = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };

    systemd.tmpfiles.rules = [ "d ${logDir} 0750 root root - -" ];
  };
}
