# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-COR-TUN-001",
#   "title": "Nix Tuning (Pure Binary Policy)",
#   "layer": 0,
#   "category": "system/settings",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 2,
#   "tags": ["nix", "tuning", "binary-only", "gc"],
#   "description": "Optimized nix-daemon settings with strict binary-only enforcement."
# }
# ---ENDNIXMETA

{
 config,
 lib,
 pkgs,
 ...
}:
let
  # 🚀 NMS v4.2 Metadaten
  nms = {
    id = "NIXH-00-COR-009";
    title = "Nix Daemon Tuning";
    description = "Optimized nix-daemon settings with strict binary-only enforcement and automated garbage collection.";
    layer = 0;
    nixpkgs.category = "system/settings";
    capabilities = ["nix/tuning" "nix/binary-only" "system/gc"];
    audit.last_reviewed = "2026-05-19";
    audit.complexity = 2;
  };
in
{
  options.my.meta.nix_tuning = lib.mkOption {
    type = lib.types.attrs;
    default = nms;
    readOnly = true;
    description = "NMS metadata";
  };

 config = {
 # ⚙️ NIX SETTINGS (anchor: nix-settings)
 nix.settings = {

 # 🛡️ TRUSTED SUBSTITUTERS
 substituters = [
 "https://cache.nixos.org"
 "https://nix-community.cachix.org"
 ];
 trusted-public-keys = [
 "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
 "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
 ];

 # 🚫 BINARY ONLY ENFORCEMENT (Fragment 748)
 # Verhindert lokale Builds (Saves SSD & CPU)
 # ⚠️ EXCEPTION: Services like Ollama (GPU/Unfree) or ZFS (Kernel module) 
 # require local builds if not present in cache. Set max-jobs > 0 for these.
 max-jobs = lib.mkDefault 0;
 builders-use-substitutes = true;
 fallback = lib.mkDefault false;

 # 🏎️ STORE OPTIMIZATION
 auto-optimise-store = true;
 connect-timeout = 5;
 experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];
 
 # 🛡️ SECURITY & USERS
 sandbox = true;
 trusted-users = ["root" config.my.configs.identity.user];
 };

 # LHF-04: Fix invalid options path (moved outside nix.settings)
 nix.optimise.automatic = true;
 
 # 🧹 AUTO-GC (Fragment 1035 Alignment)
 nix.gc = {
 automatic = true;
 dates = "weekly";
 options = "--delete-older-than 14d";
 };

 # 🚫 BUILD CONFLICT ASSERTION (Ollama vs max-jobs=0)
 warnings = lib.optional (config.services.ollama.enable && config.nix.settings.max-jobs == 0)
   "🚫 [BUILD-CONFLICT] Ollama is enabled but nix.settings.max-jobs is 0. This will likely cause build failure as Ollama components often require local compilation.";

 # 💤 RESOURCE HYGIENE
 nix.daemonCPUSchedPolicy = "idle";
 nix.daemonIOSchedClass = "idle";

 # 💾 IMPERMANENCE BASH FIX (Fragment 1084)
 # Erzwungener History-Flush vor dem Wipe + Size Limits
 programs.bash.interactiveShellInit = ''
   export HISTSIZE=10000
   export HISTFILESIZE=20000
   trap 'history -a' EXIT
 '';

 environment.systemPackages = with pkgs; [
 cachix
 nix-tree
 nix-diff
 nix-output-monitor
 ];
 };
}
