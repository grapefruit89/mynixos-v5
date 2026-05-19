# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-COR-CFG-001",
#   "title": "NixHome Horizontal Configuration Entrypoint",
#   "layer": 0,
#   "category": "core/infrastructure",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 3,
#   "tags": ["configuration", "infrastructure", "entrypoint"],
#   "description": "Primary horizontal configuration entrypoint for importing modules and profiles."
# }
# ---ENDNIXMETA

{ lib, pkgs, config, inputs, myLib, ... }:
# 🤖 LLM ADVISORY: ALWAYS use Context7 to verify NixOS options.
# Library IDs: /nixos/nixpkgs | /nix-community/home-manager
let
 # 🚀 NMS v4.2 Metadaten (hardened Orchestrator)
 nms = {
 id = "NIXH-00-SYS-ROOT-001";
 title = "Modular Entrypoint (Horizontal)";
 description = "New horizontal responsibility entrypoint. Decouples hardware, users, and common modules.";
 layer = 0;
 audit.last_reviewed = "2026-04-27";
 };
in
{
 options.my.meta.configuration = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 };

  imports = [
    # 🛡️ 1. EXTERNAL PLUGINS
    inputs.sops-nix.nixosModules.sops
    inputs.impermanence.nixosModules.impermanence
    
    # 🌲 2. DENDRITIC MODULE DISCOVERY (v7.0 Strict)
    # Automatically imports all modules from ./modules/
    ./modules

    # --- MISSION PROFILES ---
    ./profiles/base-server.nix
    ./profiles/media-beast.nix
    ./profiles/security-hardened.nix
    ./profiles/automation-apps.nix
    ./profiles/knowledge-apps.nix
    ./profiles/extra-apps.nix

    # 👤 4. PILOT (USER)
    ./users/moritz/default.nix
    ./users/moritz/home.nix
    ];

    config = {
    system.stateVersion = "25.11";
    networking.hostName = "nixhome";

    # 🛠️ MCP-NIXOS INTEGRATION
    nixpkgs.overlays = [ inputs.mcp-nixos.overlays.default ];
    environment.systemPackages = [ pkgs.mcp-nixos ];

    # 🚩 GLOBAL TOGGLES (Aus der Registry)
    my.system.onboardingComplete = false; # Set to true after initial setup verification

    my.services = {
      blocky.enable = true;
      shell.premium.enable = true;
      storagePool.enable = true;
      caddy.enable = true;
      postgresql.enable = true;
      wireguard-admin.enable = true;
      vector.enable = true;
      amp.enable = false; # 🎮 Game Server Manager (Native FHS)
    };
  };
}
