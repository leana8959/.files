{ pkgs, lib, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  home = {
    username = "ychiang";
    homeDirectory = "/udd/ychiang";
  };

  home.packages = [ myPkgs.necrolib ];

  home.file.".local/share/fonts/truetype".source = "${myPkgs.altiosevka-nerd-font-mono}/share/fonts/truetype";

  # it gets turned off so I need to run it more frequently
  nix.gc.frequency = lib.mkForce "3 hours";
}
