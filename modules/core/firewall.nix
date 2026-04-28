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
in {
  options.my.meta.firewall = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for firewall module";
  };

  config = {
    networking.nftables.enable = true;
    networking.firewall = {
      enable = true; # Aviation-Grade: Firewall ALWAYS active.
      trustedInterfaces = [ "lo" "tailscale0" ];
      
      # 🛡️ GLOBAL PUBLIC PORTS
      allowedTCPPorts = [
        80  # HTTP Redirect
        443 # HTTPS (Caddy Edge)
        sshPort # Custom SSH (SSoT)
      ];

      # 📈 LAN-SPECIFIC RULES (DNS & Multicast)
      extraInputRules = ''
        # 🌍 GEOBLOCK PROTECTION (DE Only for public ports)
        # Definieren eines Sets für DE-IPs (Platzhalter, wird durch Script/Tool befüllt)
        # In der Praxis wird dieses Set oft dynamisch geladen.
        set allowed_countries {
          type ipv4_addr
          flags interval
          elements = { 
            # Deutschland IP-Ranges (Beispiel-Auszug)
            2.16.0.0/13, 2.160.0.0/11, 5.0.0.0/14, 5.144.0.0/13
            # Hinweis: In Produktion sollte hier ein geoip-update Service laufen
          }
        }

        # Block everything NOT from DE on public ports
        # Except for LAN/Tailscale which are already in trustedInterfaces
        tcp dport { 80, 443, ${toString sshPort} } ip saddr != @allowed_countries counter drop

        # DNS Support für das LAN (AdGuard)
        ip saddr ${lanCidr} tcp dport 53 accept
        ip saddr ${lanCidr} udp dport 53 accept
        
        # mDNS für lokale Auflösung
        ip saddr ${lanCidr} udp dport 5353 accept
        
        # ICMP (Ping)
        ip protocol icmp accept
      '';

      # 🔍 INTRUSION DETECTION (H-09)
      # Log refused connections for auditing (Portscans, LAN Recon)
      logRefusedConnections = true;
    };
  };
}
