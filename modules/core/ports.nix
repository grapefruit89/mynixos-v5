{ lib, ... }: {
  # 🚀 Single Source of Truth für alle Ports
  # Alle Dienste müssen ihre Ports von hier beziehen.
  options.my.ports = lib.mkOption {
    type = lib.types.attrsOf lib.types.port;
    default = {
      # 10-Infrastructure
      pocket-id = 8080;
      postgres = 5432;
      adguard = 3001; # Web UI

      # 20-Automation
      home-assistant = 8123;
      n8n = 5678;
      ollama = 11434;

      # 30-Media
      jellyfin = 8096;
      sonarr = 8989;
      radarr = 7878;
      bazarr = 6767;
      prowlarr = 9696;
      sabnzbd = 8080;
      navidrome = 4533;
      audiobookshelf = 8000;

      # 40-Knowledge
      paperless = 28981;
      
      # 50-Apps
      vaultwarden = 8222;
      monica = 8080;
      karakeep = 20003;
      couchdb = 5984;
      
      # 80-Monitoring
      netdata = 19999;
      scrutiny = 8080;
      uptime-kuma = 3001;
      gatus = 8111;
    };
    description = "Central port registry (SSoT)";
  };
}
