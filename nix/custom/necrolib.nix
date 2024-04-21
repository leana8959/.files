{
  fetchurl,
  opam-nix,
  system,
  version ? "v0.15.0",
}:
let
  pname = "necrolib";

  hashes = {
    "v0.14.7.1" = "sha256-rFYzNFsT7LIXzWxOogoJd9vh+ywI2N1GE77tnYO7keg=";
    "v0.14.8" = "sha256-ooc1DfTf4k9vcR2aU6CYzaGCDy4XvX98tvfzTLCljSc=";
    "v0.14.9" = "sha256-wPOa/08AykXAotQLZ/CfxD0kLTnWHZTiTPW950uBukA=";
    "v0.15.0" = "sha256-NJArIZMcKUTGqTgYntch9pSFcVe15SQTUD2amsCNXGI=";
  };

  src = fetchurl {
    url = "https://gitlab.inria.fr/skeletons/necro/-/archive/${version}/necro-${version}.tar.gz";
    hash = hashes.${version};
  };

  on = opam-nix.lib.${system};
  query = {
    ocaml-base-compiler = "4.14.1";
  };

  scope = on.buildDuneProject { } pname src query;

  overlay = self: super: {
    # credits: balsoft
    # https://github.com/tweag/opam-nix/discussions/71#discussioncomment-8344504
    necrolib = super.necrolib.overrideAttrs (oa: { inherit src; });
  };
in
(scope.overrideScope' overlay).${pname}
