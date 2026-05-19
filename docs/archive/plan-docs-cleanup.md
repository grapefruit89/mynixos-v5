# Implementation Plan: Documentation Cleanup

## Objective
Consolidate `TODO_OPTIONAL.md` into `CURRENT_STATUS.md` and delete the redundant `TODO_OPTIONAL.md` file, as requested by the user. Keep all other root documentation files intact.

## Changes

1. **`docs/CURRENT_STATUS.md`**:
   - Append a new section `### ⚪ Optional (Nice-to-have)` at the bottom.
   - Add the tasks from `docs/TODO_OPTIONAL.md`:
     - `[ ] Guides 80,90,95,99: adr: [ADR-xxx] im Frontmatter ergänzen`
     - `[ ] Context7-IDs für offizielle Nixpkgs-Module (nixpkgs/nixos/modules/...)`
     - `[ ] GitHub-URLs der verwendeten Projekte in 'Externe Repositories' ergänzen`

2. **`docs/TODO_OPTIONAL.md`**:
   - Delete the file.

## Verification
- Use `git status` to ensure `TODO_OPTIONAL.md` is deleted and `CURRENT_STATUS.md` is modified.
- Commit the changes and push to `main`.
