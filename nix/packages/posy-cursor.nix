{
  lib,
  stdenv,
  fetchFromGitHub,
}:

let
  rev = "bd2bac08bf01e25846a6643dd30e2acffa9517d4";
in

stdenv.mkDerivation {
  pname = "posy-cursor";
  version = lib.substring 0 7 rev;

  src = fetchFromGitHub {
    owner = "leana8959";
    repo = "posy-improved-cursor-linux";
    inherit rev;
    hash = "sha256-ndxz0KEU18ZKbPK2vTtEWUkOB/KqA362ipJMjVEgzYQ=";
  };

  installPhase = ''
    install -dm 0755 $out/share/icons
    cp -r Posy_Cursor* $out/share/icons
  '';
}
