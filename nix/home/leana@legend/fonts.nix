{
  pkgs,
  mypkgs,
  ...
}: {
  home.packages = with pkgs; [
    mypkgs.hiosevka-nerd-font-mono
    jetbrains-mono

    lmodern
    cascadia-code
  ];
}
