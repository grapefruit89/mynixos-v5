# 🔑 Secret Injection Guide (NixHome Hardened)

This guide explains how to populate your system secrets securely using SOPS and age encryption.

## 🚀 The Schema Advantage
We use a **Hardened Secret Schema** (`modules/core/secrets-schema.nix`). 
- **Immutable:** The list of allowed keys is fixed. 
- **Type-Safe:** Only registered keys are accepted by the configuration.
- **Audit-Ready:** Missing or unknown keys generate build-time warnings.

## 🛠️ Step-by-Step Injection

### 1. Initialize Age Keys
Ensure you have your private age key available. The public keys are already configured in `.sops.yaml`.

### 2. Prepare the Secret File
Copy the immutable template to your local secret file:
```bash
cp secrets/secrets.yaml.example secrets/secrets.yaml
```

### 3. Fill the Values (Plaintext phase - DANGER)
Open `secrets/secrets.yaml` in an editor and fill in your actual credentials.

**Password Hashing:**
For `user_password` and `freund_password`, generate hashes using:
```bash
mkpasswd -m sha-512 "DEIN_PASSWORT"
```

### 4. Encrypt via SOPS
Encrypt the file in-place before committing or deploying:
```bash
sops --encrypt --in-place secrets/secrets.yaml
```

### 5. Verification
Verify that the file is encrypted. It should look like a SOPS block, not plaintext.
```bash
cat secrets/secrets.yaml
```

### 6. Deployment
Run your standard deployment command:
```bash
nixos-rebuild switch --flake .#nixhome
```

---
⚠️ **WARNING:** Never commit `secrets.yaml` while it contains plaintext. The `.gitignore` is configured to protect you, but stay vigilant.
