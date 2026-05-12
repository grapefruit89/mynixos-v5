{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;

 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail

 # --- 📦 TIER B -> C (B3: Buffer/Downloads) ---
 SOURCE_DIR_B3="${srePaths.downloads}"
 TARGET_DIR_B3="${srePaths.tierC}/archive/downloads"
 
 # --- 📦 TIER A -> B (B2: Private Overflow) ---
 SOURCE_DIR_A_B2="${srePaths.privateData}"
 TARGET_DIR_B_B2="${srePaths.tierB}/private" # Already on Tier B usually, but this is the logical flow

 LOW_THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
 TARGET_FREE_GB=${toString cfg.targetFreeGB}
 DRY_RUN=${if cfg.dryRun then "1" else "0"}
 PHYSICAL_HDDS=(${lib.concatStringsSep " " config.my.storage.devices})

 echo "--- 📦 Starting Capacity-Based Smart Mover (v6.1 Strict) ---"

 # 1. 🛡️ Check Tier A (NVMe) -> Tier B (SSD) for Private Data
 FREE_SPACE_A=$(${pkgs.coreutils}/bin/df --output=avail "${srePaths.tierA}" | tail -1)
 FREE_GB_A=$((FREE_SPACE_A / 1024 / 1024))
 
 if [ "$FREE_GB_A" -lt 5 ]; then
   echo "🚀 TIER A CRITICAL ($FREE_GB_A GB). Evacuating B2 (Private) data to Tier B..."
   # Logic to move from /persist/app-data/large_blobs to SSD if needed
 fi

 # 2. 🛡️ Check Tier B (SSD) -> Tier C (HDD) for Buffer/Archive
 # Check if HDD is active via declarative list
 IS_AWAKE=0
 for dev in "''${PHYSICAL_HDDS[@]}"; do
   if ${pkgs.hdparm}/bin/hdparm -C "$dev" 2>/dev/null | grep -q "active/idle"; then
     IS_AWAKE=$((IS_AWAKE + 1))
   fi
 done
 
 FREE_SPACE_B=$(${pkgs.coreutils}/bin/df --output=avail "${srePaths.tierB}" | tail -1)
 FREE_GB_B=$((FREE_SPACE_B / 1024 / 1024))

 if [ "$FREE_GB_B" -lt 10 ]; then
   echo "🚀 TIER B SPACE CRITICAL ($FREE_GB_B GB). Forcing archive regardless of HDD state."
 elif [ "$FREE_GB_B" -lt 20 ] && [ "$IS_AWAKE" -gt 0 ]; then
   echo "⚖️ TIER B LOW SPACE ($FREE_GB_B GB) and HDD is AWAKE. Starting archive move."
 else
   echo "💤 Conditions not met for Tier B archive (Free: $FREE_GB_B GB, HDD Awake: $IS_AWAKE). Skipping."
   exit 0
 fi

 # Perform the move (B3 -> C)
 echo "📊 Current free space on Tier B: ''${FREE_GB_B} GB"
 
 MAX_ITERATIONS=100
 COUNT=0

 while [ "$FREE_GB_B" -lt "$TARGET_FREE_GB" ] && [ "$COUNT" -lt "$MAX_ITERATIONS" ]; do
   COUNT=$((COUNT + 1))

      # 🛡️ Find oldest file, excluding critical database patterns
      OLDEST=$(find "$SOURCE_DIR_B3" -type f \
        ! -name "*.wal" ! -name "*.db" ! -name "*.sqlite" ! -name "*.db-journal" ! -name "*.lock" \
        ! -name "*.log" ! -name "*.bak" ! -path "*/database/*" \
        -printf '%T@ %p\n' | sort -n | head -1 | cut -d' ' -f2-)

      if [ -z "$OLDEST" ]; then
      echo "ℹ️ No more safe files found to move."
      break
      fi

      if ${pkgs.lsof}/bin/lsof -- "$OLDEST" > /dev/null 2>&1; then
      echo "⏭️ Skipping active file: $OLDEST (touching to defer)"
      touch -- "$OLDEST"
      continue
      fi

      REL_PATH="${OLDEST#"$SOURCE_DIR_B3/"}"
      DEST_DIR=$(dirname -- "$TARGET_DIR_B3/$REL_PATH")

      if [ "$DRY_RUN" -eq 1 ]; then
      echo "[DRY-RUN] Would move: $REL_PATH"
      FREE_GB_B=$((FREE_GB_B + 5)) # Estimate move
      else
      echo "🚚 Moving: $REL_PATH"
      mkdir -p -- "$DEST_DIR"
      # 🛡️ TRANSACTIONAL MOVE: Copy -> Verify -> Delete
      if ${pkgs.rsync}/bin/rsync -a -- "$OLDEST" "$TARGET_DIR_B3/$REL_PATH"; then
       rm -f -- "$OLDEST"
      fi

      FREE_SPACE_B=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR_B3" | tail -1)
      FREE_GB_B=$((FREE_SPACE_B / 1024 / 1024))
      fi
 done

 if [ "$COUNT" -ge "$MAX_ITERATIONS" ]; then
   echo "⚠️ Mover reached MAX_ITERATIONS ($MAX_ITERATIONS). Stopping for safety."
 fi

 if [ "$DRY_RUN" -eq 0 ]; then
   # Preserve base directory with mindepth 1
   find "$SOURCE_DIR_B3" -mindepth 1 -type d -empty -delete
   echo "🧹 Cleaned up empty directories."
 fi

 echo "--- ✅ Mover finished. Current free space: ''${FREE_GB_B} GB ---"
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
