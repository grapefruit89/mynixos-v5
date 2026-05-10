# Phase 1: Build Recovery & Port SSoT Consolidation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore build capability, resolve port collisions, and fix hardware profile synchronization across the repository.

**Architecture:** 
- Centralize hardware-specific graphics logic into the host profile.
- Fix missing option definitions in the core configuration.
- Enforce the Port Single Source of Truth (SSoT) by re-assigning colliding ports and removing hardcoded values.

**Tech Stack:** NixOS, VA-API, systemd, networking.

---

### Task 1: Hardware & Graphics Cleanup

**Files:**
- Modify: `temp_mynixos/modules/core/configs.nix`
- Modify: `temp_mynixos/configuration.nix`
- Delete: `temp_mynixos/modules/core/graphics.nix`

- [ ] **Step 1: Define `hardware.profile` in `configs.nix`**
In `temp_mynixos/modules/core/configs.nix`, add the `profile` option to the `hardware` submodule:
```nix
    hardware = {
      profile = lib.mkOption {
        type = lib.types.str;
        default = "q958";
        description = "The target hardware profile.";
      };
      # ... (existing options)
```

- [ ] **Step 2: Remove redundant `graphics.nix`**
In `temp_mynixos/configuration.nix`, remove the import line `./modules/core/graphics.nix`. 
Then, delete the file `temp_mynixos/modules/core/graphics.nix` as the logic is already present in `hardware/q958/hardware-profile.nix`.

- [ ] **Step 3: Commit**
```bash
git add temp_mynixos/modules/core/configs.nix temp_mynixos/configuration.nix
git rm temp_mynixos/modules/core/graphics.nix
git commit -m "chore(core): consolidate hardware profile and graphics logic"
```

---

### Task 2: Port Collision Resolution (SSoT)

**Files:**
- Modify: `temp_mynixos/modules/core/ports.nix`
- Modify: `temp_mynixos/modules/monitoring/gatus.nix`
- Modify: `temp_mynixos/modules/apps/service-media-sabnzbd.nix`

- [ ] **Step 1: Re-assign unique ports in `ports.nix`**
Update `temp_mynixos/modules/core/ports.nix` with the following values to resolve 8080 and 3001 collisions:
- `sabnzbd = 8081;`
- `monica = 8082;`
- `scrutiny = 8083;`
- `uptime-kuma = 3002;`

- [ ] **Step 2: Remove hardcoded port in `gatus.nix`**
In `temp_mynixos/modules/monitoring/gatus.nix`, change the Pocket-ID endpoint URL to use the SSoT:
```nix
        { 
          name = "Pocket-ID"; 
          url = "http://localhost:${toString config.my.ports.pocket-id}/health"; 
          interval = "60s"; 
          conditions = [ "[STATUS] == 200" ]; 
        }
```

- [ ] **Step 3: Fix SABnzbd default port**
In `temp_mynixos/modules/apps/service-media-sabnzbd.nix`, ensure the default port value is pulled from `config.my.ports.sabnzbd` instead of being hardcoded to `8080`.

- [ ] **Step 4: Commit**
```bash
git add temp_mynixos/modules/core/ports.nix temp_mynixos/modules/monitoring/gatus.nix temp_mynixos/modules/apps/service-media-sabnzbd.nix
git commit -m "fix(ports): resolve 8080 and 3001 collisions and enforce SSoT"
```

---

### Task 3: Cross-Check and Final Verification

**Files:**
- Modify: `temp_mynixos/configuration.nix`

- [ ] **Step 1: Verify global service toggles**
Ensure `my.services.storagePool.enable = true;` and other critical services are active in `configuration.nix`.

- [ ] **Step 2: Syntax Validation**
Run `nix-instantiate --parse` on all modified files to ensure they are valid Nix code.

- [ ] **Step 3: Commit**
```bash
git add temp_mynixos/configuration.nix
git commit -m "chore(config): final registry sync and verification"
```
