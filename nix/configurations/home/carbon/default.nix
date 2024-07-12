{ pkgs, ... }:
{
  imports = [
    ./gui
    ./browser.nix
  ];

  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.gnutar
  ];
}
