{ self, ... }:

{
  flake.lib.mkNerdFont = ./mkNerdFont.nix;

  perSystem =
    { pkgs-stable, lib, ... }:
    let
      mkNerdFont = pkgs-stable.callPackage self.lib.mkNerdFont { };
    in
    {
      # Export my package set
      packages = rec {
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

        dl-librescore = pkgs-stable.callPackage ./dl-librescore.nix { };
        fish-lsp = pkgs-stable.callPackage ./fish-lsp { };
        maeel = pkgs-stable.callPackage ./maeel.nix { };
        tokei = pkgs-stable.callPackage ./tokei { }; # alpha tokei with typst, skel, hledger

        posy-cursor = pkgs-stable.callPackage ./posy-cursor.nix { };

        nd = pkgs-stable.writeShellApplication {
          name = "nd";
          runtimeInputs = [
            pkgs-stable.nix-output-monitor
            pkgs-stable.nvd
          ];
          text = builtins.readFile ./nd.sh;
        };
      };
    };
}
