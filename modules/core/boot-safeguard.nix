{
 config,
 lib,
 ...
}: let
 nms = {
 id = "NIXH-00-COR-001";
 title = "Boot Safeguard";
 description = "Hardened boot configuration with UEFI focus and systemd-boot.";
 layer = 00;
 };
in {
 boot.loader.systemd-boot = {
 enable = true;
 configurationLimit = 10; # Gegen Speicherüberlauf in /boot
 consoleMode = "max";
 };
 
 boot.loader.efi.canTouchEfiVariables = true;
 
 boot.kernelParams = [
 "quiet"
 "loglevel=3"
 "systemd.show_status=auto"
 "rd.udev.log_level=3"
 ];

 # Schnelles Booten & Cleanup
 boot.tmp.cleanOnBoot = true;
 boot.initrd.verbose = false;
}
