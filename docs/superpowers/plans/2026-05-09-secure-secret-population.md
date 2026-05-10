# Secure Secret Population Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Establish a secure workflow for manual secret population using SOPS-Nix, ensuring all services have the required credentials while maintaining repository safety.

**Architecture:** We use SOPS-Nix with age encryption. The `secrets.yaml` file acts as the encrypted SSoT. We will create a template/example file for the user, verify the mapping in `modules/core/secrets.nix`, and provide a secure injection guide.

**Tech Stack:** NixOS, SOPS-Nix, age, PowerShell.

---

### Task 1: Create SOPS Template and Verify Directory Structure

**Files:**
- Create: `temp_mynixos/secrets/secrets.yaml.example`
- Verify: `temp_mynixos/secrets/`

- [ ] **Step 1: Ensure the secrets directory exists and is ignored by git (except examples)**

```powershell
if (!(Test-Path "temp_mynixos/secrets")) { New-Item -ItemType Directory "temp_mynixos/secrets" }
Add-Content "temp_mynixos/.gitignore" "`n/secrets/secrets.yaml"
```

- [ ] **Step 2: Create the secrets.yaml.example template**

```yaml
# temp_mynixos/secrets/secrets.yaml.example
# =============================================================================
# SECRET TEMPLATE - FILL AND ENCRYPT AS secrets.yaml
# =============================================================================

# Identity (Hashed Passwords)
user_password: ""
freund_password: ""

# Infrastructure
cloudflare_token: ""
github_token: ""
tailscale_token: ""
unraid_root_password: ""

# Automation & Apps
n8n_enc_key: ""
vaultwarden_env: ""
paperless_secret_key: ""

# Media Stack
sonarr_api_key: ""
radarr_api_key: ""
readarr_api_key: ""

# Backup & Storage
restic_password: ""
backblaze_access_key: ""
backblaze_secret_key: ""
```

- [ ] **Step 3: Commit the template**

```bash
git add temp_mynixos/secrets/secrets.yaml.example
git commit -m "docs: add secrets template and gitignore rule"
```

---

### Task 2: Service-Mapping Validation

**Files:**
- Modify: `temp_mynixos/modules/core/secrets.nix`
- Modify: `temp_mynixos/modules/apps/service-app-paperless.nix`
- Modify: `temp_mynixos/modules/apps/service-app-vaultwarden.nix`

- [ ] **Step 1: Verify all secret keys in modules/core/secrets.nix match the template**

Ensure the `secrets` attribute in `secrets.nix` matches the template keys exactly to prevent mapping errors.

- [ ] **Step 2: Wire Paperless secret to its module**

Modify `temp_mynixos/modules/apps/service-app-paperless.nix`:
```nix
# Find the config block for paperless
# Ensure it uses config.sops.secrets.paperless_secret_key.path
serviceConfig.EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;
# SRE-Fix: Add Paperless Secret Key as Environment variable if not in secretFile
environment.PAPERLESS_SECRET_KEY = config.sops.placeholder.paperless_secret_key;
```

- [ ] **Step 3: Wire Vaultwarden env to its module**

Modify `temp_mynixos/modules/apps/service-app-vaultwarden.nix`:
```nix
services.vaultwarden.environmentFile = config.sops.secrets.vaultwarden_env.path;
```

- [ ] **Step 4: Commit mapping fixes**

```bash
git add temp_mynixos/modules/core/secrets.nix temp_mynixos/modules/apps/
git commit -m "fix: synchronize secret mappings across modules"
```

---

### Task 3: Secure Injection Guide (Final Report)

**Files:**
- Create: `temp_mynixos/secrets/INJECTION_GUIDE.md`

- [ ] **Step 1: Write the step-by-step guide for the user to encrypt their secrets**

```markdown
# 🔑 Secret Injection Guide (Secure)

Follow these steps to populate your secrets without leaking them.

1. **Initialize Age Keys:**
   Ensure you have your private age key available.
   
2. **Copy Template:**
   `cp secrets/secrets.yaml.example secrets/secrets.yaml`
   
3. **Edit Secrets (Plaintext phase - DANGER):**
   Fill in your values in `secrets/secrets.yaml`. Do NOT commit yet.
   
4. **Encrypt via SOPS:**
   `sops --encrypt --in-place secrets/secrets.yaml`
   
5. **Verify Encryption:**
   Open the file and ensure values are encrypted blocks (not plaintext).
   
6. **Deploy:**
   Now you can run `nixos-rebuild switch`.
```

- [ ] **Step 2: Final Commit and Push**

```bash
git add temp_mynixos/secrets/INJECTION_GUIDE.md
git push origin main
```
