{
  config,
  lib,
  pkgs,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Stability)
  nms = {
    id = "NIXH-00-COR-034";
    title = "System Stability (SRE Guard)";
    description = "Proactive maintenance and fail-safe logic (Watchdogs, Kernel-Panic, EFI-Cleanup).";
    layer = 00;
    nixpkgs.category = "system/settings";
    capabilities = ["system/maintenance" "safety/watchdog" "safety/recovery"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
    source_repo = "grapefruit89/mynixos";
  };
in {
  options.my.meta.system_stability = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = {
    # 🐕 HARDWARE WATCHDOG (Fragment 958)
    # Rebootet das System automatisch bei Totalausfall (Hang)
    systemd.watchdog.runtimeTime = "30s";
    systemd.watchdog.rebootTime = "10min";

    # 🏎️ KERNEL PANIC HANDLING
    boot.kernel.sysctl = {
      "kernel.panic" = 10; # Reboot nach 10 Sek bei Panic
      "kernel.panic_on_oops" = 1;
      "vm.panic_on_oom" = 0; # OOM-Killer bevorzugt vor Reboot
    };

    # 🧹 EFI ACTIVATION CLEANUP
    system.activationScripts.cleanEfiEntries = {
      text = ''
        echo "🧹 Aviation-Grade: Bereinige verwaiste EFI-Boot-Einträge..."
        ${pkgs.efibootmgr}/bin/efibootmgr | grep "Boot[0-9]" | grep -vE "systemd-boot|NixOS|Linux|USB|Hard Drive|Network" | \
          ${pkgs.gawk}/bin/awk '{print $1}' | ${pkgs.gnused}/bin/sed 's/Boot//;s/\*//' | \
          xargs -I{} ${pkgs.efibootmgr}/bin/efibootmgr -b {} -B 2>/dev/null || true
      '';
    };

    # 🚨 EMERGENCY LOGGING
    systemd.services.nixhome-emergency = {
      description = "NixOS Home Emergency Recovery Info";
      serviceConfig = {
        Type = "oneshot";
        StandardOutput = "tty";
        TTYPath = "/dev/tty1";
      };
      script = ''
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🚨 NIXHOME v4.2 SYSTEM STABILITY ALERT"
        echo "Manual Recovery: Use SSH Rescue Port 2222"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" > /dev/tty1
      '';
    };
  };
}
/**
 * ---\n * technical_integrity:\n *   checksum: sha256:e918cb5d57d4499c77e11342fca451e92f6cd82723a69131a8b84c7bec01214f\n *   eof_marker: NIXHOME_VALID_EOF* ---\n */
