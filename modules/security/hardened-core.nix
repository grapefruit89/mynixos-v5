{ config, lib, pkgs, ... }:
let
 cfg = config.my.security.hardened;
 nms = {
 id = "NIXH-00-SEC-COR-001";
 title = "Hardened Core (fortress)";
 description = "Master security module implementing kernel lockdown, massive blacklisting, and service slimming.";
 layer = 00;
 audit.last_reviewed = "2026-04-28";
 audit.complexity = 4;
 };
in {
 options.my.security.hardened = {
 enable = lib.mkEnableOption "Hardened Core Hardening";
 lockdownMode = lib.mkOption {
 type = lib.types.enum [ "strict" "permissive" ];
 default = "permissive";
 description = "strict: Kernellock enable, permissive: Kernellock disable";
 };
 };
 config = lib.mkIf cfg.enable (lib.mkMerge [
 {
 boot.kernelPackages = pkgs.linuxPackages_hardened;
 security.lockKernelModules = cfg.lockdownMode == "strict";
 boot.kernelModules = [ "veth" "loop" "nvme" "ahci" "usb_storage" "tun" ];
 security.hideProcessInformation = true;
 boot.kernel.sysctl = {
 "kernel.unprivileged_userns_clone" = 1;
 "vm.unprivileged_userfaultfd" = 0;
 "kernel.printk" = "3 3 3 3";
 "kernel.kptr_restrict" = 2;
 "kernel.dmesg_restrict" = 1;
 "kernel.unprivileged_bpf_disabled" = 1;
 "net.core.bpf_jit_harden" = 2;
 "kernel.yama.ptrace_scope" = 2;
 "kernel.ftrace_enabled" = false;
 "net.ipv4.conf.all.rp_filter" = 1;
 "net.ipv4.conf.default.rp_filter" = 1;
 "net.ipv4.tcp_syncookies" = 1;
 "net.ipv4.tcp_rfc1337" = 1;
 "kernel.core_pattern" = "|/bin/false";
 "net.ipv4.icmp_echo_ignore_broadcasts" = true;
 "net.ipv4.conf.all.accept_redirects" = false;
 "net.ipv4.conf.default.accept_redirects" = false;
 "net.ipv6.conf.all.accept_redirects" = false;
 "net.ipv6.conf.default.accept_redirects" = false;
 "fs.protected_symlinks" = 1;
 "fs.protected_hardlinks" = 1;
 "fs.protected_fifos" = 1;
 "fs.protected_regular" = 1;
 };
 }
 {
 boot.blacklistedKernelModules = [
 "bluetooth" "btusb" "btrtl" "btbcm" "btintel" "bnep" "rfcomm" "thunderbolt"
 "iwlwifi" "ath9k" "ath10k_core" "ath10k_pci" "rtl8192ce" "rtl8192cu" "rtl8192de" "rtl8188ee" "mt76" "brcmfmac" "brcmutil"
 "nouveau" "radeon" "amdgpu" "mgag200" "ast"
 "ax25" "netrom" "rose"
 "ext2" "ext3" "jfs" "reiserfs" "hfs" "hfsplus" "ntfs" "cramfs" "freevxfs" "minix" "nilfs2" "sysv" "ufs"
 "pcspkr"
 "snd_hda_intel" "uvcvideo" "videodev" "ppp" "ip6table_filter"
 ];
 }
 {
 systemd.services = {
 accounts-daemon.enable = false;
 ModemManager.enable = false;
 udisks2.enable = false;
 upower.enable = false;
 cups.enable = false;
 bluetooth.enable = false;
 wpa_supplicant.enable = false;
 pcscd.enable = false;
 };
 systemd.maskedUnits = [ "plymouth-quit-wait.service" "systemd-networkd-wait-online.service" ];
 systemd.coredump.enable = false;

 fileSystems."/proc" = {
 fsType = "proc";
 options = [ "hidepid=2" ];
 };
 fileSystems."/tmp" = {
 fsType = "tmpfs";
 options = [ "noexec" "nosuid" "nodev" "mode=1777" ];
 };
 }
 { my.meta.hardened_core = nms; }
 ]);
}
