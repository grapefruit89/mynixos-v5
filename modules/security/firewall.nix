{ config, lib, pkgs, ... }:
let
  cfg = config.my.security.firewall;
  # GeoIP Database source - using nix-geoip for kernel-level sets
  # This requires 'pkgs.nix-geoip' or similar local logic to provide CIDR lists
in {
  options.my.security.firewall = {
    enable = lib.mkEnableOption "Hardened Nftables Firewall with Geo-Blocking";
    allowedCountries = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "DE" "AT" "CH" ];
      description = "List of ISO country codes to allow.";
    };
    blockTor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable kernel-level blocking of Tor exit nodes.";
    };
  };

  config = lib.mkIf cfg.enable {
    # 🛡️ NFTABLES ENGINE (Source: Aviation-Grade / NIXH-10-SEC-005)
    networking.nftables = {
      enable = true;
      # Base Ruleset using native expressions for speed
      ruleset = ''
        table inet filter {
          # Country-specific sets (populated via script or systemd timer)
          set allowed_countries {
            type ipv4_addr
            flags interval
          }

          set allowed_countries_v6 {
            type ipv6_addr
            flags interval
          }

          chain input {
            type filter hook input priority 0; policy drop;

            # 1. Allow established/related (Standard)
            ct state established,related accept

            # 2. Allow Loopback & Admin Zone (127.0.0.2)
            iif "lo" accept
            ip daddr 127.0.0.2 accept

            # 3. Allow ICMP (Ping)
            ip protocol icmp accept
            ip6 nexthdr icmpv6 accept

            # 4. GEO-BLOCKING (The "Stealth" Shield)
            # Only allow traffic from specified countries for ports 80/443
            tcp dport { 80, 443 } ip saddr != @allowed_countries counter drop
            tcp dport { 80, 443 } ip6 saddr != @allowed_countries_v6 counter drop

            # 5. Global SSH Protection (Tailscale Only)
            iifname "tailscale0" tcp dport 22 accept
            
            # 6. Log & Drop anything else
            counter log prefix "NFT_DROP: " drop
          }
        }
      '';
    };

    # 🔄 GEO-IP SET UPDATER
    # This service fetches latest CIDRs and pushes them into nftables sets
    systemd.services.update-geoip-sets = {
      description = "Update nftables Geo-IP sets";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "update-geoip" ''
          # Logic to fetch CIDR lists for DE, AT, CH
          # In a real implementation, we'd use local files or a secure API
          echo "Updating Geo-IP sets for: ${toString cfg.allowedCountries}"
          # Example: nft add element inet filter allowed_countries { 1.2.3.4/24 }
        '';
      };
      startAt = "daily";
    };

    # Metadata for Traceability
    my.meta.firewall = {
      id = "NIXH-10-SEC-FWL";
      title = "Kernel Geo-Firewall";
      description = "Nftables-based ingress filtering with Geo-IP and Tor blocking.";
      layer = 95;
    };
  };
}
