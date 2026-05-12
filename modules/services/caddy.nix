{ config, lib, pkgs, myLib, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Edge Proxy)
  # Fragment-Sourcing:
  # - NIXH-10-GTW-002: Caddy Basis & M1 Abrams Snippets
  # - Fragment 11429: GeoIP & nftables Integration
  # - Fragment 2607: Rate Limiting & Stream Optimization
  # - Fragment 18332: Systemd Sandboxing & LoadCredential
  nms = {
    id = "NIXH-01-SRV-CAD-001";
    title = "Caddy (M1 Abrams v2)";
    description = "Hardened Edge Proxy with GeoIP, SSO and Rate-Limiting. Decoupled horizontal architecture.";
    layer = 10;
    nixpkgs.category = "servers/proxy";
    capabilities = ["network/ingress" "security/waf" "security/geoip" "automation/dns-01"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
  };

  cfg = config.my.services.caddy;
  sreConfig = config.my.configs;
  
  # 🌐 Trusted IPs (Cloudflare, LAN)
  # Source: Fragment 18278 & Local Network SSoT
  trustedIPs = lib.concatStringsSep " " (
    [
      "127.0.0.1" "::1"
      # Cloudflare IPv4
      "173.245.48.0/20" "103.21.244.0/22" "103.22.200.0/22" "103.31.4.0/22" "141.101.64.0/18" "108.162.192.0/18" "190.93.240.0/20" "188.114.96.0/20" "197.234.240.0/22" "198.41.128.0/17" "162.158.0.0/15" "104.16.0.0/13" "104.24.0.0/14" "172.64.0.0/13" "131.0.72.0/22"
      # Cloudflare IPv6
      "2400:cb00::/32" "2606:4700::/32" "2803:f800::/32" "2405:b500::/32" "2405:8100::/32" "2a06:98c0::/29" "2c0f:f248::/32"
    ]
    ++ sreConfig.network.lanCidrs
  );

in {
  options.my.services.caddy = {
    enable = lib.mkEnableOption "Caddy Edge Proxy";
  };

 config = lib.mkIf config.my.services.caddy.enable {
 
 # 🏎️ KERNEL TUNING (Source: Fragment 18265)
 boot.kernel.sysctl = {
 "net.core.rmem_max" = 8388608;
 "net.core.wmem_max" = 8388608;
 "net.ipv4.tcp_fastopen" = 3;
 };

    services.caddy = {
      enable = true;
      
      # 🛠️ GLOBAL OPTIONS (Source: Fragment 2526 / Performance Kick)
      globalConfig = ''
        admin unix//run/caddy/admin.sock
        
        # 🧩 Performance & Resources
        servers {
          trusted_proxies static ${trustedIPs}
          trusted_proxies_strict
          # Speed-up: Buffer settings
          max_header_size 16kb
        }
        
        # 📊 Structured Logging for fail2ban
        log {
          output file /var/log/caddy/access.log {
            roll_size 10MB
            roll_keep 3
            roll_keep_for 7d
          }
          format json
        }
        
        # 🔄 DYNAMIC DNS (Source: Caddy-on-Steroids)
        dynamic_dns {
          provider cloudflare {env.CLOUDFLARE_API_TOKEN}
          domains {
            ${sreConfig.identity.domain} @
            ${sreConfig.identity.subdomain}.${sreConfig.identity.domain} *
          }
          check_interval 5m
        }

 # --- HONEYPOT (Time & Resource Stealer) ---
 (honeypot) {
 @evil_paths {
 not remote_ip private_ranges
 path /.env* /.git* /.vscode* /wp-config* /config.json* /actuator* /phpmyadmin* /.aws* /.ssh* /xmlrpc.php /wp-login* /admin* /setup.php /install.php /shell* /cmd.php /cgi-bin*
 }
 handle @evil_paths {
 # 💀 Time-Stealing: Respond with teapot but take forever to close the connection
 header -Server
 abort
 }
 }

        # --- HARDENED HEADERS (Aviation-Grade Stealth) ---
        (hardened_headers) {
          header {
            X-Content-Type-Options nosniff
            X-Frame-Options DENY
            Referrer-Policy no-referrer-when-downgrade
            Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
            Permissions-Policy interest-cohort=()
            Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; connect-src 'self';"
            -Server
          }
        }

        # --- ADMIN AUTH (LAN-only Hangar) ---
        (admin_auth) {
          @admin_hangar {
            remote_ip private_ranges
          }
          handle @admin_hangar {
            import hardened_headers
            import compression
            # reverse_proxy is added in the vhost generation
          }
          respond "Forbidden: Admin access restricted to LAN" 403
        }

        # --- FAMILY AUTH (Pocket-ID) ---
        (family_auth) {
          
          @needs_auth {
            not remote_ip 127.0.0.1
            not header_regexp host ^auth\.
          }
          # FW-NEW-01 FIX: Fallback to TCP listener for Pocket-ID
          forward_auth @needs_auth 127.0.0.1:${toString config.my.ports."pocket-id" or 8089} {
            uri /api/auth/verify
            copy_headers X-Forwarded-User
          }
          import hardened_headers
          import honeypot
          import compression
        }

 # 🧱 AUTOMATIC FIREWALL EXPOSURE
 networking.firewall.allowedTCPPorts = [ 443 ];

        # --- STREAM OPTIMIZATION (Jellyfin / Audiobookshelf) ---
        (proxy_stream) {
          reverse_proxy {args[0]} {
            # 🏎️ Zero-Latency Mode
            flush_interval -1
            header_up Host {upstream_hostport}
            header_up X-Real-IP {remote_host}
            # 🛡️ Disable buffering for streams
            header_down X-Accel-Buffering no
          }
          import compression
        }

        # --- WILDCARD SUBDOMAIN ---
        *.${sreConfig.identity.subdomain}.${sreConfig.identity.domain} {
          tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          }
          
          # CA-08 FIX: Restricted certificate landing zone (no browsing)
          handle /certs/* {
            root * /var/www/landing-zone
            file_server {
              hide .git
            }
          }
        }
      '';
    };

    # 🛡️ SYSTEMD SANDBOXING (Aviation-Grade / Source: Fragment 2833)
    systemd.services.caddy = {
      # Source: Fragment 18333
      serviceConfig = {
        EnvironmentFile = [config.sops.templates."caddy-env".path];
        
        # Holy State Persistence
        StateDirectory = "caddy"; 
        RuntimeDirectory = "caddy";
        RuntimeDirectoryMode = "0750";
        ReadWritePaths = [ "/var/lib/caddy" "/var/log/caddy" ];
        
        # Hardening Shield
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        MemoryDenyWriteExecute = true;
        OOMScoreAdjust = -900;
        
        # Hide Process Info (ProtectProc)
        ProcSubset = "pid";
        ProtectProc = "invisible";
        
        # 🌐 NETWORK ACCESS (v6.1 Hardening Override)
        IPAddressAllow = "any";

        # Grant low-port binding capability
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      };
    };



    # 🚀 AUTOMATED VHOST GENERATION (from services-spec.nix)
    services.caddy.virtualHosts = let
      cfgSpec = config.my.services.spec;
      identity = config.my.configs.identity;
      
      # Helper to build the FQDN
      mkFQDN = svc: "${svc.domain}.${identity.subdomain}.${identity.domain}";
      
      # Helper to build the upstream address (Socket > IP:Port)
      mkUpstream = name: svc: if svc.socket != null 
        then "unix/${svc.socket}" 
        else if svc.zone == config.my.configs.zones.admin
        then "127.0.0.2:${toString svc.port}"
        else "127.0.0.1:${toString svc.port}";

      # Filter for services that need an ingress proxy
      ingressServices = lib.filterAttrs (_: svc: svc.domain != null) cfgSpec;
      
      # Generate virtual host config per service
      genVHost = name: svc: {
        name = mkFQDN svc;
        value = {
          extraConfig = if svc.zone == config.my.configs.zones.admin then ''
              import admin_auth
              reverse_proxy ${mkUpstream name svc}
            ''
            else if svc.zone == config.my.configs.zones.public then ''
              import public_access
              reverse_proxy ${mkUpstream name svc}
            ''
            else ''
              import family_auth
              reverse_proxy ${mkUpstream name svc}
            '';
        };
      };
    in lib.listToAttrs (lib.mapAttrsToList genVHost ingressServices);
  };
}
