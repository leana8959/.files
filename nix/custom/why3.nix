{
  symlinkJoin,
  makeWrapper,
  why3,
  cvc4,
  z3_4_12,

  fetchFromGitHub,
  system,
}:
let
  provers = [
    alt-ergo
    cvc4
    z3_4_12
  ];

  inherit
    (import
      (fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "1b95daa381fa4a0963217a5d386433c20008208a";
        hash = "sha256-vwEtkxIEQjymeTk89Ty1MGfRVSWL1/3j1wt5xB5ua88=";
      })
      {
        inherit system;
        config.allowUnfree = true;
      }
    )
    alt-ergo
    ;
in
symlinkJoin {
  name = "why3";
  # Generate configuration in the store, and wrap why3 with the corresponding option
  paths = [ (why3.override { version = "1.6.0"; }) ];
  buildInputs = provers;
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    $out/bin/why3 config detect --config=$out/why3.conf
    wrapProgram $out/bin/why3 --add-flags "--config=$out/why3.conf"
  '';
}
