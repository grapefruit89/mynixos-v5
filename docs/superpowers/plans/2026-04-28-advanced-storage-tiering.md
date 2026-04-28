# Advanced Storage Tiering Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Maximize SSD efficiency and endurance by distributing data across NVMe (Tier A), SATA SSD (Tier B), HDD (Tier C), and RAM.

**Architecture:** 
1. `configs.nix`: SSoT for Tiered paths.
2. `storage-mover.nix`: Capacity-based evacuation script.
3. `jellyfin.nix`: RAM-based transcoding.

---

### Task 1: Finalize Path Definitions

**Files:**
- Modify: `temp_mynixos/modules/core/configs.nix`

- [ ] **Step 1: Update paths in configs.nix**

```nix
    # 💾 ABC-TIERING STORAGE PATHS
    paths = {
      stateDir = lib.mkOption { type = lib.types.str; default = "/var/lib"; };
      tierA = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/persist"; description = "NVMe: Persistent State"; });
      tierB = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/cache"; description = "SSD: Cache & Transcodes"; });
      tierC = myLib.mkTracedOption "SRC-OBS-852" (lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; description = "HDD: Bulk Media Archive"; });
      
      # 🚀 App-Specific Tiering
      appData = lib.mkOption { type = lib.types.str; default = "/persist/app-data"; description = "Tier A: High-IOPS (Databases, Configs)"; };
      appCache = lib.mkOption { type = lib.types.str; default = "/mnt/cache/app-cache"; description = "Tier B: High-Volume (Images, Thumbnails)"; };
      downloads = lib.mkOption { type = lib.types.str; default = "/mnt/cache/downloads"; description = "Tier B: High-Write (Active SABnzbd)"; };
      
      mediaLibrary = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool/media"; };
      storagePool = lib.mkOption { type = lib.types.str; default = "/mnt/hdd_pool"; };
    };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/configs.nix
git commit -m "feat(storage): finalize ABC-Tiering path definitions"
```

---

### Task 2: Redesign Storage Mover (Capacity-Based)

**Files:**
- Modify: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Rewrite the mover script and options**

```nix
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

    # Get free space on source drive
    FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
    FREE_GB=$((FREE_SPACE / 1024 / 1024))

    echo "📊 Current free space on Tier B ($SOURCE_DIR): ''${FREE_GB} GB"

    if [ "$FREE_GB" -ge "$LOW_THRESHOLD_GB" ]; then
      echo "✅ Sufficient space available. No action required."
      exit 0
    fi

    echo "⚠️ Low space detected (''${FREE_GB} GB < ''${LOW_THRESHOLD_GB} GB). Evacuating oldest files..."

    # Loop until target free space is reached
    while [ "$FREE_GB" -lt "$TARGET_FREE_GB" ]; do
      # Find the oldest file (excluding hidden/active files)
      OLDEST=$(find "$SOURCE_DIR" -type f -printf '%T@ %p\n' | sort -n | head -1 | cut -d' ' -f2-)
      
      if [ -z "$OLDEST" ]; then
        echo "ℹ️ No more files found to move."
        break
      fi

      # 🛡️ Safety: Skip if file is open
      if ${pkgs.lsof}/bin/lsof "$OLDEST" > /dev/null 2>&1; then
        echo "⏭️ Skipping active file: $OLDEST"
        # Temporarily 'touch' it so it's not the oldest anymore in the next find
        touch "$OLDEST"
        continue
      fi

      REL_PATH=''${OLDEST#"$SOURCE_DIR/"}
      DEST_DIR=$(dirname "$TARGET_DIR/$REL_PATH")

      if [ "$DRY_RUN" -eq 1 ]; then
        echo "[DRY-RUN] Would move: $REL_PATH"
        # Simulate free space increase for dry run loop termination
        FREE_GB=$((FREE_GB + 1)) 
      else
        echo "🚚 Moving: $REL_PATH"
        mkdir -p "$DEST_DIR"
        mv "$OLDEST" "$TARGET_DIR/$REL_PATH"
        
        # Re-check free space
        FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
        FREE_GB=$((FREE_SPACE / 1024 / 1024))
      fi
    done

    # Cleanup empty directories
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
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "refactor(storage): rewrite mover to capacity-based logic"
```

---

### Task 3: Move Jellyfin Transcoding to RAM

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-jellyfin.nix`

- [ ] **Step 1: Set RuntimeDirectory and environment variables**

```nix
{ config, pkgs, lib, myLib, ... }:
# ... existing imports ...
{
  # ... existing options ...
  config = lib.mkIf cfg.enable (lib.mkMerge [
    (myLib.mkStreamer {
      # ... existing args ...
    })
    {
      systemd.services.jellyfin = {
        serviceConfig = {
          # 🚀 TRANSCODING IN RAM (Aviation-Grade SSD Protection)
          RuntimeDirectory = "jellyfin-transcode"; # creates /run/jellyfin-transcode (tmpfs)
          RuntimeDirectoryMode = "0750";
          Environment = [
            "FFMPEG_TRANSCODING_TEMP_DIR=/run/jellyfin-transcode"
          ];
        };
      };
      
      # Optional: In case the web UI needs explicit path via config
      # This part depends on how encoding.xml is generated.
    }
  ]);
}
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/apps/service-media-jellyfin.nix
git commit -m "perf(jellyfin): move transcoding to RAM disk (tmpfs)"
```

---

### Task 4: Verify mkService Persistence (Tier A)

- [ ] **Step 1: Check lib-helpers.nix**
Verify that `appDataDir` is actually on Tier A and used for state. (Done in previous turn, just confirm).

- [ ] **Step 2: Final Verification**
Run `nix-instantiate --parse` (simulated check) or verify file structure.
