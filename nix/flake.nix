{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    nixunstable,
    ...
  }: let
    inherit (nixpkgs) lib;
    withSystem = (
      system: hostname: (lib.nixosSystem {
        specialArgs = {
          inherit nixpkgs;
          inherit nixunstable;
          inherit system;
          inherit hostname;
        };
        modules = [./hosts/thinkpad/configuration.nix];
      })
    );
  in {
    nixosConfigurations = {
      thinkpad = withSystem "aarch64-linux" "nixie";
    };
  };
}
