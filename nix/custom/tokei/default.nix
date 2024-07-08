{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libiconv,
  darwin,
  zlib,
}:

let
  rev = "6392516c47d4573d16886b9fe5f79592b1c70d49";
in

rustPlatform.buildRustPackage {
  pname = "tokei";
  version = lib.substring 0 7 rev;

  src = fetchFromGitHub {
    owner = "XAMPPRocky";
    repo = "tokei";
    inherit rev;
    hash = "sha256-EYr4K1Bt+74jb85UQ3So0efrOcYAq71/4++kMCSPi1E=";
  };

  cargoSha256 = "sha256-fdAJwQNJczRqy0KQqse8QRx5+1gZTCBw+kkwgn6UGKU=";

  patches = [
    ./hledger.patch
    ./skel.patch
    ./why3.patch
  ];

  buildInputs = lib.optionals stdenv.isDarwin [
    libiconv
    darwin.Security
  ];

  checkInputs = lib.optionals stdenv.isDarwin [ zlib ];

  # enable all output formats
  buildFeatures = [ "all" ];
}
