{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (pkgs) myPkgs;
in

{
  home = {
    username = "ychiang";
    homeDirectory = "/udd/ychiang";
  };

  home.packages = [ myPkgs.necrolib ];

  home.file."hiosevka-font" = {
    source = "${myPkgs.hiosevka-nerd-font-mono}/share/fonts/truetype";
    target = "${config.home.homeDirectory}/.local/share/fonts/truetype";
  };

  # it gets turned off so I need to run it more frequently
  nix.gc.frequency = lib.mkForce "3 hours";
}
