# NIXMETA JSON Specification (v6.1)

This document defines the JSON-in-Comments standard used for module traceability and automated metadata injection in the NixHome project.

## 1. Overview

NIXMETA allows embedding structured metadata directly into `.nix` files using a special comment block. This metadata is used for:
- SRE Audits (Last reviewed timestamps).
- Automated dependency graph generation.
- Metric collection (LoC, hash, size).

## 2. Block Syntax

Every NIXMETA-enabled module must include a block at the top of the file (or near the top):

```nix
# ---NIXMETA
# {
#   "id": "NIXH-00-CORE-001",
#   "title": "Module Title",
#   "description": "Short description",
#   "layer": 00,
#   "audit": {
#     "last_reviewed": "2026-05-12",
#     "complexity": 1
#   },
#   "metrics": {
#     "sha256": "...",
#     "size_bytes": 1234,
#     "lines_of_code": 42
#   }
# }
# ---ENDNIXMETA
```

### Constraints:
- The block must start with `# ---NIXMETA`.
- The block must end with `# ---ENDNIXMETA`.
- Every JSON line must be prefixed with `# `.

## 3. Automation Tools (Pure Bash + jq)

The project has transitioned away from Python-based injectors to a pure Bash + Nix pipeline.

### `update-headers.sh`
- **Location**: `scripts/nixmeta/update-headers.sh`
- **Dependency**: `jq`, `nix` (for `nix eval`).
- **Usage**:
  - Update a field: `./update-headers.sh last_reviewed 2026-05-12 'modules/core/*.nix'`
  - Recompute metrics: `./update-headers.sh METRICS recompute`
- **Logic**:
  1. Extracts the JSON block using `sed`.
  2. Parses and updates it using `jq`.
  3. (Optional) Recomputes `sha256`, `size_bytes`, and `lines_of_code` using `nix eval` (via `builtins.readFile` and string manipulation).
  4. Validates the resulting Nix file using `nix-instantiate --parse`.
  5. Replaces the block using `awk` in a pseudo-atomic manner.

### `dependency-graph-builder.nix`
- **Location**: `scripts/nixmeta/dependency-graph-builder.nix`
- **Nature**: Pure Nix.
- **Goal**: Reads all modules and generates a global metadata map.
- **Usage**: `nix eval --json -f scripts/nixmeta/dependency-graph-builder.nix`

## 4. Why De-Pythonize?

- **Zero External Dependencies**: Nix projects should ideally only depend on Nix and minimal standard tools (Bash, Coreutils).
- **Environment Consistency**: Removing Python eliminates the need for `python3` or specific libraries in the build/audit environment.
- **Nix-Native Metrics**: Computing file hashes and LoC via `nix eval` ensures that metrics are consistent with how Nix sees the files.
