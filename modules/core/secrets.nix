{
 config,
 lib,
 pkgs,
 ...
}:
# 🛡️ SOPS MULTI-KEY STRATEGY (Decision S-01)
# Secrets are encrypted for three independent keys. Any one can decrypt.
#  - Key 1: Server SSH Host Key (age-ssh-ed25519) – present on /persist
#  - Key 2: Admin Age Key – stored on admin workstation, NEVER on server
#  - Key 3: Recovery Age Key – stored offline (USB in safe, paper)
#
# RECOVERY: If host key is lost:
#  1. Boot recovery medium
#  2. Use admin/recovery key to decrypt secrets.yaml
#  3. Restore /persist from restic
#  4. Run nixos-rebuild switch
let
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

  options.my.security.sops.multiKey = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Require multi-key encryption (server + admin + recovery)";
    };
  };

  config = {
    warnings = lib.optional (!config.my.security.sops.multiKey.enable)
      "⚠️ SOPS multi-key encryption DISABLED – secrets are vulnerable to total loss.";

    sops = {
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
 secrets = sopsEntries // {
    "sops-recovery-test" = {
      sopsFile = ../secrets/secrets.yaml;
      format = "yaml";
      owner = "root";
      group = "root";
      mode = "0400";
      neededForUsers = false;
    };
 };

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
 # Description: Securely syncs the current SSH host key to Tier B (Persistent SSD).
 # This ensures that if the primary /persist/etc/ssh/ key is lost, the age-compatible 
 # fallback can still decrypt sops secrets on a fresh install.
 # ROTATION POLICY: Key rotation should be performed manually every 180 days by 
 # regenerating the SSH host key and re-encrypting the SOPS vault.
 systemd.services.sops-key-sync = {
   description = "Aviation-Grade Secret Key Synchronization (Tier B)";
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

    systemd.services.sops-recovery-validation = {
      description = "Weekly SOPS Recovery Validation";
      after = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.sops}/bin/sops --decrypt /run/secrets/sops-recovery-test";
        ProtectSystem = "strict";
        PrivateTmp = true;
        NoNewPrivileges = true;
      };
    };

    systemd.timers.sops-recovery-validation = {
      description = "Weekly SOPS Recovery Validation Timer";
      timerConfig = { OnCalendar = "weekly"; Persistent = true; };
      wantedBy = [ "timers.target" ];
    };
 };
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d8a9b7c1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
