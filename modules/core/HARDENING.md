# 🛡️ Core System Hardening (NixOS v6 Standard)

This document describes the implemented hardening measures for the core networking and IPC layers.

## 1. East-West Isolation (nftables)
We implement a "Zero-Trust Loopback" model to prevent lateral movement between services.

- **Admin Alias (`127.0.0.2`):** Administrative and backend services bind to this isolated loopback alias.
- **UID-Based Filtering:** `nftables` is configured to DROP any traffic targeting `127.0.0.2` unless the source process is `caddy` (UID 978).
- **Result:** Even if a frontend service (e.g., Jellyfin) is compromised, it cannot physically reach backend management tools (e.g., Portainer, Netdata) even though they share the same host.

## 2. IPC Hardening (Unix Sockets)
Network-based local communication (TCP) has been phased out in favor of Unix Domain Sockets where possible.

- **Database Zero-TCP:** PostgreSQL and Valkey have TCP listeners disabled (`port = 0`).
- **Filesystem Permissions:** Communication is governed by Linux file permissions (`u+rw, g+rw`). Services must be in the respective group (e.g., `postgres` or `redis`) to communicate.
- **Service Isolation:** `PrivateNetwork = true` is applied to database services, physically disconnecting them from the network stack.

## 3. Caddy Admin Hardening
The Caddy Admin API (`:2019`) has been moved to a Unix socket at `/run/caddy/admin.sock`.
- Prevents any local process from injecting or modifying proxy configurations via HTTP.

## 4. Trust Zones (SSoT)
Defined in `repo_v5/services-spec.nix`:
- `admin-mtls`: Requires hardware-bound mTLS (TPM-bound).
- `family-pocketid`: Requires PocketID Forward-Auth.
- `public`: No auth (limited use).

## 5. Safe TPM-LUKS Strategy (Disaster-Recovery Ready)
We use the TPM 2.0 chip for automatic, passwordless disk decryption, but strictly avoid a "lock-in" scenario by maintaining a secondary manual recovery path.

- **Primary Slot (TPM):** Bound to PCR 0+1+2+3+7 (Firmware, Bootloader, Secure Boot State). Automatically unlocks the system at boot.
- **Secondary Slot (Recovery):** A high-entropy 256-bit recovery key generated via `systemd-cryptenroll`.
- **Validation:** If the motherboard/TPM dies, the recovery key can be entered manually to decrypt the disk on any other machine.
- **Setup Command:**
  ```bash
  # 1. Generate Recovery Key (Store this safely!)
  sudo systemd-cryptenroll /dev/sdX --recovery-key
  # 2. Bind to TPM
  sudo systemd-cryptenroll /dev/sdX --tpm2-device=auto --tpm2-pcrs=0+1+2+3+7
  ```
- **NixOS Integration:** `boot.initrd.systemd.enable = true` is required to process the TPM/Recovery slots during the early boot phase.
