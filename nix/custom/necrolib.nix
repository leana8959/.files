{
  fetchurl,
  ocamlPackages,
  version ? "v0.15.0",
}:
ocamlPackages.buildDunePackage {
  pname = "necrolib";
  inherit version;

  minimalOCamlVersion = "4.14.1";

  src = fetchurl {
    url = "https://gitlab.inria.fr/skeletons/necro/-/archive/${version}/necro-${version}.tar.gz";
    hash =
      {
        "v0.14.7.1" = "sha256-rFYzNFsT7LIXzWxOogoJd9vh+ywI2N1GE77tnYO7keg=";
        "v0.14.8" = "sha256-ooc1DfTf4k9vcR2aU6CYzaGCDy4XvX98tvfzTLCljSc=";
        "v0.14.9" = "sha256-wPOa/08AykXAotQLZ/CfxD0kLTnWHZTiTPW950uBukA=";
        "v0.15.0" = "sha256-NJArIZMcKUTGqTgYntch9pSFcVe15SQTUD2amsCNXGI=";
      }
      .${version};
  };

  duneVersion = "3";
  nativeBuildInputs = [ ocamlPackages.menhir ];
  buildInputs = [
    ocamlPackages.ocamlgraph
    ocamlPackages.dune-build-info
  ];
}
