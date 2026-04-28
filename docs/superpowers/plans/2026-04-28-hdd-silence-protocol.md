# HDD-Silence-Protocol (Ghost-Disk) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Prevent HDD spin-ups for metadata and deletion tasks. Queue operations until the disk is active.

**Architecture:**
1. **Metadata Caching:** Optimize MergerFS and add a "Kernel Inode Warmer" service.
2. **Deferred Deletes:** Script to manage a `delete_queue` directory on SSD.
3. **Smart Mover v2:** Status-aware execution.

---

### Task 1: MergerFS Metadata Tuning

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Update MergerFS options for extreme caching**

```nix
options = "allow_other,use_ino,cache.files=auto-full,cache.entry=3600,cache.attr=3600,category.create=mfs,minfreespace=50G,fsname=mergerfs-pool,dropcacheonclose=true";
```

- [ ] **Step 2: Add Inode-Warmer Service**
This service runs `find /mnt/hdd_pool -maxdepth 3` once every 6 hours to keep the top-level structure in RAM.

---

### Task 2: Deferred Deletion Queue

**Files:**
- Create: `temp_mynixos/modules/storage/deferred-ops.nix`

- [ ] **Step 1: Create the 'Ghost Trash' logic**
Instead of `rm`, apps should move to `${srePaths.tierB}/delete_queue`.

- [ ] **Step 2: Create the Queue-Processor Script**
The script checks if `/dev/disk/by-id/...` is spinning (via `hdparm -C`). If spinning, it executes the deletes.

---

### Task 3: Status-Aware Mover

**Files:**
- Modify: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Inject 'Disk-Status' check into mover script**

```bash
# NEW LOGIC: Check if HDD is already awake
IS_AWAKE=$(hdparm -C /dev/sdX | grep -c "active/idle" || true)

if [ "$FREE_GB" -ge "$LOW_THRESHOLD_GB" ] && [ "$IS_AWAKE" -eq 0 ]; then
  echo "Disk is sleeping and space is OK. Sleeping too."
  exit 0
fi
```
