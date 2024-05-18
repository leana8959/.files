{
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      flake.nixConfig = {
        extra-trusted-substituters = [ "https://leana8959.cachix.org" ];
        extra-trusted-public-keys = [
          "leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M="
        ];
      };

      imports = [
        ./nix/handleInputs # Resolve inputs
        ./nix/custom # Custom package set
        ./nix/configurations # Configuration and their generators
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
          formatter = pkgs.unstable.nixfmt-rfc-style;
        };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixnur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix.url = "github:ryantm/agenix/0.15.0";
    # packages
    wired.url = "github:Toqozz/wired-notify";
    llama-cpp.url = "github:ggerganov/llama.cpp";
    nix-visualize.url = "github:craigmbooth/nix-visualize";
    nix-inspect.url = "github:bluskript/nix-inspect";
    deploy-rs.url = "github:serokell/deploy-rs";
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
    hbrainfuck.url = "git+https://git.earth2077.fr/leana/hbrainfuck";
    prop-solveur.url = "git+https://git.earth2077.fr/leana/prop_solveur";
    neovim.url = "github:neovim/neovim/v0.9.5?dir=contrib";
    # pins
    alt-ergo-pin.url = "github:NixOS/nixpkgs/1b95daa381fa4a0963217a5d386433c20008208a";
    ghc-pin.url = "github:NixOS/nixpkgs/e4330b3996980ccf70918af3c86ea3d89cd5433d"; # stackage LTS 22.16 / ghc964, right before ghc965
  };
}
