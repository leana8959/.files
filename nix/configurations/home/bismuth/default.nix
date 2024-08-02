{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  imports = [ ./fonts.nix ];

  home.packages = [
    pkgs.qmk
    pkgs.wally-cli

    # pkgs.cargo
    pkgs.nix-inspect
    # pkgs.nix-visualize
    # pkgs.nix-du
    pkgs.deploy-rs

    pkgs.audio-lint
    # pkgs.hbrainfuck
    # pkgs.prop-solveur
    myPkgs.maeel

    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
  ];

  programs.neovim.extraPackages = [ myPkgs.fish-lsp ];
}
