{
  description = "NixHome - Aviation Grade Horizontal Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    
    mcp-nixos.url = "github:utensils/mcp-nixos";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    # 🏆 Aviation-Grade System Library
    myLib = import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; pkgs = nixpkgs.legacyPackages.x86_64-linux; };
    
    # Standard-Args für alle Hosts
    specialArgs = { inherit inputs myLib; };
  in {
    nixosConfigurations = {
      # 🚀 HOST: FUJITSU Q958 (DEIN SYSTEM)
      nixhome = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        modules = [
          ./hardware/q958/hardware-configuration.nix
          ./hardware/q958/hardware-profile.nix
          ./configuration.nix # Der horizontale Entrypoint
        ];
      };

      # 🤝 HOST: FREUNDES-PC (BEISPIEL)
      # freund-pc = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   inherit specialArgs;
      #   modules = [
      #     ./hardware/freund/hardware-configuration.nix
      #     ./configuration.nix 
      #   ];
      # };
    };
  };
}
