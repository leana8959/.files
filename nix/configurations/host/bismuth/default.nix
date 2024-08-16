{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.vim
    pkgs.gnumake
    pkgs.gnused
    pkgs.cachix
  ];
}
