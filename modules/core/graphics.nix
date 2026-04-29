{ config, lib, pkgs, ... }:
let
  nms = {
    id = "NIXH-00-COR-036";
    title = "Hardware Graphics (Intel QuickSync)";
    description = "Enables VA-API and Intel UHD 630 hardware acceleration for high-performance transcoding.";
    layer = 00;
    capabilities = ["hardware/gpu" "media/transcoding"];
  };
in
{
  options.my.meta.graphics = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
  };

  config = {
    # 🏎️ Intel QuickSync & VA-API Setup
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell+ (Q958 uses Coffee Lake)
        intel-vaapi-driver # For older apps
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    # 🛠️ System-Wide Environment for VA-API
    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    # 🛡️ Monitoring Tools
    environment.systemPackages = with pkgs; [
      intel-gpu-tools # For 'intel_gpu_top' diagnostics
      libva-utils     # For 'vainfo'
    ];

    # 👥 Grant 'media' user access to GPU devices
    users.groups.render.members = [ "jellyfin" "media" ];
    users.groups.video.members = [ "jellyfin" "media" ];
  };
}
