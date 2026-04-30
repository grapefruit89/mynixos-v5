{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Vault)
 nms = {
 id = "NIXH-00-COR-028";
 title = "Secrets (Sops Master Vault)";
 description = "Centralized secret-to-module mapping with NIXH-ID traceability. Uses age with SSH-hostkey backing.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["security/secrets" "sops/mapping" "age/encryption"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 # 🗺️ NIXH-ID Mapping für Audits
 secretMap = {
 "NIXH-40-MED-017" = "sonarr_api_key";
 "NIXH-40-MED-012" = "radarr_api_key";
 "NIXH-60-APP-007" = "vaultwarden_env";
 "NIXH-10-GTW-002" = "cloudflare_token";
 };
in {
 options.my.meta.secrets = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {
 sops = {
 defaultSopsFile = ../../secrets/secrets.yaml;
 defaultSopsFormat = "yaml";
 
 age = {
 sshKeyPaths = [ 
 "/etc/ssh/ssh_host_ed25519_key"
 "/persist/etc/ssh/ssh_host_ed25519_key"
 # 🚨 C-03: EMERGENCY FALLBACK (Non-NVMe Path)
 "${config.my.configs.paths.tierB}/secrets/emergency_age_key.txt" 
 ];
 keyFile = "/var/lib/sops-nix/key.txt";
 generateKey = true;
 };

 secrets = {
 # Identity
 user_password = { neededForUsers = true; };
 freund_password = { neededForUsers = true; };

 # Infrastructure
 cloudflare_token = {};
 github_token = {};
 tailscale_token = {};
 unraid_root_password = {};
 
 # Automation & Apps
 n8n_enc_key = {};
 vaultwarden_env = {};
 paperless_secret_key = {};
 
 # Media Stack
 sonarr_api_key = {};
 radarr_api_key = {};
 readarr_api_key = {};

 # Backup & Storage
 restic_password = {};
 backblaze_access_key = {};
 backblaze_secret_key = {};
 };

 # 📄 ENVIRONMENT TEMPLATES (Injecting Secrets into Services)
 templates."media-stack.env" = {
 owner = "root";
 group = "media"; # Ermöglicht sonarr/radarr Zugriff
 mode = "0440";
 content = ''
 SONARR_API_KEY="${config.sops.placeholder.sonarr_api_key}"
 RADARR_API_KEY="${config.sops.placeholder.radarr_api_key}"
 '';
 };

 templates."caddy-env" = {
 owner = "caddy";
 mode = "0400";
 content = ''
 CLOUDFLARE_API_TOKEN="${config.sops.placeholder.cloudflare_token}"
 '';
 };

 templates."backblaze-restic.env" = {
 owner = "root";
 mode = "0400";
 content = ''
 AWS_ACCESS_KEY_ID="${config.sops.placeholder.backblaze_access_key}"
 AWS_SECRET_ACCESS_KEY="${config.sops.placeholder.backblaze_secret_key}"
 '';
 };
 };
 
 environment.systemPackages = [ pkgs.sops pkgs.age ];

 # 🚨 C-03: AUTOMATED KEY BACKUP (Anti-Deadlock)
 systemd.services.sops-key-sync = {
 description = "Sync SSH host key to Tier B fallback";
 after = [ "persist.mount" ];
 wantedBy = [ "multi-user.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = "${pkgs.bash}/bin/bash /etc/nixos/modules/core/scripts/sync-sops-keys.sh";
 RemainAfterExit = true;
 };
 };
 };
}
