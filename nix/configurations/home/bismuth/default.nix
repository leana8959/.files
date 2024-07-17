{ pkgs, ... }:
let
  inherit (pkgs) myPkgs ghc-pin;
in
{
  imports = [ ./fonts.nix ];

  home.packages = [
    ghc-pin.ghc
    ghc-pin.haskell-language-server
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

  programs.neovim.extraLangServers.packages = [ myPkgs.fish-lsp ];
}
