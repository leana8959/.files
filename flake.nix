{
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      _module.args.flakeRoot = ./.;

      flake.nixConfig = {
        extra-substituters = [ "https://leana8959.cachix.org" ];
        extra-trusted-substituters = [ "https://leana8959.cachix.org" ];
        extra-trusted-public-keys = [
          "leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M="
        ];
      };

      imports = [
        ./nix/handleInputs # Resolve inputs
        ./nix/custom # Custom package set
        ./nix/configurations # Configuration and their generators
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
    nixnur.url = "github:nix-community/NUR";
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
    agenix.url = "github:ryantm/agenix/0.15.0";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # packages
    wired.url = "github:Toqozz/wired-notify";
    llama-cpp.url = "github:ggerganov/llama.cpp";
    nix-visualize.url = "github:craigmbooth/nix-visualize";
    nix-inspect.url = "github:bluskript/nix-inspect";
    deploy-rs.url = "github:serokell/deploy-rs";
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
    hbrainfuck.url = "git+https://git.earth2077.fr/leana/hbrainfuck";
    prop-solveur.url = "git+https://git.earth2077.fr/leana/prop_solveur";
    # pins
    neovim-pin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    alt-ergo-pin.url = "github:NixOS/nixpkgs/1b95daa381fa4a0963217a5d386433c20008208a";
    # stackage LTS 22.22 / ghc965 (May 19 2024) / hls 2.8.0.0
    ghc-pin.url = "github:NixOS/nixpkgs/1faadcf5147b9789aa05bdb85b35061b642500a4";
  };
}
