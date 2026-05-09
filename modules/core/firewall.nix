{
 lib,
 config,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Shield)
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
 enable = true; # hardened: Firewall ALWAYS active.
 trustedInterfaces = [ "lo" "tailscale0" ];
 
 # 🛡️ GLOBAL PUBLIC PORTS
 # Nur HTTPS ist von außen erreichbar. Port 80 und SSH sind zu.
 allowedTCPPorts = [
 443 # HTTPS (Caddy Edge)
 ];

 # 📈 LAN-SPECIFIC RULES (DNS & Multicast)
 extraInputRules = ''
 # 🌍 GEO-IP ALLOWLIST (DE, AT, LT)
 # Dynamically updated via systemd timer from ipdeny.com
 # The included file uses 'add element inet filter geo_allowed { ... }'
 set geo_allowed {
 type ipv4_addr
 flags interval
 elements = { 
 127.0.0.1/32
 }
 }
 include "/var/lib/nftables/geoip-allowed.txt"

 # ========================================================================
 # RATE LIMITING – Token Bucket (Jellyfin & Audiobookshelf)
 # ========================================================================
 set protected_services {
 type inet_service
 elements = { ${toString config.my.ports.jellyfin}, ${toString config.my.ports.audiobookshelf} }
 }

 # Block aggressively if rate limit is exceeded (50/min, 20 burst)
 tcp dport @protected_services ct state new \
 meter burst_meter { ip saddr timeout 60s limit rate over 50/minute burst 20 packets } \
 log prefix "RATE-LIMIT: " counter drop

 # 🛡️ PUBLIC PORT PROTECTION
 # Block everything NOT from allowed countries on public port 443
 tcp dport 443 ip saddr != @geo_allowed log prefix "GEO-BLOCK: " counter drop

 # 🌍 IPv6 PROTECTION (WAN-Block)
 # Block all public IPv6 traffic to Port 443. 
 tcp dport 443 ip6 saddr != { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } counter drop

 # DNS Support für das LAN (AdGuard)
 ip saddr ${lanCidr} tcp dport 53 accept
 ip saddr ${lanCidr} udp dport 53 accept
 ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } tcp dport 53 accept
 ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } udp dport 53 accept
 
 # mDNS für lokale Auflösung
 ip saddr ${lanCidr} udp dport 5353 accept
 ip6 saddr { ::1/128, fe80::/10, fd7a:115c:a1e0::/48 } udp dport 5353 accept
 
 # ICMP (Ping)
 ip protocol icmp accept
 ip6 nexthdr icmpv6 accept
 '';

 # 🔍 INTRUSION DETECTION (H-09)
 # Log refused connections for auditing (Portscans, LAN Recon)
 logRefusedConnections = true;

 extraForwardRules = ''
 # 📺 MEDIA STACK SEGMENTATION (Phase 1)
 # 1. Allow traffic from media-ns to WAN (specific ports: 80, 443, 119, 563)
 iifname "veth-media" ip saddr ${config.my.configs.network.mediaSubnet} ip daddr != { 192.168.2.0/24, 127.0.0.1/32 } tcp dport { 80, 443, 119, 563 } accept
 
 # 2. Allow established/related traffic back to media-ns
 oifname "veth-media" ct state { established, related } accept

 # 3. Allow Inbound from Host (Caddy) to mediaSubnet
 oifname "veth-media" accept

 # 4. Explicitly drop anything else from veth-media to prevent leaks to LAN/Host
 iifname "veth-media" drop
 '';
 };

 networking.nftables.tables.media-nat = {
 family = "ip";
 content = ''
 chain postrouting {
 type nat hook postrouting priority 100;
 ip saddr ${config.my.configs.network.mediaSubnet} masquerade
 }
 '';
 };
 };
}
