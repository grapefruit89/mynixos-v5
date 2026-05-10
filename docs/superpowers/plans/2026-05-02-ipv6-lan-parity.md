# IPv6 LAN Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable IPv6 LAN access for DNS and mDNS to match IPv4 configuration, ensuring Tailscale and local ULA addresses can access these services.

**Architecture:** Extend `my.configs.network` with an IPv6 LAN CIDR and update `firewall.nix` to include `ip6 saddr` rules for ports 53 and 5353.

**Tech Stack:** NixOS, nftables.

---

### Task 1: Add IPv6 LAN CIDR to Central Configs

**Files:**
- Modify: `repo_v5/modules/core/configs.nix`

- [ ] **Step 1: Add lanCidrV6 option**

```nix
<<<<
      tailnetCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "100.64.0.0/10" ];
        description = "Tailscale network range";
      });
    };
====
      tailnetCidrs = myLib.mkTracedOption "SRC-CHAT-878" (lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "100.64.0.0/10" ];
        description = "Tailscale network range";
      });
      lanCidrV6 = myLib.mkTracedOption "SRC-SPEC-FIREWALL" (lib.mkOption {
        type = lib.types.str;
        default = "fd7a:115c:a1e0::/48";
        description = "Trusted local IPv6 range (Tailscale/ULA)";
      });
    };
>>>>
```

- [ ] **Step 2: Commit changes**

```bash
git add repo_v5/modules/core/configs.nix
git commit -m "feat(config): add lanCidrV6 for IPv6 firewall parity"
```

---

### Task 2: Implement IPv6 Firewall Rules

**Files:**
- Modify: `repo_v5/modules/core/firewall.nix`

- [ ] **Step 1: Update SSoT Integration to include lanCidrV6**

```nix
<<<<
  # SSoT Integration
  sshPort = config.my.ports.ssh;
  lanCidr = config.my.configs.network.lanCidr;
in {
====
  # SSoT Integration
  sshPort = config.my.ports.ssh;
  lanCidr = config.my.configs.network.lanCidr;
  lanCidrV6 = config.my.configs.network.lanCidrV6;
in {
>>>>
```

- [ ] **Step 2: Add ip6 saddr rules to extraInputRules**

```nix
<<<<
        # DNS Support für das LAN (AdGuard)
        ip saddr ${lanCidr} tcp dport 53 accept
        ip saddr ${lanCidr} udp dport 53 accept
        
        # mDNS für lokale Auflösung
        ip saddr ${lanCidr} udp dport 5353 accept
====
        # DNS Support für das LAN (AdGuard)
        ip saddr ${lanCidr} tcp dport 53 accept
        ip saddr ${lanCidr} udp dport 53 accept
        ip6 saddr ${lanCidrV6} tcp dport 53 accept
        ip6 saddr ${lanCidrV6} udp dport 53 accept
        
        # mDNS für lokale Auflösung
        ip saddr ${lanCidr} udp dport 5353 accept
        ip6 saddr ${lanCidrV6} udp dport 5353 accept
>>>>
```

- [ ] **Step 3: Commit changes**

```bash
git add repo_v5/modules/core/firewall.nix
git commit -m "feat(firewall): add IPv6 LAN parity for DNS and mDNS"
```

---

### Task 3: Verification

- [ ] **Step 1: Verify Nix syntax**

Run: `nix-instantiate --parse repo_v5/modules/core/configs.nix repo_v5/modules/core/firewall.nix`
Expected: Successfully parsed paths.

- [ ] **Step 2: Visual inspection**

Verify that `ip6 saddr ${lanCidrV6}` correctly follows the pattern of `ip saddr ${lanCidr}` in `firewall.nix`.
Check that no other services are inadvertently exposed.
