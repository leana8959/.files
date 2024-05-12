{ pkgs, ... }:
let
  inherit (pkgs) ghc-pin;
in
{
  home.homeDirectory = throw "fix this"
  # lib.mkForce "/Users/leana"
  ;

  home.packages = [
    ghc-pin.ghc
    ghc-pin.haskell-language-server
  ];
}
