# Storage Tiering Mover Implementation Plan (P3)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement an intelligent "Unraid-style" mover that shifts files from Tier B (SSD) to Tier C (HDD) safely.

**Architecture:** Custom module `modules/storage/storage-mover.nix`. Uses `rsync` for atomic moves and `lsof` for safety.

**Tech Stack:** NixOS, Bash, Rsync.

---

### Task 1: Create the Storage Mover Module

**Files:**
- Create: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Write the module code**

```nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.storage.mover;
 srePaths = config.my.configs.paths;
 
 # 🚀 SMART MOVER SCRIPT
 moverScript = pkgs.writeShellScript "smart-mover" ''
 set -euo pipefail
 
 SOURCE="${cfg.ssdDir}"
 TARGET="${cfg.hddDir}"
 DRY_RUN=${if cfg.dryRun then "1" else "0"}
 AGE_DAYS=${toString cfg.minAgeDays}
 THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
 
 echo "--- 📦 Starting Smart Mover [DryRun: $DRY_RUN, Age: $AGE_DAYS, Threshold: $THRESHOLD_GB GB] ---"
 
 # 1. Space Check
 FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE" | tail -1)
 FREE_GB=$((FREE_SPACE / 1024 / 1024))
 
 FORCE_MOVE=0
 if [ "$FREE_GB" -lt "$THRESHOLD_GB" ]; then
 echo "⚠️ Low space detected ($FREE_GB GB < $THRESHOLD_GB GB). Forcing move of older files."
 FORCE_MOVE=1
 fi

 # 2. Find and Move
 # Criteria: Older than $AGE_DAYS OR (Low Space and older than 7 days)
 FIND_AGE=$AGE_DAYS
 [ "$FORCE_MOVE" -eq 1 ] && FIND_AGE=7

 echo "🔍 Scanning for files older than $FIND_AGE days..."
 
 # Use find to generate file list
 find "$SOURCE" -type f -mtime +"$FIND_AGE" | while read -r file; do
 # 🛡️ Safety: Skip if file is open (lsof)
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
 # Atomic move with rsync (preserves mtime/atime)
 ${pkgs.rsync}/bin/rsync -a --remove-source-files "$file" "$TARGET/$REL_PATH"
 fi
 done

 # 3. Cleanup empty directories
 if [ "$DRY_RUN" -eq 0 ]; then
 find "$SOURCE" -type d -empty -delete
 echo "🧹 Cleaned up empty directories."
 
 # 🔄 Trigger Metadata Update if service exists
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
 description = "hardened Smart Mover (SSD -> HDD)";
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
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "feat(storage): add smart storage tiering mover module"
```

---

### Task 2: Integrate into Hardware Profile

**Files:**
- Modify: `temp_mynixos/hardware/q958/hardware-profile.nix` (or similar)

- [ ] **Step 1: Check hardware profile imports**

- [ ] **Step 2: Add import and activation**

```nix
imports = [
 ../../modules/storage/storage-mover.nix
];

my.storage.mover.enable = true;
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/hardware/q958/hardware-profile.nix
git commit -m "feat(hardware): enable smart storage mover for Q958"
```

---

### Task 3: Roadmap Update

- [ ] **Step 1: Update ROADMAP.md**

Mark P3 as DONE.
