# Hardening 'Tools' NixOS Modules Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Audit and harden six 'Tools' application modules in `temp_mynixos/modules/apps/` according to SRE standards.

**Architecture:** Systematic application of systemd sandboxing, SSoT path resolution, and persistence registration.

**Tech Stack:** NixOS, systemd, Sops-nix, Impermanence.

---

### Task 1: Update Global Registry (Ports & Persistence)

**Files:**
- Modify: `temp_mynixos/modules/core/ports.nix`
- Modify: `temp_mynixos/modules/core/impermanence.nix`

- [ ] **Step 1: Add Readeck port to `ports.nix`**
    ```nix
    # In my.ports default set
    readeck = 8072;
    ```
- [ ] **Step 2: Register state directories in `impermanence.nix`**
    ```nix
    # In environment.persistence."/persist".directories
    "/var/lib/vaultwarden"
    "/var/lib/miniflux"
    "/var/lib/linkwarden"
    "/var/lib/filebrowser"
    "/var/lib/readeck"
    "/var/lib/monica"
    ```
- [ ] **Step 3: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/core/ports.nix temp_mynixos/modules/core/impermanence.nix`
- [ ] **Step 4: Commit**
    ```bash
    git add temp_mynixos/modules/core/ports.nix temp_mynixos/modules/core/impermanence.nix
    git commit -m "infra: register ports and persistence for tools"
    ```

### Task 2: Harden Vaultwarden

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-vaultwarden.nix`

- [ ] **Step 1: Apply hardening changes**
    - Replace `/var/lib/vaultwarden` with `${config.my.configs.paths.stateDir}/vaultwarden`.
    - Add `ProtectHome = true;`.
    - Set `OOMScoreAdjust = 300;`.
- [ ] **Step 2: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-vaultwarden.nix`
- [ ] **Step 3: Commit**
    ```bash
    git add temp_mynixos/modules/apps/service-app-vaultwarden.nix
    git commit -m "harden: vaultwarden security and paths"
    ```

### Task 3: Harden Miniflux

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-miniflux.nix`

- [ ] **Step 1: Apply hardening changes**
    - Add `after = [ "postgresql.service" ];`.
    - Ensure `StateDirectory = "miniflux";` is set.
- [ ] **Step 2: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-miniflux.nix`
- [ ] **Step 3: Commit**
    ```bash
    git add temp_mynixos/modules/apps/service-app-miniflux.nix
    git commit -m "harden: miniflux dependencies and sandboxing"
    ```

### Task 4: Harden Linkwarden

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-linkwarden.nix`

- [ ] **Step 1: Apply hardening changes**
    - Add `after = [ "postgresql.service" ];`.
    - Uncomment `secretEnv` and use it in `environmentFile`.
    - Ensure `StateDirectory = "linkwarden";`.
    - Add `ProtectHome = true;`.
- [ ] **Step 2: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-linkwarden.nix`
- [ ] **Step 3: Commit**
    ```bash
    git add temp_mynixos/modules/apps/service-app-linkwarden.nix
    git commit -m "harden: linkwarden secrets and sandboxing"
    ```

### Task 5: Harden Filebrowser

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-filebrowser.nix`

- [ ] **Step 1: Apply hardening changes**
    - Replace `/var/lib/filebrowser` with `${config.my.configs.paths.stateDir}/filebrowser`.
    - Add `OOMScoreAdjust = 300;`.
- [ ] **Step 2: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-filebrowser.nix`
- [ ] **Step 3: Commit**
    ```bash
    git add temp_mynixos/modules/apps/service-app-filebrowser.nix
    git commit -m "harden: filebrowser paths and OOM score"
    ```

### Task 6: Harden Readeck

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-readeck.nix`

- [ ] **Step 1: Apply hardening changes**
    - Change `ProtectSystem` to `"strict"`.
    - Add `StateDirectory = "readeck";`.
- [ ] **Step 2: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-readeck.nix`
- [ ] **Step 3: Commit**
    ```bash
    git add temp_mynixos/modules/apps/service-app-readeck.nix
    git commit -m "harden: readeck sandboxing"
    ```

### Task 7: Harden Monica

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-monica.nix`

- [ ] **Step 1: Apply hardening changes**
    - Add `after = [ "postgresql.service" ];`.
    - Replace `/var/lib/monica` with `${config.my.configs.paths.stateDir}/monica`.
    - Update `activationScripts`.
    - Add `OOMScoreAdjust = 300;`.
- [ ] **Step 2: Syntax check**
    Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-monica.nix`
- [ ] **Step 3: Commit**
    ```bash
    git add temp_mynixos/modules/apps/service-app-monica.nix
    git commit -m "harden: monica paths and dependencies"
    ```
