# SSD-Endurance Hardening Task 2: Move System Logs to HDD

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move system logs from the SSD (Tier B) to the HDD (Tier C) to reduce SSD wear.

**Architecture:** Modify the Vector logging configuration to point to Tier C and optimize batching for HDD efficiency (larger batches, longer timeouts).

**Tech Stack:** Nix, Vector

---

### Task 1: Update Vector Logging Configuration

**Files:**
- Modify: `temp_mynixos/modules/logging/vector-tier-b.nix`

- [ ] **Step 1: Modify logDir and Vector sink settings**

Change the `logDir` variable and update the `sinks.file` configuration.

```nix
<<<<
  logDir = "${srePaths.tierB}/logs/vector";
====
  logDir = "${srePaths.tierC}/logs/system";
>>>>
```

And update the sink:

```nix
<<<<
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "ndjson";
          compression = "gzip";
          batch.max_bytes = cfg.maxFileSizeMB * 1024 * 1024;
          healthcheck = true;
        };
====
        sinks.file = {
          type = "file";
          inputs = [ "mask_sensitive" ];
          path = "${logDir}/journal-%Y-%m-%d.log";
          encoding.codec = "ndjson";
          compression = "gzip";
          batch.max_bytes = 50 * 1024 * 1024; # 50MB for HDD efficiency
          batch.timeout_secs = 300; # 5 minutes to let HDD sleep
          healthcheck = true;
        };
>>>>
```

- [ ] **Step 2: Commit changes**

Run:
```bash
git add temp_mynixos/modules/logging/vector-tier-b.nix
git commit -m "chore(logging): move system logs from SSD to HDD (Tier C)"
```
