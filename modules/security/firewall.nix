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
            # FW-01 FIX: Bound to Caddy UID (assuming 'caddy' user)
            iif "lo" accept
            ip daddr 127.0.0.2 meta skuid caddy accept

            # 3. Allow ICMP (Ping)
            ip protocol icmp accept
            ip6 nexthdr icmpv6 accept

            # 4. GEO-BLOCKING (The "Stealth" Shield)
            # Only allow traffic from specified countries for ports 80/443
            # We allow LAN/Private IPs via the set elements above
            tcp dport { 80, 443 } ip saddr != @allowed_countries counter drop
            tcp dport { 80, 443 } ip6 saddr != @allowed_countries_v6 counter drop

            # 4b. TOR-BLOCKING (FW-04 FIX)
            ip saddr @tor_exit_nodes counter drop

            # 5. Global SSH Protection (Tailscale Only)
            iifname "tailscale0" tcp dport 22 accept
            
            # 6. Log & Drop anything else
            counter log prefix "NFT_DROP: " drop
          }

          set tor_exit_nodes {
            type ipv4_addr
            flags interval
          }
        }
      '';
    };

    # 🔄 GEO-IP SET UPDATER
    systemd.services.update-geoip-sets = {
      description = "Update nftables Geo-IP and Tor sets";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      path = with pkgs; [ curl nftables gawk ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "update-geoip" ''
          set -e
          echo "Fetching Geo-IP zones for: ${toString cfg.allowedCountries}..."
          
          # Create temporary files for the new sets
          WORKDIR=$(mktemp -d)
          trap 'rm -rf "$WORKDIR"' EXIT

          IPV4_ZONE="$WORKDIR/ipv4.zone"
          IPV6_ZONE="$WORKDIR/ipv6.zone"
          TOR_ZONE="$WORKDIR/tor.zone"

          # FW-03 FIX: Use HTTPS and --fail
          for country in ${lib.concatStringsSep " " cfg.allowedCountries}; do
            echo "Downloading $country (v4)..."
            curl -s --fail "https://www.ipdeny.com/ipblocks/data/countries/$country.zone" >> "$IPV4_ZONE"
            echo "Downloading $country (v6)..."
            curl -s --fail "https://www.ipdeny.com/ipv6/ipaddresses/blocks/$country.zone" >> "$IPV6_ZONE"
          done

          # FW-04 FIX: Fetch Tor Exit Nodes
          echo "Downloading Tor exit nodes..."
          curl -s --fail "https://check.torproject.org/exit-addresses" | grep ExitAddress | awk '{print $2}' > "$TOR_ZONE"

          # FW-02 FIX: Atomic update using a single nft file
          echo "Applying atomic nftables update..."
          
          # Prepare the nft transaction file
          NFT_CMD="$WORKDIR/update.nft"
          
          {
            echo "table inet filter {"
            
            # IPv4 Set
            echo "  set allowed_countries {"
            echo "    type ipv4_addr"
            echo "    flags interval"
            echo "    elements = { 127.0.0.1, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, $(cat "$IPV4_ZONE" | tr '\n' ',' | sed 's/,$//') }"
            echo "  }"

            # IPv6 Set
            echo "  set allowed_countries_v6 {"
            echo "    type ipv6_addr"
            echo "    flags interval"
            echo "    elements = { ::1, fe80::/10, $(cat "$IPV6_ZONE" | tr '\n' ',' | sed 's/,$//') }"
            echo "  }"

            # Tor Set
            echo "  set tor_exit_nodes {"
            echo "    type ipv4_addr"
            echo "    flags interval"
            echo "    elements = { $(cat "$TOR_ZONE" | tr '\n' ',' | sed 's/,$//') }"
            echo "  }"
            
            echo "}"
          } > "$NFT_CMD"

          nft -f "$NFT_CMD"
          echo "Geo-IP and Tor sets updated successfully."
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
