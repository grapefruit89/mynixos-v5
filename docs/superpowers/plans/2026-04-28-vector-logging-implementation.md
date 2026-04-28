# Vector Logging Implementation Plan (P1)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement persistent logging via Vector to Tier B (SSD) with 14-day rotation.

**Architecture:** Custom module leveraging `services.vector` and `systemd.timers`.

**Tech Stack:** NixOS, Vector.

---

### Task 1: Create Vector Logging Module

**Files:**
- Create: `temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 1: Write the module code**

```nix
# modules/logging/vector-tier-b.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.my.logging.vector;
  srePaths = config.my.configs.paths;
  logDir = "${srePaths.tierB}/logs/vector";
in
{
  options.my.logging.vector = {
    enable = lib.mkEnableOption "Vector logging to Tier B";
    retentionDays = lib.mkOption { type = lib.types.int; default = 14; };
  };

  config = lib.mkIf cfg.enable {
    # 1. Journald bleibt volatile
    services.journald.extraConfig = ''
      Storage=volatile
      Compress=yes
      RateLimitIntervalSec=30
      RateLimitBurst=1000
    '';

    # 2. Vector Service
    services.vector = {
      enable = true;
      config = {
        sources.journald = {
          type = "journald";
          current_boot_only = false;
          include_units = [
            "*.service"
            "*.socket"
            "systemd-journald"
            "kernel"
          ];
        };
        transforms.mask_sensitive = {
          type = "remap";
          inputs = [ "journald" ];
          source = ''
            # Maskiere Medienpfade, API-Keys, IPs
            .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
            .message = replace(.message, r'\b[\w\s\-\.]+\.(mkv|mp4|avi|m4b|epub|pdf|nzb)\b', "[FILENAME]")
            .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
          '';
        };
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "json";
          compression = "gzip";
          batch.max_bytes = 104857600;
          healthcheck = true;
        };
      };
    };

    # 3. Rotation & Löschung
    systemd.services.rotate-vector-logs = {
      description = "Delete old Vector log files from Tier B";
      serviceConfig = {
        Type = "oneshot";
        Nice = 19;
        IOSchedulingClass = "idle";
        ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
          set -euo pipefail
          find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete
        '';
      };
    };
    systemd.timers.rotate-vector-logs = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };

    systemd.tmpfiles.rules = [
      "d ${logDir} 0750 root root - -"
    ];
  };
}
```

- [ ] **Step 2: Verify syntax**

Run: `nix-instantiate --parse temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/logging/vector-tier-b.nix
git commit -m "feat(logging): add vector tier-b logging module with masking"
```

---

### Task 2: Profile Integration

**Files:**
- Modify: `temp_mynixos/profiles/base-server.nix`

- [ ] **Step 1: Swap logging imports**

Replace `../modules/core/logging.nix` with `../modules/logging/vector-tier-b.nix`.

- [ ] **Step 2: Enable Vector logging**

Add `my.logging.vector.enable = true;` to the configuration block.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/profiles/base-server.nix
git commit -m "feat(profile): switch base-server to persistent vector logging"
```

---

### Task 4: Cleanup

- [ ] **Step 1: Remove old logging module (Optional)**

If no longer needed, remove `temp_mynixos/modules/core/logging.nix`.

- [ ] **Step 2: Update ROADMAP.md**

Mark P1 as DONE.
