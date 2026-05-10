{ lib, pkgs, config, inputs, myLib, ... }:
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
    
    # 🛠️ 2. SHARED SYSTEM LOGIC (CORE)
    ./services-spec.nix
    ./modules/core/configs.nix
    ./modules/core/ports.nix
    ./modules/core/uid-registry.nix
    ./modules/core/users-registry.nix
    ./modules/core/registry.nix
    ./modules/core/admin-triggers.nix
    ./modules/core/boot-watchdog.nix
    ./modules/core/lib-helpers-meta.nix
    ./modules/core/secrets.nix
    ./modules/core/graphics.nix
    ./modules/core/kernel-hardening.nix
    ./modules/core/backup.nix

    # --- MISSION PROFILES ---
    ./profiles/base-server.nix
    ./profiles/media-beast.nix
    ./profiles/security-hardened.nix
    ./profiles/automation-apps.nix
    ./profiles/knowledge-apps.nix
    ./profiles/extra-apps.nix
    ./modules/services/wireguard-admin.nix

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
    my.services = {
      blocky.enable = true;
      shell.premium.enable = true;
      storagePool.enable = true;
      caddy.enable = true;
      postgresql.enable = true;
      wireguard-admin.enable = true;
      vector.enable = true;
    };
  };
}
