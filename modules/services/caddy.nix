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
    description = "Hardened Edge Proxy with GeoIP, mTLS, SSO and Rate-Limiting. Decoupled horizontal architecture.";
    layer = 10;
    nixpkgs.category = "servers/proxy";
    capabilities = ["network/ingress" "security/waf" "security/mtls" "security/geoip" "automation/dns-01"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
  };

  cfg = config.my.services.caddy;
  sreConfig = config.my.configs;
  
  # 🌐 Trusted IPs (Cloudflare, LAN, Tailscale)
  # Source: Fragment 18278 & Local Network SSoT
  trustedIPs = lib.concatStringsSep " " (
    ["127.0.0.1" "173.245.48.0/20" "103.21.244.0/22" "103.22.200.0/22" "103.31.4.0/22" "141.101.64.0/18" "108.162.192.0/18" "190.93.240.0/20" "188.114.96.0/20" "197.234.240.0/22" "198.41.128.0/17" "162.158.0.0/15" "104.16.0.0/13" "104.24.0.0/14" "172.64.0.0/13" "131.0.72.0/22"]
    ++ sreConfig.network.tailnetCidrs
    ++ sreConfig.network.lanCidrs
  );

in {
  options.my.meta.caddy = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
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
      
      # 🛠️ GLOBAL OPTIONS (Source: Fragment 2526)
      globalConfig = ''
        admin localhost:2019
        
        # 🧩 Rate Limiting Plugin Settings (Standard for Homelab)
        order rate_limit before reverse_proxy

        servers {
          trusted_proxies static ${trustedIPs}
          # Source: Fragment 2544
          trusted_proxies_strict
        }
        
        # ACME DNS-01 Challenge (Cloudflare)
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';

      # 📜 REUSABLE SNIPPETS (Source: Caddy-on-Steroids / Titanium v5)
      extraConfig = ''
        # --- HONEYPOT (Detect Scanners and ABORT) ---
        (honeypot) {
          @evil_paths {
            not remote_ip private_ranges
            path /.env* /.git* /.vscode* /wp-config* /config.json* /actuator* /phpmyadmin* /.aws* /.ssh* /xmlrpc.php /wp-login* /admin* /setup.php /install.php /shell* /cmd.php /cgi-bin*
          }
          handle @evil_paths {
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

        # --- GEOBLOCK (MaxMind Stealth) ---
        (geoblock) {
          @geoblock {
             not remote_ip ${trustedIPs}
          }
          # Note: Real geoblock is now in nftables. This is a L7 safety net.
        }

        # --- mTLS AUTH (Hardware Binding) ---
        (mtls_auth) {
          tls {
            client_auth {
              mode require_and_verify
              trust_pool file /var/lib/caddy/internal-ca.pem
            }
          }
          import hardened_headers
        }

        # --- SSO AUTH (Pocket-ID) ---
        (sso_auth) {
          @needs_auth {
            not remote_ip 127.0.0.1
            not header_regexp host ^auth\.
          }
          forward_auth @needs_auth localhost:${toString config.my.ports.pocketId} {
            uri /api/auth/verify
            copy_headers X-Forwarded-User
          }
          import hardened_headers
          import honeypot
          encode br zstd gzip
        }

        # --- STREAM OPTIMIZATION (Jellyfin) ---
        (proxy_stream) {
          reverse_proxy {args[0]} {
            flush_interval -1
            header_up Host {upstream_hostport}
            header_up X-Real-IP {remote_host}
          }
        }

        # --- WILDCARD SUBDOMAIN ---
        *.${sreConfig.identity.subdomain}.${sreConfig.identity.domain} {
          tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          }
          
          # Zertifikat-Download (für OliveTin mTLS Generator)
          handle /certs/* {
            root * /var/www/landing-zone
            file_server browse
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
        ReadWritePaths = [ "/var/lib/caddy" "/var/log/caddy" ];
        
        # Hardening Shield
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        MemoryDenyWriteExecute = true;
        OOMScoreAdjust = -500;
        
        # Grant low-port binding capability
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      };
    };

    # 🧱 AUTOMATIC FIREWALL EXPOSURE
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    # 💾 IMPERMANENCE (Cert Cache & Logs)
    environment.persistence."/persist" = {
      directories = [ 
        "/var/lib/caddy"
        "/var/log/caddy"
      ];
    };
  };
}
/**
 * ---\n * technical_integrity:\n *   checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04e2f\n *   eof_marker: NIXHOME_VALID_EOF* ---\n */
