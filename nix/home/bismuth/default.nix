{ pkgs, lib, ... }:
let
  inherit (pkgs) myPkgs unstable ghc-pin;
in
{
  imports = [ ./fonts.nix ];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = [
    ghc-pin.ghc
    ghc-pin.haskell-language-server
    unstable.qmk
    unstable.wally-cli

    unstable.cargo
    pkgs.nix-inspect
    pkgs.nix-visualize
    pkgs.deploy-rs

    pkgs.audio-lint
    # # I got myself into the dependency hell, they have a common dependency that clash
    # pkgs.hbrainfuck
    # pkgs.prop-solveur
    myPkgs.maeel

    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
  ];
}
