{ pkgs, ... }:
let
  inherit (pkgs) ghc-pin;
in
{
  home = {
    username = "ychiang";
    homeDirectory = "/udd/ychiang";
  };

  home.packages = [
    ghc-pin.ghc
    ghc-pin.haskell-language-server
  ];
}
