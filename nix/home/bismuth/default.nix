{audio-lint, lib, ...}: {
  imports = [./fonts.nix];

  home.homeDirectory = lib.mkForce "/Users/leana";

  home.packages = [
    audio-lint
  ];
}
