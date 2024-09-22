{
  symlinkJoin,
  makeWrapper,
  why3,
  cvc4,
  z3_4_12,
  alt-ergo,
}:

let
  provers = [
    alt-ergo
    cvc4
    z3_4_12
  ];
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
