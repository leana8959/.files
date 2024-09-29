{
  rustPlatform,
  fetchFromGitHub,

  lib,
}:

let
  rev = "6be5470fcb19e857f76ede9a7f0c96cac63e3abc";
in

rustPlatform.buildRustPackage rec {
  pname = "typst-bot";
  version = lib.substring 0 8 rev;

  src = fetchFromGitHub {
    owner = "mattfbacon";
    repo = "typst-bot";
    inherit rev;
    hash = "sha256-G3tcyFiHeVH77YT2NeIXS/U1GvqGJBw8o26AlBUc4ok=";
  };

  preBuild = ''
    # Don't use the upstream way of embedding the git rev
    echo 'fn main() { println!("cargo:rustc-env=BUILD_SHA=${rev}"); }' > crates/bot/build.rs

    # Patch the fonts with src
    # FIXME: is this the right way to patch
    substituteInPlace crates/worker/src/sandbox.rs --replace-fail 'read_dir("fonts")' 'read_dir("${src}/fonts")'
  '';

  cargoBuildFlags = [ "--workspace" ];

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "poise-0.6.1" = "sha256-AZtF5P7E5xzHJcNdc1k61P2Rr8vIt+oun9vFYSr0nSc=";
    };
  };
}
