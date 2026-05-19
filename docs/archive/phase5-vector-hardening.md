# Implementation Plan: Systemd Hardening (Phase 5)

## Objective
Apply systemd hardening to `modules/services/vector.nix` as specified in Prompt 20 of Phase 5.

## Key Files & Context
- `modules/services/vector.nix`

## Implementation Steps
1. In `modules/services/vector.nix`, locate the `systemd.services.vector.serviceConfig` block.
2. Replace the entire block with the new hardened configuration provided in the prompt:
   - Sets strict protections (`ProtectSystem`, `ProtectHome`, `PrivateTmp`, `PrivateDevices`, `NoNewPrivileges`, `RestrictNamespaces`, `LockPersonality`, `MemoryDenyWriteExecute`).
   - Clears capabilities (`CapabilityBoundingSet = []`, `AmbientCapabilities = []`).
   - Restricts address families to `AF_INET`, `AF_INET6`, `AF_UNIX`.
   - Filters system calls (`SystemCallFilter`).
   - Grants read-write access to `/var/log/vector` via `ReadWritePaths`.
3. Keep other parts of the file unchanged.
4. Commit the changes using the commit message: `fix(vector): add full systemd hardening`.

## Verification & Testing
- Use `git status` and `git diff` to verify the replacement occurred exactly as requested.
- Run `nix flake check` or `nixos-rebuild dry-run` to ensure syntax is correct, depending on later instructions.