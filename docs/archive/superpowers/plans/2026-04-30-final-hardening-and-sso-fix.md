# Final Hardening & SSO-Bypass Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Close all remaining critical security gaps (SSO-Bypass, Public Registration, Port Collisions, IPv6 Parity) to achieve a production-ready "Aviation-Grade" state.

**Architecture:** Surgical removal of IP-based bypasses in favor of strict OIDC/mTLS, centralization of port mappings to prevent service failure, and enforcement of IPv6 parity in firewall rules.

**Tech Stack:** NixOS, NFTables, Caddy (sso_auth), Sops-nix.

---

### Task 1: Clean Homepage SSO-Bypass

**Files:**
- Modify: `temp_mynixos/modules/services/homepage.nix`

- [ ] **Step 1: Remove any residual Tailscale matchers**
Ensure that *only* `import sso_auth` is used for the virtualHost, with no `@tailscale` or IP-based exclusions.

```nix
# Find and ensure this structure:
    services.caddy.virtualHosts."${host}" = {
      extraConfig = ''
        import sso_auth
        reverse_proxy 127.0.0.1:${toString config.my.ports.homepage}
      '';
    };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/services/homepage.nix
git commit -m "fix(security): remove all IP-based SSO bypasses for dashboard"
```

---

### Task 2: Lock Pocket-ID Registration

**Files:**
- Modify: `temp_mynixos/modules/services/pocket-id.nix`

- [ ] **Step 1: Enforce public_registration = false**
Even if present, ensure it is not overridden elsewhere and explicitly set.

```nix
      settings = {
        public_registration = false;
        # ... rest
      };
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/services/pocket-id.nix
git commit -m "fix(security): strictly disable public registration in Pocket-ID"
```

---

### Task 3: Deactivate OliveTin (High Risk)

**Files:**
- Modify: `temp_mynixos/profiles/automation-apps.nix`

- [ ] **Step 1: Disable OliveTin service**
Set the enable flag to `false` to mitigate RCE risks until a custom hardened config is verified.

```nix
  my.services.olivetin.enable = false;
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/profiles/automation-apps.nix
git commit -m "chore(security): deactivate OliveTin until audit is complete"
```

---

### Task 4: Resolve High-Priority Port Collisions

**Files:**
- Modify: `temp_mynixos/modules/core/ports.nix`

- [ ] **Step 1: Update conflicting ports**
Shift services to free up 8080, 8081, 8082, 8083, and 3001/3002.

```nix
      # 10-Infrastructure
      pocketId = 8089;
      adguard = 3004;
      
      # 30-Media
      sabnzbd = 8081; # Keep or move if 8081 is taken by legacy
      
      # 50-Apps
      monica = 8087;
      
      # 80-Monitoring
      uptimeKuma = 3005;
      scrutiny = 8088;
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/ports.nix
git commit -m "refactor(network): resolve port collisions for web-services"
```

---

### Task 5: IPv6 Parity & Logging

**Files:**
- Modify: `temp_mynixos/modules/core/firewall.nix`

- [ ] **Step 1: Expand IPv6 Geoblock & Rules**
Ensure WAN IPv6 is blocked for port 443 and only LAN/Tailscale is allowed.

```nix
      logRefusedConnections = true;
      extraInputRules = ''
        # ...
        tcp dport 443 ip6 saddr != { ::1/128, fe80::/10, ${config.my.configs.network.tailscaleIpv6Prefix or "fd7a:115c:a1e0::/48"} } counter drop
        # ...
      '';
```

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/core/firewall.nix
git commit -m "fix(security): achieve IPv6 parity and enable connection logging"
```

---

### Task 6: Final Secrets Inventory

**Files:**
- Create/Update: `temp_mynixos/secrets/secrets.yaml.example`

- [ ] **Step 1: Document required secrets**
Provide a template for the user to fill in manually.

```yaml
# secrets.yaml template
user_password: ""
freund_password: ""
restic_password: ""
backblaze_key_id: ""
backblaze_application_key: ""
```
