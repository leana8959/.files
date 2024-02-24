{
  pkgs,
  unstable,
  mkNerdFont,
}: let
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
