{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  imports = [
    ./browser.nix
    ./wm.nix
    ./joshuto
  ];

  home.file = {
    ".xscreensaver".source = ./xscreensaver/.xscreensaver;
    ".wallpaper".source = ./wallpapers/wp3023938-nebula-wallpapers-hd.jpg;
  };

  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.gnutar
    pkgs.p7zip
    pkgs.deploy-rs
    myPkgs.nd

    pkgs.discord
    pkgs.cinny-desktop

    pkgs.sioyek
    pkgs.hacksaw
    pkgs.shotgun
    pkgs.vlc

    pkgs.qmk
    pkgs.wally-cli
  ];

  programs = {
    kitty.enable = true;
    password-store.enable = true;
  };

  programs.neovim.extraPackages = [ myPkgs.fish-lsp ];
}
