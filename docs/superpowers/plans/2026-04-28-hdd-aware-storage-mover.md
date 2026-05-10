# HDD-Aware Storage Mover Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the Storage Mover 'HDD-aware' to avoid unnecessary spin-ups unless space is critical.

**Architecture:** Inject a check at the beginning of the `moverScript` that evaluates HDD state (active/idle) and SSD free space.

**Tech Stack:** NixOS, Bash, hdparm, df.

---

### Task 1: Modify storage-mover.nix

**Files:**
- Modify: `temp_mynixos/modules/storage/storage-mover.nix`

- [ ] **Step 1: Inject HDD-awareness logic into `moverScript`**

```nix
  moverScript = pkgs.writeShellScript "smart-mover" ''
    set -euo pipefail

    SOURCE_DIR="${cfg.ssdDir}"
    TARGET_DIR="${cfg.hddDir}"
    LOW_THRESHOLD_GB=${toString cfg.lowSpaceThresholdGB}
    TARGET_FREE_GB=${toString cfg.targetFreeGB}
    DRY_RUN=${if cfg.dryRun then "1" else "0"}

    echo "--- 📦 Starting Capacity-Based Smart Mover ---"

    # --- HDD-Awareness Injection Start ---
    # Check if HDD is active
    # Assuming /dev/sda and /dev/sdb are your HDDs (Tier C)
    IS_AWAKE=$(${pkgs.hdparm}/bin/hdparm -C /dev/sd[a-z] | grep -c "active/idle" || true)
    
    # Space Check
    FREE_SPACE=$(${pkgs.coreutils}/bin/df --output=avail "$SOURCE_DIR" | tail -1)
    FREE_GB=$((FREE_SPACE / 1024 / 1024))

    # LOGIC:
    # 1. If space is CRITICAL (< 10GB) -> Always move.
    # 2. If space is LOW (< 20GB) AND HDD is awake -> Move.
    # 3. Else -> Exit.
    
    if [ "$FREE_GB" -lt 10 ]; then
       echo "🚀 SPACE CRITICAL ($FREE_GB GB). Forcing move regardless of HDD state."
    elif [ "$FREE_GB" -lt 20 ] && [ "$IS_AWAKE" -gt 0 ]; then
       echo "⚖️ LOW SPACE ($FREE_GB GB) and HDD is AWAKE ($IS_AWAKE active). Starting move."
    else
       echo "💤 Conditions not met for move (Free: $FREE_GB GB, HDD Awake: $IS_AWAKE). Skipping to avoid spin-up."
       exit 0
    fi
    # --- HDD-Awareness Injection End ---

    echo "📊 Current free space on Tier B ($SOURCE_DIR): ''${FREE_GB} GB"
    # ... rest of script
```

- [ ] **Step 2: Commit the changes**

Run:
```bash
git add temp_mynixos/modules/storage/storage-mover.nix
git commit -m "perf(storage): make mover status-aware (no spin-up unless critical)"
```

- [ ] **Step 3: Verification**

Since this is a Nix module, manual verification of the script content is needed.
Run: `cat temp_mynixos/modules/storage/storage-mover.nix` and verify the injected logic matches the requirements.
