{ self, ... }:
{
  flake.lib.mkNerdFont = ./mkNerdFont.nix;

  perSystem =
    { pkgs, ... }:
    let
      inherit (pkgs) alt-ergo-pin;
      mkNerdFont = pkgs.callPackage self.lib.mkNerdFont { };
    in
    {
      # Export my package set
      packages = rec {
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
        altiosevka = pkgs.callPackage ./altiosevka { };

        logisim-evolution = pkgs.callPackage ./logisim-evolution.nix { };
        necrolib = pkgs.callPackage ./necrolib.nix { };
        why3 = pkgs.callPackage ./why3.nix { inherit (alt-ergo-pin) alt-ergo; };

        dl-librescore = pkgs.callPackage ./dl-librescore.nix { };
        fish-lsp = pkgs.callPackage ./fish-lsp { };
        maeel = pkgs.callPackage ./maeel.nix { };
        tokei = pkgs.callPackage ./tokei { }; # alpha tokei with typst, skel, hledger

        posy-cursor = pkgs.callPackage ./posy-cursor.nix { };
      };
    };
}
