{
  outputs = {...} @ inputs: let
    inherit (import ./lib.nix inputs) mkNixOS mkHomeManager;
  in {
    nixosConfigurations = {
      nixie = mkNixOS {
        hostname = "nixie";
        system = "x86_64-linux";
        extraSettings = {
          extraLanguageServers = true;
          extraUtils = true;
          enableCmus = true;
          universityTools = true;
        };
      };
    };

    homeConfigurations = {
      "macOS" = mkHomeManager {
        hostname = "macOS";
        system = "aarch64-darwin";
        extraSettings = {
          extraLanguageServers = true;
          extraUtils = true;
          enableCmus = true;
          universityTools = true;
        };
      };

      "pi4" = mkHomeManager {
        hostname = "pi4";
        system = "aarch64-linux";
      };

      "oracle" = mkHomeManager {
        hostname = "oracle";
        system = "aarch64-linux";
      };
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
