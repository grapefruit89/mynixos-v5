{
 description = "NixHome - hardened Horizontal Configuration";

 # 🤖 LLM CONTEXT GATEWAY
 # Before modifying this flake, YOU MUST use Context7 MCP to fetch the latest documentation.
 # DO NOT rely on training data for NixOS versions, EOL dates, or Flake syntax.
 # Recommended Library IDs:
 # - NixOS/Nixpkgs: /nixos/nixpkgs
 # - Home Manager:  /nix-community/home-manager
 # - SOPS-nix:     /mic92/sops-nix

 inputs = {
 nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
 
 sops-nix.url = "github:Mic92/sops-nix";
 sops-nix.inputs.nixpkgs.follows = "nixpkgs";

 home-manager.url = "github:nix-community/home-manager/release-25.11";
 home-manager.inputs.nixpkgs.follows = "nixpkgs";

 impermanence.url = "github:nix-community/impermanence";
 
 mcp-nixos.url = "github:utensils/mcp-nixos";
 mcp-nixos.inputs.nixpkgs.follows = "nixpkgs";
 };

 outputs = { self, nixpkgs, ... }@inputs: let
 # 🏆 hardened System Library Factory (System Parametric)
 mkMyLib = system: import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; pkgs = nixpkgs.legacyPackages.${system}; };
 in {
 nixosConfigurations = {
 # 🚀 HOST: FUJITSU Q958 (DEIN SYSTEM)
 nixhome = nixpkgs.lib.nixosSystem {
 system = "x86_64-linux";
 specialArgs = { inherit inputs; myLib = mkMyLib "x86_64-linux"; };
 modules = [
 ./hardware/q958/hardware-configuration.nix
 ./hardware/q958/hardware-profile.nix
 ./configuration.nix # Der horizontale Entrypoint
 ];
 };

 # 🤝 HOST: FREUNDES-PC (BEISPIEL)
 # freund-pc = nixpkgs.lib.nixosSystem {
 # system = "x86_64-linux";
 # specialArgs = { inherit inputs; myLib = mkMyLib "x86_64-linux"; };
 # modules = [
 # ./hardware/freund/hardware-configuration.nix
 # ./configuration.nix 
 # ];
 # };
 };
 };
}
