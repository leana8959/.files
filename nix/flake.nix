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
      device: system: hostname: (lib.nixosSystem {
        specialArgs = {
          inherit nixpkgs;
          inherit nixunstable;
          inherit system;
          inherit hostname;
        };
        modules = [./hosts/${device}/configuration.nix];
      })
    );
  in {
    nixosConfigurations = {
      thinkpad = withSystem "thinkpad" "aarch64-linux" "nixie-test";
    };
  };
}
