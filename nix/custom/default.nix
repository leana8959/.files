{ self, ... }:

{
  flake.lib.mkNerdFont = ./mkNerdFont.nix;

  flake.overlays.packages =
    final: _:
    let
      mkNerdFont = final.callPackage self.lib.mkNerdFont { };
    in
    rec {
      # fonts
      hiosevka = final.callPackage ./hiosevka { };
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
      altiosevka = final.callPackage ./altiosevka { };

      logisim-evolution = final.callPackage ./logisim-evolution.nix { };
      necrolib = final.callPackage ./necrolib.nix { };
      why3 = final.callPackage ./why3.nix { };
      isabelle-wrapped = final.callPackage ./isabelle-wrapped.nix { };

      maeel = final.callPackage ./maeel.nix { };
      tokei = final.callPackage ./tokei { }; # alpha tokei with typst, skel, hledger
      typst-mutilate = final.callPackage ./typst-mutilate.nix { };

      posy-cursor = final.callPackage ./posy-cursor.nix { };
      nd = final.callPackage ./nd { };
      xbrightness = final.callPackage ./xbrightness.nix { };
      ffgun = final.callPackage ./ffgun.nix { };

      # Unmerged packages from nixfinal
      # TODO: use upstream when merged
      dl-librescore = final.callPackage ./dl-librescore.nix { };
      fish-lsp = final.callPackage ./fish-lsp { };
    };

  perSystem =
    { pkgs-stable, ... }:
    {
      packages = self.overlays.packages pkgs-stable pkgs-stable;
    };
}
