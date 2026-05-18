# Final Sortie: Extra Apps (Linkding) & Backup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable Linkding, finalize RAG pipeline integration, and validate the backup strategy for `/persist`.

**Architecture:** Following Horizontal Responsibility v5.0. Apps are enabled via profile toggles in the main `configuration.nix`.

**Tech Stack:** NixOS, Restic, Python (RAG), Linkding.

---

### Task 1: Enable Linkding Application

**Files:**
- Modify: `temp_mynixos/configuration.nix`

- [ ] **Step 1: Enable Linkding in global toggles**

Update `my.services` block:
```nix
    my.services = {
      # ... existing ...
      linkding.enable = true;
    };
```

- [ ] **Step 2: Verify nix syntax**

Run: `nix-instantiate --parse temp_mynixos/configuration.nix`
Expected: Success (output of AST)

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/configuration.nix
git commit -m "feat(apps): enable linkding"
```

### Task 2: Validate Backup Expansion

**Files:**
- Modify: `temp_mynixos/modules/core/backup.nix`

- [ ] **Step 1: Check if /persist is included in restic paths**

Verify `services.restic.backups.remote.paths` includes `/persist`.

- [ ] **Step 2: Add /persist if missing**

```nix
services.restic.backups.remote = {
  paths = [ "/var/lib" "/etc" "/persist" ];
  # ...
};
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/backup.nix
git commit -m "chore(backup): ensure /persist is included in restic paths"
```

### Task 3: Final Status Sync

**Files:**
- Modify: `GEMINI.md`
- Modify: `ROADMAP.md`

- [ ] **Step 1: Mark P6 and P7 as DONE in Roadmap**

- [ ] **Step 2: Update Status to MISSION ACCOMPLISHED**

- [ ] **Step 3: Commit**

```bash
git add GEMINI.md ROADMAP.md
git commit -m "docs: finalize project milestones"
```
