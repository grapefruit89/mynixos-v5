{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.vector;
  srePaths = config.my.configs.paths;
  # 💾 LOGGING TIER B (SSD) - Optimized for RAM-to-SSD chunking
  logDir = "${srePaths.tierB}/logs/system";
  maxTotalSizeMB = 2048; # 2 GB for Tier B
in
{
  options.my.logging.vector = {
    enable = lib.mkEnableOption "Vector logging (RAM-Buffered to SSD)";
    retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
    maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 256; };
    ntfyTopic = lib.mkOption { 
      type = lib.types.nullOr lib.types.str; 
      default = "nixhome-alerts"; 
      description = "Ntfy topic for emergency alerts (ERROR level).";
    };
  };

  config = lib.mkIf cfg.enable {
    # 1. Journald remains volatile (RAM only) to prevent double-writes to disk
    services.journald.extraConfig = ''Storage=volatile'';

    # 2. Vector Service
    services.vector = {
      enable = true;
      config = {
        sources.journald = {
          type = "journald";
          current_boot_only = false;
        };

        # 📂 Additional source for traditional logs
        sources.var_log = {
          type = "file";
          include = [ "/var/log/*.log" ];
        };

        # 🛡️ Transformation: Masking & Filtering
        transforms.mask_sensitive = {
          type = "remap";
          inputs = [ "journald" "var_log" ];
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

        # 📂 Sink 1: SSD (Tier B) with RAM-to-Chunking
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "ndjson";
          compression = "gzip";
          
          # 🚀 CHUNKING LOGIC: Buffer in RAM, write in large sequential blocks
          batch.max_bytes = 128 * 1024 * 1024; # 128MB per flush
          batch.timeout_secs = 3600;           # Max 1 hour delay (safety against crash)
          
          buffer.type = "memory";              # Explicit RAM buffer
          buffer.max_size = 256 * 1024 * 1024; # 256MB capacity
          
          healthcheck = true;
        };

        # 📱 Sink 2: NTFY (Emergency Alerts)
        sinks.ntfy = lib.mkIf (cfg.ntfyTopic != null) {
          type = "http";
          inputs = [ "error_filter" ];
          uri = "https://ntfy.sh/${cfg.ntfyTopic}";
          method = "post";
          encoding.codec = "text";
          # Immediate dispatch for critical errors
          batch.max_events = 1;
        };
      };
    };

    # 3. Rotation logic (Optimized for Tier B)
    systemd.services.rotate-vector-logs = {
      description = "Rotate and delete old Vector logs (SSD/Age based)";
      serviceConfig = {
        Type = "oneshot";
        Nice = 19;
        IOSchedulingClass = "idle";
        ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
          set -euo pipefail
          # 1. Age-based deletion
          find ${logDir} -name "*.log.gz" -type f -mtime +${toString cfg.retentionDays} -delete

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
