{audio-lint, ...}: {
  imports = [./dev.nix ./fonts.nix ../common];
  home.homeDirectory = "/Users/leana";

  home.packages = [
    audio-lint
  ];
}
