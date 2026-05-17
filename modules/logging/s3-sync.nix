{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.s3Sync;
in
{
  options.my.logging.s3Sync = {
    enable = lib.mkEnableOption "Hourly off-site log persistence to Backblaze B2 via rclone";
    bucket = lib.mkOption {
      type = lib.types.str;
      default = "nixhome-logs";
      description = "S3 bucket name for logs";
    };
    endpoint = lib.mkOption {
      type = lib.types.str;
      default = "s3.us-west-004.backblazeb2.com";
      description = "S3 endpoint for Backblaze B2";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.log-s3-sync = {
      description = "S3 Log Sync to Backblaze B2";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        Type = "oneshot";
        EnvironmentFile = config.sops.templates."backblaze-restic.env".path;
        ExecStart = "${pkgs.rclone}/bin/rclone sync \"${config.my.configs.paths.logDir}/system\" \":s3:${cfg.bucket}/logs\" " +
                    "--s3-provider Other " +
                    "--s3-endpoint \"${cfg.endpoint}\" " +
                    "--s3-env-auth " +
                    "--contimeout 60s " +
                    "--timeout 300s " +
                    "--retries 3 " +
                    "--low-level-retries 10 " +
                    "--stats 1m " +
                    "--log-level ERROR"; # KRIT-01: Remove --verbose
        # Standard Hardening
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        NoNewPrivileges = true;
        CapabilityBoundingSet = "";
        
        # LHF-07: Enable rclone cache
        CacheDirectory = "rclone-s3-sync";
        CacheDirectoryMode = "0700";
      };
    };

    systemd.timers.log-s3-sync = {
      description = "Hourly S3 Log Sync Timer";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "hourly";
        RandomizedDelaySec = "5m";
        Persistent = true;
      };
    };
  };
}
