{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.deferred;
 srePaths = config.my.configs.paths;

 processScript = pkgs.writeShellScript "process-delete-queue" ''
 set -euo pipefail

 QUEUE_DIR="${cfg.queueDir}"
 MAX_AGE_DAYS=${toString cfg.maxAgeDays}
 HDD_POOL="${srePaths.tierC}"

 echo "--- 🗑️ Starting Deferred Deletion Processor ---"
 
 # Ensure queue dir exists
 mkdir -p "$QUEUE_DIR"

 # Detect devices for HDD_POOL
 # We want physical block devices.
 # We look for anything mounted under /mnt/hdd*
 echo "🔍 Detecting HDD devices..."
 DEVICES=$( ${pkgs.util-linux}/bin/lsblk -pno NAME,MOUNTPOINT | grep "/mnt/hdd" | awk '{print $1}' || echo "" )
 
 if [ -z "$DEVICES" ]; then
 echo "⚠️ No HDD devices detected under /mnt/hdd*"
 fi

 ANY_ACTIVE=false
 for DEV in $DEVICES; do
 if [ -b "$DEV" ]; then
 # -C check power mode without spinning up
 STATE=$( ${pkgs.hdparm}/bin/hdparm -C "$DEV" | grep "drive state is" | awk '{print $NF}' || echo "unknown" )
 echo "📊 Drive $DEV state: $STATE"
 if [[ "$STATE" == "active/idle" ]]; then
 ANY_ACTIVE=true
 fi
 fi
 done

 echo "📈 Pool Status: ANY_ACTIVE=$ANY_ACTIVE"

 # Process queue
 shopt -s nullglob
 for ENTRY in "$QUEUE_DIR"/*; do
 [ -f "$ENTRY" ] || continue
 
 FILE_AGE_SECONDS=$(($(date +%s) - $(stat -c %Y "$ENTRY")))
 MAX_AGE_SECONDS=$((MAX_AGE_DAYS * 86400))
 
 SHOULD_DELETE=false
 if [ "$ANY_ACTIVE" = true ]; then
 SHOULD_DELETE=true
 elif [ "$FILE_AGE_SECONDS" -gt "$MAX_AGE_SECONDS" ]; then
 SHOULD_DELETE=true
 echo "⏰ Forcing deletion of $ENTRY due to age ($MAX_AGE_DAYS days)"
 fi
 
 if [ "$SHOULD_DELETE" = true ]; then
 TARGET_PATH=$(cat "$ENTRY")
 if [ -n "$TARGET_PATH" ] && [ -e "$TARGET_PATH" ]; then
 # 🛡️ PATH VALIDATION (M-02 Defense)
 # Ensure target path starts with HDD_POOL and doesn't contain parent directory escapes
 REAL_TARGET=$(readlink -f "$TARGET_PATH" || echo "$TARGET_PATH")
 if [[ "$REAL_TARGET" == "$HDD_POOL"* ]]; then
 echo "🗑️ Safely deleting: $REAL_TARGET"
 rm -rf "$REAL_TARGET"
 else
 echo "🛑 SECURITY ALERT: Attempted out-of-bounds deletion! Target: $REAL_TARGET"
 exit 1
 fi
 else
 echo "❓ Target path '$TARGET_PATH' not found or empty, skipping."
 fi
 rm -f "$ENTRY"
 else
 echo "😴 Skipping $ENTRY (HDD is standby and file is not old enough)"
 fi
 done

 echo "--- ✅ Deferred Deletion Finished ---"
 '';
in
{
 options.my.storage.deferred = {
 enable = lib.mkEnableOption "Deferred Deletion Queue to save HDD spin-ups";
 queueDir = lib.mkOption {
 type = lib.types.str;
 default = "${srePaths.tierB}/delete_queue";
 description = "Directory on SSD where paths to be deleted are stored";
 };
 maxAgeDays = lib.mkOption {
 type = lib.types.int;
 default = 7;
 description = "Force delete if entry is older than this many days, even if HDD is asleep";
 };
 };

 config = lib.mkIf cfg.enable {
 systemd.services.process-delete-queue = {
 description = "Process Deferred Deletion Queue";
 after = [ "network.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = processScript;
 User = "root";
 Nice = 19;
 IOSchedulingClass = "idle";
 };
 };

 systemd.timers.process-delete-queue = {
 description = "Hourly processing of deferred deletion queue";
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = "hourly";
 Persistent = true;
 };
 };

 systemd.tmpfiles.rules = [
 "d ${cfg.queueDir} 0755 root root -"
 ];
 };
}
