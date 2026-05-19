# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-AUTO-GEN",
#   "title": "Auto Generated",
#   "layer": 99,
#   "category": "auto/gen",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 2,
#   "tags": ["auto-generated"],
#   "description": "Auto-migrated module to NIXMETA 2.0."
# }
# ---ENDNIXMETA

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
      blocky.enable = lib.mkEnableOption "Blocky DNS Resolver";
      pocketId.enable = lib.mkEnableOption "Pocket-ID (OIDC)";
      postgresql.enable = lib.mkEnableOption "PostgreSQL Cluster";
      
      # 20-Automation
      aiAgents.enable = lib.mkEnableOption "AI (Ollama/Claude)";
      homeAssistant.enable = lib.mkEnableOption "Home Assistant";
      n8n.enable = lib.mkEnableOption "n8n Workflows";

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
      shell.premium.enable = lib.mkEnableOption "Shell Premium";
    };
  };

  config.my.services = {
    # Default Enabled für das Master-System
    blocky.enable = lib.mkDefault true;
    aiAgents.enable = lib.mkDefault true;
    audiobookshelf.enable = lib.mkDefault true;
    backup.enable = lib.mkDefault true;
    jellyfin.enable = lib.mkDefault true;
    navidrome.enable = lib.mkDefault true;
    paperless.enable = lib.mkDefault true;
    postgresql.enable = lib.mkDefault true;
    sonarr.enable = lib.mkDefault true;
    radarr.enable = lib.mkDefault true;
    vaultwarden.enable = lib.mkDefault true;
    shell.premium.enable = lib.mkDefault true;
  };
}
