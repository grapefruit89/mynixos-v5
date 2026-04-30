{ config, lib, pkgs, ... }:
let
 # 🚀 NMS v4.2 Metadaten (hardened Setup)
 # Fragment-Sourcing:
 # - Fragment 6067: API-Setup Patterns
 # - Fragment 3331: LoadCredential for Secrets
 # - ADR 852: Path Alignment
 nms = {
 id = "NIXH-01-APP-SON-SET";
 title = "Sonarr API Setup";
 description = "Idempotent API configuration for Sonarr: Root Folders, Quality Profiles.";
 layer = 40;
 nixpkgs.category = "services/media";
 capabilities = ["automation/api" "media/tv" "security/sandboxing"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 cfg = config.my.media.sonarr;
 srePaths = config.my.configs.paths;
 
in
{
 options.my.meta.sonarr_setup = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = lib.mkIf cfg.enable {
 systemd.services.sonarr-setup = {
 description = "Sonarr API Configuration (hardened)";
 after = [ "sonarr.service" "network.target" ];
 requires = [ "sonarr.service" ];
 wantedBy = [ "multi-user.target" ];

 serviceConfig = {
 Type = "oneshot";
 User = cfg.user;
 Group = cfg.group;
 
 # 🔑 SECRETS (Source: Fragment 3331)
 LoadCredential = lib.optional (cfg.apiKeyFile != null) "sonarr-api-key:${toString cfg.apiKeyFile}";
 
 # 🛡️ SANDBOXING
 ProtectSystem = "strict";
 ProtectHome = true;
 PrivateTmp = true;
 NoNewPrivileges = true;
 
 ExecStart = pkgs.writeShellScript "sonarr-setup-script" ''
 set -euo pipefail
 
 # 1. API-Key beziehen
 if [ -d "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/sonarr-api-key" ]; then
 API_KEY=$(cat "$CREDENTIALS_DIRECTORY/sonarr-api-key")
 else
 echo "🛑 ERROR: Sonarr API key not found in credentials directory."
 exit 1
 fi

 URL="http://127.0.0.1:${toString cfg.settings.server.port}/api/v3"

 # Warten bis Sonarr bereit ist (Max 60s)
 echo "⏳ Waiting for Sonarr API..."
 for i in {1..12}; do
 if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $API_KEY" "$URL/system/status" > /dev/null; then
 echo "✅ Sonarr API is online."
 break
 fi
 if [ $i -eq 12 ]; then
 echo "🛑 ERROR: Sonarr API timed out."
 exit 1
 fi
 sleep 5
 done

 # 📁 2. ROOT FOLDER ANLEGEN (Idempotent)
 ROOT_PATH="${srePaths.mediaLibrary}/tv"
 echo "📁 Checking root folder: $ROOT_PATH"
 
 EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $API_KEY" "$URL/rootfolder" | \
 ${pkgs.jq}/bin/jq -r ".[] | select(.path == \"$ROOT_PATH\") | .id")

 if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
 ${pkgs.curl}/bin/curl -s -X POST "$URL/rootfolder" \
 -H "X-Api-Key: $API_KEY" \
 -H "Content-Type: application/json" \
 -d "{\"path\":\"$ROOT_PATH\"}" > /dev/null
 echo "✅ Created root folder $ROOT_PATH"
 else
 echo "ℹ️ Root folder $ROOT_PATH already exists (ID: $EXISTING)"
 fi

 echo "✅ API Setup for Sonarr completed successfully."
 '';
 
 RemainAfterExit = true;
 };
 };
 };
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f8\n * eof_marker: NIXHOME_VALID_EOF* ---\n */
