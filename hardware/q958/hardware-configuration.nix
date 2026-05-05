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
    boot.initrd.systemd.enable = true; # Required for TPM2-LUKS enrollment
    
    # Sensors: Fujitsu Esprimo Q958 uses Nuvoton NCT6775
    # Source: https://github.com/nix-community/nixos-hardware/
    boot.kernelModules = [ 
      "kvm-intel" 
      "nct6775"   # Mainboard Sensors (Fan/Temp)
      "coretemp"  # CPU Sensors
    ];

    boot.kernelParams = [
      # Required for nct6775 on many Fujitsu boards to bypass ACPI resource conflicts
      "acpi_enforce_resources=lax"
    ];

    boot.extraModulePackages = [];

    # 📂 DISK LAYOUT (Static UUIDs for Q958)
    boot.initrd.luks.devices."cryptroot" = {
      device = "/dev/disk/by-uuid/CHANGE_ME_TO_PARTITION_UUID"; # Die UUID der physischen Partition
      preLVM = true;
      # TPM2 support is handled via systemd-cryptenroll manually, 
      # but Nix needs to know it's a LUKS device.
    };

    fileSystems."/" = {
      device = "/dev/mapper/cryptroot";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/B413-DB53";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    # 🔗 PCIE PASSTHROUGH (Placeholder for VM-Identity)
    # Move specific PCI-IDs here if hardware-bound
    # boot.kernelParams = [ "vfio-pci.ids=..." ];

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
