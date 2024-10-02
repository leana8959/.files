{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  imports = [
    ./browser.nix
    ./wm.nix

    # system-wide language servers, build tools, compilers
    ./dev.nix
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

    # CVE-2024-45191
    # CVE-2024-45192
    # CVE-2024-45193
    # disabled for security
    #
    # pkgs.cinny-desktop

    pkgs.hacksaw
    pkgs.shotgun
    pkgs.vlc

    pkgs.evolution
    pkgs.teams-for-linux

    myPkgs.typst-mutilate

    pkgs.prop-solveur
    pkgs.hbf
  ];

  programs = {
    kitty.enable = true;
    password-store.enable = true;
  };

}
