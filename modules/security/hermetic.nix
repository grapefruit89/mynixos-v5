# modules/security/hermetic.nix
# =============================================================================
# HERMETIC: HARDWARE-BOUND IDENTITY (TPM 2.0)
# =============================================================================
# Anchors administrative SSH access to the physical TPM 2.0 chip.
# Implements 'sk-ssh-ed25519' for multi-factor authentication without YubiKey.
# =============================================================================

{ config, lib, pkgs, ... }:

let
  cfg = config.my.security.hermetic;
  user = config.my.configs.identity.user;
  
  # 🚀 NMS v6.0 Metadata
  nms = {
    id = "NIXH-90-SEC-HRM";
    title = "Hermetic (TPM Identity)";
    description = "TPM-bound SSH identity provider for aviation-grade administrative access.";
    layer = 90;
    capabilities = ["security/tpm" "security/ssh-sk" "identity/hardware-bound"];
    audit.last_reviewed = "2026-05-09";
    audit.complexity = 3;
  };

in {
  options.my.security.hermetic = {
    enable = lib.mkEnableOption "Hermetic TPM-bound Identity";
    
    enforceHardwareKeys = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Restrict SSH access to hardware-backed (SK) keys only.";
    };
  };

  config = lib.mkIf cfg.enable {
    # 🧬 METADATA
    my.meta.hermetic = nms;

    # 🛠️ TPM SYSTEM REQUIREMENTS
    # (Redundant check but ensures consistency)
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      abrmd.enable = true; # Userspace Resource Manager
      tctiEnvironment.enable = true;
    };

    # 🔑 SSH HARDENING
    services.openssh = {
      # Allow Security Keys (FIDO2/TPM-backed)
      settings.PubkeyAuthentication = "yes";
      
      # Strict key restriction if enforced
      extraConfig = lib.optionalString cfg.enforceHardwareKeys ''
        # aviation-grade: only allow security-key algorithms
        PubkeyAcceptedKeyTypes sk-ssh-ed25519@openssh.com
      '';
    };

    # 📦 TOOLS FOR TPM KEY GENERATION & MANAGEMENT
    environment.systemPackages = with pkgs; [
      tpm2-tools
      tpm2-tss
      tpm2-pkcs11
      openssh
      openssl
    ];

    # 👤 USER PERMISSIONS
    users.users.${user}.extraGroups = [ "tss" ];

    # 🛡️ FORBIDDEN TECH WARNINGS (Dynamic Integration)
    warnings = lib.optional (!config.security.tpm2.enable) 
      "⚠️ [HERMETIC] TPM 2.0 is not enabled. Hardware-bound identity will not function.";
  };
}
