{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.vector;
  srePaths = config.my.configs.paths;
  logDir = "${srePaths.tierB}/logs/vector";
  maxTotalSizeMB = 1024;  # 1 GB
in
{
  options.my.logging.vector = {
    enable = lib.mkEnableOption "Vector logging to Tier B";
    retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
    maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 200; };
  };

  config = lib.mkIf cfg.enable {
    # 1. Journald bleibt volatile
    services.journald.extraConfig = ''Storage=volatile'';

    # 2. Vector Service
    services.vector = {
      enable = true;
      config = {
        sources.journald = {
          type = "journald";
          current_boot_only = false;
        };
        transforms.mask_sensitive = {
          type = "remap";
          inputs = [ "journald" ];
          source = ''
            # Maskiere Medienpfade, API-Keys
            .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
            .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
          '';
        };
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "ndjson";
          compression = "gzip";
          batch.max_bytes = cfg.maxFileSizeMB * 1024 * 1024;
          healthcheck = true;
        };
      };
    };

    # 3. Rotation & Löschung (Größen- & Altersbasiert)
    systemd.services.rotate-vector-logs = {
      description = "Rotate and delete old Vector logs (size/age based)";
      serviceConfig = {
        Type = "oneshot";
        Nice = 19;
        IOSchedulingClass = "idle";
        ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
          set -euo pipefail
          # 1. Lösche Dateien älter als retentionDays
          find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete

          # 2. Falls Gesamtgröße > ${toString maxTotalSizeMB} MB, lösche die ältesten Dateien
          total=0
          while IFS= read -r file; do
            size=$(stat -c %s "$file")
            total=$((total + size))
          done < <(find ${logDir} -name "*.gz" -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)
          totalMB=$((total / 1024 / 1024))
          if [ $totalMB -gt ${toString maxTotalSizeMB} ]; then
            find ${logDir} -name "*.gz" -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2- | while read -r file; do
              [ $totalMB -le ${toString maxTotalSizeMB} ] && break
              rm "$file"
              total=0
              for f in $(find ${logDir} -name "*.gz" -type f); do
                s=$(stat -c %s "$f")
                total=$((total + s))
              done
              totalMB=$((total / 1024 / 1024))
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
