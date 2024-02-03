{
  pkgs,
  opam-nix,
  system,
  version ? "v0.14.7.1",
}: let
  pname = "necrolib";

  src = pkgs.fetchurl {
    url = "https://gitlab.inria.fr/skeletons/necro/-/archive/${version}/necro-${version}.tar.gz";
    hash = "sha256-ooc1DfTf4k9vcR2aU6CYzaGCDy4XvX98tvfzTLCljSc=";
  };

  on = opam-nix.lib.${system};
  query = {ocaml-base-compiler = "4.14.1";};

  scope = on.buildDuneProject {} pname src query;

  overlay = self: super: {
    # credits: balsoft
    # https://github.com/tweag/opam-nix/discussions/71#discussioncomment-8344504
    necrolib = super.necrolib.overrideAttrs (oa: {inherit src;});
  };
in
  (scope.overrideScope' overlay).${pname}
