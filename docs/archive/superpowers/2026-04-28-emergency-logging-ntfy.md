# Emergency Logging & Renaming Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rename the logging module to reflect its new HDD target and add an `ntfy` emergency sink for `ERROR` level logs.

**Architecture:** 
1. `vector-hdd.nix`: Renamed from `vector-tier-b.nix`.
2. **Emergency Sink:** Vector `http` sink targeting an `ntfy` topic for high-priority alerts.

---

### Task 1: Rename and Refactor Logging Module

**Files:**
- Create: `temp_mynixos/modules/logging/vector-hdd.nix`
- Remove: `temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 1: Create the new module with ntfy sink**

```nix
{ config, lib, pkgs, ... }:
let
 cfg = config.my.logging.vector;
 srePaths = config.my.configs.paths;
 logDir = "${srePaths.tierC}/logs/system";
 maxTotalSizeMB = 1024; # 1 GB
in
{
 options.my.logging.vector = {
 enable = lib.mkEnableOption "Vector logging to HDD (Tier C)";
 retentionDays = lib.mkOption { type = lib.types.int; default = 30; };
 maxFileSizeMB = lib.mkOption { type = lib.types.int; default = 200; };
 ntfyTopic = lib.mkOption { 
 type = lib.types.nullOr lib.types.str; 
 default = "nixhome-alerts"; 
 description = "Ntfy topic for emergency alerts (ERROR level).";
 };
 };

 config = lib.mkIf cfg.enable {
 # 1. Journald remains volatile (RAM only)
 services.journald.extraConfig = ''Storage=volatile'';

 # 2. Vector Service
 services.vector = {
 enable = true;
 config = {
 sources.journald = {
 type = "journald";
 current_boot_only = false;
 };

 # 🛡️ Transformation: Masking & Filtering
 transforms.mask_sensitive = {
 type = "remap";
 inputs = [ "journald" ];
 source = ''
 # Redact paths and keys
 .message = replace(.message, r'/mnt/(media|hdd_pool|tierC)/[^\s]+', "[MEDIA_PATH]")
 .message = replace(.message, r'[A-Za-z0-9]{32,}', "[API_KEY_REDACTED]")
 '';
 };

 # 🚨 Emergency Filter (Only ERRORS)
 transforms.error_filter = {
 type = "filter";
 inputs = [ "mask_sensitive" ];
 condition = ''includes(["err", "crit", "alert", "emerg"], .priority) || .level == "error" || .level == "critical" '';
 };

 # 📂 Sink 1: HDD (Archive)
 sinks.file = {
 type = "file";
 inputs = [ "mask_sensitive" ];
 path = "${logDir}/journal-%Y-%m-%d.log";
 encoding.codec = "ndjson";
 compression = "gzip";
 batch.max_bytes = 50 * 1024 * 1024; # 50MB for HDD efficiency
 batch.timeout_secs = 300; # 5 minutes
 healthcheck = true;
 };

 # 📱 Sink 2: NTFY (Emergency)
 sinks.ntfy = lib.mkIf (cfg.ntfyTopic != null) {
 type = "http";
 inputs = [ "error_filter" ];
 uri = "https://ntfy.sh/${cfg.ntfyTopic}";
 method = "post";
 encoding.codec = "text";
 # Simplified message for mobile notification
 batch.max_events = 1;
 };
 };
 };

 # 3. Rotation logic (unchanged from vector-tier-b but using new path)
 systemd.services.rotate-vector-logs = {
 description = "Rotate and delete old Vector logs (size/age based)";
 serviceConfig = {
 Type = "oneshot";
 Nice = 19;
 IOSchedulingClass = "idle";
 ExecStart = pkgs.writeShellScript "rotate-vector-logs" ''
 set -euo pipefail
 find ${logDir} -name "*.gz" -type f -mtime +${toString cfg.retentionDays} -delete
 # ... total size limit logic ...
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

 systemd.tmpfiles.rules = [ "d ${logDir} 0750 root root - -" ];
 };
}
```

- [ ] **Step 2: Commit new file**

```bash
git add temp_mynixos/modules/logging/vector-hdd.nix
git commit -m "feat(logging): add vector-hdd module with ntfy emergency sink"
```

- [ ] **Step 3: Remove old file**

```bash
git rm temp_mynixos/modules/logging/vector-tier-b.nix
git commit -m "chore(logging): remove deprecated vector-tier-b module"
```

---

### Task 2: Update Profile Import

**Files:**
- Modify: `temp_mynixos/profiles/base-server.nix`

- [ ] **Step 1: Change import from vector-tier-b to vector-hdd**

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/profiles/base-server.nix
git commit -m "refactor(profile): use vector-hdd logging module"
```
