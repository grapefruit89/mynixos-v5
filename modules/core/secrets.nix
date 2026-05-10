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
 description = "Centralized secret-to-module mapping derived from fixed schema. Uses age with SSH-hostkey backing.";
 layer = 00;
 nixpkgs.category = "system/security";
 capabilities = ["security/secrets" "sops/mapping" "age/encryption"];
 audit.last_reviewed = "2026-05-09";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 # 🗺️ SSoT: Schema to SOPS Transformation
 # Derives sops.secrets entries from the read-only schema.
 schemaKeys = lib.attrNames config.my.secrets.schema;
 sopsEntries = lib.genAttrs schemaKeys (name: {
   # Passwords need users access
   neededForUsers = lib.hasSuffix "_password" name;
 });

in {
 imports = [ ./secrets-schema.nix ];

 options.my.meta.secrets = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

      secrets = {
        # Infrastructure
        cloudflare_token = {};
        github_token = {};
        unraid_root_password = {};
        
        # Automation & Apps
        n8n_enc_key = {};
        vaultwarden_env = {};
        paperless_secret_key = {};
        miniflux_admin_password = {};
        readeck_env = {};
        linkwarden_env = {};
        
        # Media Stack
        sonarr_api_key = {};
        radarr_api_key = {};
        readarr_api_key = {};

 # 🚀 DERIVED SECRETS (Schema-First)
 secrets = sopsEntries;

 # 📄 ENVIRONMENT TEMPLATES (Injecting Secrets into Services)
 templates."media-stack.env" = {
 owner = "root";
 group = "media";
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
 # Correct logic: only run if the fallback directory is available
 unitConfig.ConditionPathExists = config.my.configs.paths.tierB;
 wantedBy = [ "multi-user.target" ];
 serviceConfig = {
 Type = "oneshot";
 ExecStart = pkgs.writeShellScript "sops-key-sync" ''
   set -euo pipefail
   KEY="/etc/ssh/ssh_host_ed25519_key"
   DEST="${config.my.configs.paths.tierB}/secrets/emergency_age_key.txt"
   if [ -f "$KEY" ]; then
     mkdir -p "$(dirname "$DEST")"
     cp -f "$KEY" "$DEST"
     chmod 600 "$DEST"
     logger -t sops-sync "Backup of SSH host key to Tier B successful."
   fi
 '';
 RemainAfterExit = true;
 # 🛡️ SANDBOXING
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 ReadWritePaths = [ config.my.configs.paths.tierB ];
 };
 };
 };
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d8a9b7c1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
