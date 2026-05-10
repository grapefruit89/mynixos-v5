# IPv6 LAN Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Duplicate IPv4 LAN restrictions for IPv6 in the firewall to allow Tailscale and local ULA access to DNS and mDNS.

**Architecture:** Update existing nftables `extraInputRules` to include the `fd7a:115c:a1e0::/48` CIDR for IPv6 LAN parity.

**Tech Stack:** NixOS, nftables

---

### Task 1: Update Firewall Rules

**Files:**
- Modify: `temp_mynixos/modules/core/firewall.nix`

- [ ] **Step 1: Verify current failure (Nix Parsing)**
Run: `nix-instantiate --parse temp_mynixos/modules/core/firewall.nix`
Expected: PASS (The file should currently parse correctly).

- [ ] **Step 2: Implement the IPv6 LAN Parity**
Update the `ip6 saddr` sets for ports 53 and 5353 to include `fd7a:115c:a1e0::/48`.

```nix
<<<<
    # DNS Support für das LAN (AdGuard)
    ip saddr ${lanCidr} tcp dport 53 accept
    ip saddr ${lanCidr} udp dport 53 accept
    ip6 saddr { ::1/128, fe80::/10 } tcp dport 53 accept
    ip6 saddr { ::1/128, fe80::/10 } udp dport 53 accept
    
    # mDNS für lokale Auflösung
    ip saddr ${lanCidr} udp dport 5353 accept
    ip6 saddr { ::1/128, fe80::/10 } udp dport 5353 accept
====
    # DNS Support für das LAN (AdGuard)
    ip saddr ${lanCidr} tcp dport 53 accept
    ip saddr ${lanCidr} udp dport 53 accept
    ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } tcp dport 53 accept
    ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } udp dport 53 accept
    
    # mDNS für lokale Auflösung
    ip saddr ${lanCidr} udp dport 5353 accept
    ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } udp dport 5353 accept
>>>>
```

- [ ] **Step 3: Verify the changes (Nix Parsing)**
Run: `nix-instantiate --parse temp_mynixos/modules/core/firewall.nix`
Expected: PASS

- [ ] **Step 4: Commit the change**
Run: `git add temp_mynixos/modules/core/firewall.nix`
Run: `git commit -m "feat(firewall): implement IPv6 LAN parity for DNS and mDNS"`
