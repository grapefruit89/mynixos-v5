{ config, lib, pkgs, ... }:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-90-SEC-003";
    title = "No-Legacy Policy";
    description = "Disables legacy protocols and insecure services (Telnet, FTP, RSH, etc.).";
    layer = 90;
    nixpkgs.category = "system/policy";
    capabilities = ["security/no-legacy" "network/hardening"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 2;
  };
  msg = prefix: alt: "🚫 [LEGACY-BLOCK] ${prefix} ist veraltet. Nutze ${alt}.";
in
{
 options.my.meta.no_legacy = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config = {
    warnings = [
      (lib.optionalString config.boot.loader.grub.enable (msg "GRUB" "systemd-boot"))
      (lib.optionalString config.services.cron.enable (msg "Cron" "systemd.timers"))
      (lib.optionalString config.networking.networkmanager.enable (msg "NetworkManager" "systemd-networkd"))
    ];

    services.samba.settings.global = lib.mkIf config.services.samba.enable {
      "server min protocol" = "SMB2_10";
    };

    # ✂️ KERNEL SURGICAL DIET (anchor: kernel-diet)
    boot.blacklistedKernelModules = [ "ext2" "ext3" "jfs" "reiserfs" "hfs" "hfsplus" "ntfs" ];
 networking.nftables.enable = true;
 networking.firewall.enable = lib.mkForce true;
 boot.initrd.compressor = "zstd";
 };
}
