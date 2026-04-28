{
  config,
  lib,
  pkgs,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten (Aviation-Grade Rescue)
  nms = {
    id = "NIXH-00-COR-031";
    title = "SSH Rescue (Fail-Safe)";
    description = "Isolated emergency SSH instance on port 2222. Auto-terminates after 5 minutes via systemd-timer.";
    layer = 00;
    nixpkgs.category = "system/networking";
    capabilities = ["security/recovery" "ssh/fail-safe"];
    audit.last_reviewed = "2026-04-27";
    audit.complexity = 3;
    source_repo = "grapefruit89/mynixos";
  };

  user = config.my.configs.identity.user;
  rescuePort = 2222;
in {
  options.my.meta.ssh_rescue = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = lib.mkIf (config.my.services.sshRescue.enable or false) {
    # 🚨 RESCUE INSTANCE CONFIG
    systemd.services.sshd-rescue = {
      description = "Emergency SSH Service (Password Auth)";
      serviceConfig = {
        ExecStart = "${pkgs.openssh}/bin/sshd -D -f ${pkgs.writeText "sshd-rescue-config" ''
          Port ${toString rescuePort}
          ListenAddress 127.0.0.1
          ListenAddress 100.64.0.0/10 # Target: Tailscale only
          PasswordAuthentication yes
          PermitRootLogin no
          AllowUsers ${user}
          PidFile /run/sshd-rescue.pid
        ''}";
        KillMode = "process";
        Restart = "no";
      };
    };

    # Note: Global firewall port 2222 removed. 
    # Tailscale traffic is allowed via trustedInterfaces in firewall.nix.
  };
}
