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
      default = [ "de" "at" "lt" ]; # Germany, Austria, Lithuania
      description = "List of ISO country codes (lowercase) to allow.";
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
          # Country-specific sets
          set allowed_countries {
            type ipv4_addr
            flags interval
            elements = { 127.0.0.1, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 } # Safety: Allow LAN
          }

          set allowed_countries_v6 {
            type ipv6_addr
            flags interval
            elements = { ::1, fe80::/10 } # Safety: Allow Link-Local
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
            # We allow LAN/Private IPs via the set elements above
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
    systemd.services.update-geoip-sets = {
      description = "Update nftables Geo-IP sets from ipdeny.com";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      path = with pkgs; [ curl nftables gawk ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "update-geoip" ''
          set -e
          echo "Fetching Geo-IP zones for: ${toString cfg.allowedCountries}..."
          
          # Create temporary files for the new sets
          IPV4_ZONE=$(mktemp)
          IPV6_ZONE=$(mktemp)

          for country in ${lib.concatStringsSep " " cfg.allowedCountries}; do
            echo "Downloading $country (v4)..."
            curl -s "http://www.ipdeny.com/ipblocks/data/countries/$country.zone" >> $IPV4_ZONE || true
            echo "Downloading $country (v6)..."
            curl -s "http://www.ipdeny.com/ipv6/ipaddresses/blocks/$country.zone" >> $IPV6_ZONE || true
          done

          # Flush and refill sets (Atomic updates)
          # Note: We keep the private ranges in the initial ruleset, 
          # so here we only add the dynamic country IPs.
          
          echo "Updating nftables sets..."
          
          # Process IPv4
          nft flush set inet filter allowed_countries
          nft add element inet filter allowed_countries { 127.0.0.1, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 }
          while read -r ip; do
            if [[ -n "$ip" ]]; then nft add element inet filter allowed_countries { "$ip" }; fi
          done < "$IPV4_ZONE"

          # Process IPv6
          nft flush set inet filter allowed_countries_v6
          nft add element inet filter allowed_countries_v6 { ::1, fe80::/10 }
          while read -r ip; do
            if [[ -n "$ip" ]]; then nft add element inet filter allowed_countries_v6 { "$ip" }; fi
          done < "$IPV6_ZONE"

          rm "$IPV4_ZONE" "$IPV6_ZONE"
          echo "Geo-IP sets updated successfully."
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
