# Hourly S3 Log Sync (rclone) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a secure, hourly synchronization of RAM-buffered logs (from SSD Tier B) to an off-site S3 bucket (Backblaze) using `rclone`.

**Architecture:** A dedicated NixOS module `modules/logging/s3-sync.nix` will configure `rclone` with SOPS-Nix credentials. A `systemd.service` will execute the sync command, triggered by an hourly `systemd.timer`.

**Tech Stack:** NixOS, rclone, SOPS-Nix, Backblaze B2 (S3 compatible).

---

### Task 1: Create rclone Configuration Module

**Files:**
- Create: `temp_mynixos/modules/logging/s3-sync.nix`

- [ ] **Step 1: Define the module structure and options**

```nix
{ config, lib, pkgs, ... }:

let
  cfg = config.my.logging.s3Sync;
  srePaths = config.my.configs.paths;
  logDir = "${srePaths.tierB}/logs/system";
  
  # 🚀 NMS v6.0 Metadata
  nms = {
    id = "NIXH-90-LOG-S3S";
    title = "S3 Log Sync (rclone)";
    description = "Hourly off-site log synchronization for aviation-grade persistence.";
    layer = 90;
    capabilities = ["logging/offsite" "storage/s3" "automation/timer"];
    audit.last_reviewed = "2026-05-09";
  };

in {
  options.my.logging.s3Sync = {
    enable = lib.mkEnableOption "Hourly S3 Log Synchronization";
    bucket = lib.mkOption {
      type = lib.types.str;
      default = "nixhome-logs";
      description = "Destination S3 bucket name.";
    };
    endpoint = lib.mkOption {
      type = lib.types.str;
      default = "s3.us-west-004.backblazeb2.com"; # Example B2 endpoint
      description = "S3 API endpoint.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Metadata registration
    my.meta.s3Sync = nms;

    # SOPS Environment File for rclone
    # Reusing the existing 'backblaze-restic.env' template keys or creating a specific one
    # Note: rclone can use RCLONE_CONFIG_MYREMOTE_TYPE=s3 etc.
  };
}
```

- [ ] **Step 2: Implement the systemd service and timer**

```nix
    systemd.services.log-s3-sync = {
      description = "Sync logs to S3 (Backblaze)";
      after = [ "network.target" ];
      
      # Inject credentials via SOPS template
      serviceConfig = {
        Type = "oneshot";
        EnvironmentFile = config.sops.templates."backblaze-restic.env".path;
        ExecStart = pkgs.writeShellScript "s3-log-sync" ''
          ${pkgs.rclone}/bin/rclone sync ${logDir} \
            :s3:${cfg.bucket}/logs \
            --s3-provider Backblaze \
            --s3-endpoint ${cfg.endpoint} \
            --s3-access-key-id "$AWS_ACCESS_KEY_ID" \
            --s3-secret-access-key "$AWS_SECRET_ACCESS_KEY" \
            --stats-one-line \
            -v
        '';
        # Hardening
        ProtectSystem = "strict";
        ReadOnlyPaths = [ logDir ];
        PrivateTmp = true;
      };
    };

    systemd.timers.log-s3-sync = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "hourly";
        Persistent = true;
        RandomizedDelaySec = "5m";
      };
    };
```

---

### Task 2: Profile Integration and Registration

**Files:**
- Modify: `temp_mynixos/profiles/base-server.nix`
- Modify: `temp_mynixos/modules/core/registry.nix`

- [ ] **Step 1: Register the option in the Registry**

Add `s3Sync.enable = lib.mkEnableOption "S3 Log Sync";` to `modules/core/registry.nix` under logging or services.

- [ ] **Step 2: Import the module in the Base Server profile**

```nix
imports = [
  # ...
  ../modules/logging/s3-sync.nix
];
# Enable it
my.logging.s3Sync.enable = true;
```

---

### Task 3: Validation and Verification

**Files:**
- Modify: `temp_mynixos/ROADMAP.md`

- [ ] **Step 1: Perform a syntax check (mental or via subagent)**

- [ ] **Step 2: Update Roadmap status**

Change `S3 Log Sync` from `🟠 TODO` to `✅ DONE`.

- [ ] **Step 3: Commit and Push**

```bash
git add .
git commit -m "feat(logging): implement hourly S3 log synchronization via rclone"
git push origin main
```
