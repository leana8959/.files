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

    # nix
    alejandra

    # University stuff
    unstable.opam
    unstable.cargo
    mypkgs.logisim-evolution
    mypkgs.necrolib
    pkgs.rars
  ];
}
