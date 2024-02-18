{
  pkgs,
  unstable,
  ...
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
        find \( -name \*.ttf -o -name \*.otf \) | parallel nerd-font-patcher {} \
            --name {/.}-NF \
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
      privateBuildPlan = ''
        [buildPlans.${pname}]
        family = "hIosekva"
        spacing = "normal"
        serifs = "sans"

        [buildPlans.${pname}.ligations]
        inherits = "haskell"
        enables = [
            "brst",  # (* *)
            "logic", # \/ /\
        ]
        disables = [
            "lteq", # <=
            "gteq", # >=
        ]

        [buildPlans.${pname}.variants.design]
        capital-z = 'straight-serifless-with-crossbar'
        capital-m = 'hanging-motion-serifed'
        capital-n = 'standard-motion-serifed'
        capital-q = 'crossing'
        m = 'top-left-serifed'
        n = 'straight-top-left-serifed'
        lower-lambda = 'tailed-turn'
        seven = 'straight-serifless-crossbar'
        number-sign = 'slanted'
        ampersand = "upper-open"
        dollar = 'open'
        percent = 'rings-continuous-slash-also-connected'
      '';
    };
in {
  home.packages = with pkgs; [
    (mkNerdFont hiosevka)

    lmodern
    cascadia-code
    hiosevka
  ];
}
