# HDD-Ghosting & SSD-Endurance Refinement Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Eliminate HDD spin-ups for non-media tasks and protect SSD from high-write metadata.

**Architecture:**
1. **Jellyfin:** Metadata -> Tier B SSD via Bind-Mount.
2. **HDD Policy:** Udev-based hdparm spindown (10 min).
3. **Ghosting:** Refined Inode-Warmer for RAM-caching directory trees.

---

### Task 1: Jellyfin Metadata Relocation (SSD)

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-jellyfin.nix`

- [ ] **Step 1: Define SSD Metadata Path and Bind Mount**

```nix
{ config, pkgs, lib, myLib, ... }:
let
 srePaths = config.my.configs.paths;
 ssdMetadataDir = "${srePaths.tierB}/metadata/jellyfin";
in
{
 # ... existing mkStreamer ...
 config = lib.mkIf cfg.enable (lib.mkMerge [
 {
 # Ensure SSD directory exists
 systemd.tmpfiles.rules = [
 "d ${ssdMetadataDir} 0775 jellyfin media - -"
 ];

 # Bind-Mount SSD Metadata to Jellyfin's standard path
 fileSystems."/var/lib/jellyfin/metadata" = {
 device = ssdMetadataDir;
 options = [ "bind" "noatime" ];
 depends = [ "${srePaths.tierB}" ];
 };
 }
 ]);
}
```

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(jellyfin): move metadata (thumbnails/fanart) to SSD Tier B"
```

---

### Task 2: Global HDD Spindown Policy (Udev)

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Add Udev rules for hdparm**

```nix
services.udev.extraRules = ''
 # hardened HDD Spindown: 10 Minutes (120 * 5s)
 ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 120 /dev/%k"
'';
```

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(storage): add global HDD spindown policy via udev"
```

---

### Task 3: Refined Inode-Warmer (Ghost-Tree)

- [ ] **Step 1: Update the hdd-inode-warmer service**
Make it read enough metadata to keep the tree in RAM.

```nix
systemd.services.hdd-inode-warmer = {
 description = "Refined Inode Warmer for HDD Ghost-Tree";
 serviceConfig = {
 Type = "oneshot";
 ExecStart = "${pkgs.findutils}/bin/find /mnt/hdd_pool -mindepth 1 -maxdepth 5 -exec stat {} +";
 };
};
```

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(storage): refine inode-warmer for better metadata ghosting"
```
