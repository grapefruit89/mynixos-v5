{ config, lib, pkgs, ... }:
let
  cfg = config.my.security.zeroTrustSecrets;
in
{
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
