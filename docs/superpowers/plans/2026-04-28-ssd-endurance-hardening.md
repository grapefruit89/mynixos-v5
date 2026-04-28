# SSD-Endurance & Logging Refinement Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Protect Tier A/B SSDs by moving high-write operations (SABnzbd temp, Logs) to RAM and HDD.

**Architecture:**
1. **SABnzbd:** `incomplete` directory -> `/run/sabnzbd-tmp` (tmpfs).
2. **Vector:** Sink -> Tier C (HDD).
3. **Mounts:** Apply `noatime`.

---

### Task 1: SABnzbd RAM-Tuning

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-sabnzbd.nix`

- [ ] **Step 1: Configure tmpfs for incomplete downloads**

```nix
systemd.services.sabnzbd = {
  serviceConfig = {
    # 🚀 RAM-DISK for Incomplete Downloads (Max 8GB for 16GB System)
    RuntimeDirectory = "sabnzbd-tmp";
    RuntimeDirectoryMode = "0750";
  };
};
```

- [ ] **Step 2: Update SABnzbd config to use /run/sabnzbd-tmp**
(Assuming the module handles the config file or allows overrides).

- [ ] **Step 3: Commit**

```bash
git commit -m "perf(sabnzbd): move incomplete downloads to RAM disk"
```

---

### Task 2: Vector Logging to HDD (Tier C)

**Files:**
- Modify: `temp_mynixos/modules/logging/vector-tier-b.nix` (rename or move logic)

- [ ] **Step 1: Change log directory to Tier C**

```nix
let
  logDir = "${srePaths.tierC}/logs/system";
in
# ... change sinks.file.path ...
```

- [ ] **Step 2: Add RAM buffering to Vector**
Ensure Vector collects logs in RAM and flushes to HDD every 5 minutes to reduce IO.

- [ ] **Step 3: Commit**

```bash
git commit -m "chore(logging): move system logs from SSD to HDD (Tier C)"
```

---

### Task 3: Global Mount Optimization

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Add 'noatime' to all relevant mounts**
Ensure `fileSystems` or `systemd.mounts` include the `noatime` option.

- [ ] **Step 2: Commit**

```bash
git commit -m "perf(storage): apply noatime to all mounts for SSD endurance"
```
