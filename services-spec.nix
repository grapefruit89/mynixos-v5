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
          type = lib.types.enum [ "loopback" "admin-hangar" "family-pocketid" "public" ]; 
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

    # --- ZONE: PUBLIC (No Authentication) ---
    gatus = { port = p.gatus; zone = "public"; domain = "status"; description = "Public Health Dashboard"; };

    # --- ZONE: ADMIN-HANGAR (LAN only, no SSO) ---
    # Infrastructure & Monitoring
    netdata = { port = p.netdata; zone = "admin-hangar"; domain = "netdata"; description = "Real-time Monitoring"; };
    scrutiny = { port = p.scrutiny; zone = "admin-hangar"; domain = "scrutiny"; description = "HDD S.M.A.R.T. Dashboards"; };
    uptime-kuma = { port = p.uptime-kuma; zone = "admin-hangar"; domain = "status"; description = "Uptime Monitoring"; };
    cockpit = { port = p.cockpit; zone = "admin-hangar"; domain = "admin"; description = "System Management"; };
    blocky = { port = 53; zone = "admin-hangar"; domain = "dns"; description = "DNS Resolver"; };
    
    # Media Backend (Arr-Stack)
    sonarr = { port = p.sonarr; zone = "admin-hangar"; domain = "sonarr"; description = "TV Series Management"; };
    radarr = { port = p.radarr; zone = "admin-hangar"; domain = "radarr"; description = "Movie Management"; };
    prowlarr = { port = p.prowlarr; zone = "admin-hangar"; domain = "prowlarr"; description = "Indexer Manager"; };
    lidarr = { port = p.lidarr; zone = "admin-hangar"; domain = "lidarr"; description = "Music Management"; };
    readarr = { port = p.readarr; zone = "admin-hangar"; domain = "readarr"; description = "Book Management"; };
    sabnzbd = { port = p.sabnzbd; zone = "admin-hangar"; domain = "sabnzbd"; description = "Usenet Downloader"; };
    
    # Internal Apps
    linkding = { port = p.linkding; zone = "admin-hangar"; domain = "links"; description = "Bookmark Manager"; };
    vaultwarden = { socket = "/run/vaultwarden/vaultwarden.sock"; zone = "admin-hangar"; domain = "vault"; description = "Password Manager"; };
    miniflux = { socket = "/run/miniflux/miniflux.sock"; zone = "admin-hangar"; domain = "miniflux"; description = "RSS Reader"; };
    n8n = { port = p.n8n; zone = "admin-hangar"; domain = "n8n"; description = "Workflow Automation"; };
    paperless = { socket = "/run/paperless/paperless.sock"; zone = "admin-hangar"; domain = "paperless"; description = "Document Management"; };
    filebrowser = { socket = "/run/filebrowser/filebrowser.sock"; zone = "admin-hangar"; domain = "files"; description = "File Manager"; };
    matrix = { port = p.matrix; zone = "admin-hangar"; domain = "matrix"; description = "Matrix Homeserver (Conduit)"; };

    # --- ZONE: FAMILY-POCKETID (LAN/WAN, PocketID Forward Auth) ---
    pocketid = { port = p.pocket-id; zone = "family-pocketid"; domain = "auth"; description = "Identity Provider"; };
    jellyfin = { port = p.jellyfin; zone = "family-pocketid"; domain = "media"; description = "Media Streaming"; };
    seerr = { port = p.seerr; zone = "family-pocketid"; domain = "requests"; description = "Media Requests"; };
    audiobookshelf = { port = p.audiobookshelf; zone = "family-pocketid"; domain = "audiobooks"; description = "Audiobooks & Podcasts"; };
    navidrome = { port = p.navidrome; zone = "family-pocketid"; domain = "music"; description = "Music Streaming"; };
    readmeabook = { port = p.readmeabook; zone = "family-pocketid"; domain = "read"; description = "Alternative Audiobook Reader"; };
    
    # Dashboard (Entry point)
    homepage = { port = p.homepage; zone = "admin-hangar"; domain = "dash"; description = "Service Dashboard"; };
  };
}
