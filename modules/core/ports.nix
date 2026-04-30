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
      adguard = 3004; # Web UI
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
      sonarr = 8989;
      radarr = 7878;
      bazarr = 6767;
      prowlarr = 9696;
      sabnzbd = 8081;
      navidrome = 4533;
      audiobookshelf = 8000;

      # 40-Knowledge
      paperless = 28981;
      
      # 50-Apps
      vaultwarden = 8222;
      monica = 8087;
      karakeep = 20003;
      couchdb = 5984;
      
      # 80-Monitoring
      netdata = 19999;
      scrutiny = 8088;
      uptimeKuma = 3005;
      gatus = 8111;
    };
    description = "Central port registry (SSoT)";
  };
}
