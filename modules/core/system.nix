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
 # 💎 STATELESS ROOT (ADR 852)
 # ---------------------------------------------------------
 fileSystems."/" = lib.mkForce {
 device = "none";
 fsType = "tmpfs";
 options = [ "defaults" "size=4G" "mode=755" ];
 };

 # 💾 DECLARATIVE PERSISTENCE (Impermanence)
 # ---------------------------------------------------------
 environment.persistence."/persist" = {
 hideMounts = true;
 directories = [
 "/var/lib/sops-nix"
 "/var/lib/nixos"
 "/etc/nixos"
 "/var/lib/tailscale"
 "/var/lib/bluetooth"
 "/var/lib/pocket-id"
 "/var/lib/acme"
 "/var/log"
 ];
 files = [
 "/etc/machine-id"
 "/etc/ssh/ssh_host_ed25519_key"
 "/etc/ssh/ssh_host_ed25519_key.pub"
 ];
 };

 # 🛡️ BOOT & KERNEL
 boot.loader = {
 systemd-boot = {
 enable = lib.mkForce true;
 configurationLimit = lib.mkForce 15;
 editor = false;
 consoleMode = "max";
 };
 efi.canTouchEfiVariables = lib.mkForce true;
 grub.enable = lib.mkForce false;
 timeout = lib.mkForce 3;
 };

 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "rd.udev.log_level=3"
 ];

 # Schnelles Booten & Cleanup
 boot.tmp.cleanOnBoot = true;
 boot.initrd.verbose = false;

 boot.kernel.sysctl = {
 "net.ipv4.conf.all.rp_filter" = lib.mkForce 1;
 "net.ipv4.tcp_syncookies" = lib.mkForce 1;
 "kernel.kptr_restrict" = lib.mkForce 2;
 "kernel.unprivileged_bpf_disabled" = lib.mkForce 1;
 };

 nixpkgs.config.allowUnfree = true;
 programs.nix-ld.enable = true;

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

 environment.sessionVariables = {
 PATH = "/home/${config.my.configs.identity.user}/.npm-global/bin:$PATH";
 };
 };
}
