{ lib, ... }: {
  # 🚀 Single Source of Truth für alle Ports
  # Alle Dienste müssen ihre Ports von hier beziehen.
  options.my.ports = lib.mkOption {
    type = lib.types.attrsOf lib.types.port;
    default = {
      # 10-Infrastructure
      ssh = 53844;
      pocket-id = 8080;
      linkding = 8082;
      postgres = 5432;
      valkey = 6379;
      adguard = 3001; # Web UI
      ca-server = 5000;
      cockpit = 9090;

      # 20-Automation
      home-assistant = 8123;
      n8n = 5678;
      ollama = 11434;

      # 30-Media
      jellyfin = 8096;
      jellyseerr = 5055;
      sonarr = 8989;
      radarr = 7878;
      bazarr = 6767;
      prowlarr = 9696;
      lidarr = 8686;
      readarr = 8787;
      sabnzbd = 8083; # Changed from 8080 to avoid collision
      navidrome = 4533;
      audiobookshelf = 8000;

      # 40-Knowledge
      paperless = 28981;
      
      # 50-Apps
      vaultwarden = 8222;
      monica = 8085; # Changed from 8080 to avoid collision
      karakeep = 20003;
      couchdb = 5984;
      filebrowser = 8081; # Changed from 8080 to avoid collision
      homepage = 3000;
      
      # 80-Monitoring
      netdata = 19999;
      scrutiny = 8084; # Changed from 8080 to avoid collision
      uptime-kuma = 3005; # Changed from 3001 to avoid collision with AdGuard
      gatus = 8111;
    };
    description = "Central port registry (SSoT)";
  };
}
