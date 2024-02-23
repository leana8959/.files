{
  pkgs,
  unstable,
}: let
  mkNerdFont = {
    font,
    extraArgs ? [],
    useDefaultsArgs ? true,
  }:
    pkgs.stdenv.mkDerivation {
      /*
      Credits:
      https://github.com/NixOS/nixpkgs/issues/44329#issuecomment-1231189572
      https://github.com/NixOS/nixpkgs/issues/44329#issuecomment-1544597422

      long font names is not problematic:
      https://github.com/ryanoasis/nerd-fonts/issues/1018#issuecomment-1953555781
      */
      name = "${font.name}-NerdFont";
      src = font;
      nativeBuildInputs = [unstable.nerd-font-patcher pkgs.parallel];
      buildPhase = let
        args = builtins.concatStringsSep " " extraArgs;
        defArgs =
          if useDefaultsArgs
          then builtins.concatStringsSep " " ["--careful" "--complete" "--quiet" "--no-progressbars"]
          else "";
      in ''
        mkdir -p nerd-font
        find \( -name \*.ttf -o -name \*.otf \) | parallel nerd-font-patcher {} \
            --outputdir nerd-font ${defArgs} ${args}
      '';
      installPhase = ''
        fontdir="$out"/share/fonts/truetype
        install -d "$fontdir"
        install nerd-font/* "$fontdir"
      '';
    };

  hiosevka = let
    pname = "hiosevka";
  in
    (pkgs.iosevka.overrideAttrs (_: {inherit pname;}))
    .override {
      set = pname;
      /*
      Guide: https://github.com/be5invis/Iosevka/blob/main/doc/custom-build.md

      Use `term` spacing to avoid dashed arrow issue
      https://github.com/ryanoasis/nerd-fonts/issues/1018
      */
      privateBuildPlan = builtins.readFile ./buildplan.toml;
    };
in rec {
  inherit hiosevka;

  hiosevka-nerd-font-mono = mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFM" "--use-single-width-glyphs"];
  };
  hiosevka-nerd-font-propo = mkNerdFont {
    font = hiosevka;
    extraArgs = ["--name {/.}-NFP" "--variable-width-glyphs"];
  };
}
