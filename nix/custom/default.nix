{
  perSystem =
    { pkgs, ... }:
    let
      inherit (pkgs) unstable alt-ergo-pin;
    in
    {
      # Export my package set
      packages = rec {
        mkNerdFont = pkgs.callPackage ./mkNerdFont.nix { inherit (unstable) nerd-font-patcher; };

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
        maeel = pkgs.callPackage ./maeel.nix { };
      };
    };
}
