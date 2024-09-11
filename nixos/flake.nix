{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.Hufflepuff = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./machines/Hufflepuff/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

    scripts = import ./lib/scripts;
  };
}
