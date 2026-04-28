# Persist Backup Implementation Plan (P2)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a secondary Restic job for `/persist` targeting Backblaze B2.

**Architecture:** Extended `restic.backups` with Sops secret injection.

**Tech Stack:** NixOS, Restic, Sops, Backblaze B2.

---

### Task 1: Update Secret Management

**Files:**
- Modify: `temp_mynixos/modules/core/secrets.nix`

- [ ] **Step 1: Add secret definitions**

Add `restic_password`, `backblaze_access_key`, and `backblaze_secret_key` to `sops.secrets`.

- [ ] **Step 2: Add Sops Template for Restic Env**

Add `templates."backblaze-restic.env"` to provide `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

```nix
      templates."backblaze-restic.env" = {
        owner = "root";
        mode = "0400";
        content = ''
          AWS_ACCESS_KEY_ID="${config.sops.placeholder.backblaze_access_key}"
          AWS_SECRET_ACCESS_KEY="${config.sops.placeholder.backblaze_secret_key}"
        '';
      };
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/secrets.nix
git commit -m "chore(secrets): add backblaze and restic secret definitions"
```

---

### Task 2: Implement Persist Backup Job

**Files:**
- Modify: `temp_mynixos/modules/core/backup.nix`

- [ ] **Step 1: Add the 'persist' job**

```nix
    services.restic.backups.persist = {
      initialize = true;
      repository = "s3:https://s3.eu-central-003.backblazeb2.com/nixhome-persist";
      passwordFile = config.sops.secrets.restic_password.path;
      environmentFile = config.sops.templates."backblaze-restic.env".path;

      paths = [ "/persist" ];
      exclude = [ "**/.cache" "**/tmp" ];

      pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-monthly 6" ];
      
      timerConfig = {
        OnCalendar = "03:00";
        Persistent = true;
      };
      
      extraOptions = [ "--compression=max" ];
    };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/backup.nix
git commit -m "feat(backup): add secondary restic job for /persist to cloud"
```

---

### Task 3: Update Roadmap

- [ ] **Step 1: Update ROADMAP.md**

Mark P2 as DONE.
