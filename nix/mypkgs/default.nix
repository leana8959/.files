{
  pkgs,
  unstable,
  system,
  opam-nix,
  ...
}: rec {
  lib = {
    mkNerdFont = import ./mkNerdFont.nix {inherit pkgs unstable;};
  };

  logisim-evolution = import ./logisim-evolution.nix {inherit pkgs;};

  necrolib = import ./necrolib.nix {
    inherit pkgs system;
    inherit opam-nix;
  };

  hiosevka = import ./hiosevka {inherit pkgs;};
  hiosevka-nerd-font-mono = lib.mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFM" "--use-single-width-glyphs"];
  };
  hiosevka-nerd-font-propo = lib.mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFP" "--variable-width-glyphs"];
  };
}
