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

{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (Stateless Manifesto)
 nms = {
 id = "NIXH-00-COR-035";
 title = "Stateless System (Wipe-on-Boot)";
 description = "Stateless root on tmpfs with declarative persistence via Impermanence. ADR 852 compliant.";
 layer = 0;
 nixpkgs.category = "system/settings";
 capabilities = ["system/stateless" "impermanence/active" "kernel/hardening"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 3;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.system = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

  config = {
    # 🛡️ BOOT & KERNEL
    boot.loader = {
      systemd-boot = {
        enable = lib.mkForce true;
        # ⚠️ SAFE LIMIT: Verhindert Überlaufen der EFI-Partition (oft nur 50-100MB).
        # Bei ~10MB pro Generation (Kernel + Initrd) sind 5-8 ein sicherer Wert.
        configurationLimit = lib.mkForce 8;
        editor = false;
      };
      efi.canTouchEfiVariables = lib.mkForce true;
      grub.enable = lib.mkForce false;
      timeout = lib.mkForce 3;
    };

 boot.initrd.systemd.enable = lib.mkDefault true; # 🚀 Modern initrd

 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "rd.udev.log_level=3"
 ];

 # Schnelles Booten & Cleanup
 boot.tmp.cleanOnBoot = true;
 boot.initrd.verbose = false;

 nixpkgs.config.allowUnfree = lib.mkDefault true;
 programs.nix-ld.enable = lib.mkDefault true;

 # 🧹 LEAN SYSTEM
 documentation.nixos.enable = false;

 environment.systemPackages = with pkgs; [
 nodejs_22
 alejandra
 git
 htop
 wget
 curl
 tree
 unzip
 file
 nix-output-monitor
 rsync
 hdparm
 pciutils
 usbutils
 ];

 environment.sessionVariables = lib.mkIf (config.my.configs.identity.user != "") {
 PATH = "/home/${config.my.configs.identity.user}/.npm-global/bin:$PATH";
 };
 };
}
