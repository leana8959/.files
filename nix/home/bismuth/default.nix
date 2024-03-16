{
  pkgs,
  lib,
  ...
} @ input: {
  imports = [./fonts.nix];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = [
    pkgs.ghc
    pkgs.haskell-language-server

    input.audio-lint
    input.hbrainfuck
    input.prop-solveur
  ];

  fish.extraCompletions = [
    input.hbrainfuck
    input.prop-solveur
  ];
}
