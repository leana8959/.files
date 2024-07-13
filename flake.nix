{
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      flake.nixConfig = {
        extra-substituters = [ "https://leana8959.cachix.org" ];
        extra-trusted-substituters = [ "https://leana8959.cachix.org" ];
        extra-trusted-public-keys = [
          "leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M="
        ];
      };

      imports = [
        ./nix/configurations

        ./nix/homeModules
        ./nix/nixosModules
        ./nix/darwinModules
        ./nix/flakeModules

        ./nix/resolve
        ./nix/custom

        ./nix/pre-commit
        ./nix/devShells
      ];

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      # plz merge my PR
      url = "github:leana8959/home-manager/fish_source_vendor_completion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix = {
      url = "github:ryantm/agenix/0.15.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "nix-darwin";
      inputs.home-manager.follows = "home-manager";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    # packages
    audio-lint = {
      url = "git+https://git.earth2077.fr/leana/audio-lint";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hbrainfuck = {
      url = "git+https://git.earth2077.fr/leana/hbrainfuck";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prop-solveur = {
      url = "git+https://git.earth2077.fr/leana/prop_solveur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
