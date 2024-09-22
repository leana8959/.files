{
  lib,
  fetchFromGitLab,
  ocaml-ng,
  ocamlPackages ? ocaml-ng.ocamlPackages_4_14,
}:

let
  rev = "4690dd27717e687b8eba449e44127a53fabe7a2d";
in

ocamlPackages.buildDunePackage {
  pname = "necrolib";
  version = lib.substring 0 7 rev;

  minimalOCamlVersion = "4.14.1";

  src = fetchFromGitLab {
    domain = "gitlab.inria.fr";
    owner = "skeletons";
    repo = "necro";
    inherit rev;
    hash = "sha256-FYeVuSUmA6as0oI80uC3wW8l1/AazOPAtiNsnZyUahU=";
  };

  duneVersion = "3";
  nativeBuildInputs = [ ocamlPackages.menhir ];
  buildInputs = [
    ocamlPackages.ocamlgraph
    ocamlPackages.dune-build-info
  ];
}
