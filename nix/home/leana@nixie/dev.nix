{
  pkgs,
  mypkgs,
  unstable,
  ...
}: {
  home.packages = with pkgs; [
    # University stuff
    unstable.opam
    unstable.cargo
    mypkgs.logisim-evolution
    mypkgs.necrolib
    pkgs.rars
  ];
}
