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
    PHYSICAL_HDDS=(${lib.concatStringsSep " " config.my.storage.devices})

    echo "--- 📦 Starting Capacity-Based Smart Mover ---"

    # 1. Check if HDD is active (Don't wake up if not critical)
    IS_AWAKE=0
    for dev in "''${PHYSICAL_HDDS[@]}"; do
      # Fix KRIT-02: Don't fail if grep finds nothing
      HD_STATE=$(${pkgs.hdparm}/bin/hdparm -C "$dev" 2>/dev/null || true)
      if echo "$HD_STATE" | grep -q "active/idle"; then
        IS_AWAKE=$((IS_AWAKE + 1))
      fi
    done
    
    FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
    FREE_GB=$((FREE_SPACE / 1024 / 1024))

    if [ "$FREE_GB" -lt 10 ]; then
      echo "🚀 SPACE CRITICAL ($FREE_GB GB). Forcing move."
    elif [ "$FREE_GB" -lt "$LOW_THRESHOLD_GB" ] && [ "$IS_AWAKE" -gt 0 ]; then
      echo "⚖️ LOW SPACE ($FREE_GB GB) and HDD is AWAKE. Starting move."
    else
      echo "💤 Conditions not met for move (Free: $FREE_GB GB, Awake: $IS_AWAKE). Skipping."
      exit 0
    fi

    # 2. Robust Transactional Move (KRIT-01/03)
    echo "🚚 Moving files from $SOURCE_DIR to $TARGET_DIR..."
    
    # Find files, oldest first (excluding SQLite temporary files to prevent corruption)
    find "$SOURCE_DIR" -type f ! -name "*-wal" ! -name "*-shm" ! -name "*-journal" -printf '%T@ %p\n' | sort -n | awk '{print $2}' | \
    while IFS= read -r src_file; do
      # Calculate destination path
      rel_path="''${src_file#$SOURCE_DIR/}"
      dst_file="$TARGET_DIR/$rel_path"
      
      echo "  -> Processing: $rel_path"
      
      if [ "$DRY_RUN" = "1" ]; then
        echo "  [DRY-RUN] Would move $src_file to $dst_file"
      else
        mkdir -p "$(dirname "$dst_file")"
        
        # Transfer with checksum
        if ${pkgs.rsync}/bin/rsync -a --checksum "$src_file" "$dst_file"; then
          # Verify integrity before deletion
          src_hash=$(${pkgs.coreutils}/bin/sha256sum "$src_file" | cut -d' ' -f1)
          dst_hash=$(${pkgs.coreutils}/bin/sha256sum "$dst_file" | cut -d' ' -f1)
          
          if [ "$src_hash" = "$dst_hash" ]; then
            rm -f -- "$src_file"
            echo "  ✅ Verified and removed source."
          else
            echo "  ❌ HASH MISMATCH for $rel_path! Keeping source." >&2
          fi
        else
          echo "  ❌ Rsync FAILED for $rel_path!" >&2
        fi
      fi

      # Check if we reached the target free space
      CURRENT_FREE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
      CURRENT_FREE_GB=$((CURRENT_FREE / 1024 / 1024))
      if [ "$CURRENT_FREE_GB" -ge "$TARGET_FREE_GB" ]; then
        echo "✅ Target free space reached ($CURRENT_FREE_GB GB). Stopping."
        break
      fi
    done
    
    echo "--- ✅ Mover finished. ---"
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
      serviceConfig = {
        Type = "oneshot";
        ExecStart = moverScript;
        
        # 🛡️ Jailing (v7.1 Hardened)
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        NoNewPrivileges = true;
        ReadWritePaths = [ cfg.ssdDir cfg.hddDir ];
        
        Nice = 19;
        IOSchedulingClass = "idle";
      };
    };

    systemd.timers.storage-mover = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        RandomizedDelaySec = "4h";
        Persistent = true;
      };
    };
  };
}
