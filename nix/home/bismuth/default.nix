{
  pkgs,
  lib,
  ...
} @ input: {
  imports = [./fonts.nix];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = [
    input.audio-lint
    input.hbrainfuck
  ];

  fish.extraCompletions = [
    input.hbrainfuck
  ];
}
