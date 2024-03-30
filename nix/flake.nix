{
  outputs =
    { ... }@inputs:
    let
      inherit (import ./lib.nix inputs)
        mkNixOSes
        mkDarwins
        mkHomeManagers
        myPkgs
        myLib
        formatter
        ;

      darwinConfigurations = mkDarwins {
        # MacBook Pro 2021
        bismuth = {
          system = "aarch64-darwin";
          settings = {
            extraLanguageServers.enable = true;
            extraUtils.enable = true;
            cmus.enable = true;
            universityTools.enable = true;
            docker.enable = true;
          };
        };
      };

      homeConfigurations = mkHomeManagers {
        # MacBook Air 2014
        tungsten = {
          system = "x86_64-darwin";
          settings.cmus.enable = true;
        };
        # Raspberry Pi 4
        hydrogen.system = "aarch64-linux";
        # Oracle cloud
        oracle.system = "aarch64-linux";
        # Linode
        linode.system = "x86_64-linux";
      };

      nixosConfigurations = mkNixOSes {
        # Thinkpad
        carbon = {
          system = "x86_64-linux";
          settings = {
            extraLanguageServers.enable = true;
            extraUtils.enable = true;
            cmus.enable = true;
            universityTools.enable = true;
          };
        };
      };
    in
    {
      inherit nixosConfigurations homeConfigurations darwinConfigurations;
    }
    // formatter
    // myPkgs
    // myLib;

  inputs = {
    # package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # tools
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # packages
    wired.url = "github:Toqozz/wired-notify";
    agenix.url = "github:ryantm/agenix/0.15.0";
    nixnur.url = "github:nix-community/NUR";
    opam-nix.url = "github:tweag/opam-nix";
    llama-cpp.url = "github:ggerganov/llama.cpp";
    alt-ergo-pin.url = "github:NixOS/nixpkgs/1b95daa381fa4a0963217a5d386433c20008208a";
    neovim-pin.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-visualize.url = "github:craigmbooth/nix-visualize";
    # my stuff
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
    hbrainfuck.url = "git+https://git.earth2077.fr/leana/hbrainfuck";
    prop-solveur.url = "git+https://git.earth2077.fr/leana/prop_solveur";
  };
}
