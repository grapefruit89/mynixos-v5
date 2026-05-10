{ config, lib, pkgs, ... }: {
  # 🔐 HARDWARE-BOUND SECURITY (TPM 2.0)
  # Enables support for TPM-backed LUKS unlocking.

  config = {
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;          # PKCS#11 interface for browser/OpenSSL
      tctiEnvironment.enable = true; # Helper variables
    };

    # Add primary user to tss group for TPM access
    users.users.${config.my.configs.identity.user}.extraGroups = [ "tss" ];

    # Standard metadata for traceability
    my.meta.tpm = {
      id = "NIXH-00-SEC-TPM";
      title = "TPM 2.0 Integration";
      description = "Hardware-bound identity and storage encryption support.";
      layer = 90;
      audit.last_reviewed = "2026-05-05";
    };
  };
}
