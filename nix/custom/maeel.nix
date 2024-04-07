{
  stdenv,
  fetchFromGitHub,
  rustc,
}:
stdenv.mkDerivation {
  pname = "maeel";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "Traumatism";
    repo = "maeel";
    rev = "d8e4261266a181904947ef940b6744a6360c93a6";
    hash = "sha256-Ee4/N2Q90xsbyGVtpE/yUFWC/ELt8nBAICkR/FlZQOo=";
  };

  nativeBuildInputs = [ rustc ];
  installPhase = ''
    mkdir -p "$out/bin"
    cp --reflink=auto ./maeel "$out/bin"
  '';
}
