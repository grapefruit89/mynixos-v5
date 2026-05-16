# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-090-SEC-COR-001",
#   "title": "Hardened Core (fortress)",
#   "layer": 90,
#   "category": "core/security",
#   "lastReviewed": "2026-05-15",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 3,
#   "tags": ["security", "hardening", "sandboxing"],
#   "description": "Master security module implementing service slimming and additional system-level hardening."
# }
# ---ENDNIXMETA

{ config, lib, ... }:

let
  cfg = config.my.security.hardened;
in {
  options.my.security.hardened = {
    enable = lib.mkEnableOption "Hardened Core Hardening";
    lockdownMode = lib.mkOption {
      type = lib.types.enum [ "strict" "permissive" ];
      default = "permissive";
      description = "strict: Kernellock enable, permissive: Kernellock disable";
    };
  };

  config = lib.mkIf cfg.enable {
    # 🛡️ SYSTEM-LEVEL HARDENING (v6.1 Strict)
    security.lockKernelModules = cfg.lockdownMode == "strict";
    security.hideProcessInformation = true;

    # 🧹 SERVICE SLIMMING (Eliminating Attack Surface)
    systemd.services = {
      accounts-daemon.enable = false;
      ModemManager.enable = false;
      udisks2.enable = false;
      upower.enable = false;
      cups.enable = false;
      bluetooth.enable = false;
      wpa_supplicant.enable = false;
    };

    systemd.maskedUnits = [ 
      "plymouth-quit-wait.service" 
      "systemd-networkd-wait-online.service" 
    ];
    
    systemd.coredump.enable = false;

    # 📊 METADATA INTEGRATION
    my.meta.hardened_core = {
      id = "NIXH-SEC-COR";
      title = "Hardened Core";
      layer = 90;
      audit.last_reviewed = "2026-05-15";
    };
  };
}
