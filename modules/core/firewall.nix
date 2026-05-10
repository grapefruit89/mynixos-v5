{
  lib,
  config,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Shield)
  nms = {
    id = "NIXH-00-COR-011";
    title = "Firewall (NFTables Secured)";
    description = "Hardened nftables setup. Only SSoT ports and trusted LAN segments allowed. No legacy port 22.";
    layer = 00;
    nixpkgs.category = "system/networking";
    capabilities = ["network/firewall" "security/nftables"];
    audit.last_reviewed = "2026-05-10";
    audit.complexity = 2;
    source_repo = "grapefruit89/mynixos";
  };

  # SSoT Integration
  sshPort = config.my.ports.ssh;
  lanCidr = config.my.configs.network.lanCidr;
in {
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
      # Nur HTTPS ist von außen erreichbar. Port 80 und SSH sind zu.
      allowedTCPPorts = [
        443 # HTTPS (Caddy Edge)
      ];

      # 📈 LAN-SPECIFIC RULES (DNS & Multicast)
      extraInputRules = let
        u = config.my.users.registry;
      in ''
        # 🌍 GEOBLOCK PROTECTION (DE, AT, LT for public ports)
        set allowed_countries {
          type ipv4_addr
          flags interval
          elements = { 
            # Deutschland, Österreich, Litauen IP-Ranges
            2.16.0.0/13, 2.160.0.0/11, 5.0.0.0/14, 5.144.0.0/13, # DE
            62.178.0.0/15, 77.116.0.0/14, # AT
            78.56.0.0/13, 82.135.128.0/17 # LT
          }
        }

        # Dynamic GeoIP Set (Decision N)
        set geo_allowed {
          type ipv4_addr
          flags interval
          elements = { 1.1.1.1/32, 9.9.9.9/32 } # Seed elements
        }

        # 🛡️ GLOBAL RATE LIMITING (Decision I)
        # Port 443 global limit: 60 new connections/min per IP
        tcp dport 443 ct state new meter https_meter { ip saddr limit rate over 60/minute burst 20 packets } counter drop
        # SSH port limit: 5 new connections/min per IP
        tcp dport ${toString sshPort} ct state new meter ssh_meter { ip saddr limit rate over 5/minute burst 5 packets } counter drop

        # 🛡️ EAST-WEST ISOLATION (Zone: Admin Loopback)
        # Only Caddy is allowed to talk to the Admin Loopback Alias (127.0.0.2)
        # This prevents lateral movement from compromised apps.
        ip daddr 127.0.0.2 meta skuid != ${toString u.caddy} counter drop

        # 🛡️ DATABASE ISOLATION (Loopback Protection)
        # Block all local TCP access to Postgres/Valkey unless authorized.
        # Authorized: Caddy (Proxy), Postgres (Self), Valkey (Self)
        tcp dport { 5432, 6379 } meta skuid != { ${toString u.caddy}, ${toString u.postgresql}, ${toString u.valkey} } counter drop

        # Block everything NOT from allowed countries or verified GeoIP on public port 443
        tcp dport 443 ip saddr != @allowed_countries ip saddr != @geo_allowed counter drop

        # 🌍 IPv6 PROTECTION (WAN-Block)
        # Block all public IPv6 traffic to Port 443. 
        # Only IPv4 (with Geoblock) is allowed from WAN.
        # LAN-IPv6 is still allowed via trustedInterfaces.
        tcp dport 443 ip6 saddr != { ::1/128, fe80::/10 } counter drop

        # SSH Support für das LAN (Custom Port)
        ip saddr ${lanCidr} tcp dport ${toString sshPort} accept

        # DNS Support für das LAN (Blocky)
        ip saddr ${lanCidr} tcp dport 53 accept
        ip saddr ${lanCidr} udp dport 53 accept
        
        # mDNS für lokale Auflösung
        ip saddr ${lanCidr} udp dport 5353 accept
        
        # ICMP (Ping)
        ip protocol icmp accept
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

        # 7. Whitelist: Critical Backend
        # Matrix/Conduit, Vector (if needed), Restic (Backblaze)
        nft 'add rule inet outbound_filter output meta skuid { ${toString u.matrix}, ${toString u.vector} } accept'
        
        # Log dropped packets for debugging (Phase 6A fallback)
        nft 'add rule inet outbound_filter output meta skuid 2000-2999 counter log prefix "NFT_OUTBOUND_DROP: "'
      '';

      extraStopRules = ''
        nft delete table inet outbound_filter 2>/dev/null || true
      '';

      # 🔍 INTRUSION DETECTION (H-09)
      # Log refused connections for auditing (Portscans, LAN Recon)
      logRefusedConnections = true;
    };
  };
}
