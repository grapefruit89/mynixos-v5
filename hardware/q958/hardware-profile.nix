{ config, lib, pkgs, myLib, ... }: 
let
 cfg = config.my.hardware;
in
{
 # 🚀 hardened HARDWARE PROFILE: FUJITSU Q958
 # Optimized for Intel Coffee Lake (Gen 9) & UHD Graphics 630.

 imports = [
 ../../modules/storage/storage-mover.nix
 ];
 
 config = lib.mkIf (cfg.profile == "q958") {
 
 # 💾 STORAGE TIERING MOVER
 my.storage.mover.enable = true;

 # 🧠 CPU & KERNEL TUNING
 boot.kernelPackages = pkgs.linuxPackages_latest; # Latest kernel for best CFL support

 boot.kernelParams = [
 "quiet"
 "mitigations=auto"
 
 # ⚡ Power & Stability (hardened Selection)
 "acpi_osi=Linux" # Better power management (Fragment 975)
 "i915.enable_guc=3" # GuC/HuC Firmware for QSV/HEVC (Fragment 2272)
 "i915.enable_fbc=1" # Frame Buffer Compression (Saves power)
 "i915.fastboot=1" # Cleaner boot transition
 "intel_idle.max_cstate=4" # Balance between power saving and C-state exit latency stability
 "ibt=off" # Disable Indirect Branch Tracking (Workaround for some CFL issues)
 "intel_pstate=passive" # Use passive mode to allow TLP/thermald better control
 ];

 boot.kernelModules = [ "kvm_intel" ];

 # 🖥️ GPU (INTEL UHD 630)
 # Note: Using hardware.graphics for NixOS 25.11 compatibility
 hardware.graphics = {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver # Modern VAAPI for Broadwell+ (Fragment 4899)
 vpl-gpu-rt # OneVPL runtime for QSV
 libvdpau-va-gl # VDPAU to VAAPI bridge
 ];
 };
 
 # Force iHD driver for Jellyfin/QuickSync
 environment.variables.LIBVA_DRIVER_NAME = "iHD"; # Fragment 2272

 # ⚡ ADVANCED POWER MANAGEMENT
 services.thermald.enable = true; # Intel Thermal Daemon (Fragment 2291)
 
 services.tlp = {
 enable = true; # Fragment 2292
 settings = {
 # Sane defaults for a Headless Q958 Server
 CPU_SCALING_GOVERNOR_ON_AC = "powersave";
 CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
 PCIE_ASPM_ON_AC = "performance"; # Prioritize I/O stability on AC
 START_CHARGE_THRESH_BAT8 = 75; # Not relevant for Q958 desktop but good practice in profiles
 STOP_CHARGE_THRESH_BAT8 = 80;
 };
 };

 # 🛠️ SYSCTL HARDENING & PERFORMANCE (Tracing Enabled)
 boot.kernel.sysctl = {
 "kernel.nmi_watchdog" = 0; # Save power by disabling NMI watchdog
 
 # Protected links for security in shared environments
 "fs.protected_symlinks" = 1;
 "fs.protected_hardlinks" = 1;
 
 # Hide kernel pointers from unprivileged users
 "kernel.kptr_restrict" = 2;
 };

 # 💾 STORAGE & RAM STRATEGY
 zramSwap.enable = true; # Fragment 4937
 swapDevices = []; # Prefer ZRAM over SSD wear (Fragment 731)
 
 # 🔧 FIRMWARE
 hardware.cpu.intel.updateMicrocode = true;
 };
}
