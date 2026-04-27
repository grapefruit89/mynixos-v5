{
  config,
  lib,
  pkgs,
  ...
}: let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-015";
    title = "Host Q958 Hardware Profile";
    description = "Specific hardware optimizations for Fujitsu Q958 (i3-9100 / UHD 630) including GuC/HuC and QSV.";
    layer = 00;
    nixpkgs.category = "hardware/graphics";
    capabilities = ["gpu/intel-qsv" "hardware/firmware" "power/management"];
    audit.last_reviewed = "2026-03-03";
    audit.complexity = 2;
  };

  cfg = config.my.profiles.hardware.q958;
in {
  options.my.meta.host_q958_hardware_profile = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata for host-q958-hardware-profile module";
  };

  config = lib.mkIf cfg.enable {
    # ⚙️ CPU & Microcode
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.firmware = [pkgs.linux-firmware];

    # 🏎️ INTEL GPU OPTIMIZATION (Nixpkgs Hardware Standard)
    boot.kernelParams = [
      "i915.enable_guc=3" # 💎 Enable GuC/HuC loading
      "i915.enable_fbc=1" # Framebuffer compression
      "i915.enable_psr=1" # Panel Self Refresh
    ];
    boot.kernelModules = ["i915"];

    # 🚀 Hardware-Beschleunigung (UHD 630 / QuickSync)
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver   # iHD driver (Broadwell+)
        intel-vaapi-driver   # i965 driver (Fallback)
        libvdpau-va-gl       # VDPAU Bridge
        intel-compute-runtime # OpenCL
        vpl-gpu-rt           # OneVPL for newer ffmpeg
      ];
    };

    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    
    environment.systemPackages = with pkgs; [
      libva-utils      # vainfo
      intel-gpu-tools  # intel_gpu_top
      vulkan-tools     # vulkaninfo
    ];

    # Berechtigungen für Media-Services
    users.users.${config.my.configs.identity.user}.extraGroups = ["video" "render"];
  };
}
/**
* ---
 * technical_integrity:
 *   checksum: sha256:3320a25690cd5a9c3b6155791edf76fc573f3b3d07273af97f4a0077772ba350
 *   eof_marker: NIXHOME_VALID_EOF* ---
*/
