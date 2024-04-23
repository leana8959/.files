{ pkgs, myPkgs, ... }:
{
  home.packages = [
    myPkgs.hiosevka-nerd-font-mono
    pkgs.jetbrains-mono

    pkgs.lmodern
    pkgs.cascadia-code
  ];
}
