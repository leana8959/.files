{
  callPackage,
  unstable,
  opam-nix,
}: let
  mkNerdFont = callPackage ./mkNerdFont.nix {inherit (unstable) nerd-font-patcher;};

  logisim-evolution = callPackage ./logisim-evolution.nix {};

  necrolib = callPackage ./necrolib.nix {
    inherit opam-nix;
  };

  hiosevka = callPackage ./hiosevka {};
  hiosevka-nerd-font-mono = mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFM" "--use-single-width-glyphs"];
  };
  hiosevka-nerd-font-propo = mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFP" "--variable-width-glyphs"];
  };
in {
  myPkgs = {
    inherit
      logisim-evolution
      necrolib
      hiosevka
      hiosevka-nerd-font-mono
      hiosevka-nerd-font-propo
      ;
  };

  myLib = {
    inherit
      mkNerdFont
      ;
  };
}
