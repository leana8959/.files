{ pkgs, myPkgs, ... }:
{
  home.packages = [
    myPkgs.hiosevka-nerd-font-mono
    myPkgs.hiosevka-nerd-font-propo
    pkgs.jetbrains-mono

    pkgs.lmodern
    pkgs.cascadia-code
  ];
}
