# Aviation-Grade Hardening & Storage Optimization Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Resolve critical audit flaws (Swappiness conflict, lib-helpers typos, Storage-Mover WAL corruption, Sops-Deadlock) and implement a RAM-based media caching strategy.

**Architecture:** 
1. Centralized Sysctl management for determinism.
2. Hardened Service Factories with fixed resource limits.
3. Transactional Storage Mover with broad DB exclusion patterns.
4. Resilient Sops key-path hierarchy.
5. RAM-transcoding/caching for Jellyfin to minimize disk wear and latency.

**Tech Stack:** NixOS, systemd, Sops-nix, Jellyfin, Bash.

---

### Task 1: Resolve Swappiness Conflict & Non-Determinism

**Files:**
- Modify: `temp_mynixos/modules/core/defaults.nix`
- Modify: `temp_mynixos/modules/core/zram-swap.nix`

- [ ] **Step 1: Centralize Swappiness in defaults.nix**
  Remove `mkForce` from any other modules (if found) and set a conditional `mkDefault` in `defaults.nix`.

```nix
# In modules/core/defaults.nix
    boot.kernel.sysctl."vm.swappiness" = lib.mkDefault (if config.zramSwap.enable then 180 else 10);
```

- [ ] **Step 2: Clean up zram-swap.nix**
  Ensure no `swappiness` is set here to avoid conflicts.

- [ ] **Step 3: Verify with nix-instantiate (or dry-run)**
  Ensure the configuration evaluates without "multiple definitions" errors.

- [ ] **Step 4: Commit**
```bash
git add temp_mynixos/modules/core/defaults.nix temp_mynixos/modules/core/zram-swap.nix
git commit -m "refactor: centralize vm.swappiness logic based on zram state"
```

---

### Task 2: Fix lib-helpers.nix Typos (MemoryMax)

**Files:**
- Modify: `temp_mynixos/modules/core/lib-helpers.nix`

- [ ] **Step 1: Correct key-casing in mkDocumentApp and workers**
  Ensure `MemoryMax` is used as the key and `memoryMax` as the value variable.

```nix
# In lib-helpers.nix, ensure all systemd keys are PascalCase
      extraServiceConfig = pythonHardening // {
        MemoryMax = memoryMax;
        # ...
      };
```

- [ ] **Step 2: Add MemoryMax to workers/beat services**
  Propagate the limit to sidecar services.

- [ ] **Step 3: Commit**
```bash
git add temp_mynixos/modules/core/lib-helpers.nix
git commit -m "fix(lib-helpers): correct MemoryMax casing and propagate to workers"
```

---

### Task 3: Storage-Mover WAL Blacklist & Safety

**Files:**
- Modify: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Expand blacklist patterns**
  Add `*.sqlite-wal`, `*.sqlite-shm`, `*.db-shm`, `*.db-wal` to the `find` exclusion.

```bash
      # 🛡️ Find oldest file, excluding critical database patterns
      OLDEST=$(find "$SOURCE_DIR" -type f \
        ! -name "*.wal" ! -name "*.db" ! -name "*.sqlite" ! -name "*.db-journal" \
        ! -name "*.db-shm" ! -name "*.db-wal" ! -name "*.sqlite-shm" ! -name "*.sqlite-wal" \
        -printf '%T@ %p\n' | sort -n | head -1 | cut -d' ' -f2-)
```

- [ ] **Step 2: Add log rotation for the mover log**
  (Optional but recommended for Tier C).

- [ ] **Step 3: Commit**
```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "feat(storage-mover): expand database file exclusions to prevent corruption"
```

---

### Task 4: Sops-Deadlock Resilience

**Files:**
- Modify: `temp_mynixos/modules/core/secrets.nix`

- [ ] **Step 1: Update sshKeyPaths hierarchy**
  Ensure the order is: `/etc/ssh/...` -> Tier B Fallback -> `/persist/etc/ssh/...`.
  Add a comment about the fallback key sync.

- [ ] **Step 2: Commit**
```bash
git add temp_mynixos/modules/core/secrets.nix
git commit -m "feat(sops): implement resilient hostkey search hierarchy"
```

---

### Task 5: Media RAM-Caching & 4K Policy

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-jellyfin.nix`

- [ ] **Step 1: Create RAM Cache Mount**
  Define a `systemd.mount` for `/dev/shm/jellyfin-cache` with `size=2G`.

- [ ] **Step 2: Configure Jellyfin to use RAM Cache**
  Set `cacheDir` and `transcodingDir` to the RAM mount.

- [ ] **Step 3: Commit**
```bash
git add temp_mynixos/modules/apps/service-media-jellyfin.nix
git commit -m "feat(jellyfin): implement 2GB RAM cache for transcoding and metadata"
```
