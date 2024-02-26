{
  outputs = {...} @ inputs: let
    inherit (import ./lib.nix inputs) mkNixOSes mkHomeManagers myPackages formatter;

    nixosConfigurations = mkNixOSes {
      # Thinkpad
      carbon = {
        system = "x86_64-linux";
        settings = {
          extraLanguageServers = true;
          extraUtils = true;
          enableCmus = true;
          universityTools = true;
        };
      };
    };

    homeConfigurations = mkHomeManagers {
      # MacBook Pro 2021
      bismuth = {
        system = "aarch64-darwin";
        settings = {
          extraLanguageServers = true;
          extraUtils = true;
          enableCmus = true;
          universityTools = true;
        };
      };
      # MacBook Air 2014
      tungsten = {
        system = "x86_64-darwin";
        settings.enableCmus = true;
      };
      # Raspberry Pi 4
      hydrogen.system = "aarch64-linux";
      # Oracle cloud
      oracle.system = "aarch64-linux";
    };
  in
    myPackages // formatter // {inherit nixosConfigurations homeConfigurations;};

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
