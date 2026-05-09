# 🛡️ SOPS Secret Injection Guide

This guide explains how to populate your system secrets securely using SOPS and age encryption.

## 1. Prepare the Secret File
Copy the template to your local secret file:
```bash
cp secrets/secrets.yaml.example secrets/secrets.yaml
```

## 2. Fill the Values
Open `secrets/secrets.yaml` in an editor and fill in your actual credentials.

**Password Hashing:**
For `user_password` and `freund_password`, generate hashes using:
```bash
mkpasswd -m sha-512
```

## 3. Encrypt via SOPS
Encrypt the file in-place before committing or deploying:
```bash
sops --encrypt --in-place secrets/secrets.yaml
```

## 4. Verification
Verify that the file is encrypted. It should contain `sops` metadata and encrypted blocks.
```bash
cat secrets/secrets.yaml
```

---
⚠️ **WARNING:** Never commit `secrets.yaml` while it contains plaintext. The `.gitignore` is configured to protect you.
