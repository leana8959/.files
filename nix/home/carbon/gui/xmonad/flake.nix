{
  description = ''
    Bring XMonad library to $PATH for the language server to work
  '';

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          packages = [
            (pkgs.haskell.packages.ghc947.ghcWithPackages (
              hpkgs: with hpkgs; [
                haskell-language-server
                stylish-haskell

                xmonad
                xmonad-contrib
                neat-interpolation
              ]
            ))
          ];
        };
      }
    );
}
