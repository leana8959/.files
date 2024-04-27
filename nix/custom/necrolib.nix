{
  fetchFromGitLab,
  ocaml-ng,
  ocamlPackages ? ocaml-ng.ocamlPackages_4_14,
  version ? "v0.15.0",
}:
ocamlPackages.buildDunePackage {
  pname = "necrolib";
  inherit version;

  minimalOCamlVersion = "4.14.1";

  src = fetchFromGitLab {
    domain = "gitlab.inria.fr";
    owner = "skeletons";
    repo = "necro";
    rev = version;
    hash =
      {
        "v0.14.7.1" = "sha256-Y7+LcQyz9NP20E1uGJbHE3/gPus6xL2GjL2auxnmPK0=";
        "v0.14.8" = "sha256-MLx3BenTbgFILgQgTOGb2E3R/p3Z1Lsy0ojPbP9g/eg=";
        "v0.14.9" = "sha256-10S+duTyffKUS3BiC5TnGnhjgChhqHivyN/PpTU1q6Q=";
        "v0.15.0" = "sha256-2ZVc2Je29pPQNA+Oc6lw5Z5obAMTTEB7NvEZ01/12F8=";
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
