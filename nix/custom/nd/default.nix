{
  writeShellApplication,

  nix-output-monitor,
  nvd,
}:

writeShellApplication {
  name = "nd";
  runtimeInputs = [
    nix-output-monitor
    nvd
  ];
  text = builtins.readFile ./nd.sh;
}
