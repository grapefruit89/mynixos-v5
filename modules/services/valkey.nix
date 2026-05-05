{ pkgs, lib, config, ... }:
let
  # 🚀 NMS v4.0 Metadaten
  nms = {
    id = "NIXH-20-INF-006";
    title = "Valkey (SRE Exhausted)";
    description = "High-performance Valkey (Redis fork) with memory caps and aviation-grade sandboxing.";
    layer = 10;
    nixpkgs.category = "services/databases";
    capabilities = [ "database/key-value" "caching/redis" ];
    audit.last_reviewed = "2026-03-02";
    audit.complexity = 2;
  };
in
{
  options.my.meta.valkey = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for valkey module";
  };


  config = lib.mkIf config.my.services.valkey.enable {
    services.redis.package = pkgs.valkey;
    services.redis.servers.valkey = {
      # 🛡️ AVIATION HARDENING: Disable TCP, use Unix Sockets only
      enable = true; 
      bind = ""; 
      port = 0; 
      openFirewall = false;
      settings = {
        maxmemory = "512mb"; maxmemory-policy = "allkeys-lru";
        save = [ "900 1" "300 10" "60 10000" ];
        unixsocket = "/run/redis-valkey/redis.sock"; 
        unixsocketperm = "770";
      };
    };
    systemd.services.redis-valkey.serviceConfig = {
      ProtectSystem = "strict"; ProtectHome = true; PrivateTmp = true; PrivateDevices = true; NoNewPrivileges = true;
      # 🛡️ KERNEL-LEVEL ISOLATION: No network access needed for local sockets
      PrivateNetwork = true;
      MemoryDenyWriteExecute = true; 
      RestrictAddressFamilies = [ "AF_UNIX" ]; 
      OOMScoreAdjust = -500;
    };
  };
}
