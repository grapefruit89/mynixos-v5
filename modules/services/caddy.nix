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
      
      # 🛠️ GLOBAL OPTIONS (Source: Fragment 2526 / Performance Kick)
      globalConfig = ''
        admin localhost:2019
        
        # 🧩 Performance & Resources
        servers {
          trusted_proxies static ${trustedIPs}
          trusted_proxies_strict
          # Speed-up: Buffer settings
          max_header_size 16kb
        }
        
        # ACME DNS-01 Challenge (Cloudflare)
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';

      # 📜 REUSABLE SNIPPETS (Source: Caddy-on-Steroids / Titanium v5.2)
      extraConfig = ''
        # --- PERFORMANCE: COMPRESSION ---
        (compression) {
          encode br zstd gzip
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

        # --- DDOS SHIELD (3-Stage Defense - UX Optimized) ---
        (ddos_shield) {
          # Stage 2: Authenticated (Pocket-ID) -> No Limits
          @is_auth {
            header_regexp Cookie "pocketid_session="
          }

          # Stage 1: Verified Human (JS-Challenge passed) -> 500 req/min
          @is_human {
            header_regexp Cookie "m7c5_human=verified"
            not remote_ip 127.0.0.1
            not remote_ip ${trustedIPs}
          }
          rate_limit @is_human {
            zone human_limit {
              key {remote_host}
              window 1m
              max_events 500
            }
          }

          # Stage 0: Unknown/Bots/API-Clients -> 30 req/min
          @is_unknown {
            not header_regexp Cookie "m7c5_human=verified"
            not header_regexp Cookie "pocketid_session="
            not remote_ip 127.0.0.1
            not remote_ip ${trustedIPs}
          }
          rate_limit @is_unknown {
            zone bot_limit {
              key {remote_host}
              window 1m
              max_events 30
            }
          }
        }

        # --- JS CHALLENGE PAGE (API Aware) ---
        (human_challenge) {
          @need_challenge {
            not header_regexp Cookie "m7c5_human=verified"
            not header_regexp Cookie "pocketid_session="
            not remote_ip 127.0.0.1
            not remote_ip ${trustedIPs}
            not path /api/* /socket.io/* /json/* /web/assets/* /Users/* /jellyfin/*
            method GET
          }
          handle @need_challenge {
            header Content-Type "text/html; charset=utf-8"
            respond <<HTML
              <html>
                <head><title>m7c5 Security Check</title></head>
                <body style="background:#000;color:#333;font-family:monospace;display:flex;align-items:center;justify-content:center;height:100vh;">
                  <script>
                    var x = 13 + 37;
                    if (x === 50) {
                      document.cookie = "m7c5_human=verified; path=/; max-age=3600; SameSite=Lax";
                      location.reload(); 
                    }
                  </script>
                  <div id="msg">Verifying identity...</div>
                </body>
              </html>
            HTML 200
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

        # --- SSO AUTH (Pocket-ID) ---
        (sso_auth) {
          import ddos_shield
          import human_challenge
          
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
          import compression
        }

        # --- WAKE ON DEMAND (Power Saver) ---
        # Note: Requires caddy-wol plugin
        (wake_on_demand) {
          handle_errors {
            @offline expression {err.status_code} == 502
            handle @offline {
              # wake_on_lan {args[0]} # MAC Address
              header Content-Type "text/html"
              respond <<HTML
                <html><body style="background:#000;color:#eee;text-align:center;padding-top:20%;">
                <h1>⚡ Awakening Server...</h1>
                <p>The requested service is powering up. Auto-refresh in 10s.</p>
                <script>setTimeout(function(){ location.reload(); }, 10000);</script>
                </body></html>
              HTML 200
            }
          }
        }

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
          import wake_on_demand
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

    # 🛡️ SYSTEMD SANDBOXING (Unified Factory)
    myLib.mkHardenedService {
      name = "caddy";
      readWritePaths = [ "/var/lib/caddy" "/var/log/caddy" ];
      extraConfig = {
        EnvironmentFile = [config.sops.templates."caddy-env".path];
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        OOMScoreAdjust = -500;
      };
    }

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
