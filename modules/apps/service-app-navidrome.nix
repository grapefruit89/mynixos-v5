# ---
# nms_id: APP-MEDIA-NAVIDROME
# title: Navidrome (Aviation-Grade Music Server)
# capabilities: [ "music", "streaming" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, myLib, ... }:
let
  nms = {
    id = "NIXH-01-APP-NAV-001";
    title = "Navidrome (Aviation-Grade Music Server)";
    layer = 40;
    audit.last_reviewed = "2026-04-28";
  };
  cfg = config.my.apps.navidrome;
  srePaths = config.my.configs.paths;
  sreConfig = config.my.configs;
in
{
  options.my.apps.navidrome = {
    enable = lib.mkEnableOption "Navidrome Music Server";
    user = lib.mkOption { type = lib.types.str; default = "navidrome"; };
    group = lib.mkOption { type = lib.types.str; default = "media"; };
    port = lib.mkOption { type = lib.types.port; default = config.my.ports.navidrome or 4533; };
    stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/navidrome"; };
    cacheDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/cache/navidrome"; };
    musicDir = lib.mkOption { type = lib.types.str; default = "${srePaths.mediaLibrary}/music"; };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # 🎬 1. AVIATION-GRADE STREAMER FABRIK
    (myLib.mkStreamer {
      inherit config;
      name = "navidrome";
      port = cfg.port;
      useGPU = false;
      memoryMax = "1G";
      cpuWeight = 60;
      description = "Navidrome Music Streaming";
    })

    # 🔧 2. NAVIDROME SPECIFICS
    {
      users.users.${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
        home = cfg.stateDir;
        extraGroups = [ "media" ];
      };

      services.navidrome = {
        enable = true;
        user = cfg.user;
        group = cfg.group;
        address = "127.0.0.1";
        port = cfg.port;
        musicFolder = cfg.musicDir;
        dataFolder = cfg.stateDir;
        cacheFolder = cfg.cacheDir;
        settings.EnableSubsonicApi = true;
      };

      # 🔗 Caddy Subdomain Override
      services.caddy.virtualHosts."music.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" =
        config.services.caddy.virtualHosts."navidrome.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

      systemd.services.navidrome.serviceConfig.ReadOnlyPaths = [ cfg.musicDir ];

      systemd.tmpfiles.rules = [
        "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
        "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
      ];

      environment.persistence."/persist".directories = [
        "/var/lib/navidrome"
      ];
    }
  ]);
}
