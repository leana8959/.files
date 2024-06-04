{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  libiconv,
  darwin,
  zlib,
}:

rustPlatform.buildRustPackage rec {
  pname = "tokei";
  version = "13.0.0-alpha.1";

  src = fetchFromGitHub {
    owner = "XAMPPRocky";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-oKgTBfwOAP4fJzgN8NBR0KcuVD0caa9Qf3dkCb0zUR8=";
  };

  cargoSha256 = "sha256-NE6hw6rgSDOsmSD6JpOfBLgGKGPfPmHjpMIsqLOkH7M=";

  buildInputs = lib.optionals stdenv.isDarwin [
    libiconv
    darwin.Security
  ];

  checkInputs = lib.optionals stdenv.isDarwin [ zlib ];

  # enable all output formats
  buildFeatures = [ "all" ];
}
