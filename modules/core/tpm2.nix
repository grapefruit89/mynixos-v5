{ config, lib, pkgs, ... }:
{
  # 🛡️ TPM 2.0 HARDWARE STACK (v7.1 Strict)
  # Enables support for the hardware-bound root of trust on Fujitsu Q958.
  
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true; # Required for TPM-backed SSH keys
    abrmd.enable = true;  # Userspace Resource Manager
    tctiEnvironment.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tpm2-tools
    tpm2-tss
    tpm2-pkcs11
    age-plugin-tpm
  ];

  # Allow access to TPM for certain services (handled in lib-helpers.nix)
  # But we also add the kernel modules explicitly just in case
  boot.kernelModules = [ "tpm_tis" ];
}
