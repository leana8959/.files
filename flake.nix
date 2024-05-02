{
  outputs =
    inputs:
    (inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      imports = [
        ./nix/handleInputs # Resolve inputs
        ./nix/custom # Custom package set
        ./nix/lib # Configuration and their generators
      ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.unstable.nixfmt-rfc-style;
        };
    });

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
    flake-parts.url = "github:hercules-ci/flake-parts";
    # packages
    wired.url = "github:Toqozz/wired-notify";
    agenix.url = "github:ryantm/agenix/0.15.0";
    nixnur.url = "github:nix-community/NUR";
    llama-cpp.url = "github:ggerganov/llama.cpp";
    alt-ergo-pin.url = "github:NixOS/nixpkgs/1b95daa381fa4a0963217a5d386433c20008208a";
    neovim-pin.url = "github:nixos/nixpkgs/nixos-unstable";
    ghc-pin.url = "github:nixos/nixpkgs/nixos-unstable"; # pin the latest unstable ghc
    nix-visualize.url = "github:craigmbooth/nix-visualize";
    nix-inspect.url = "github:bluskript/nix-inspect";
    # my stuff
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
    hbrainfuck.url = "git+https://git.earth2077.fr/leana/hbrainfuck";
    prop-solveur.url = "git+https://git.earth2077.fr/leana/prop_solveur";
  };
}
