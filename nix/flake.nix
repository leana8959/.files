{
  outputs = {...} @ inputs: let
    inherit (import ./lib.nix inputs) mkNixOS mkHomeManager myPackages formatter;
    myConfigs = {
      nixosConfigurations = {
        # Thinkpad
        nixie = mkNixOS "nixie" "x86_64-linux" {
          extraLanguageServers = true;
          extraUtils = true;
          enableCmus = true;
          universityTools = true;
        };
      };
      homeConfigurations = {
        # MacBook Pro 2021
        "stardust" = mkHomeManager "stardust" "aarch64-darwin" {
          extraLanguageServers = true;
          extraUtils = true;
          enableCmus = true;
          universityTools = true;
        };
        # MacBook Air 2014
        "legend" = mkHomeManager "legend" "x86_64-darwin" {
          enableCmus = true;
        };

        # Raspberry Pi 4
        "pi4" = mkHomeManager "pi4" "aarch64-linux" {};

        # Oracle cloud
        "oracle" = mkHomeManager "oracle" "aarch64-linux" {};
      };
    };
  in
    myPackages // myConfigs // formatter;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    wired.url = "github:Toqozz/wired-notify";
    agenix.url = "github:ryantm/agenix/0.15.0";
    nixnur.url = "github:nix-community/NUR";
    opam-nix.url = "github:tweag/opam-nix";
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
  };
}
