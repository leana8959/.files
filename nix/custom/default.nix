{ self, ... }:

{
  flake.lib.mkNerdFont = ./mkNerdFont.nix;

  perSystem =
    { pkgs-stable, lib, ... }:
    let
      mkNerdFont = pkgs-stable.callPackage self.lib.mkNerdFont { };
    in
    {
      packages = rec {
        # fonts
        hiosevka = pkgs-stable.callPackage ./hiosevka { };
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
        altiosevka = pkgs-stable.callPackage ./altiosevka { };

        logisim-evolution = pkgs-stable.callPackage ./logisim-evolution.nix { };
        necrolib = pkgs-stable.callPackage ./necrolib.nix { };
        why3 = pkgs-stable.callPackage ./why3.nix { };

        maeel = pkgs-stable.callPackage ./maeel.nix { };
        tokei = pkgs-stable.callPackage ./tokei { }; # alpha tokei with typst, skel, hledger
        typst-mutilate = pkgs-stable.callPackage ./typst-mutilate.nix { };

        posy-cursor = pkgs-stable.callPackage ./posy-cursor.nix { };
        nd = pkgs-stable.callPackage ./nd { };
        xbrightness = pkgs-stable.callPackage ./xbrightness.nix { };

        # Unmerged packages from nixpkgs
        # TODO: use upstream when merged
        dl-librescore = pkgs-stable.callPackage ./dl-librescore.nix { };
        fish-lsp = pkgs-stable.callPackage ./fish-lsp { };
      };
    };
}
