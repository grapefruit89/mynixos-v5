# /var/log is persisted via modules/core/impermanence.nix.
{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.vector;
  srePaths = config.my.configs.paths;
  # 💾 LOGGING TIER B (SSD) - Optimized for RAM-to-SSD chunking
  logDir = "${srePaths.logDir}/system";
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

        # 📈 Host Metrics (Topic 6)
        sources.host_metrics = {
          type = "host_metrics";
          scrape_interval_secs = 15;
        };

        # 📂 Additional source for traditional logs
        sources.var_log = {
          type = "file";
          include = [ "/var/log/*.log" ];
        };

        # 🛡️ Transformation: Masking & Filtering
        transforms.mask_sensitive = {
          type = "remap";
          inputs = [ "journald" "var_log" "host_metrics" ];
          source = ''
            # Redact paths and keys (LHF-05)
            .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
            .message = replace(.message, r'Bearer\s+[A-Za-z0-9\-_\.]{20,}', "Bearer [REDACTED]")
            .message = replace(.message, r'[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}', "[UUID_REDACTED]")
            .message = replace(.message, r'(?i)(api[_-]?key|token|secret|password)\s*[=:]\s*\S+', "[CREDENTIAL_REDACTED]")
          '';
        };

        # 🚨 Emergency Filter (Only ERRORS)
        transforms.error_filter = {
          type = "filter";
          inputs = [ "mask_sensitive" ];
          condition = ''includes(["err", "crit", "alert", "emerg"], .priority) || .level == "error" || .level == "critical" '';
        };

        # 📂 Sink 1: SSD (Tier B) with RAM-to-Chunking
        sinks = {
          file = {
            type = "file";
            inputs = [ "mask_sensitive" ];
            path = "${logDir}/journal-%Y-%m-%d.log";
            encoding.codec = "ndjson";
            compression = "gzip";
            
            # 🚀 CHUNKING LOGIC: Buffer in RAM, write in large sequential blocks
            batch.max_bytes = 128 * 1024 * 1024; # 128MB per flush
            batch.timeout_secs = 300;           # KRIT-02: Reduced timeout (5 min)
            
            buffer = {
              type = "memory";              # Explicit RAM buffer
              max_size = 256 * 1024 * 1024; # 256MB capacity
              when_full = "block";          # KRIT-02: Prevent silent log loss
            };
            
            healthcheck = true;
          };
        } // (lib.optionalAttrs (cfg.ntfyTopic != null) {
          # 📱 Sink 2: NTFY (Emergency Alerts) - LHF-06
          ntfy = {
            type = "http";
            inputs = [ "error_filter" ];
            uri = "${config.my.configs.identity.ntfyUrl}/${cfg.ntfyTopic}";
            method = "post";
            encoding.codec = "text";
            # Immediate dispatch for critical errors
            batch.max_events = 1;
          };
        });
      };
    };

    # 3. Rotation logic (Optimized for Tier B)
    systemd.services.rotate-vector-logs = {
      description = "Rotate and delete old Vector logs (SSD/Age based)";
      serviceConfig = {
        Type = "oneshot";
        Nice = 19;
        IOSchedulingClass = "idle";
        User = "root";
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ReadWritePaths = [ logDir ];
        CapabilityBoundingSet = "";
        PrivateTmp = true;
        ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
          set -euo pipefail
          # 1. Age-based deletion
          ${pkgs.findutils}/bin/find "${logDir}" -name "*.log.gz" -type f -mtime +${toString cfg.retentionDays} -delete

          # 2. Size-based deletion (Target: ${toString maxTotalSizeMB}MB) - LHF-04
          if [ -d "${logDir}" ]; then
            CURRENT_SIZE=$(${pkgs.coreutils}/bin/du -sm "${logDir}" | ${pkgs.coreutils}/bin/cut -f1)
            if [ "$CURRENT_SIZE" -gt ${toString maxTotalSizeMB} ]; then
              echo "Log directory size ($CURRENT_SIZE MB) exceeds limit (${toString maxTotalSizeMB} MB). Cleaning up..."
              # Delete oldest files first until under limit
              ${pkgs.findutils}/bin/find "${logDir}" -name "*.log.gz" -type f -printf "%T+ %p\n" | sort | awk '{print $2}' | while read -r file; do
                rm -f -- "$file"
                CURRENT_SIZE=$(${pkgs.coreutils}/bin/du -sm "${logDir}" | ${pkgs.coreutils}/bin/cut -f1)
                [ "$CURRENT_SIZE" -le ${toString maxTotalSizeMB} ] && break
              done
            fi
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
