{
  pkgs,
  mypkgs,
  ...
}: {
  home.packages = with pkgs; [
    mypkgs.hiosevka-nerd-font-mono
    mypkgs.hiosevka-nerd-font-propo
    jetbrains-mono

    lmodern
    cascadia-code
  ];
}
