{ lib, ... }: {
  # 🚀 Single Source of Truth für alle Ports
  # Alle Dienste müssen ihre Ports von hier beziehen.
  options.my.ports = lib.mkOption {
    type = lib.types.attrsOf lib.types.port;
    default = {
      # 10-Infrastructure
      ssh = 53844;
      pocketId = 8089;
      postgres = 5432;
      valkey = 6379;
      adguard = 3004; # Web UI
      caServer = 5000;
      cockpit = 9090;
      mqtt = 1883;

      # 20-Automation
      homeAssistant = 8123;
      n8n = 5678;
      ollama = 11434;
      zigbee2mqtt = 8084;
      linkding = 8085;
      olivetin = 8086;

      # 30-Media
      jellyfin = 8096;
      jellyseerr = 5055;
      sonarr = 8989;
      radarr = 7878;
      bazarr = 6767;
      prowlarr = 9696;
      lidarr = 8686;
      readarr = 8787;
      sabnzbd = 8081;
      navidrome = 4533;
      audiobookshelf = 8000;

      # 40-Knowledge
      paperless = 28981;
      miniflux = 8070;
      linkwarden = 3007;
      
      # 50-Apps
      vaultwarden = 8222;
      monica = 8082;
      readeck = 8072;
      karakeep = 20003;
      couchdb = 5984;
      filebrowser = 8071;
      homepage = 3000;
      matrix = 6167;
      
      # 80-Monitoring
      netdata = 19999;
      scrutiny = 8083;
      uptimeKuma = 3002;
      gatus = 8111;
      ddnsUpdater = 8091;
      edgeHttps = 4433;
    };
    description = "Central port registry (SSoT)";
  };
}
