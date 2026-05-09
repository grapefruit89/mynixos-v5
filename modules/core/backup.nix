{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Backup)
 nms = {
 id = "NIXH-00-COR-004";
 title = "Backup (Restic edition)";
 description = "Hardened Restic backup logic with atomical Cloud-Sync and failure-safe ExecConditions.";
 layer = 00;
 nixpkgs.category = "services/backup";
 capabilities = ["backup/restic" "cloud/sync" "security/integrity-check"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 localRepo = "/mnt/archive/.restic-vault";
 maxSizeGB = 20; # Erhöht für Media-Metadaten
in {
 options.my.meta.backup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf config.my.services.backup.enable {
 services.restic.backups.daily = {
 initialize = true;
 repository = localRepo;
 passwordFile = config.sops.secrets.restic_password.path; # Sops Integration

 paths = [
 config.my.configs.paths.appData
 config.my.configs.paths.tierA
 "/etc/nixos"
 "/var/lib/pocket-id"
 "/persist" # Impermanence Support
 ];

 exclude = [ "**/.cache" "**/tmp" "**/node_modules" "*.log" ];

 createWrapper = true;
 runCheck = true;
 checkOpts = ["--with-cache"];

 extraOptions = [ "--exclude-caches" "--compression=max" ];
 inhibitsSleep = true;

 # 🛡️ PRE-FLIGHT CHECK (SRE-Standard)
 backupPrepareCommand = ''
 # Validierung aller Pfade inkl. /persist und /var/lib/pocket-id
 DATA_SIZE=$(${pkgs.coreutils}/bin/du -sb ${config.my.configs.paths.appData} /etc/nixos /persist /var/lib/pocket-id | ${pkgs.gawk}/bin/awk '{sum+=$1} END {print sum}')
 LIMIT=$(( ${toString maxSizeGB} * 1024 * 1024 * 1024 ))
 if [ "$DATA_SIZE" -gt "$LIMIT" ]; then
 echo "🚨 BACKUP ABGEBROCHEN: Datenmenge ($DATA_SIZE) > Limit ($LIMIT)!"
 exit 1
 fi
 '';
 # ☁️ CLOUD SYNC (Fragment 748 Fix: Atomarer Post-Stop)
 backupCleanupCommand = ''
 echo "📤 Starte Cloud-Sync..."
 ${pkgs.rclone}/bin/rclone sync ${localRepo} cloud-backup:nixhome-vault --bwlimit 5M
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

 paths = [
 "/var/lib"
 "/etc"
 "/persist"
 ];
 exclude = [ "**/.cache" "**/tmp" ];

 pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];
 
 timerConfig = {
 OnCalendar = "03:00";
 Persistent = true;
 };
 
 extraOptions = [ "--compression=max" ];
 };

 environment.systemPackages = with pkgs; [restic rclone];
 };
}
