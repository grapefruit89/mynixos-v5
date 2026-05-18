{ config, lib, pkgs, ... }:
let
  localRepo = "/mnt/archive/.restic-vault";
  maxSizeGB = 20;
in
{
  options.my.services.backup = {
    enable = lib.mkEnableOption "Hardened Restic Backups";
  };

  config = lib.mkIf config.my.services.backup.enable {
    # 🔐 SOPS: Rclone Config Protection
    sops.secrets.rclone_config = {
      owner = "root";
      # Die Rclone-Config enthält Cloud-Credentials und wird hardware-gebunden geschützt.
    };

    # 🔐 RESTIC BACKUP (anchor: restic-backup)
    services.restic.backups.daily = {
      initialize = true;
      repository = localRepo;
      passwordFile = config.sops.secrets.restic_password.path;

      paths = [
        config.my.configs.paths.appData
        config.my.configs.paths.tierA
        "/etc/nixos"
        "/var/lib/pocket-id"
        "/persist"
      ];

      exclude = [ "**/.cache" "**/tmp" "**/node_modules" "*.log" ];
      createWrapper = true;
      runCheck = true;
      checkOpts = ["--with-cache"];
      extraOptions = [ "--exclude-caches" "--compression=max" ];
      inhibitsSleep = true;

      # 🛡️ PRE-FLIGHT CHECK (Hardened)
      backupPrepareCommand = ''
        DATA_SIZE=$(${pkgs.coreutils}/bin/du -sb ${config.my.configs.paths.appData} /etc/nixos /persist /var/lib/pocket-id | ${pkgs.gawk}/bin/awk '{sum+=$1} END {print sum}')
        LIMIT=$(( ${toString maxSizeGB} * 1024 * 1024 * 1024 ))
        if [ "$DATA_SIZE" -gt "$LIMIT" ]; then
          echo "🚨 BACKUP ABGEBROCHEN: Datenmenge ($DATA_SIZE) > Limit ($LIMIT)!"
          exit 1
        fi
      '';

      # ☁️ CLOUD SYNC (v7.1 Hardened: SOPS + TPM 2.0)
      backupCleanupCommand = ''
        echo "📤 Starte Cloud-Sync via SOPS-protected rclone..."
        ${pkgs.rclone}/bin/rclone --config ${config.sops.secrets.rclone_config.path} sync ${localRepo} cloud-backup:nixhome-vault --bwlimit 5M
        echo "✅ Cloud-Sync abgeschlossen."
      '';

      timerConfig = {
        OnCalendar = "02:00";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };

      pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];
    };

    services.restic.backups.remote = {
      initialize = true;
      repository = "s3:s3.eu-central-003.backblazeb2.com/nixhome-backup";
      passwordFile = config.sops.secrets.restic_password.path;
      environmentFile = config.sops.templates."backblaze-restic.env".path;

      paths = [ "/var/lib" "/etc" "/persist" ];
      exclude = [ "**/.cache" "**/tmp" ];
      pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];
      timerConfig = { OnCalendar = "03:00"; Persistent = true; };
      extraOptions = [ "--compression=max" ];
    };

    environment.systemPackages = with pkgs; [ restic rclone ];
  };
}
