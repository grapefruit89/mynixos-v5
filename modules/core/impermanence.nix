{ config, lib, ... }: {
 # 💾 hardened IMPERMANENCE (ADR 852)
 # Verwaltet die systemweiten Persistenz-Pfade für das Stateless-Root (tmpfs).
 # App-spezifische Pfade werden automatisch via mkService (lib-helpers) registriert.

  config = {
    # 🛡️ SYSTEM PERSISTENCE (Tier A: NVMe State)
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/nix"
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/lib/sops-nix"
        "/var/lib/bluetooth"
        "/var/lib/pocket-id"
        "/var/lib/caddy"
        "/var/lib/postgresql" # PostgreSQL socket, database runs on tmpfs
        "/home/moritz"
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };

    # 🚀 ROOT-ON-RAM SETUP (Stateless Manifesto)
    fileSystems."/" = lib.mkForce {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=4G" "mode=755" ];
    };

    fileSystems."/proc" = {
      device = "proc";
      fsType = "proc";
      options = [ "nosuid" "nodev" "noexec" "hidepid=2" ];
    };

    # Metadaten für die Traceability
    my.meta.impermanence = {
      id = "NIXH-00-COR-IMP";
      title = "Impermanence Core";
      description = "System-wide persistence for stateless root-on-RAM setup. Fixed for v6.0 (removed /nix/var).";
      layer = 0;
      audit.last_reviewed = "2026-05-06";
    };
  };
}
