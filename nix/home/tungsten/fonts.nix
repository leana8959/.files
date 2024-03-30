{ pkgs, myPkgs, ... }:
{
  home.packages = with pkgs; [
    myPkgs.hiosevka-nerd-font-mono
    jetbrains-mono

    lmodern
    cascadia-code
  ];
}
