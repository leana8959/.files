{
  self,
  lib,
  inputs,

  withSystem,
  ...
}:

{
  imports = [ inputs.flakies.flakeModules.typstLib ];

  flake.lib.mkNerdFont = ./mkNerdFont.nix;

  flake.overlays.packages =
    final: _:
    let
      mkNerdFont = final.callPackage self.lib.mkNerdFont { };
    in
    lib.fix (ps: {
      # fonts
      hiosevka = final.callPackage ./hiosevka { };
      hiosevka-nerd-font-mono = mkNerdFont {
        font = ps.hiosevka;
        extraArgs = [
          "--name {/.}-NFM"
          "--use-single-width-glyphs"
        ];
      };
      hiosevka-nerd-font-propo = mkNerdFont {
        font = ps.hiosevka;
        extraArgs = [
          "--name {/.}-NFP"
          "--variable-width-glyphs"
        ];
      };

      altiosevka = final.callPackage ./altiosevka { };
      altiosevka-nerd-font-mono = mkNerdFont {
        font = ps.altiosevka;
        extraArgs = [
          "--name {/.}-NFM"
          "--use-single-width-glyphs"
        ];
      };
      altiosevka-nerd-font-propo = mkNerdFont {
        font = ps.altiosevka;
        extraArgs = [
          "--name {/.}-NFP"
          "--variable-width-glyphs"
        ];
      };

      logisim-evolution = final.callPackage ./logisim-evolution.nix { };
      necrolib = final.callPackage ./necrolib.nix { };
      why3 = final.callPackage ./why3.nix {
        inherit
          (import inputs.alt-ergo-pin {
            inherit (final) system;
            config.allowUnfree = true;
          })
          alt-ergo
          ;
      };
      isabelle-wrapped = final.callPackage ./isabelle-wrapped.nix { };

      maeel = final.callPackage ./maeel.nix { };
      tokei = final.callPackage ./tokei { }; # alpha tokei with typst, skel, hledger
      typst-mutilate = final.callPackage ./typst-mutilate.nix { };
      typst-bot = final.callPackage ./typst-bot.nix { };

      posy-cursor = final.callPackage ./posy-cursor.nix { };
      nd = final.callPackage ./nd { };
      xbrightness = final.callPackage ./xbrightness.nix { };
      ffgun = final.callPackage ./ffgun.nix { };
      easyscan = final.callPackage ./easyscan.nix { };

      y-combinator-wallpaper = withSystem final.system (
        { typstLib, ... }:
        typstLib.typstDerivation.overrideAttrs {
          src = ./y-combinator-wallpaper;
          buildPhase = ''
            runHook preBuild
            typst compile main.typ "$out"/main.svg
          '';
          dontFixup = true;
        }
      );

      # Unmerged packages from nixfinal
      # TODO: use upstream when merged
      dl-librescore = final.callPackage ./dl-librescore.nix { };
      fish-lsp = final.callPackage ./fish-lsp { };
    });

  perSystem =
    { system, ... }:
    let
      pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
    in
    {
      packages = self.overlays.packages pkgs-stable pkgs-stable;
    };
}
