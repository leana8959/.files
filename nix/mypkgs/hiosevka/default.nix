{
  pkgs,
  unstable,
}: let
  mkNerdFont = font:
    pkgs.stdenv.mkDerivation {
      # credits:
      # https://github.com/NixOS/nixpkgs/issues/44329#issuecomment-1231189572
      # https://github.com/NixOS/nixpkgs/issues/44329#issuecomment-1544597422
      name = "${font.name}-NerdFont";
      src = font;
      nativeBuildInputs = [unstable.nerd-font-patcher pkgs.parallel];
      buildPhase = ''
        mkdir -p nerd-font
        find \( -name \*.ttf -o -name \*.otf \) | parallel nerd-font-patcher \
            {} \
            --name {/.}-NF \
            --use-single-width-glyphs \
            --careful \
            --complete \
            --quiet \
            --no-progressbars \
            --outputdir nerd-font
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
      # https://github.com/be5invis/Iosevka/blob/main/doc/custom-build.md
      # Use `term` spacing to avoid dashed arrow issue
      # https://github.com/ryanoasis/nerd-fonts/issues/1018
      privateBuildPlan = builtins.readFile ./buildplan.toml;
    };
in {
  inherit hiosevka;
  hiosevka-nerd-font = mkNerdFont hiosevka;
}
