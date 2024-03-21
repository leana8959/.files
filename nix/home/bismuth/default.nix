{
  pkgs,
  config,
  lib,
  ...
} @ input: {
  imports = [./fonts.nix];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = (
    [
      pkgs.ghc
      pkgs.haskell-language-server

      input.audio-lint
      input.hbrainfuck
      input.prop-solveur
    ]
    ++ lib.lists.optionals config.docker.enable [
      pkgs.docker
      pkgs.docker-compose
      pkgs.colima
    ]
  );

  fish.extraCompletions = (
    [
      input.hbrainfuck
      input.prop-solveur
    ]
    ++ lib.lists.optionals config.docker.enable [
      pkgs.docker
      pkgs.colima
    ]
  );
}
