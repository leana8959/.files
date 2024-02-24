{
  pkgs,
  unstable,
  system,
  opam-nix,
  ...
}: let
  mkNerdFont = import ./mkNerdFont.nix {inherit pkgs unstable;};
in {
  logisim-evolution = import ./logisim-evolution.nix {inherit pkgs;};

  necrolib = import ./necrolib.nix {
    inherit pkgs system;
    inherit opam-nix;
  };

  inherit
    (import ./hiosevka {inherit pkgs unstable mkNerdFont;})
    hiosevka
    hiosevka-nerd-font-mono
    hiosevka-nerd-font-propo
    ;
}
