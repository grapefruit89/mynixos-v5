{ config, lib, pkgs, ... }:
let
  cfg = config.my.storage.mover;
  srePaths = config.my.configs.paths;

  moverScript = pkgs.writeShellScript "smart-mover" ''
    set -euo pipefail

    SOURCE_DIR="${cfg.ssdDir}"
    TARGET_DIR="${cfg.hddDir}"
    LOW_THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
    TARGET_FREE_GB=${toString cfg.targetFreeGB}
    DRY_RUN=${if cfg.dryRun then "1" else "0"}

    echo "--- 📦 Starting Capacity-Based Smart Mover ---"

    FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
    FREE_GB=$((FREE_SPACE / 1024 / 1024))

    echo "📊 Current free space on Tier B ($SOURCE_DIR): ''${FREE_GB} GB"

    if [ "$FREE_GB" -ge "$LOW_THRESHOLD_GB" ]; then
      echo "✅ Sufficient space available. No action required."
      exit 0
    fi

    echo "⚠️ Low space detected (''${FREE_GB} GB < ''${LOW_THRESHOLD_GB} GB). Evacuating oldest files..."

    while [ "$FREE_GB" -lt "$TARGET_FREE_GB" ]; do
      OLDEST=$(find "$SOURCE_DIR" -type f -printf '%T@ %p\n' | sort -n | head -1 | cut -d' ' -f2-)
      if [ -z "$OLDEST" ]; then
        echo "ℹ️ No more files found to move."
        break
      fi
      if ${pkgs.lsof}/bin/lsof "$OLDEST" > /dev/null 2>&1; then
        echo "⏭️ Skipping active file: $OLDEST"
        touch "$OLDEST"
        continue
      fi
      REL_PATH=''${OLDEST#"$SOURCE_DIR/"}
      DEST_DIR=$(dirname "$TARGET_DIR/$REL_PATH")
      if [ "$DRY_RUN" -eq 1 ]; then
        echo "[DRY-RUN] Would move: $REL_PATH"
        FREE_GB=$((FREE_GB + 1)) 
      else
        echo "🚚 Moving: $REL_PATH"
        mkdir -p "$DEST_DIR"
        mv "$OLDEST" "$TARGET_DIR/$REL_PATH"
        FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
        FREE_GB=$((FREE_SPACE / 1024 / 1024))
      fi
    done

    if [ "$DRY_RUN" -eq 0 ]; then
      find "$SOURCE_DIR" -type d -empty -delete
      echo "🧹 Cleaned up empty directories."
    fi

    echo "--- ✅ Mover finished. Current free space: ''${FREE_GB} GB ---"
  '';

in
{
  options.my.storage.mover = {
    enable = lib.mkEnableOption "Smart Storage Tiering Mover";
    ssdDir = lib.mkOption { type = lib.types.str; default = srePaths.downloads; };
    hddDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierC}/downloads"; };
    lowSpaceThresholdGB = lib.mkOption { type = lib.types.int; default = 20; };
    targetFreeGB = lib.mkOption { type = lib.types.int; default = 50; };
    dryRun = lib.mkOption { type = lib.types.bool; default = false; };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.storage-mover = {
      description = "Capacity-Based Smart Mover (SSD -> HDD)";
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
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };
  };
}
