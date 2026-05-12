# ---
# nms_id: APP-DOCS-PAPERLESS
# title: Paperless-ngx
# capabilities: ["docs/management"]
# status: "hardened"
# tier_strategy: "ABC-v5.1"
# ---
{ config, lib, pkgs, myLib, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Paperless-ngx)
 # Fragment-Sourcing:
 # - NIXH-01-APP-PAP-001: Vorherige Version
 # - Fragment: Valkey Integration (Open-Source Redis Alternative)
 nms = {
 id = "NIXH-01-APP-PAP-002";
 title = "Paperless-ngx (hardened)";
 description = "Hardened document management system with Valkey and PostgreSQL.";
 layer = 50;
 nixpkgs.category = "services/misc";
 capabilities = ["knowledge/documents" "security/sandboxing" "database/postgres" "caching/valkey"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 };

 cfg = config.my.apps.paperless;
 srePaths = config.my.configs.paths;
 
in
{
 options.my.meta.paperless = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

  options.my.apps.paperless = {
    enable = lib.mkEnableOption "Paperless-ngx Document Management";
    secretFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = config.sops.secrets.paperless_secret_key.path;
      description = "Path to Paperless Secret Key (via Sops)";
    };
  };

 config = lib.mkIf cfg.enable (lib.mkMerge [
 
 # 📄 1. hardened DOCUMENT APP FABRIK
 (myLib.mkDocumentApp {
 inherit config;
 name = "paperless";
 port = config.my.ports.paperless or 28981;
 description = "Paperless-ngx Document Management";
 useValkey = true; # 🔥 Nutzt die Open-Source Alternative zu Redis
 usePostgres = true;
 inherit (cfg) secretFile;
 ocrLanguages = [ "deu" "eng" ];
 })

 # 🔧 2. PAPERLESS SPECIFICS & ENVIRONMENT
 {
 services.paperless = {
 enable = true;
 user = "paperless";
 address = "127.0.0.1";
 port = config.my.ports.paperless or 28981;
 };

 systemd.services.paperless-web = {
 environment = {
 PAPERLESS_URL = "https://paperless.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
 PAPERLESS_TIME_ZONE = config.my.configs.locale.timezone;
 PAPERLESS_OCR_LANGUAGE = "deu+eng";
 
 # ABC-Tiering Paths (Source: ADR 852)
 PAPERLESS_DATA_DIR = "${srePaths.stateDir}/paperless";
 PAPERLESS_MEDIA_ROOT = "${srePaths.mediaLibrary}/documents/paperless";
 PAPERLESS_CONSUMPTION_DIR = "${srePaths.privateData}/consume/paperless";
 
 # Database & Valkey Wiring
 PAPERLESS_DBHOST = "/run/postgresql";
 PAPERLESS_DBNAME = "paperless";
 PAPERLESS_DBUSER = "paperless";
 # Paperless spricht mit Valkey über den Unix-Socket des fabrik-eigenen Servers
 PAPERLESS_REDIS = "unix://${config.services.redis.servers.paperless.unixSocket}";
 };
 
 serviceConfig.EnvironmentFile = lib.optional (cfg.secretFile != null) cfg.secretFile;
 };

 # Mirror environment to worker for processing
 systemd.services.paperless-worker.environment = config.systemd.services.paperless-web.environment;
 }
 ]);
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f9\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
