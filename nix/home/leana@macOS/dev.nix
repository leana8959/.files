{
  pkgs,
  mypkgs,
  unstable,
  ...
}: {
  home.packages = with pkgs; [
    # Tools
    hyperfine
    watchexec
    tea
    tokei
    gnumake

    # University stuff
    unstable.opam
    unstable.cargo
    mypkgs.logisim-evolution
    mypkgs.necrolib
    pkgs.rars
  ];
}
