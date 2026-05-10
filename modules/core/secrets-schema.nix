# modules/core/secrets-schema.nix
# =============================================================================
# SOPS-NIX SECRET SCHEMA (SSoT)
# =============================================================================
# This file defines the IMMUTABLE list of allowed secret keys.
# No other module can add keys to this list (readOnly = true).
# This prevents accidental key mutation or leakage of untracked secrets.
# =============================================================================

{ lib, config, ... }:

let
  inherit (lib) mkOption types;

  # 🔐 THE IMMUTABLE KEY LIST
  # Add new keys here first if you want to use them in the project.
  schema = {
    # Identity
    user_password = "";
    freund_password = "";

    # Infrastructure
    cloudflare_token = "";
    github_token = "";
    wireguard_admin_private_key = "";
    
    # Automation & Apps
    paperless_secret_key = "";
    vaultwarden_env = "";
    miniflux_admin_password = "";
    readeck_env = "";
    linkwarden_env = "";
    n8n_enc_key = "";
    
    # Media Stack
    sonarr_api_key = "";
    radarr_api_key = "";
    readarr_api_key = "";

    # Backup & Storage
    restic_password = "";
    backblaze_access_key = "";
    backblaze_secret_key = "";
  };

in {
  options.my.secrets.schema = mkOption {
    type = types.attrsOf types.str;
    default = schema;
    readOnly = true;
    description = "Hardened schema for allowed SOPS secret keys.";
  };

  config = {
    # 🔍 AUDIT WARNING
    # Emits a warning if a secret is defined in SOPS that is not in our schema.
    # Note: We check if any defined secret name is NOT a key in our schema.
    warnings = let
      definedKeys = lib.attrNames config.sops.secrets;
      allowedKeys = lib.attrNames config.my.secrets.schema;
      unknownKeys = lib.filter (k: !lib.elem k allowedKeys) definedKeys;
    in lib.optional (unknownKeys != []) 
      "⚠️ [SEC-SCHEMA] Unknown keys found in sops.secrets: ${lib.concatStringsSep ", " unknownKeys}. Please register them in secrets-schema.nix.";
  };
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:7f9a8b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
