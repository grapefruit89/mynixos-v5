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
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 2;
    source_repo = "grapefruit89/mynixos";
  };

  # SSoT Integration
  sshPort = config.my.ports.ssh;
  lanCidr = config.my.configs.network.lanCidr;
  lanCidrV6 = config.my.configs.network.lanCidrV6;
  linkLocalV6 = config.my.configs.network.linkLocalV6;
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
      trustedInterfaces = [ "lo" "tailscale0" ];
      
      # 🛡️ GLOBAL PUBLIC PORTS
      # Nur HTTPS ist von außen erreichbar. Port 80 und SSH sind zu.
      allowedTCPPorts = [
        443 # HTTPS (Caddy Edge)
      ];

      # 📈 LAN-SPECIFIC RULES (DNS & Multicast)
      extraInputRules = ''
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

        # 🛡️ EAST-WEST ISOLATION (Zone: Admin Loopback)
        # Only Caddy is allowed to talk to the Admin Loopback Alias (127.0.0.2)
        # This prevents lateral movement from compromised apps (Nextcloud, etc.)
        ip daddr 127.0.0.2 meta skuid != caddy counter drop

        # 🛡️ DATABASE ISOLATION (Loopback Protection)
        # Block all local TCP access to Postgres/Valkey unless authorized.
        # Authorized: Caddy (Proxy), Postgres (Self), Redis (Self)
        tcp dport { 5432, 6379 } meta skuid != { caddy, postgres, redis } counter drop

        # Block everything NOT from allowed countries on public port 443
        tcp dport 443 ip saddr != @allowed_countries counter drop

        # 🌍 IPv6 PROTECTION (WAN-Block)
        # Block all public IPv6 traffic to Port 443. 
        # Only IPv4 (with Geoblock) is allowed from WAN.
        # LAN-IPv6 is still allowed via trustedInterfaces.
        tcp dport 443 ip6 saddr != { ::1/128, fe80::/10 } counter drop

        # DNS Support für das LAN (AdGuard)
        ip saddr ${lanCidr} tcp dport 53 accept
        ip saddr ${lanCidr} udp dport 53 accept
        ip6 saddr { ${lanCidrV6}, ${linkLocalV6} } tcp dport 53 accept
        ip6 saddr { ${lanCidrV6}, ${linkLocalV6} } udp dport 53 accept
        
        # mDNS für lokale Auflösung
        ip saddr ${lanCidr} udp dport 5353 accept
        ip6 saddr { ${lanCidrV6}, ${linkLocalV6} } udp dport 5353 accept
        
        # ICMP (Ping)
        ip protocol icmp accept
      '';

      # 🔍 INTRUSION DETECTION (H-09)
      # Log refused connections for auditing (Portscans, LAN Recon)
      logRefusedConnections = true;
    };
  };
}
