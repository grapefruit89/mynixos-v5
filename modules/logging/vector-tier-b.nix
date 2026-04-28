# modules/logging/vector-tier-b.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.vector;
  srePaths = config.my.configs.paths;
  logDir = "${srePaths.tierB}/logs/vector";
in
{
  options.my.logging.vector = {
    enable = lib.mkEnableOption "Vector logging to Tier B";
    retentionDays = lib.mkOption { type = lib.types.int; default = 14; };
  };

  config = lib.mkIf cfg.enable {
    # 1. Journald bleibt volatile
    services.journald.extraConfig = ''
      Storage=volatile
      Compress=yes
      RateLimitIntervalSec=30
      RateLimitBurst=1000
    '';

    # 2. Vector Service
    services.vector = {
      enable = true;
      config = {
        sources.journald = {
          type = "journald";
          current_boot_only = false;
          include_units = [
            "*.service"
            "*.socket"
            "systemd-journald"
            "kernel"
          ];
        };
        transforms.mask_sensitive = {
          type = "remap";
          inputs = [ "journald" ];
          source = ''
            # Maskiere Medienpfade, API-Keys, IPs
            .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
            .message = replace(.message, r'\b[\w\s\-\.]+\.(mkv|mp4|avi|m4b|epub|pdf|nzb)\b', "[FILENAME]")
            .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
          '';
        };
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "json";
          compression = "gzip";
          batch.max_bytes = 104857600;
          healthcheck = true;
        };
      };
    };

    # 3. Rotation & Löschung
    systemd.services.rotate-vector-logs = {
      description = "Delete old Vector log files from Tier B";
      serviceConfig = {
        Type = "oneshot";
        Nice = 19;
        IOSchedulingClass = "idle";
        ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
          set -euo pipefail
          find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete
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

    systemd.tmpfiles.rules = [
      "d ${logDir} 0750 root root - -"
    ];
  };
}
