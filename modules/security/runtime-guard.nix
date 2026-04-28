{ config, lib, pkgs, ... }:
let
  nms = {
    id = "NIXH-90-POL-002";
    title = "Runtime Security Watchdog";
    description = "Checks active system state (not just config) and alerts on violations.";
    layer = 90;
  };
in
{
  options.my.security.runtime-guard = {
    enable = lib.mkEnableOption "Runtime Security Monitoring";
    interval = lib.mkOption { type = lib.types.str; default = "hourly"; };
  };

  config = lib.mkIf config.my.security.runtime-guard.enable {
    my.meta.runtime_guard = nms;

    systemd.services.security-watchdog = {
      description = "Aviation-Grade Runtime Security Check";
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      script = ''
        set -euo pipefail
        
        # 1. Check Firewall (nftables active)
        if ! ${pkgs.nftables}/bin/nft list tables | grep -q "inet filter"; then
          echo "🛑 SECURITY ALERT: nftables filter table is MISSING!"
          exit 1
        fi

        # 2. Check Kernel Lockdown Status
        if [ -d /sys/kernel/security/lockdown ]; then
          LOCKDOWN=$(cat /sys/kernel/security/lockdown | grep -o '\[.*\]' | tr -d '[]')
          if [ "$LOCKDOWN" != "confidentiality" ] && [ "$LOCKDOWN" != "integrity" ]; then
             echo "🛑 SECURITY ALERT: Kernel Lockdown is NOT effective (Current: $LOCKDOWN)"
             # Optional: ntfy trigger
          fi
        fi

        # 3. Check SSH Root Login (Runtime check via sshd -T)
        if ${pkgs.openssh}/bin/sshd -T | grep -q "permitrootlogin yes"; then
          echo "🛑 SECURITY ALERT: sshd allows root login in active config!"
          exit 1
        fi

        echo "✅ Runtime Security Check passed."
      '';
    };

    systemd.timers.security-watchdog = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = config.my.security.runtime-guard.interval;
        Persistent = true;
      };
    };
  };
}
