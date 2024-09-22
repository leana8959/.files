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
        ./nix/deploy

        ./nix/homeModules
        ./nix/nixosModules
        ./nix/darwinModules
        ./nix/flakeModules
        ./nix/disko

        ./nix/overlays
        ./nix/packages

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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nur.url = "github:nix-community/nur";
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix.url = "github:ryantm/agenix/0.15.0";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    # packages
    neovim-pin.url = "github:nixos/nixpkgs/6132b0f6e344ce2fe34fc051b72fb46e34f668e0";
    wired-notify = {
      url = "github:Toqozz/wired-notify/0.10.6";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    audio-lint = {
      url = "git+https://git.earth2077.fr/leana/audio-lint";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hbrainfuck = {
      url = "git+https://git.earth2077.fr/leana/hbrainfuck";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    prop-solveur = {
      url = "git+https://git.earth2077.fr/leana/prop_solveur";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hoot = {
      url = "git+https://git.earth2077.fr/leana/hoot";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };
}
