# Final Cleanup Plan (NixHome v6.1)

This plan consolidates the remaining "Medium" priority cleanup tasks and automation scripts required to finalize the NixHome v6.1 hardening phase.

## Phase A: Hardcoded Paths (SSoT Migration)

| Module | Target Value | SSoT Replacement |
| :--- | :--- | :--- |
| `monica.nix` | `/var/lib/monica` | `config.my.configs.paths.stateDir + "/monica"` |
| `vpn-live-config.nix` | `91.148.237.38`, `100.64.3.155` | `config.my.configs.vpn.privado` (defined in `configs.nix`) |
| `automation.nix` | `/run/current-system/sw/bin/nixos-rebuild` | Use `${pkgs.nixos-rebuild}/bin/nixos-rebuild` for absolute reference. |
| `lidarr.nix` | `/var/lib/lidarr` (MediaCover) | `config.my.media.lidarr.metadataDir` |

## Phase B: NIXMETA Automation Scripts

Leverage the JSON-in-Comments standard (defined in `docs/NIXMETA_JSON_SPEC.md`) to build the following tools:

1.  **Script A: `dependency-graph-builder.nix`**
    *   **Goal**: A pure-Nix derivation that reads the `repo_v5` tree, extracts JSON blocks using `builtins.match`, and generates a `flake-graph.json` artifact.
    *   **Logic**: Use `lib.filesystem.listFilesRecursive` and `builtins.fromJSON`.
2.  **Script B: `header-updater` (Shell Wrapper)**
    *   **Goal**: A CLI utility to batch-update `last_reviewed` timestamps across multiple modules.
    *   **Reference**: See `conductor/NIXMETA_AUTOMATION_DESIGN.md` for extraction regex patterns.

## Phase C: flake.lock (CRITICAL USER ACTION)

The `flake.lock` file is currently inconsistent with the `flake.nix` input declarations (`impermanence`, `mcp-nixos`). This prevents successful builds.

**Required Command:**
```powershell
cd repo_v5
nix flake lock
```
*Note: This must be executed on a machine with a working Nix installation (e.g., the target Q958 or a Nix-enabled VM).*
