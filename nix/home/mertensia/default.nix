{ pkgs, config, ... }:
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
    ghc-pin.cabal-install
    ghc-pin.haskell-language-server
    myPkgs.necrolib
  ];

  home.file."hiosevka-font" = {
    source = "${myPkgs.hiosevka-nerd-font-mono}/share/fonts/truetype";
    target = "${config.home.homeDirectory}/.local/share/fonts/truetype";
  };

  programs.password-store.enable = true;
}
