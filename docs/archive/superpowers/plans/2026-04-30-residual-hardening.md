# NixHome v5.0: Residual Hardening Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Finalize the NixHome v5.0 configuration by addressing critical security gaps, port collisions, and reliability issues identified in the forensic audit.

**Architecture:** Following the Horizontal Responsibility (v5.0) pattern. Changes are applied surgically to existing modules (firewall, backup, ports, services) to ensure consistency and maintainability.

**Tech Stack:** NixOS, nftables, Restic, Caddy, SOPS-nix.

---

### Task 1: Resolve Port Registry Collisions

**Files:**
- Modify: `temp_mynixos/modules/core/ports.nix`

- [ ] **Step 1: Assign unique ports**

Update the registry to eliminate collisions on `8080` and `3001`.

```nix
# temp_mynixos/modules/core/ports.nix
# ... inside the default set ...
    # 10-Infrastructure
    ssh = 53844;
    pocketId = 8089; # Changed from 8080
    postgres = 5432;
    adguard = 3004;
    mqtt = 1883;

    # ...
    sabnzbd = 8081; # Changed from 8080
    
    # ...
    monica = 8082; # Changed from 8080
    
    # ...
    scrutiny = 8083; # Changed from 8080
    uptimeKuma = 3002; # Changed from 3001
# ...
```

- [ ] **Step 2: Verify nix evaluation**

Run: `nix-instantiate --parse temp_mynixos/modules/core/ports.nix`
Expected: Successful parse (no syntax errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/ports.nix
git commit -m "fix(core): resolve port collisions in registry"
```

---

### Task 2: Implement IPv6 LAN Parity

**Files:**
- Modify: `temp_mynixos/modules/core/firewall.nix`

- [ ] **Step 1: Add IPv6 rules for DNS and mDNS**

Duplicate the IPv4 LAN restrictions for IPv6 to prevent unauthorized access from the local network.

```nix
# temp_mynixos/modules/core/firewall.nix:60-75 (approx)
    # DNS Support für das LAN (AdGuard)
    ip saddr ${lanCidr} tcp dport 53 accept
    ip saddr ${lanCidr} udp dport 53 accept
    ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } tcp dport 53 accept
    ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } udp dport 53 accept
    
    # mDNS für lokale Auflösung
    ip saddr ${lanCidr} udp dport 5353 accept
    ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } udp dport 5353 accept
```

- [ ] **Step 2: Verify nix evaluation**

Run: `nix-instantiate --parse temp_mynixos/modules/core/firewall.nix`
Expected: Successful parse.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/firewall.nix
git commit -m "feat(firewall): implement IPv6 LAN parity for DNS and mDNS"
```

---

### Task 3: Enhance Backup Validation

**Files:**
- Modify: `temp_mynixos/modules/core/backup.nix`

- [ ] **Step 1: Update size check logic**

Extend the `backupPrepareCommand` to include all critical data paths in the size validation.

```nix
# temp_mynixos/modules/core/backup.nix:48-55 (approx)
    # 🛡️ PRE-FLIGHT CHECK (SRE-Standard)
    backupPrepareCommand = ''
      # Validierung aller Pfate inkl. /persist und /var/lib/pocket-id
      DATA_SIZE=$(${pkgs.coreutils}/bin/du -sb /data/state /etc/nixos /persist /var/lib/pocket-id | ${pkgs.gawk}/bin/awk '{sum+=$1} END {print sum}')
      LIMIT=$(( ${toString maxSizeGB} * 1024 * 1024 * 1024 ))
      if [ "$DATA_SIZE" -gt "$LIMIT" ]; then
        echo "🚨 BACKUP ABGEBROCHEN: Datenmenge ($DATA_SIZE) > Limit ($LIMIT)!"
        exit 1
      fi
    '';
```

- [ ] **Step 2: Verify nix evaluation**

Run: `nix-instantiate --parse temp_mynixos/modules/core/backup.nix`
Expected: Successful parse.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/core/backup.nix
git commit -m "feat(backup): expand pre-flight size validation to critical paths"
```

---

### Task 4: Harden Gatus and Vector

**Files:**
- Modify: `temp_mynixos/modules/monitoring/gatus.nix`
- Modify: `temp_mynixos/modules/logging/vector-hdd.nix`

- [ ] **Step 1: Bind Gatus to Localhost**

```nix
# temp_mynixos/modules/monitoring/gatus.nix
# Change web address to 127.0.0.1
services.gatus.settings.web.address = "127.0.0.1";
```

- [ ] **Step 2: Implement Vector Log-Rotation**

Replace the placeholder with a functional logic to limit log size on the HDD.

```nix
# temp_mynixos/modules/logging/vector-hdd.nix
# Implement actual rotation logic (placeholder fix)
# ... inside rotation script ...
find /storage/logs -name "*.log" -type f -mtime +30 -delete
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/monitoring/gatus.nix temp_mynixos/modules/logging/vector-hdd.nix
git commit -m "refactor(monitor/log): harden gatus bind and implement log rotation"
```

---

### Task 5: Final Clean-up and Template Generation

**Files:**
- Create: `temp_mynixos/secrets/secrets.yaml.template`
- Modify: `temp_mynixos/configuration.nix`

- [ ] **Step 1: Remove phantom imports**

Ensure `configuration.nix` only imports existing files.

```nix
# temp_mynixos/configuration.nix
# Remove or comment out non-existent graphics.nix
# ./modules/core/graphics.nix 
```

- [ ] **Step 2: Create Secret Template**

Provide a clear template for the user to fill.

```yaml
# temp_mynixos/secrets/secrets.yaml.template
user_password: ""
freund_password: ""
restic_password: ""
backblaze_access_key: ""
backblaze_secret_key: ""
```

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/configuration.nix temp_mynixos/secrets/secrets.yaml.template
git commit -m "chore: cleanup configuration and add secrets template"
```
