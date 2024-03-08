{
  pkgs,
  unstable,
  system,
  opam-nix,
  ...
}: let
  mkNerdFont = import ./mkNerdFont.nix {inherit pkgs unstable;};
in rec {
  logisim-evolution = import ./logisim-evolution.nix {inherit pkgs;};

  necrolib = import ./necrolib.nix {
    inherit pkgs system;
    inherit opam-nix;
  };

  hiosevka = import ./hiosevka {inherit pkgs;};
  hiosevka-nerd-font-mono = mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFM" "--use-single-width-glyphs"];
  };
  hiosevka-nerd-font-propo = mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFP" "--variable-width-glyphs"];
  };
}
