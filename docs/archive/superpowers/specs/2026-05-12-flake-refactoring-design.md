# Design Spec: Flake Parametrization (Task 10.3)

**Status:** Draft
**Date:** 2026-05-12
**Task ID:** `DEBT-03` / `Task 10.3`

## 1. Problem Statement
The current `flake.nix` instantiates `myLib` at the top level of the `outputs` function using a hardcoded `x86_64-linux` package set. This causes issues if the configuration is ever used for a different architecture (e.g., `aarch64-linux`), as `myLib` would still attempt to use x86 packages.

## 2. Proposed Design
We will refactor the `outputs` section to define a factory function for `myLib`.

### 2.1 Changes to `flake.nix`
- Remove the top-level `myLib` assignment.
- Define `mkMyLib = system: ...`.
- Update `nixosConfigurations` to pass the correctly instantiated `myLib` via `specialArgs`.

### 2.2 Code Example
```nix
outputs = { self, nixpkgs, ... }@inputs: let
  mkMyLib = system: import ./modules/core/lib-helpers.nix { 
    inherit (nixpkgs) lib; 
    pkgs = nixpkgs.legacyPackages.${system}; 
  };
in {
  nixosConfigurations.nixhome = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { 
      inherit inputs; 
      myLib = mkMyLib "x86_64-linux"; 
    };
    modules = [ ... ];
  };
};
```

## 3. Success Criteria
- System builds successfully for `nixhome`.
- `myLib` is accessible within modules as before.
- No hardcoded architecture strings remain in the global scope of `flake.nix` outputs.

## 4. Risks & Mitigations
- **Risk:** Type errors in `lib-helpers.nix`.
- **Mitigation:** Ensure `pkgs` passed to `lib-helpers.nix` matches the host architecture.
