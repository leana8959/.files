{
  pkgs,
  unstable,
  system,
  opam-nix,
  ...
}: {
  logisim-evolution = import ./logisim-evolution.nix {inherit pkgs;};

  necrolib = import ./necrolib.nix {
    inherit pkgs system;
    inherit opam-nix;
  };

  inherit
    (import ./hiosevka {inherit pkgs unstable;})
    hiosevka
    hiosevka-nerd-font-mono
    hiosevka-nerd-font-propo
    ;
}
