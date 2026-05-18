# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-COR-FW-001",
#   "title": "Zero-Trust nftables Firewall",
#   "layer": 0,
#   "category": "core/network",
#   "lastReviewed": "2026-05-14",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 5,
#   "tags": ["firewall", "nftables", "security", "zero-trust"],
#   "description": "Hardened nftables configuration with UID-based outbound filtering and dual-stack parity."
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

  config = {
    # 🛰️ LOOPBACK ALIAS (Zone: Admin)
    networking.interfaces.lo.ipv4.addresses = [
      { address = "127.0.0.1"; prefixLength = 8; }
      { address = "127.0.0.2"; prefixLength = 32; }
    ];
    networking.interfaces.lo.ipv6.addresses = [
      { address = "::1"; prefixLength = 128; }
      { address = "::2"; prefixLength = 128; }
    ];

    # 🛡️ NFTABLES MASTERY (anchor: nftables-mastery)
    networking.nftables.enable = true;
    networking.firewall = {
      enable = true; # Production Hardened: Firewall ALWAYS active.
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
        # 🌍 DYNAMIC SETS (Populated by geoip-update service)
        set geo_allowed {
          type ipv4_addr; flags interval
        }
        set geo_allowed_v6 {
          type ipv6_addr; flags interval
        }
        set dc_blocked {
          type ipv4_addr; flags interval
        }
        set dc_blocked_v6 {
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
        # IPv6 Parity (H-07)
        tcp dport ${toString sshPort} ct state new meter ssh_meter_v6 { ip6 saddr limit rate over 5/minute burst 5 packets } counter drop

        # 🛡️ EAST-WEST ISOLATION (Zone: Admin Loopback)
        # Only Caddy is allowed to talk to the Admin Loopback Alias (127.0.0.2 / ::2)
        ip daddr 127.0.0.2 meta skuid != ${toString u.caddy} counter drop
        ip6 daddr ::2 meta skuid != ${toString u.caddy} counter drop

        # 🛡️ DATABASE ISOLATION (Loopback Protection)
        # Authorized: Caddy (Proxy), Postgres (Self), Valkey (Self)
        tcp dport { 5432, 6379 } meta skuid != { ${toString u.caddy}, ${toString u.postgresql}, ${toString u.valkey} } counter drop

        # 🌍 DEFENSIVE FILTERING (Layer 0)
        # 1. Block Datacenters (FireHOL / ipverse)
        tcp dport 443 ip saddr @dc_blocked counter drop
        tcp dport 443 ip6 saddr @dc_blocked_v6 counter drop

        # 2. Whitelist Countries (DE, AT, LT for public ports)
        # Block everything NOT from allowed countries on public port 443 (Dual-Stack Parity)
        tcp dport 443 ip saddr != @geo_allowed counter drop
        tcp dport 443 ip6 saddr != @geo_allowed_v6 counter drop

        # 🛡️ TOR-BLOCKING (Decision FW-03)
        ${lib.optionalString cfg.blockTor ''
          ip saddr @tor_exit_nodes counter drop
          ip6 saddr @tor_exit_nodes_v6 counter drop
        ''}

        # SSH Support für das LAN (Custom Port - Dual-Stack)
        ip saddr ${lanCidr} tcp dport ${toString sshPort} accept
        ip6 saddr ${lanCidrV6} tcp dport ${toString sshPort} accept

        # DNS Support für das LAN (Blocky) (anchor: lan-dns-support)
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

      # 🔍 INTRUSION DETECTION (H-09)
      # Log refused connections for auditing (Portscans, LAN Recon)
      logRefusedConnections = true;
    };

    # 🛡️ ZERO-TRUST OUTBOUND FILTER (KRIT-01: Persistent via native tables)
    networking.nftables.tables.outbound_filter = {
      family = "inet";
      content = let
        u = config.my.users.registry;
      in ''
        chain output {
          type filter hook output priority 0; policy drop;

          # 1. Allow System (UID < 2000) & Loopback
          meta skuid < 2000 accept
          oifname "lo" accept

          # 2. Whitelist: Caddy (ACME / Cloudflare API)
          meta skuid ${toString u.caddy} accept

          # 3. Whitelist: Blocky (Upstream DNS over TLS)
          meta skuid ${toString u.blocky} tcp dport 853 accept

          # 4. Whitelist: Media Streamers (Metadata APIs)
          meta skuid { ${toString u.jellyfin}, ${toString u.navidrome}, ${toString u.audiobookshelf} } accept

          # 5. Whitelist: Arr-Stack (Indexer / Metadata)
          meta skuid { ${toString u.sonarr}, ${toString u.radarr}, ${toString u.prowlarr}, ${toString u.sabnzbd}, ${toString u.lidarr}, ${toString u.readarr} } accept

          # 6. Whitelist: Monitoring & Management
          meta skuid { ${toString u.gatus}, ${toString u.uptime-kuma}, ${toString u.homepage} } accept

          # 7. Whitelist: Critical Backend
          meta skuid { ${toString u.matrix}, ${toString u.vector} } accept

          # 🌐 MEDIA NAMESPACE ISOLATION
          meta skuid 2000-2999 counter log prefix "NFT_OUTBOUND_DROP: " drop
        }
      '';
    };
  };
}
