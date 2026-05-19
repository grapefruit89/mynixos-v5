{ lib, config, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-002";
    title = "Global Port Registry";
    description = "Central SSoT for all service ports, prioritizing Unix sockets and localhost bindings.";
    layer = 0;
    nixpkgs.category = "core/network";
    capabilities = ["network/ports" "security/isolation"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 1;
  };
in
{
  options.my.meta.ports_registry = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

  # 🚀 Single Source of Truth für alle Ports (v6.0)
  # Alle Dienste nutzen primär Unix-Sockets. TCP-Ports sind reine Fallbacks auf 127.0.0.1.
  
  options.my.ports = lib.mkOption {
    type = lib.types.attrsOf lib.types.port;
    default = {
      # 🛡️ ADMINISTRATIVE (High-Port)
      ssh = 53844;
      sshRescue = 2222;
      wireguard = 51820;

      # 🏗️ 10xxx: INFRASTRUCTURE & CORE
      pocket-id = 10880;
      adguard = 10053;
      caddyAdmin = 2019;
      cockpit = 10090;
      postgres = 10432;
      valkey = 10379;
      ollama = 11434;
      zigbee2mqtt = 8084;
      linkding = 8085;

      # 📦 20xxx: APPS & MEDIA
      jellyfin = 20096;
      seerr = 20055;
      sonarr = 20989;
      radarr = 20878;
      prowlarr = 20696;
      sabnzbd = 20880;
      navidrome = 20533;
      audiobookshelf = 20000;
      paperless = 20981;
      vaultwarden = 20222;
      monica = 20985;
      filebrowser = 20081;
      couchdb = 20984;
      homepage = 20300;
      matrix = 20001;
      readmeabook = 20002;
      forgejo = 20003;
      amp = 20080;

      # 📈 80xxx: MONITORING
      netdata = 80999;
      scrutiny = 80084;
      uptime-kuma = 80005;
      gatus = 80111;
      ntfy = 80112;
    };
    description = "Central port registry (SSoT). Only bound to 127.0.0.1.";
  };

  config = {
    # 🚫 PORT VIOLATIONS (ADR 010)
    warnings = [
      (lib.optionalString (lib.any (p: p == 8080) (lib.attrValues config.my.ports))
        "🚫 [PORT-VIOLATION] Port 8080 is strictly forbidden to avoid common collisions.")
      (lib.optionalString (lib.any (p: p == 80) (lib.attrValues config.my.ports))
        "🚫 [PORT-VIOLATION] Port 80 is reserved for Caddy redirection.")
    ];
  };
}
