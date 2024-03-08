{
  pkgs,
  unstable,
}: {
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
    truetype="$out"/share/fonts/truetype
    opentype="$out"/share/fonts/opentype

    install -d "$truetype"
    install -d "$opentype"

    install nerd-font/*.ttf "$truetype"
    install nerd-font/*.otf "$opentype"
  '';
}
