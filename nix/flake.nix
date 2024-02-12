{
  outputs = {...} @ inputs: let
    inherit (import ./lib.nix inputs) mkNixOS mkHomeManager;
  in {
    nixosConfigurations = {
      nixie = mkNixOS "nixie" "x86_64-linux" {
        extraLanguageServers = true;
        extraUtils = true;
        enableCmus = true;
        universityTools = true;
      };
    };

    homeConfigurations = {
      "macOS" = mkHomeManager "macOS" "aarch64-darwin" {
        extraLanguageServers = true;
        extraUtils = true;
        enableCmus = true;
        universityTools = true;
      };

      "pi4" = mkHomeManager "pi4" "aarch64-linux" {};
      "oracle" = mkHomeManager "oracle" "aarch64-linux" {};
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wired.url = "github:Toqozz/wired-notify";
    agenix.url = "github:ryantm/agenix/0.15.0";
    nixnur.url = "github:nix-community/NUR";
    opam-nix.url = "github:tweag/opam-nix";
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
  };
}
