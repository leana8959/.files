{pkgs, ...}: {
  imports = [./dev.nix ./gui ./browser.nix];

  home.packages = with pkgs; [
    zip
    unzip
    gnutar
  ];
}
