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

    pkgs.sioyek
    pkgs.hacksaw
    pkgs.shotgun
    pkgs.vlc

    pkgs.evolution

    pkgs.teams-for-linux

    pkgs.qmk
    pkgs.wally-cli
  ];

  programs = {
    kitty.enable = true;
    password-store.enable = true;
  };

  programs.neovim.extraPackages = [ myPkgs.fish-lsp ];
}
