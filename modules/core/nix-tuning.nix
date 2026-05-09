{
 config,
 lib,
 pkgs,
 ...
}: let
 # 🚀 NMS v4.2 Metadaten (hardened Nix Tuning)
 nms = {
 id = "NIXH-00-COR-024";
 title = "Nix Tuning (Pure Binary Policy)";
 description = "Optimized nix-daemon settings. Strict binary-only enforcement to prevent local compilation wear.";
 layer = 00;
 nixpkgs.category = "system/settings";
 capabilities = ["nix/tuning" "policy/binary-only" "maintenance/auto-gc" "impermanence/bash-fix"];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 source_repo = "grapefruit89/mynixos";
 };
in {
 options.my.meta.nix_tuning = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

 config = {
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

 # 💤 RESOURCE HYGIENE
 nix.daemonCPUSchedPolicy = "idle";
 nix.daemonIOSchedClass = "idle";

 # 🧹 AUTO-GC (Fragment 1035 Alignment)
 nix.gc = {
 automatic = true;
 dates = "weekly";
 options = "--delete-older-than 14d";
 };

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
