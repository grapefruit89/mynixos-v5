# CPU Pinning Templates Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add commented-out CPU pinning templates to Jellyfin and Audiobookshelf services to allow for future performance tuning.

**Architecture:** Enhance the `mkStreamer` factory in `lib-helpers.nix` to support `extraServiceConfig`, then update the service definitions to include the commented templates.

**Tech Stack:** NixOS, systemd

---

### Task 1: Enhance `mkStreamer` Factory

**Files:**
- Modify: `repo_v5/modules/core/lib-helpers.nix`

- [ ] **Step 1: Add `extraServiceConfig` argument to `mkStreamer` signature**

Update the argument set of `mkStreamer` to include `extraServiceConfig ? {},`.

- [ ] **Step 2: Merge `extraServiceConfig` in the `mkService` call**

Use `lib.recursiveUpdate` to merge the streamer's internal defaults with the provided `extraServiceConfig`.

```nix
    (config.myLib.mkService {
      inherit config name port description persist useVPN;
      isStream = true;
      readWritePaths = [ cacheDir mediaDir ];
      extraServiceConfig = lib.recursiveUpdate {
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
        Restart = "always";
        RestartSec = "5s";
        MemoryMax = memoryMax;
        MemoryHigh = "75%";
        CPUWeight = cpuWeight;
        OOMScoreAdjust = oomScoreAdjust;
        PrivateDevices = if useGPU then lib.mkForce false else true;
        DeviceAllow = if useGPU then [ "/dev/dri/renderD128 rw" ] else [];
      } extraServiceConfig;
    })
```

- [ ] **Step 3: Commit**

```bash
git add repo_v5/modules/core/lib-helpers.nix
git commit -m "feat(lib-helpers): add extraServiceConfig support to mkStreamer"
```

### Task 2: Add Template to Jellyfin

**Files:**
- Modify: `repo_v5/modules/apps/service-media-jellyfin.nix`

- [ ] **Step 1: Add commented CPU pinning block to `mkStreamer` call**

```nix
 (myLib.mkStreamer {
 inherit config;
 name = "jellyfin";
 netns = "media-ns";
 port = config.my.ports.jellyfin;
 useGPU = true;
 memoryMax = "4G";
 cpuWeight = 80;
 description = "Jellyfin hardened Instance";
 extraServiceConfig = {
   # CPU Pinning (aktivieren bei Bedarf):
   # CPUAffinity = 2 3;  # Dedizierte Cores für QuickSync
 };
 })
```

- [ ] **Step 2: Commit**

```bash
git add repo_v5/modules/apps/service-media-jellyfin.nix
git commit -m "chore(jellyfin): add commented CPU pinning template"
```

### Task 3: Add Template to Audiobookshelf

**Files:**
- Modify: `repo_v5/modules/apps/service-app-audiobookshelf.nix`

- [ ] **Step 1: Add commented CPU pinning block to `mkStreamer` call**

```nix
 (myLib.mkStreamer {
 inherit config;
 name = "audiobookshelf";
 netns = "media-ns";
 port = cfg.port;
 useGPU = false;
 memoryMax = "2G";
 cpuWeight = 70;
 oomScoreAdjust = 350;
 description = "Audiobookshelf Instance";
 extraServiceConfig = {
   # CPU Pinning (aktivieren bei Bedarf):
   # CPUAffinity = 2 3;  # Dedizierte Cores für QuickSync
 };
 })
```

- [ ] **Step 2: Commit**

```bash
git add repo_v5/modules/apps/service-app-audiobookshelf.nix
git commit -m "chore(audiobookshelf): add commented CPU pinning template"
```
