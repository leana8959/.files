{ iosevka }:
let
  pname = "hiosevka";
in
with builtins;
(iosevka.overrideAttrs (_: { inherit pname; })).override {
  set = pname;
  /* Guide: https://github.com/be5invis/Iosevka/blob/main/doc/custom-build.md

     Use `term` spacing to avoid dashed arrow issue
     https://github.com/ryanoasis/nerd-fonts/issues/1018
  */
  privateBuildPlan = readFile ./buildplan.toml;
}
