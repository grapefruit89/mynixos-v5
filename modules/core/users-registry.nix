{ lib, ... }: {
  # 🚀 PRODUCTION-HARDENED USER REGISTRY (ADR 005)
  # Centralized mapping for static UIDs to enable nftables 'meta skuid' filtering.
  # UID Range: 2000-2999 (Reserved for persistent services with network identity)

  options.my.users.registry = lib.mkOption {
    type = lib.types.attrsOf lib.types.int;
    default = {
      # Infrastructure
      caddy = 2000;
      postgres = 2001;
      pocket-id = 2002;
      valkey = 2003;
      step-ca = 2004;
      
      # Monitoring
      vector = 2010;
      gatus = 2011;
      uptime-kuma = 2012;
      netdata = 2013;
      ntfy = 2014;

      # Apps (Ingress/Outbound)
      adguardhome = 2020;
      jellyfin = 2030;
      audiobookshelf = 2031;
      navidrome = 2032;
      
      # Arr-Stack
      sonarr = 2040;
      radarr = 2041;
      prowlarr = 2042;
      sabnzbd = 2043;
      lidarr = 2044;
      readarr = 2045;

      # Productivity
      paperless = 2050;
      vaultwarden = 2051;
      miniflux = 2052;
      n8n = 2053;
      filebrowser = 2054;
      linkding = 2055;
    };
  };
}
