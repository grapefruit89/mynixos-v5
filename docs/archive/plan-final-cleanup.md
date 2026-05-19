# Implementation Plan: Final Structural Cleanup

## Objective
Dissolve the `conductor/` directory and (optionally) the `scripts/security/` directory to achieve a flatter repository structure.

## Changes

1. **Dissolve `conductor/`:**
   - `conductor/plan-vulnix.md` -> `docs/archive/plan-vulnix.md`
   - Remove `conductor/` directory.

2. **Dissolve `scripts/security/` (Pending User Confirmation):**
   - `scripts/security/audit-security-score.sh` -> `scripts/`
   - `scripts/security/secrets-decryptor.sh` -> `scripts/`
   - `scripts/security/setup-luks-tpm.sh` -> `scripts/`
   - `scripts/security/setup-secrets-tpm.sh` -> `scripts/`
   - `scripts/security/sync-sops-keys.sh` -> `scripts/`
   - Remove `scripts/security/` directory.

## Verification
- Use `git mv` for all file moves.
- Verify directory removal.
- Commit and push.
