{
  pkgs,
  unstable,
  opam-nix,
  alt-ergo,
}:
let
  mkNerdFont = pkgs.callPackage ./mkNerdFont.nix { inherit (unstable) nerd-font-patcher; };

  logisim-evolution = pkgs.callPackage ./logisim-evolution.nix { };

  necrolib = pkgs.callPackage ./necrolib.nix { inherit opam-nix; };

  hiosevka = pkgs.callPackage ./hiosevka { };
  hiosevka-nerd-font-mono = mkNerdFont {
    font = hiosevka;
    extraArgs = [
      "--name {/.}-NFM"
      "--use-single-width-glyphs"
    ];
  };
  hiosevka-nerd-font-propo = mkNerdFont {
    font = hiosevka;
    extraArgs = [
      "--name {/.}-NFP"
      "--variable-width-glyphs"
    ];
  };

  why3 = pkgs.callPackage ./why3.nix { inherit alt-ergo; };

  maeel = pkgs.callPackage ./maeel.nix { };
in
{
  myPkgs = {
    inherit
      logisim-evolution
      necrolib
      hiosevka
      hiosevka-nerd-font-mono
      hiosevka-nerd-font-propo
      why3
      maeel
      ;
  };

  myLib = {
    inherit mkNerdFont;
  };
}
