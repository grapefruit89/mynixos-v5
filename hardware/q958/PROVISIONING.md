# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-070-HW-Q958-DISK",
#   "title": "Disk Provisioning Guide (Q958)",
#   "layer": 70,
#   "category": "hardware/provisioning",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "draft",
#   "complexity": 3,
#   "tags": ["disk", "provisioning", "luks", "ext4"],
#   "description": "Step-by-step shell instructions for preparing disks on Fujitsu Q958."
# }
# ---ENDNIXMETA

# 🛠️ DISK PROVISIONING GUIDE (Fujitsu Q958)
# Manual execution from NixOS Installer (minimal ISO).

## 1. Environment Preparation
```bash
# Set variables
export NVME="/dev/nvme0n1"
export SSD="/dev/sda"
export HDD="/dev/sdb"
```

## 2. Partitioning (Tier A - NVMe)
```bash
# Wipe partition table
sgdisk --zap-all $NVME

# Create EFI Partition (512MB)
sgdisk -n 1:0:+512M -t 1:ef00 -c 1:"NIXBOOT" $NVME

# Create Cryptroot Partition (Remaining space)
sgdisk -n 2:0:0 -t 2:8300 -c 2:"CRYPTROOT" $NVME
```

## 3. Encryption (LUKS2)
```bash
# Format LUKS
cryptsetup luksFormat --type luks2 --label CRYPTROOT ${NVME}p2

# Open LUKS
cryptsetup open ${NVME}p2 cryptroot
```

## 4. Formatting & Labeling
```bash
# 4.1 EFI (Tier A)
mkfs.vfat -F 32 -n NIXBOOT ${NVME}p1

# 4.2 Nix Store & Persist (Tier A - LVM or Plain Partitions)
# Note: In this v7.1 Strict config, we use plain partitions inside LUKS or LVM.
# Recommendation: Use LVM for flexibility.
pvcreate /dev/mapper/cryptroot
vgcreate vg_system /dev/mapper/cryptroot
lvcreate -L 40G -n nix vg_system
lvcreate -l 100%FREE -n persist vg_system

mkfs.ext4 -L NIXSTORE /dev/vg_system/nix
mkfs.ext4 -L NIXPERSIST /dev/vg_system/persist

# 4.3 App Data (Tier B - SSD)
mkfs.ext4 -L NIXDATA $SSD

# 4.4 Media & Backup (Tier C - HDD)
# Note: HDD is handled as a single GPT disk with multiple partitions or single partition.
sgdisk --zap-all $HDD
sgdisk -n 1:0:+10T -t 1:8300 -c 1:"NIXMEDIA" $HDD
sgdisk -n 2:0:0 -t 2:8300 -c 2:"NIXBACKUP" $HDD

mkfs.ext4 -L NIXMEDIA ${HDD}1
mkfs.ext4 -L NIXBACKUP ${HDD}2
```

## 5. Mounting (Impermanence Check)
```bash
# Mount tmpfs to /mnt (Stateless Root)
mount -t tmpfs none /mnt

# Create mount points
mkdir -p /mnt/{boot,nix,persist,mnt/fast-pool,mnt/media,mnt/backup}

# Mount Physical Targets
mount /dev/disk/by-label/NIXBOOT /mnt/boot
mount /dev/vg_system/nix /mnt/nix
mount /dev/vg_system/persist /mnt/persist
mount /dev/disk/by-label/NIXDATA /mnt/mnt/fast-pool
mount /dev/disk/by-label/NIXMEDIA /mnt/mnt/media
mount /dev/disk/by-label/NIXBACKUP /mnt/mnt/backup
```

## 6. Install Preparation
```bash
# Generate hardware-configuration.nix
nixos-generate-config --root /mnt
```
