# 🚀 System Onboarding Guide

## Overview
To ensure the system is not considered "Production Hardened" before the administrator has verified all initial settings (Secrets, Network, Backups), we use an assertion-based onboarding mechanism.

## The Onboarding Flag
The system uses a Nix-native option instead of a physical flag file.

### Status: Incomplete (Default)
By default, `my.system.onboardingComplete` is set to `false`. This will trigger a **warning** during every `nixos-rebuild`.

### Status: Complete
Once you have verified the following points, you should set the option to `true`:
- [ ] SOPS Secrets are successfully decrypted.
- [ ] Network zones (LAN/VPN) are reachable.
- [ ] Backup paths on `/persist` are configured.
- [ ] SSH access via Keys is verified.

## Configuration
Add the following line to your `configuration.nix`:

```nix
my.system.onboardingComplete = true;
```

If you are currently developing or debugging and want to suppress the warning without finalizing the state, enable the "Bastelmodus":

```nix
my.configs.bastelmodus = true;
```
