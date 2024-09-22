{
  nerd-font-patcher,
  parallel,
  stdenvNoCC,
}:
{
  font,
  extraArgs ? [ ],
  useDefaultsArgs ? true,
}:
stdenvNoCC.mkDerivation {
  /*
    Credits:
    https://github.com/NixOS/nixpkgs/issues/44329#issuecomment-1231189572
    https://github.com/NixOS/nixpkgs/issues/44329#issuecomment-1544597422

    long font names is not problematic:
    https://github.com/ryanoasis/nerd-fonts/issues/1018#issuecomment-1953555781
  */
  name = "${font.name}-NerdFont";
  src = font;
  nativeBuildInputs = [
    nerd-font-patcher
    parallel
  ];

  buildPhase =
    let
      args = builtins.concatStringsSep " " extraArgs;
      defArgs =
        if useDefaultsArgs then
          builtins.concatStringsSep " " [
            "--careful"
            "--complete"
            "--quiet"
            "--no-progressbars"
          ]
        else
          "";
    in
    ''
      mkdir -p nerd-font
      find \( -name \*.ttf -o -name \*.otf \) | parallel nerd-font-patcher {} \
          --outputdir nerd-font ${defArgs} ${args}
    '';

  installPhase = ''
    exists() { [ -e "$1" ]; }

    truetype="$out/share/fonts/truetype"
    opentype="$out/share/fonts/opentype"

    if exists nerd-font/*.ttf ; then
      mkdir -p "$truetype"
      cp nerd-font/*.ttf "$truetype"
    fi

    if exists nerd-font/*.otf ; then
      mkdir -p "$opentype"
      cp nerd-font/*.otf "$opentype"
    fi
  '';
}
