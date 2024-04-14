{
  pkgs,
  unstable,
  myPkgs,
  lib,
  ...
}@input:
{
  imports = [ ./fonts.nix ];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = [
    pkgs.ghc
    pkgs.haskell-language-server
    unstable.qmk
    unstable.wally-cli

    unstable.cargo

    input.audio-lint
    input.hbrainfuck
    input.prop-solveur
    myPkgs.maeel

    input.nix-inspect

    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
  ];

  fish.opamInit = true;

  fish.extraCompletions = [
    input.hbrainfuck
    input.prop-solveur
  ];
}
