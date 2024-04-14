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

    pkgs.audio-lint
    pkgs.hbrainfuck
    pkgs.prop-solveur
    myPkgs.maeel

    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
  ];

  fish.opamInit = true;

  fish.extraCompletions = [
    pkgs.hbrainfuck
    pkgs.prop-solveur
  ];
}
