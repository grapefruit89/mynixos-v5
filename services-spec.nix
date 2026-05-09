{ lib, config, ... }: {
  options.my.services.spec = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        port = lib.mkOption { 
          type = lib.types.nullOr lib.types.port; 
          default = null;
        };
        socket = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "Optional Unix socket path for the service.";
        };
        zone = lib.mkOption { 
          type = lib.types.enum [ "loopback" "admin-mtls" "family-pocketid" ]; 
        };
        domain = lib.mkOption { 
          type = lib.types.nullOr lib.types.str; 
          default = null; 
        };
        description = lib.mkOption { 
          type = lib.types.str; 
          default = ""; 
        };
      };
    });
    default = {};
    description = "Single Source of Truth for all services and their trust zones.";
  };

  config.my.services.spec = let
    p = config.my.ports;
  in {
    # --- ZONE: LOOPBACK (Internal only, no Caddy Proxy) ---
    postgresql = { socket = "/run/postgresql/.s.PGSQL.5432"; zone = "loopback"; description = "Primary Database Cluster"; };
    valkey = { socket = "/run/redis-valkey/redis.sock"; zone = "loopback"; description = "High-performance Cache"; };
    ollama = { port = p.ollama; zone = "loopback"; description = "LLM Engine"; };

    # --- ZONE: ADMIN-mTLS (LAN/WAN, TPM-bound mTLS required) ---
    # Infrastructure & Monitoring
    ca-server = { socket = "/run/ca-server/ca.sock"; zone = "admin-mtls"; domain = "ca"; description = "Minimalist CA Manager"; };
    netdata = { port = p.netdata; zone = "admin-mtls"; domain = "netdata"; description = "Real-time Monitoring"; };
    scrutiny = { port = p.scrutiny; zone = "admin-mtls"; domain = "scrutiny"; description = "HDD S.M.A.R.T. Dashboards"; };
    uptime-kuma = { port = p.uptime-kuma; zone = "admin-mtls"; domain = "status"; description = "Uptime Monitoring"; };
    cockpit = { port = p.cockpit; zone = "admin-mtls"; domain = "admin"; description = "System Management"; };
    adguard = { port = p.adguard; zone = "admin-mtls"; domain = "dns"; description = "DNS Sinkhole"; };
    
    # Media Backend (Arr-Stack)
    sonarr = { port = p.sonarr; zone = "admin-mtls"; domain = "sonarr"; description = "TV Series Management"; };
    radarr = { port = p.radarr; zone = "admin-mtls"; domain = "radarr"; description = "Movie Management"; };
    prowlarr = { port = p.prowlarr; zone = "admin-mtls"; domain = "prowlarr"; description = "Indexer Manager"; };
    lidarr = { port = p.lidarr; zone = "admin-mtls"; domain = "lidarr"; description = "Music Management"; };
    readarr = { port = p.readarr; zone = "admin-mtls"; domain = "readarr"; description = "Book Management"; };
    sabnzbd = { port = p.sabnzbd; zone = "admin-mtls"; domain = "sabnzbd"; description = "Usenet Downloader"; };
    
    # Internal Apps
    linkding = { port = p.linkding; zone = "admin-mtls"; domain = "links"; description = "Bookmark Manager"; };
    vaultwarden = { socket = "/run/vaultwarden/vaultwarden.sock"; zone = "admin-mtls"; domain = "vault"; description = "Password Manager"; };
    miniflux = { socket = "/run/miniflux/miniflux.sock"; zone = "admin-mtls"; domain = "miniflux"; description = "RSS Reader"; };
    n8n = { port = p.n8n; zone = "admin-mtls"; domain = "n8n"; description = "Workflow Automation"; };
    paperless = { socket = "/run/paperless/paperless.sock"; zone = "admin-mtls"; domain = "paperless"; description = "Document Management"; };
    filebrowser = { socket = "/run/filebrowser/filebrowser.sock"; zone = "admin-mtls"; domain = "files"; description = "File Manager"; };

    # --- ZONE: FAMILY-POCKETID (LAN/WAN, PocketID Forward Auth) ---
    pocketid = { socket = "/run/pocket-id/pocket-id.sock"; zone = "family-pocketid"; domain = "auth"; description = "Identity Provider"; };
    jellyfin = { port = p.jellyfin; zone = "family-pocketid"; domain = "media"; description = "Media Streaming"; };
    jellyseerr = { port = p.jellyseerr; zone = "family-pocketid"; domain = "requests"; description = "Media Requests"; };
    audiobookshelf = { port = p.audiobookshelf; zone = "family-pocketid"; domain = "audiobooks"; description = "Audiobooks & Podcasts"; };
    navidrome = { port = p.navidrome; zone = "family-pocketid"; domain = "music"; description = "Music Streaming"; };
    homeassistant = { port = p.home-assistant; zone = "family-pocketid"; domain = "home"; description = "Smart Home"; };
    
    # Dashboard (Entry point)
    homepage = { port = p.homepage; zone = "family-pocketid"; domain = "dash"; description = "Service Dashboard"; };
  };
}
