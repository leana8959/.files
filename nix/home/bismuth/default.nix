{
  pkgs,
  unstable,
  config,
  lib,
  ...
}@input:
{
  imports = [ ./fonts.nix ];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = (
    [
      pkgs.ghc
      pkgs.haskell-language-server
      unstable.qmk
      unstable.wally-cli

      unstable.cargo

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

  fish.extraCompletions = [
    input.hbrainfuck
    input.prop-solveur
  ];
}
