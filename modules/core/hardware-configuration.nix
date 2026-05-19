# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-AUTO-GEN",
#   "title": "Auto Generated",
#   "layer": 99,
#   "category": "auto/gen",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 2,
#   "tags": ["auto-generated"],
#   "description": "Auto-migrated module to NIXMETA 2.0."
# }
# ---ENDNIXMETA

{ config, lib, pkgs, modulesPath, ... }:
let
 nms = {
 id = "NIXH-00-COR-012";
 title = "Hardware Configuration";
 description = "Auto-generated hardware abstraction layer.";
 layer = 00;
 nixpkgs.category = "system/boot";
 capabilities = [ "system/hardware" "boot/initrd" ];
 audit.last_reviewed = "2026-03-02";
 audit.complexity = 1;
 };
in
{
 options.my.meta.hardware_configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

 config = {
 boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
 boot.initrd.kernelModules = [ ];
 boot.kernelModules = [ "kvm-intel" ];
 boot.extraModulePackages = [ ];
 fileSystems."/" = { device = "/dev/disk/by-uuid/8d1d5128-6413-4b5b-bd96-e55851ae5dc2"; fsType = "ext4"; };
 fileSystems."/boot" = { device = "/dev/disk/by-uuid/1EDF-972E"; fsType = "vfat"; options = [ "fmask=0077" "dmask=0077" ]; };
 swapDevices = [ ];
 nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}
