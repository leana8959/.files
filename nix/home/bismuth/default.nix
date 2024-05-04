{ pkgs, lib, ... }:
let
  inherit (pkgs) myPkgs unstable ghc-pin;
in
{
  imports = [ ./fonts.nix ];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = [
    ghc-pin.ghc
    pkgs.haskell-language-server
    unstable.qmk
    unstable.wally-cli

    unstable.cargo
    pkgs.nix-inspect
    pkgs.nix-visualize
    pkgs.deploy-rs

    pkgs.audio-lint
    pkgs.hbrainfuck
    pkgs.prop-solveur
    myPkgs.maeel

    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
  ];
}
