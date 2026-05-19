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

{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-90-SEC-004";
    title = "Zero-Trust Secrets (Native)";
    description = "TPM2-backed native secrets decryptor service for hardware-bound identity and zero-trust ingestion.";
    layer = 90;
    nixpkgs.category = "security/secrets";
    capabilities = ["security/zero-trust" "identity/tpm2" "sops/native-decryption"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 3;
  };

  cfg = config.my.security.zeroTrustSecrets;
in
{
  options.my.meta.zero_trust_secrets = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

  options.my.security.zeroTrustSecrets = {
    enable = lib.mkEnableOption "Zero-Trust Secrets (Native Decryptor)";
    secretsFile = lib.mkOption {
      type = lib.types.path;
      default = ../../secrets/secrets.yaml;
      description = "Path to the encrypted SOPS secrets file.";
    };
  };

  config = lib.mkIf cfg.enable {
    # 🛠️ Systemd Decryptor Service
    systemd.services.secrets-decryptor = {
      description = "Zero-Trust Native Secrets Decryptor";
      wantedBy = [ "multi-user.target" ];
      before = [ "network.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = false;
        ExecStart = "${pkgs.bash}/bin/bash ${../../scripts/secrets-decryptor.sh}";
        
        # 🛡️ Sandboxing
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
        CapabilityBoundingSet = "";
        PrivateUsers = true;
        RestrictAddressFamilies = [ "AF_UNIX" ];
        SystemCallFilter = [ "@system-service" "~@privileged" "~@mount" "~@swap" ];

        # Benötigt Zugriff auf /persist/etc/ssh für den Key und /run/secrets für den Output
        # Sowie Zugriff auf den TPM-Chip
        ReadWritePaths = [ "/run/secrets" ];
        ReadOnlyPaths = [ "/persist/etc/ssh" "/etc/nixos/secrets" "/persist/secrets" ];
        DeviceAllow = [ "/dev/tpmrm0 rw" ];
      };
      
      path = with pkgs; [ tpm2-tools sops age ];
      
      # Übergebe Pfade via Environment an das Skript
      environment = {
        SOPS_FILE = toString cfg.secretsFile;
      };
    };

    # Stelle sicher, dass sops & age installiert sind
    environment.systemPackages = [ pkgs.sops pkgs.age ];
  };
}
