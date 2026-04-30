{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Audit)
 nms = {
 id = "NIXH-00-COR-017";
 title = "Kernel Slim (Advanced Hardened)";
 description = "hardened optimized and hardened kernel. Max security via slab_nomerge and poison-paging.";
 layer = 00;
 nixpkgs.category = "system/boot";
 capabilities = ["kernel/hardening" "system/performance" "security/sysctl"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };

 ramBenchmark = pkgs.writeShellScriptBin "ram-benchmark" ''
 #!/usr/bin/env bash
 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
 echo "🔬 Kernel RAM-Footprint Analyse"
 echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
 TOTAL=$(free -m | awk 'NR==2 {print $2}')
 USED=$(free -m | awk 'NR==2 {print $3}')
 echo "Gesamt-RAM: ''${TOTAL} MB"
 echo "Verwendet: ''${USED} MB"
 MODULES=$(lsmod | wc -l)
 echo "Geladene Module: $((MODULES - 1))"
 '';
in {
 options.my.meta.kernel_slim = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for kernel-slim module";
 };

 config = lib.mkIf (config.my.services.kernelSlim.enable) {
 boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

 # 🛡️ MODULE BLACKLIST (Minimal Surface Area)
 boot.blacklistedKernelModules = [
 "bluetooth" "btusb" "btrtl" "btbcm" "btintel" "bnep" "rfcomm"
 "iwlwifi" "ath9k" "ath10k_core" "ath10k_pci" "rtl8192ce" 
 "rtl8192cu" "rtl8192de" "rtl8188ee" "mt76" "brcmfmac" "brcmutil"
 "nouveau" "radeon" "amdgpu" "mgag200" "ast" "pcspkr" "iTCO_wdt"
 "thunderbolt"
 ];

 # 🏎️ KERNEL SYSCTL HARDENING
 boot.kernel.sysctl = {
 # IPv4/v6 Stack Hardening
 "net.ipv4.conf.all.rp_filter" = lib.mkForce 1;
 "net.ipv4.conf.default.rp_filter" = lib.mkForce 1;
 "net.ipv4.tcp_syncookies" = lib.mkForce 1;
 "net.ipv4.icmp_echo_ignore_broadcasts" = true;
 "net.ipv4.conf.all.accept_redirects" = false;
 "net.ipv4.conf.all.secure_redirects" = false;
 
 # Security & Integrity
 "kernel.kptr_restrict" = lib.mkForce 2;
 "kernel.dmesg_restrict" = lib.mkForce 1;
 "kernel.unprivileged_bpf_disabled" = 1; 
 "net.core.bpf_jit_enable" = false; # 🛡️ Against JIT spray
 "kernel.ftrace_enabled" = false;
 "kernel.perf_event_paranoid" = 3;

 # Memory & Performance
 "vm.vfs_cache_pressure" = 50;
 };

 # 💎 BOOT TIME HARDENING (From NixOS Wiki & Fragments)
 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "slab_nomerge" # Prevents heap grooming
 "page_poison=1" # Overwrites free'd pages
 "page_alloc.shuffle=1" # Randomizes page allocation
 "debugfs=off" # Closes debug attack vector
 ];

 boot.initrd.availableKernelModules = lib.mkForce ["ahci" "sd_mod" "xhci_pci" "usbhid" "usb_storage"];

 environment.systemPackages = with pkgs; [
 linuxPackages_latest.perf
 ramBenchmark
 kmod pciutils usbutils
 ];

 programs.bash.shellAliases = { ram-bench = "${ramBenchmark}/bin/ram-benchmark"; };

 systemd.services.kernel-slim-info = {
 description = "Kernel Slim Info Banner";
 wantedBy = ["multi-user.target"];
 serviceConfig = { Type = "oneshot"; RemainAfterExit = true; };
 script = ''
 logger -t kernel-slim "hardened Hardened Kernel loaded"
 MODULES=$(lsmod | wc -l)
 logger -t kernel-slim "Loaded modules: $((MODULES - 1))"
 '';
 };
 };
}
