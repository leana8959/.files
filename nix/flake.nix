{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixunstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (nixpkgs.lib) nixosSystem;
  in {
    nixosConfigurations = {
      thinkpad = let
        system = "aarch64-linux";
        unstable = import nixunstable {inherit system;};
      in
        nixosSystem {
          specialArgs = {inherit system;};
          modules = [
            ./hosts/thinkpad/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.leana = import ./hosts/thinkpad/home.nix;
                extraSpecialArgs = {inherit unstable;};
              };
            }
          ];
        };
    };
  };
}
