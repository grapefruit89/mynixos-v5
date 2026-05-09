{lib, ...}: let
 # 🚀 NMS v4.2 Metadaten (hardened Switchboard)
 nms = {
 id = "NIXH-00-COR-027";
 title = "Registry (Master Switch)";
 description = "Global feature-toggles for all layers. Single Source of Truth for service enablement.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/feature-flags" "ssot/registry"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.registry = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 options.my = {
 profiles = {
 hardware.q958.enable = lib.mkOption { type = lib.types.bool; default = true; };
 networking = {
 reverseProxy = lib.mkOption {
 type = lib.types.enum ["caddy" "none"];
 default = "caddy";
 };
 systemd-networkd.enable = lib.mkOption {
 type = lib.types.bool;
 default = true;
 description = "Use systemd-networkd for optimized networking.";
 };
 };
 };

 services = {
 # 10-Infrastructure
 adguardhome.enable = lib.mkEnableOption "AdGuard Home";
 pocketId.enable = lib.mkEnableOption "Pocket-ID (OIDC)";
 caServer.enable = lib.mkEnableOption "CA Server UI";
 postgresql.enable = lib.mkEnableOption "PostgreSQL Cluster";
 caddy.enable = lib.mkEnableOption "Caddy Reverse Proxy";
 
 # 20-Automation
 aiAgents.enable = lib.mkEnableOption "AI (Ollama/Claude)";
 homeAssistant.enable = lib.mkEnableOption "Home Assistant";
 n8n.enable = lib.mkEnableOption "n8n Workflows";
 zigbeeStack.enable = lib.mkEnableOption "Zigbee Stack (Z2M + MQTT)";

 # 40-Knowledge
 paperless.enable = lib.mkEnableOption "Paperless-ngx";
 miniflux.enable = lib.mkEnableOption "Miniflux RSS";
 linkding.enable = lib.mkEnableOption "Linkding Bookmarks";

 # 50-Apps
 vaultwarden.enable = lib.mkEnableOption "Vaultwarden";
 monica.enable = lib.mkEnableOption "Monica CRM";

 # 80-Monitoring
 netdata.enable = lib.mkEnableOption "Netdata";
 uptimeKuma.enable = lib.mkEnableOption "Uptime Kuma";
 scrutiny.enable = lib.mkEnableOption "Scrutiny";

 # 90-Logging
 logging = {
 s3Sync.enable = lib.mkEnableOption "S3 Log Sync";
 };

 # Core Features
 backup.enable = lib.mkEnableOption "Restic Backup";
 kernelSlim.enable = lib.mkEnableOption "Kernel Slim";
 shell.premium.enable = lib.mkEnableOption "Shell Premium";
 };

 media = {
 jellyfin.enable = lib.mkEnableOption "Jellyfin";
 navidrome.enable = lib.mkEnableOption "Navidrome (Music)";
 audiobookshelf.enable = lib.mkEnableOption "Audiobookshelf";
 sonarr.enable = lib.mkEnableOption "Sonarr";
 radarr.enable = lib.mkEnableOption "Radarr";
 prowlarr.enable = lib.mkEnableOption "Prowlarr";
 sabnzbd.enable = lib.mkEnableOption "SABnzbd";
 storagePool.enable = lib.mkEnableOption "MergerFS Pool";
 };
 };

 config.my = {
 services = {
 # Default Enabled für das Master-System
 adguardhome.enable = lib.mkDefault true;
 aiAgents.enable = lib.mkDefault true;
 backup.enable = lib.mkDefault true;
 paperless.enable = lib.mkDefault true;
 postgresql.enable = lib.mkDefault true;
 vaultwarden.enable = lib.mkDefault true;
 shell.premium.enable = lib.mkDefault true;
 };
 media = {
 audiobookshelf.enable = lib.mkDefault true;
 jellyfin.enable = lib.mkDefault true;
 navidrome.enable = lib.mkDefault true;
 sonarr.enable = lib.mkDefault true;
 radarr.enable = lib.mkDefault true;
 };
 };
}
