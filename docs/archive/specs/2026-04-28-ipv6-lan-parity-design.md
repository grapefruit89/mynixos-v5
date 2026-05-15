# Design Doc: IPv6 LAN Parity for Firewall

## Problem
Currently, the IPv6 firewall rules for DNS and mDNS only allow localhost and link-local addresses. This deviates from the IPv4 configuration which allows the entire LAN CIDR. Specifically, the Tailscale/ULA range `fd7a:115c:a1e0::/48` is missing from the allowed IPv6 sources for these services.

## Goals
- Achieve parity between IPv4 and IPv6 LAN access for DNS (TCP/UDP 53) and mDNS (UDP 5353).
- Ensure consistent access for Tailscale and local ULA addresses.

## Proposed Changes
Modify `temp_mynixos/modules/core/firewall.nix`:
Update `extraInputRules` to include `fd7a:115c:a1e0::/48` in the `ip6 saddr` sets for ports 53 and 5353.

## Verification
- `nix-instantiate --parse temp_mynixos/modules/core/firewall.nix` to verify Nix syntax.
- Visual inspection to ensure symmetry with existing `allowed_countries` logic and IPv4 LAN rules.
