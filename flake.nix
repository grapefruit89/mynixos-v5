{
  description = "NixHome - Aviation Grade Horizontal Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    
    mcp-nixos.url = "github:utensils/mcp-nixos";
    mcp-nixos.inputs.nixpkgs.follows = "nixpkgs";
  };
outputs = { self, nixpkgs, ... }@inputs: let
  # Funktion zur Erstellung von specialArgs pro System
  mkSpecialArgs = system: {
    inherit inputs;
    myLib = import ./modules/core/lib-helpers.nix {
      inherit (nixpkgs) lib;
      pkgs = nixpkgs.legacyPackages.${system};
    };
  };
in {
  nixosConfigurations = {
    # 🚀 HOST: FUJITSU Q958 (DEIN SYSTEM)
    nixhome = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = mkSpecialArgs "x86_64-linux";
      modules = [
        ./hardware/q958/hardware-configuration.nix
        ./hardware/q958/hardware-profile.nix
        ./configuration.nix # Der horizontale Entrypoint
      ];
    };
  };
};
}
