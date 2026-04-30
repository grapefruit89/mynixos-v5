{
 config,
 lib,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened RAM-Tuning)
 nms = {
 id = "NIXH-00-COR-040";
 title = "Zram Swap (AI Optimized)";
 description = "Optimized compressed RAM swap for AI workloads (Ollama/Claude). High swappiness for CPU-efficient memory management.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["system/performance" "hardware/ram-optimization" "ai/optimization"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 # RAM-Detection (Fallback auf 16GB falls nicht definiert)
 ramGB = config.my.configs.hardware.ramGB or 16;
in {
 options.my.meta.zram_swap = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata for zram-swap module";
 };

 config = {
 zramSwap = {
 enable = true;
 algorithm = "zstd"; # 💎 hardened standard for best ratio
 priority = 100;
 memoryPercent =
 if ramGB <= 4 then 75
 else if ramGB <= 8 then 60
 else 40; # 🚀 40% of RAM for ZRAM to buffer AI models
 };
 
 boot.kernel.sysctl = {
 # 🏎️ ZRAM Performance Tuning
 "vm.page-cluster" = 0; # Skip expensive read-ahead on ZRAM
 "vm.vfs_cache_pressure" = 50; # Keep directory entries in RAM longer
 };
 };
}
