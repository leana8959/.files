{ pkgs, myPkgs, ... }:
{
  home.packages = with pkgs; [
    myPkgs.hiosevka-nerd-font-mono
    myPkgs.hiosevka-nerd-font-propo
    jetbrains-mono

    lmodern
    cascadia-code
  ];
}
