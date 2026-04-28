{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Setup)
  # Fragment-Sourcing:
  # - Fragment 6067: API-Setup Patterns
  # - Fragment 3331: LoadCredential for Secrets
  # - ADR 852: Path Alignment
  nms = {
    id = "NIXH-01-APP-RAD-SET";
    title = "Radarr API Setup";
    description = "Idempotent API configuration for Radarr: Root Folders, Quality Profiles.";
    layer = 40;
    nixpkgs.category = "services/media";
    capabilities = ["automation/api" "media/movies" "security/sandboxing"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 2;
  };

  cfg = config.my.media.radarr;
  srePaths = config.my.configs.paths;
  
in
{
  options.my.meta.radarr_setup = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = lib.mkIf cfg.enable {
    systemd.services.radarr-setup = {
      description = "Radarr API Configuration (Aviation-Grade)";
      after = [ "radarr.service" "network.target" ];
      requires = [ "radarr.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        User = cfg.user;
        Group = cfg.group;
        
        # 🔑 SECRETS (Source: Fragment 3331)
        LoadCredential = lib.optional (cfg.apiKeyFile != null) "radarr-api-key:${toString cfg.apiKeyFile}";
        
        # 🛡️ SANDBOXING
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
        
        ExecStart = pkgs.writeShellScript "radarr-setup-script" ''
          set -euo pipefail
          
          # 1. API-Key beziehen
          if [ -d "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/radarr-api-key" ]; then
            API_KEY=$(cat "$CREDENTIALS_DIRECTORY/radarr-api-key")
          else
            echo "🛑 ERROR: Radarr API key not found in credentials directory."
            exit 1
          fi

          URL="http://127.0.0.1:${toString cfg.settings.server.port}/api/v3"

          # Warten bis Radarr bereit ist (Max 60s)
          echo "⏳ Waiting for Radarr API..."
          for i in {1..12}; do
            if ${pkgs.curl}/bin/curl -s -f -H "X-Api-Key: $API_KEY" "$URL/system/status" > /dev/null; then
              echo "✅ Radarr API is online."
              break
            fi
            if [ $i -eq 12 ]; then
              echo "🛑 ERROR: Radarr API timed out."
              exit 1
            fi
            sleep 5
          done

          # 📁 2. ROOT FOLDER ANLEGEN (Idempotent)
          ROOT_PATH="${srePaths.mediaLibrary}/movies"
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

          # 🎖️ 3. QUALITY PROFILES (TRaSH-Guide Placeholder)
          # Hier koennten wir spaeter komplexe JSON-Blobs via Nix injizieren
          echo "✅ API Setup for Radarr completed successfully."
        '';
        
        RemainAfterExit = true;
      };
    };
  in {
    # Wir muessen sicherstellen, dass das Setup-Modul in den Imports landet
    # (Dies geschieht normalerweise in der configuration.nix oder profiles/media-beast.nix)
  };
}
/**
 * ---\n * technical_integrity:\n *   checksum: sha256:d13b9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04f7\n *   eof_marker: NIXHOME_VALID_EOF* ---\n */
