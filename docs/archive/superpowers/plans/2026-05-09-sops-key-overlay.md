# SOPS Key Overlay Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a read-only SOPS key schema and update related configuration and documentation to match a specific set of allowed keys.

**Architecture:** Use a dedicated Nix file (`secrets-schema.nix`) to define a `readOnly` option for allowed secret keys. Derive `sops.secrets` entries from this schema in `secrets.nix` to ensure strict enforcement.

**Tech Stack:** NixOS, sops-nix

---

### Task 1: Update secrets-schema.nix

**Files:**
- Modify: `modules/core/secrets-schema.nix`

- [ ] **Step 1: Update the schema attribute set**

Update the `schema` variable to contain exactly these keys:
`user_password, freund_password, cloudflare_token, github_token, restic_password, backblaze_access_key, backblaze_secret_key, paperless_secret_key, vaultwarden_env, sonarr_api_key, radarr_api_key, readarr_api_key`.

```nix
  schema = {
    # Identity
    user_password = "";
    freund_password = "";

    # Infrastructure
    cloudflare_token = "";
    github_token = "";
    
    # Automation & Apps
    paperless_secret_key = "";
    vaultwarden_env = "";
    
    # Media Stack
    sonarr_api_key = "";
    radarr_api_key = "";
    readarr_api_key = "";

    # Backup & Storage
    restic_password = "";
    backblaze_access_key = "";
    backblaze_secret_key = "";
  };
```

- [ ] **Step 2: Verify technical integrity marker**

Ensure the file still follows the project's technical integrity standards (checksum/eof_marker). I will let the project's existing markers be updated if they were present.

### Task 2: Verify secrets.nix

**Files:**
- Modify: `modules/core/secrets.nix`

- [ ] **Step 1: Check for removed key usage**

Review `modules/core/secrets.nix` to ensure no removed keys (`tailscale_token`, `unraid_root_password`, `n8n_enc_key`) are used in templates or other logic.
(Already checked: they are not used).

- [ ] **Step 2: Update templates if necessary**

The current templates look fine:
- `media-stack.env` uses `sonarr_api_key`, `radarr_api_key`.
- `caddy-env` uses `cloudflare_token`.
- `backblaze-restic.env` uses `backblaze_access_key`, `backblaze_secret_key`.

I will add a template for `paperless` and `vaultwarden` if they are in the schema but missing templates, or just leave it as is if they are used elsewhere. The user didn't explicitly ask for new templates, just the schema overlay.

### Task 3: Update INJECTION_GUIDE.md

**Files:**
- Modify: `secrets/INJECTION_GUIDE.md`

- [ ] **Step 1: Update key list in documentation**

Add a section or update existing one to list the required keys that must be present in `secrets.yaml`.

### Task 4: Final Validation

- [ ] **Step 1: Run nix-instantiate or similar to check for syntax errors**

Run: `nix-instantiate --parse modules/core/secrets-schema.nix`
Expected: Success

Run: `nix-instantiate --parse modules/core/secrets.nix`
Expected: Success

- [ ] **Step 2: Commit changes**

```bash
git add modules/core/secrets-schema.nix modules/core/secrets.nix secrets/INJECTION_GUIDE.md
git commit -m "feat(security): implement SOPS key overlay and read-only schema"
```
