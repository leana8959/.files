{audio-lint, ...}: {
  imports = [./dev.nix ./fonts.nix ../common ../common/cmus];
  home.homeDirectory = "/Users/leana";

  home.packages = [
    audio-lint
  ];
}
