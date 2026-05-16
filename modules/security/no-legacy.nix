{ config, lib, pkgs, ... }:
let
 nms = {
 id = "NIXH-90-POL-003";
 title = "No Legacy";
 description = "Blocks legacy services and insecure protocols.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "security/hardening" ];
 audit.last_reviewed = "2026-03-02";
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

    boot.blacklistedKernelModules = [ "ext2" "ext3" "jfs" "reiserfs" "hfs" "hfsplus" "ntfs" ];
 networking.nftables.enable = true;
 networking.firewall.enable = lib.mkForce true;
 boot.initrd.compressor = "zstd";
 };
}
