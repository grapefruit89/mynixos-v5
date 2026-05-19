# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-001-HW-Q958-001",
#   "title": "Hardware Configuration Template (Q958)",
#   "layer": 1,
#   "category": "hardware/provisioning",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "draft",
#   "complexity": 2,
#   "tags": ["hardware", "template", "q958"],
#   "description": "Template for board-specific hardware configuration for Fujitsu Esprimo Q958."
# }
# ---ENDNIXMETA

# This is a template. Copy to hardware-configuration.nix and fill in actual UUIDs before deployment.
{
 config,
 lib,
 pkgs,
 modulesPath,
 myLib,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (Hardware-Silo)
 nms = {
 id = "NIXH-01-HW-Q958-CFG";
 title = "Hardware Configuration (Fujitsu Q958)";
 description = "Physical identity and board-specific settings for Fujitsu Esprimo Q958.";
 layer = 1;
 nixpkgs.category = "system/boot";
 capabilities = ["system/hardware" "hardware/q958" "sensors/nct6775"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 1;
 };
in {
 options.my.meta.host_q958_hardware_configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 imports = [(modulesPath + "/installer/scan/not-detected.nix")];

 config = {
 # 🦾 PHYSICAL BOARD DRIVERS
 boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "nvme"];
 boot.initrd.kernelModules = [];
 
 # Sensors: Fujitsu Esprimo Q958 uses Nuvoton NCT6775
 # Source: https://github.com/nix-community/nixos-hardware/
 boot.kernelModules = [ 
 "kvm-intel" 
 "nct6775" # Mainboard Sensors (Fan/Temp)
 "coretemp" # CPU Sensors
 ];

 boot.kernelParams = [
 # Required for nct6775 on many Fujitsu boards to bypass ACPI resource conflicts
 "acpi_enforce_resources=lax"
 ];

 boot.extraModulePackages = [];

    # 📂 DISK LAYOUT (Production Hardened: Stateless Root with ext4 Persistence)
    boot.initrd.systemd.tpm2.enable = true; # Enable TPM2 support in initrd

    boot.initrd.luks.devices."cryptroot" = {
      # device = "/dev/disk/by-uuid/REAL_UUID";  # Replace with actual UUID during first boot. Use scripts/setup-luks-tpm.sh to enroll TPM and get the correct UUID.
      preLVM = true;
    };

    # Root is tmpfs (defined in modules/core/impermanence.nix)
    # We only define the persistent stores here.

    fileSystems."/nix" = {
      # device = "/dev/disk/by-uuid/REAL_UUID";  # Replace with actual UUID during first boot. Use scripts/setup-luks-tpm.sh to enroll TPM and get the correct UUID.
      fsType = "ext4";
    };

    fileSystems."/persist" = {
      # device = "/dev/disk/by-uuid/REAL_UUID";  # Replace with actual UUID during first boot. Use scripts/setup-luks-tpm.sh to enroll TPM and get the correct UUID.
      fsType = "ext4";
      neededForBoot = true;
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/B413-DB53";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

 swapDevices = [];

 nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
 hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 };
}
