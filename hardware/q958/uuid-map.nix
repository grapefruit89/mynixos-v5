# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-070-HW-Q958-UUID",
#   "title": "Hardware UUID & Partition Map (Q958)",
#   "layer": 70,
#   "category": "hardware/provisioning",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "draft",
#   "complexity": 2,
#   "tags": ["uuid", "provisioning", "q958", "disk"],
#   "description": "Stable UUID template and partition mapping for Fujitsu Q958 deployment."
# }
# ---ENDNIXMETA

# 🧬 HARDWARE UUID TEMPLATE (Fujitsu Q958)
# Use these labels and UUID patterns for manual disk preparation.
# Implementation of ADR-040 (Decoupled Storage) and ABC-Tiering.

{
  # 💾 TIER A: NVMe (System & Fast State)
  # Layout: GPT -> [EFI (vfat)] -> [LUKS (cryptroot)] -> [LVM/Partitions (ext4)]
  tier_a = {
    device = "/dev/nvme0n1";
    partitions = {
      efi = {
        label = "NIXBOOT";
        uuid  = "B413-DB53"; # FIXED: Already in hardware-configuration.template.nix
        mount = "/boot";
      };
      luks_container = {
        label = "CRYPTROOT";
        # REAL_UUID to be generated during provisioning
      };
      nix_store = {
        label = "NIXSTORE";
        mount = "/nix";
        # REAL_UUID to be generated after formatting
      };
      persist = {
        label = "NIXPERSIST";
        mount = "/persist";
        # REAL_UUID to be generated after formatting
      };
    };
  };

  # 💾 TIER B: SATA SSD (App Data & Containers)
  tier_b = {
    device = "/dev/sda";
    partitions = {
      data = {
        label = "NIXDATA";
        mount = "/mnt/fast-pool";
      };
    };
  };

  # 💾 TIER C: SATA HDD (Media & Cold Storage)
  tier_c = {
    device = "/dev/sdb";
    partitions = {
      media = {
        label = "NIXMEDIA";
        mount = "/mnt/media";
      };
      backup = {
        label = "NIXBACKUP";
        mount = "/mnt/backup";
      };
    };
  };
}
