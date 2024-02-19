{
  pkgs,
  mypkgs,
  ...
}: {
  home.packages = with pkgs; [
    mypkgs.hiosevka-nerd-font

    lmodern
    cascadia-code
  ];
}
