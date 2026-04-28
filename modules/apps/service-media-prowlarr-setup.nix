{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Prowlarr Sync)
  nms = {
    id = "NIXH-01-APP-PRO-SET";
    title = "Prowlarr Indexer Sync";
    description = "Idempotent API configuration for Prowlarr: Registering Radarr and Sonarr.";
    layer = 40;
    nixpkgs.category = "services/media";
    capabilities = ["automation/api" "media/indexer-management" "security/sandboxing"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
  };

  prowlarrCfg = config.my.media.prowlarr;
  radarrCfg = config.my.media.radarr;
  sonarrCfg = config.my.media.sonarr;

in
{
  options.my.meta.prowlarr_setup = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = lib.mkIf prowlarrCfg.enable {
    systemd.services.prowlarr-setup = {
      description = "Prowlarr Indexer Sync (Aviation-Grade)";
      after = [ "prowlarr.service" "radarr.service" "sonarr.service" "network.target" ];
      requires = [ "prowlarr.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        User = prowlarrCfg.user;
        Group = prowlarrCfg.group;
        
        # 🔑 SECRETS ISOLATION
        LoadCredential = lib.flatten [
          (lib.optional (prowlarrCfg.apiKeyFile != null) "prowlarr-api-key:${toString prowlarrCfg.apiKeyFile}")
          (lib.optional (radarrCfg.apiKeyFile != null) "radarr-api-key:${toString radarrCfg.apiKeyFile}")
          (lib.optional (sonarrCfg.apiKeyFile != null) "sonarr-api-key:${toString sonarrCfg.apiKeyFile}")
        ];
        
        # 🛡️ SANDBOXING
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
        
        ExecStart = pkgs.writeShellScript "prowlarr-setup-script" ''
          set -euo pipefail
          
          # 1. API-Keys beziehen
          get_key() {
            if [ -f "$CREDENTIALS_DIRECTORY/$1" ]; then cat "$CREDENTIALS_DIRECTORY/$1"; else echo ""; fi
          }

          PROWLARR_KEY=$(get_key "prowlarr-api-key")
          RADARR_KEY=$(get_key "radarr-api-key")
          SONARR_KEY=$(get_key "sonarr-api-key")

          if [ -z "$PROWLARR_KEY" ]; then
            echo "🛑 ERROR: Prowlarr API key missing."
            exit 1
          fi

          PROWLARR_URL="http://127.0.0.1:${toString prowlarrCfg.settings.server.port}/api/v1"

          # Warten bis Prowlarr bereit ist
          echo "⏳ Waiting for Prowlarr API..."
          for i in {1..12}; do
            if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $PROWLARR_KEY" "$PROWLARR_URL/system/status" > /dev/null; then
              echo "✅ Prowlarr API is online."
              break
            fi
            sleep 5
          done

          # 🛠️ HELPER: Anwendung registrieren
          register_app() {
            local name=$1
            local port=$2
            local key=$3
            local implementation=$4

            if [ -z "$key" ]; then
              echo "⚠️ Skipping $name: No API key provided."
              return
            fi

            echo "🔗 Checking $name integration..."
            EXISTING=$(${pkgs.curl}/bin/curl -s -H "X-Api-Key: $PROWLARR_KEY" "$PROWLARR_URL/applications" | \
              ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$name\") | .id")

            if [ -z "$EXISTING" ] || [ "$EXISTING" == "null" ]; then
              echo "➕ Registering $name in Prowlarr..."
              ${pkgs.curl}/bin/curl -s -X POST "$PROWLARR_URL/applications" \
                -H "X-Api-Key: $PROWLARR_KEY" \
                -H "Content-Type: application/json" \
                -d "{
                  \"name\": \"$name\",
                  \"configContract\": \"$implementation\",
                  \"implementation\": \"$implementation\",
                  \"fields\": [
                    {\"name\": \"baseUrl\", \"value\": \"http://127.0.0.1:$port\"},
                    {\"name\": \"apiKey\", \"value\": \"$key\"}
                  ],
                  \"syncLevel\": \"fullAndIndexers\"
                }" > /dev/null
              echo "✅ $name registered."
            else
              echo "ℹ️ $name already registered (ID: $EXISTING)."
            fi
          }

          # 🚀 APPS REGISTRIEREN
          register_app "Radarr" "${toString radarrCfg.settings.server.port}" "$RADARR_KEY" "Radarr"
          register_app "Sonarr" "${toString sonarrCfg.settings.server.port}" "$SONARR_KEY" "Sonarr"

          echo "✅ Prowlarr Indexer Sync setup completed."
        '';
        
        RemainAfterExit = true;
      };
    };
  };
}
/**
 * ---\n * technical_integrity:\n *   checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f8\n *   eof_marker: NIXHOME_VALID_EOF* ---\n */
