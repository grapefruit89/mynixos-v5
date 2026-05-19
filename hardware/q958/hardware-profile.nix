# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-HW-Q958-001",
#   "title": "Hardware Profile: Fujitsu Q958",
#   "layer": 0,
#   "category": "hardware",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 3,
#   "tags": ["hardware", "q958", "intel", "quicksync"],
#   "description": "Optimized hardware profile for Fujitsu Q958 with Intel UHD 630 Graphics and QuickSync."
# }
# ---ENDNIXMETA

{ config, lib, pkgs, myLib, ... }: 
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-HW-Q958-001";
    title = "Hardware Profile: Fujitsu Q958";
    description = "Optimized hardware profile for Fujitsu Q958 with Intel UHD 630 Graphics and QuickSync.";
    layer = 0;
    nixpkgs.category = "hardware";
    capabilities = ["hardware/intel" "hardware/quicksync" "power/management"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 3;
  };

 cfg = config.my.hardware;
in
{
  options.my.meta.hardware_q958 = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

 # 🚀 hardened HARDWARE PROFILE: FUJITSU Q958
 # Optimized for Intel Coffee Lake (Gen 9) & UHD Graphics 630.

 imports = [
 # ./hardware-configuration.nix # Template: hardware-configuration.template.nix
 ../../modules/services/service-storage-mover.nix ];
 
 config = lib.mkIf (cfg.profile == "q958") {
 
 # 💾 STORAGE TIERING MOVER
 my.storage.mover.enable = true;

 # 🧠 CPU & KERNEL TUNING
 boot.kernelPackages = pkgs.linuxPackages; # Stable kernel (nixos-25.11 standard)

 boot.kernelParams = [
 "quiet"
 "mitigations=auto"
 
 # ⚡ Power & Stability (hardened Selection)
 "acpi_osi=Linux" # Better power management (Fragment 975)
 "i915.enable_guc=3" # GuC/HuC Firmware for QSV/HEVC (Fragment 2272)
 "i915.enable_fbc=1" # Frame Buffer Compression (Saves power)
 "i915.fastboot=1" # Cleaner boot transition
 "intel_idle.max_cstate=4" # Balance between power saving and C-state exit latency stability
 "ibt=off" # TODO: Prüfen ob ibt=off noch nötig ist (Kernel >= 6.x?)
 "intel_pstate=passive" # Use passive mode to allow TLP/thermald better control
 ];

 boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
 boot.kernelModules = [ "kvm_intel" "nct6775" "coretemp" "i915" "e1000e" "ipmi_si" "tpm_tis" ];

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
