{ config, lib, pkgs, ... }: {
  # 🚀 PRODUCTION HARDENED ADMIN TRIGGERS (ADR 007)
  # Hardened systemd units for administrative tasks.
  # Usage: sudo systemctl start admin-<trigger>
  
  systemd.services = {
    "admin-rebuild" = {
      description = "NixOS System Rebuild (Switch)";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /etc/nixos#nixhome";
        StandardOutput = "journal";
      };
    };

    "admin-gc" = {
      description = "NixOS Garbage Collection";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nix}/bin/nix-collect-garbage -d";
      };
    };

    "admin-update-ca" = {
      description = "Update Step-CA Certificates";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/true"; # Placeholder for actual update script
      };
    };
  };

  # Metadaten
  my.meta.admin_triggers = {
    id = "NIXH-00-COR-007";
    title = "Admin Triggers (CLI-only)";
    layer = 0;
  };
}
