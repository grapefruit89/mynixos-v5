{ config, lib, pkgs, ... }:
let
  cfg = config.my.storage.mover;
  srePaths = config.my.configs.paths;
  
  moverScript = pkgs.writeShellScript "smart-mover" ''
    set -euo pipefail
    
    SOURCE="${cfg.ssdDir}"
    TARGET="${cfg.hddDir}"
    DRY_RUN=${if cfg.dryRun then "1" else "0"}
    AGE_DAYS=${toString cfg.minAgeDays}
    THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
    
    echo "--- 📦 Starting Smart Mover [DryRun: $DRY_RUN, Age: $AGE_DAYS, Threshold: $THRESHOLD_GB GB] ---"
    
    FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE" | tail -1)
    FREE_GB=$((FREE_SPACE / 1024 / 1024))
    
    FORCE_MOVE=0
    if [ "$FREE_GB" -lt "$THRESHOLD_GB" ]; then
      echo "⚠️ Low space detected ($FREE_GB GB < $THRESHOLD_GB GB). Forcing move of older files."
      FORCE_MOVE=1
    fi

    FIND_AGE=$AGE_DAYS
    [ "$FORCE_MOVE" -eq 1 ] && FIND_AGE=7

    echo "🔍 Scanning for files older than $FIND_AGE days..."
    
    find "$SOURCE" -type f -mtime +"$FIND_AGE" | while read -r file; do
      if ${pkgs.lsof}/bin/lsof "$file" > /dev/null 2>&1; then
        echo "⏭️ Skipping active file: $file"
        continue
      fi

      REL_PATH=''${file#"$SOURCE/"}
      DEST_DIR=$(dirname "$TARGET/$REL_PATH")

      if [ "$DRY_RUN" -eq 1 ]; then
        echo "[DRY-RUN] Would move: $REL_PATH"
      else
        echo "🚚 Moving: $REL_PATH"
        mkdir -p "$DEST_DIR"
        ${pkgs.rsync}/bin/rsync -a --remove-source-files "$file" "$TARGET/$REL_PATH"
      fi
    done

    if [ "$DRY_RUN" -eq 0 ]; then
      find "$SOURCE" -type d -empty -delete
      echo "🧹 Cleaned up empty directories."
      if systemctl is-active --quiet update-metadata-db.service; then
         systemctl start update-metadata-db.service
         echo "🔄 Metadata DB update triggered."
      fi
    fi
    
    echo "--- ✅ Mover finished ---"
  '';

in
{
  options.my.storage.mover = {
    enable = lib.mkEnableOption "Smart Storage Tiering Mover";
    ssdDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/media"; };
    hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/media"; };
    minAgeDays = lib.mkOption { type = lib.types.int; default = 30; };
    lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 100; };
    dryRun = lib.mkOption { type = lib.types.bool; default = false; };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.storage-mover = {
      description = "Aviation-Grade Smart Mover (SSD -> HDD)";
      after = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = moverScript;
        Nice = 19;
        IOSchedulingClass = "idle";
        CPUSchedulingPolicy = "idle";
      };
    };

    systemd.timers.storage-mover = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 04:00:00";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };
  };
}
