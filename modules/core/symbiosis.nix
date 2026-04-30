{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten
 nms = {
 id = "NIXH-00-COR-033";
 title = "Symbiosis";
 description = "Hardware abstraction layer with auto-discovery and microcode management.";
 layer = 0;
 nixpkgs.category = "system/hardware";
 capabilities = ["hardware/discovery" "hardware/management"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 userConfigFile = "/var/lib/nixhome/user-config.json";
 cpuType = config.my.configs.hardware.cpuType or "none";
 ramGB = config.my.configs.hardware.ramGB or 0;
in {
 options.my.meta.symbiosis = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for symbiosis module";
 };

 config = {
 hardware.cpu.intel.updateMicrocode = lib.mkForce (lib.mkIf (cpuType == "intel") true);
 hardware.cpu.amd.updateMicrocode = lib.mkForce (lib.mkIf (cpuType == "amd") true);
 warnings = lib.optional (ramGB < 4) "⚠️ [HARDWARE-WARNUNG] Weniger als 4GB RAM erkannt (${toString ramGB}GB).";
 environment.etc."nixhome-hw-age-check".source = pkgs.writeShellScript "hw-check" "if [ -f '${userConfigFile}' ]; then AGE=$(( $(date +%s) - $(stat -c %Y '${userConfigFile}') )); if [ $AGE -gt 2592000 ]; then echo '⚠️ Hardware-Profil ist älter als 30 Tage. Ausführen: nixhome-detect-hw'; fi; fi";
 environment.systemPackages = [(pkgs.writeShellScriptBin "nixhome-detect-hw" "set -euo pipefail; echo '🔍 Hardware-Discovery...'; RAM=$(free -g | awk '/^Speicher:/ {print $2}'); echo '{\"ram_gb\": '$RAM'}';")];
 };
}
