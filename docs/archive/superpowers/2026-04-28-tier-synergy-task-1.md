# Tier Synergy Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a synergy mount that uses Tier A (NVMe) space for Tier B (SSD) data if A has >50GB free.

**Architecture:** Add a new `fuse.mergerfs` mount in `storage.nix` that pools Tier A app data and Tier B app data. Uses `mfs` policy with `50G` min free space.

**Tech Stack:** NixOS, MergerFS.

---

### Task 1: Research and Validation

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Verify current content of storage.nix**
Already done.

- [ ] **Step 2: Check for existing appdata paths**
Already done.

---

### Task 2: Implement Synergy Mount

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Add srePaths to let block**

```nix
<<<<
  cfg = config.my.services.storagePool;
  # Pfade aus SSoT Registry
  lanIP = config.my.configs.network.lanIP;
====
  cfg = config.my.services.storagePool;
  # Pfade aus SSoT Registry
  srePaths = config.my.configs.paths;
  lanIP = config.my.configs.network.lanIP;
>>>>
```

- [ ] **Step 2: Add /mnt/app-data-synergy mount**

Add to `systemd.mounts`:
```nix
      {
        description = "App Data Synergy Pool (Tier A/B)";
        where = "/mnt/app-data-synergy";
        what = "${srePaths.appData}:${srePaths.tierB}/appdata";
        type = "fuse.mergerfs";
        options = "allow_other,use_ino,cache.files=auto-full,dropcacheonclose=true,category.create=mfs,minfreespace=50G,fsname=app-data-synergy,noatime";
        wantedBy = [ "multi-user.target" ];
      }
```
*Note: Using `srePaths.appData` (which is `/persist/app-data`) instead of raw `srePaths.tierA` to satisfy the "No logs" requirement, as logs are in `/persist/var/log`.*

- [ ] **Step 3: Update storage-init script to ensure paths exist**

```nix
<<<<
      script = ''
        # Verzeichnisse anlegen
        mkdir -p /storage/{media,downloads,documents,backups}
====
      script = ''
        # Verzeichnisse anlegen
        mkdir -p /storage/{media,downloads,documents,backups}
        mkdir -p ${srePaths.tierB}/appdata
>>>>
```

---

### Task 3: Verification and Commit

- [ ] **Step 1: Check syntax (dry-run if possible, otherwise manual review)**

- [ ] **Step 2: Commit changes**

```bash
git add temp_mynixos/modules/core/storage.nix
git commit -m "perf(storage): implement opportunistic Tier A/B synergy for app data"
```
