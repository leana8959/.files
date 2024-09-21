{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  imports = [
    ./browser.nix
    ./wm.nix
  ];

  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.gnutar
    pkgs.p7zip
    pkgs.bc

    pkgs.deploy-rs
    myPkgs.nd

    pkgs.discord
    pkgs.cinny-desktop

    pkgs.hacksaw
    pkgs.shotgun
    pkgs.vlc

    pkgs.evolution
    pkgs.teams-for-linux

    pkgs.qmk
    pkgs.wally-cli

    myPkgs.typst-mutilate

    pkgs.vscode-fhs
    pkgs.jetbrains.idea-community

    pkgs.prop-solveur
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  programs = {
    kitty.enable = true;
    password-store.enable = true;
  };

  programs.neovim.extraPackages = [
    myPkgs.fish-lsp

    pkgs.typescript
    pkgs.nodePackages.typescript-language-server
  ];
}
