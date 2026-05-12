# ---NIXMETA
# {
#   "id": "core/firewall",
#   "layer": "00-core",
#   "status": "active",
#   "hardware_specific": false,
#   "depends_on_capabilities": [
#     "network_configuration",
#     "uid_registry"
#   ],
#   "provides_capabilities": [
#     "zero_trust_outbound_filtering"
#   ],
#   "obsidian_tags": [
#     "firewall",
#     "nftables",
#     "core"
#   ],
#   "last_reviewed": "2026-05-12"
# }
# ---ENDNIXMETA
{
  lib,
  config,
  ...
}: let
  # SSoT Integration
  sshPort = config.my.ports.ssh;
  lanCidr = config.my.configs.network.lanCidr;
  lanCidrV6 = config.my.configs.network.lanCidrV6;
  linkLocalV6 = config.my.configs.network.linkLocalV6;
in {
  options.my.security.firewall = {
    enable = lib.mkEnableOption "Hardened Nftables Firewall with Geo-Blocking";
    allowedCountries = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "de" "at" "lt" ];
      description = "List of ISO country codes (lowercase) to allow.";
    };
    blockTor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable kernel-level blocking of Tor exit nodes.";
    };
  };

  options.my.meta.firewall = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for firewall module";
  };

  config = {
    # 🛰️ LOOPBACK ALIAS (Zone: Admin)
    networking.interfaces.lo.ipv4.addresses = [
      { address = "127.0.0.1"; prefixLength = 8; }
      { address = "127.0.0.2"; prefixLength = 32; }
    ];

    networking.nftables.enable = true;
    networking.firewall = {
      enable = true; # Aviation-Grade: Firewall ALWAYS active.
      trustedInterfaces = [ "lo" ];
      
      # 🛡️ GLOBAL PUBLIC PORTS
      allowedTCPPorts = [
        443 # HTTPS (Caddy Edge)
      ];

      # 📈 LAN-SPECIFIC RULES (DNS & Multicast)
      extraInputRules = let
        u = config.my.users.registry;
        cfg = config.my.security.firewall;
      in ''
        # 🌍 DYNAMIC SETS (Populated by update-geoip-sets)
        set allowed_countries {
          type ipv4_addr; flags interval
        }
        set allowed_countries_v6 {
          type ipv6_addr; flags interval
        }
        set tor_exit_nodes {
          type ipv4_addr; flags interval
        }
        set tor_exit_nodes_v6 {
          type ipv6_addr; flags interval
        }

        # 🛡️ GLOBAL RATE LIMITING
        # Port 443 limit: 60/min (Dual-Stack)
        tcp dport 443 ct state new meter https_meter { ip saddr limit rate over 60/minute burst 20 packets } counter drop
        tcp dport 443 ct state new meter https_meter_v6 { ip6 saddr limit rate over 60/minute burst 20 packets } counter drop
        
        # SSH port limit: 5/min (Dual-Stack Parity)
        tcp dport ${toString sshPort} ct state new meter ssh_meter { ip saddr limit rate over 5/minute burst 5 packets } counter drop
        tcp dport ${toString sshPort} ct state new meter ssh_meter_v6 { ip6 saddr limit rate over 5/minute burst 5 packets } counter drop

        # 🛡️ EAST-WEST ISOLATION (Zone: Admin Loopback)
        # Only Caddy is allowed to talk to the Admin Loopback Alias (127.0.0.2)
        ip daddr 127.0.0.2 meta skuid != ${toString u.caddy} counter drop

        # 🛡️ DATABASE ISOLATION (Loopback Protection)
        # Authorized: Caddy (Proxy), Postgres (Self), Valkey (Self)
        tcp dport { 5432, 6379 } meta skuid != { ${toString u.caddy}, ${toString u.postgresql}, ${toString u.valkey} } counter drop

        # 🌍 GEOBLOCK PROTECTION (DE, AT, LT for public ports)
        # Block everything NOT from allowed countries on public port 443 (Dual-Stack Parity)
        tcp dport 443 ip saddr != @allowed_countries counter drop
        tcp dport 443 ip6 saddr != @allowed_countries_v6 counter drop

        # 🛡️ TOR-BLOCKING (Decision FW-03)
        ${lib.optionalString cfg.blockTor ''
          ip saddr @tor_exit_nodes counter drop
          ip6 saddr @tor_exit_nodes_v6 counter drop
        ''}

        # SSH Support für das LAN (Custom Port - Dual-Stack)
        ip saddr ${lanCidr} tcp dport ${toString sshPort} accept
        ip6 saddr ${lanCidrV6} tcp dport ${toString sshPort} accept

        # DNS Support für das LAN (Blocky)
        ip saddr ${lanCidr} { tcp, udp } dport 53 accept
        ip6 saddr ${lanCidrV6} { tcp, udp } dport 53 accept

        # mDNS für lokale Auflösung
        ip saddr ${lanCidr} udp dport 5353 accept
        ip6 saddr { ${lanCidrV6}, ${linkLocalV6} } udp dport 5353 accept
        
        # ICMP/ICMPv6 (Harden ND/DoS)
        ip protocol icmp accept
        # ICMPv6: Limit rate for non-critical types to prevent ND-DoS
        icmpv6 type { 
          destination-unreachable, 
          packet-too-big, 
          time-exceeded, 
          parameter-problem, 
          echo-request, 
          echo-reply,
          nd-router-solicit,
          nd-router-advert,
          nd-neighbor-solicit,
          nd-neighbor-advert
        } limit rate 20/second accept
      '';


      # 🛡️ ZERO-TRUST OUTBOUND FILTERING (ADR 005)
      # Blocks all outbound traffic from apps (2000-2999) by default.
      # Whitelist strategy for metadata and required external APIs.
      extraCommands = let
        u = config.my.users.registry;
      in ''
        # We use a custom table for outbound to not interfere with standard NixOS rules
        nft 'add table inet outbound_filter'
        nft 'add chain inet outbound_filter output { type filter hook output priority 0; policy drop; }'
        nft 'flush chain inet outbound_filter output'

        # 1. Allow System (UID < 2000) & Loopback
        nft 'add rule inet outbound_filter output meta skuid < 2000 accept'
        nft 'add rule inet outbound_filter output oifname "lo" accept'

        # 2. Whitelist: Caddy (ACME / Cloudflare API)
        nft 'add rule inet outbound_filter output meta skuid ${toString u.caddy} accept'

        # 3. Whitelist: Blocky (Upstream DNS over TLS)
        nft 'add rule inet outbound_filter output meta skuid ${toString u.blocky} tcp dport 853 accept'

        # 4. Whitelist: Media Streamers (Metadata APIs)
        # Includes: Jellyfin, Navidrome, Audiobookshelf
        nft 'add rule inet outbound_filter output meta skuid { ${toString u.jellyfin}, ${toString u.navidrome}, ${toString u.audiobookshelf} } accept'

        # 5. Whitelist: Arr-Stack (Indexer / Metadata)
        nft 'add rule inet outbound_filter output meta skuid { ${toString u.sonarr}, ${toString u.radarr}, ${toString u.prowlarr}, ${toString u.sabnzbd}, ${toString u.lidarr}, ${toString u.readarr} } accept'

        # 6. Whitelist: Monitoring & Management
        nft 'add rule inet outbound_filter output meta skuid { ${toString u.gatus}, ${toString u.uptime-kuma}, ${toString u.homepage} } accept'

        # Whitelist: Critical Backend
        # Matrix/Conduit, Vector (if needed), Restic (Backblaze)
        nft 'add rule inet outbound_filter output meta skuid { ${toString u.matrix}, ${toString u.vector} } accept'

        # 🌐 MEDIA NAMESPACE ISOLATION (Item 3)
        # Note: Services in 'media-ns' hit the outbound chain via their respective UIDs.
        # This centralized rule ensures that compromised media apps cannot bypass the DROP policy.
        nft 'add rule inet outbound_filter output meta skuid 2000-2999 counter log prefix "NFT_OUTBOUND_DROP: "'
        '';

      extraStopRules = ''
        nft delete table inet outbound_filter 2>/dev/null || true
      '';

      # 🔍 INTRUSION DETECTION (H-09)
      # Log refused connections for auditing (Portscans, LAN Recon)
      logRefusedConnections = true;
    };

    # 🔄 GEO-IP SET UPDATER
    systemd.services.update-geoip-sets = let
      cfg = config.my.security.firewall;
    in lib.mkIf cfg.enable {
      description = "Update nftables Geo-IP and Tor sets";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      path = with pkgs; [ curl nftables gawk sed ];
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
          TOR_ZONE_V6="$WORKDIR/tor_v6.zone"

          touch "$IPV4_ZONE" "$IPV6_ZONE" "$TOR_ZONE" "$TOR_ZONE_V6"

          for country in ${lib.concatStringsSep " " cfg.allowedCountries}; do
            echo "Downloading $country (v4)..."
            curl -s --fail "https://www.ipdeny.com/ipblocks/data/countries/$country.zone" >> "$IPV4_ZONE"
            echo "Downloading $country (v6)..."
            curl -s --fail "https://www.ipdeny.com/ipv6/ipaddresses/blocks/$country.zone" >> "$IPV6_ZONE"
          done

          # Fetch Tor Exit Nodes
          echo "Downloading Tor exit nodes..."
          TEMP_TOR="$WORKDIR/tor_raw.zone"
          curl -s --fail "https://check.torproject.org/exit-addresses" | grep ExitAddress | awk '{print $2}' > "$TEMP_TOR"
          
          # Split into v4 and v6
          grep -v ":" "$TEMP_TOR" > "$TOR_ZONE" || true
          grep ":" "$TEMP_TOR" > "$TOR_ZONE_V6" || true

          # Atomic update using a full ruleset snippet
          echo "Applying atomic nftables update..."
          
          NFT_CMD="$WORKDIR/update.nft"
          
          {
            echo "table inet filter {"
            
            # IPv4 Set
            echo "  set allowed_countries {"
            echo "    type ipv4_addr; flags interval;"
            echo "    elements = { 127.0.0.1, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, $(cat "$IPV4_ZONE" | tr '\n' ',' | sed 's/,$//') }"
            echo "  }"

            # IPv6 Set
            echo "  set allowed_countries_v6 {"
            echo "    type ipv6_addr; flags interval;"
            echo "    elements = { ::1, fe80::/10, $(cat "$IPV6_ZONE" | tr '\n' ',' | sed 's/,$//') }"
            echo "  }"

            # Tor Set (v4)
            echo "  set tor_exit_nodes {"
            echo "    type ipv4_addr; flags interval;"
            echo "    elements = { $(cat "$TOR_ZONE" | tr '\n' ',' | sed 's/,$//' | sed 's/^,//') }"
            echo "  }"

            # Tor Set (v6)
            echo "  set tor_exit_nodes_v6 {"
            echo "    type ipv6_addr; flags interval;"
            echo "    elements = { $(cat "$TOR_ZONE_V6" | tr '\n' ',' | sed 's/,$//' | sed 's/^,//') }"
            echo "  }"
            
            echo "}"
          } > "$NFT_CMD"

          # Use -f for atomic transaction
          if nft -f "$NFT_CMD"; then
            echo "✅ Geo-IP and Tor sets updated successfully."
          else
            echo "❌ Failed to apply atomic update."
            exit 1
          fi
        '';
      };
      startAt = "daily";
    };
  };
}
