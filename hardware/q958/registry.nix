{ lib, ... }: {
 options.my.profiles.hardware = {
 q958.enable = lib.mkOption {
 type = lib.types.bool;
 default = true;
 description = "Enable Fujitsu Q958 hardware profile";
 };
 };
}
