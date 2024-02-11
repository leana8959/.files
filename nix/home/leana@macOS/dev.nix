{
  pkgs,
  mypkgs,
  unstable,
  ...
}: {
  home.packages = [
    # University stuff
    unstable.opam
    unstable.cargo
    mypkgs.logisim-evolution
    mypkgs.necrolib
    pkgs.rars
  ];
}
