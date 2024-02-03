{
  pkgs,
  opam-nix,
  ...
}: {
  logisim-evolution = pkgs.callPackage ./logisim-evolution.nix {};
  necrolib = pkgs.callPackage ./necrolib.nix {inherit opam-nix;};
}
