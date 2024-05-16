{ pkgs, ... }:
let
  inherit (pkgs) ghc-pin myPkgs;
in
{
  home = {
    username = "ychiang";
    homeDirectory = "/udd/ychiang";
  };

  home.packages = [
    ghc-pin.ghc
    ghc-pin.haskell-language-server
    myPkgs.necrolib
  ];
}
