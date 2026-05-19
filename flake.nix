# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-000-COR-FLK-001",
#   "title": "NixHome Primary Flake",
#   "layer": 0,
#   "category": "core/infrastructure",
#   "lastReviewed": "2026-05-19",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 4,
#   "tags": ["flake", "infrastructure", "entrypoint"],
#   "description": "Primary system entrypoint for the NixHome Horizontal Configuration."
# }
# ---ENDNIXMETA

{
 # Current stable channel: nixos-25.11 (as of May 2026)
 # See docs/NIXOS_VERSION_INFO.md for details.

 description = "NixHome - hardened Horizontal Configuration";

 # 🤖 LLM CONTEXT GATEWAY
 # Before modifying this flake, YOU MUST use Context7 MCP to fetch the latest documentation.
 # DO NOT rely on training data for NixOS versions, EOL dates, or Flake syntax.
 # Recommended Library IDs:
 # - NixOS/Nixpkgs: /nixos/nixpkgs
 # - Home Manager:  /nix-community/home-manager
 # - SOPS-nix:     /mic92/sops-nix

 inputs = {
   # 🗓️ NIXPKGS CHANNEL (anchor: nixpkgs-version)
   nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
 
 sops-nix.url = "github:Mic92/sops-nix";
 sops-nix.inputs.nixpkgs.follows = "nixpkgs";

 home-manager.url = "github:nix-community/home-manager/release-25.11";
 home-manager.inputs.nixpkgs.follows = "nixpkgs";

   impermanence.url = "github:nix-community/impermanence";
 
   mcp-nixos = {
     url = "github:utensils/mcp-nixos";
     inputs.nixpkgs.follows = "nixpkgs";
   };

   vulnix = {
     url = "github:nix-community/vulnix";
     inputs.nixpkgs.follows = "nixpkgs";
   };
 };

 outputs = { self, nixpkgs, ... }@inputs: let
   systems = [ "x86_64-linux" ];
   forAllSystems = nixpkgs.lib.genAttrs systems;
 in {
   checks = forAllSystems (system: {
     basic-eval = let pkgs = nixpkgs.legacyPackages.${system}; in pkgs.runCommand "basic-eval" {} ''
       nix eval --file ${./scripts/basic.nix} > $out
     '';

     nixmeta-validation = let
       pkgs = nixpkgs.legacyPackages.${system};
     in pkgs.runCommand "validate-nixmeta" {
       nativeBuildInputs = [ pkgs.jq pkgs.bash ];
     } ''
       cd ${self}
       ${pkgs.bash}/bin/bash ${./scripts/validate-nixmeta.sh}
       touch $out
     '';
   });

   apps = forAllSystems (system: {
     validate-nixmeta = {
       type = "app";
       program = let
         pkgs = nixpkgs.legacyPackages.${system};
         script = pkgs.writeShellScriptBin "validate-nixmeta" ''
           ${pkgs.bash}/bin/bash ${./scripts/validate-nixmeta.sh}
         '';
       in "${script}/bin/validate-nixmeta";
     };
   });

   formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

   devShells = forAllSystems (system: {
     default = let
       pkgs = nixpkgs.legacyPackages.${system};
     in pkgs.mkShell {
       buildInputs = [
         pkgs.jq
         pkgs.ripgrep
         pkgs.fd
         inputs.vulnix.packages.${system}.vulnix
       ];
       shellHook = ''
         echo -e "\n🚀 \033[0;32mNixHome DevShell Loaded\033[0m"
         echo "Available NIXMETA commands:"
         echo "  nix run .#validate-nixmeta"
         echo "  nix run .#generate-nixmeta-schema"
         echo "  nix flake check"
         echo "  vulnix --help (CVE Scanner)"
       '';
     };
   });

   nixosConfigurations = {
     # 🚀 HOST: FUJITSU Q958 (DEIN SYSTEM)
     nixhome = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       specialArgs = {
         inherit inputs;
         myLib = import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; };
       };
       modules = [
         # ./hardware/q958/hardware-configuration.nix # Template: hardware-configuration.template.nix
         ./hardware/q958/hardware-profile.nix
         ./configuration.nix # Der horizontale Entrypoint
       ];
     };

     # 🤝 HOST: FREUNDES-PC (BEISPIEL)
     # freund-pc = nixpkgs.lib.nixosSystem {
     #   system = "x86_64-linux";
     #   specialArgs = {
     #     inherit inputs;
     #     myLib = import ./modules/core/lib-helpers.nix { inherit (nixpkgs) lib; };
     #   };
     #   modules = [
     #     ./hardware/freund/hardware-configuration.nix
     #     ./configuration.nix 
     #   ];
     # };
   };
 };
}
