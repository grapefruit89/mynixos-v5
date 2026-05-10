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
 description = "hardened Runtime Security Check";
 serviceConfig = {
 Type = "oneshot";
 User = "root";
 };
 script = ''
 set -euo pipefail
 
 # 1. Check Firewall (nftables active)
 if ! ${pkgs.nftables}/bin/nft list tables | ${pkgs.gnugrep}/bin/grep -q -- "inet filter"; then
 echo "🛑 SECURITY ALERT: nftables filter table is MISSING!"
 exit 1
 fi

 # 2. Check Kernel Lockdown Status
 if [ -d /sys/kernel/security/lockdown ]; then
 LOCKDOWN=$(${pkgs.coreutils}/bin/cat -- /sys/kernel/security/lockdown | ${pkgs.gnugrep}/bin/grep -o '\[.*\]' | ${pkgs.gnused}/bin/sed 's/\[//;s/\]//')
 if [ "$LOCKDOWN" != "confidentiality" ] && [ "$LOCKDOWN" != "integrity" ]; then
 echo "🛑 SECURITY ALERT: Kernel Lockdown is NOT effective (Current: $LOCKDOWN)"
 fi
 fi

 # 3. Check SSH Root Login (Runtime check via sshd -T)
 if ${pkgs.openssh}/bin/sshd -T | ${pkgs.gnugrep}/bin/grep -q -- "permitrootlogin yes"; then
 echo "🛑 SECURITY ALERT: sshd allows root login in active config!"
 exit 1
 fi

        # 4. Check Admin-Zone Alias (127.0.0.2)
        if ! ${pkgs.iproute2}/bin/ip addr show lo | grep -q "127.0.0.2"; then
          echo "🛑 SECURITY ALERT: Admin-Hangar Alias 127.0.0.2 is MISSING!"
          exit 1
        fi

 systemd.timers.security-watchdog = {
 wantedBy = [ "timers.target" ];
 timerConfig = {
 OnCalendar = config.my.security.runtime-guard.interval;
 Persistent = true;
 };
 };
 };
}
