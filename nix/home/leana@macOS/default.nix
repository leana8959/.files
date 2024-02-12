{audio-lint, ...}: {
  imports = [./fonts.nix];

  home.homeDirectory = "/Users/leana";

  home.packages = [
    audio-lint
  ];
}
