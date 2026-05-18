# Flake Parametrization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Parametrize `myLib` instantiation in `repo_v5/flake.nix` to support multiple architectures.

**Architecture:** Replace static `myLib` variable with a factory function `mkMyLib` that takes `system` as an argument. Pass the specific instance via `specialArgs`.

**Tech Stack:** Nix

---

### Task 1: Refactor myLib to Factory Function

**Files:**
- Modify: `repo_v5/flake.nix`

- [ ] **Step 1: Replace static myLib with mkMyLib function**

Replace the existing `myLib` and `specialArgs` definitions.

**Old String:**
```nix
 outputs = { self, nixpkgs, ... }@inputs: let
 # 🏆 hardened System Library
 myLib = import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; pkgs = nixpkgs.legacyPackages.x86_64-linux; };
 
 # Standard-Args für alle Hosts
 specialArgs = { inherit inputs myLib; };
```

**New String:**
```nix
 outputs = { self, nixpkgs, ... }@inputs: let
 # 🏆 hardened System Library Factory (System Parametric)
 mkMyLib = system: import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; pkgs = nixpkgs.legacyPackages.${system}; };
```

- [ ] **Step 2: Update nixhome configuration to use the factory**

Update the `specialArgs` for the `nixhome` host.

**Old String:**
```nix
 nixhome = nixpkgs.lib.nixosSystem {
 system = "x86_64-linux";
 inherit specialArgs;
```

**New String:**
```nix
 nixhome = nixpkgs.lib.nixosSystem {
 system = "x86_64-linux";
 specialArgs = { inherit inputs; myLib = mkMyLib "x86_64-linux"; };
```

- [ ] **Step 3: Update example configuration (friendly documentation)**

Update the commented out `freund-pc` example to show the new pattern.

**Old String:**
```nix
 # freund-pc = nixpkgs.lib.nixosSystem {
 # system = "x86_64-linux";
 # inherit specialArgs;
 # modules = [
 # ./hardware/freund/hardware-configuration.nix
 # ./configuration.nix 
 # ];
 # };
```

**New String:**
```nix
 # freund-pc = nixpkgs.lib.nixosSystem {
 # system = "x86_64-linux";
 # specialArgs = { inherit inputs; myLib = mkMyLib "x86_64-linux"; };
 # modules = [
 # ./hardware/freund/hardware-configuration.nix
 # ./configuration.nix 
 # ];
 # };
```

- [ ] **Step 4: Verify syntax**

Run: `nix-instantiate --parse repo_v5/flake.nix`
Expected: Successful parse.

- [ ] **Step 5: Commit changes**

```bash
git add repo_v5/flake.nix
git commit -m "refactor: parametrize myLib in flake.nix (Task 10.3)"
```
