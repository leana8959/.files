{pkgs, ...}: {
  imports = [./dev.nix ./gui ./browser.nix ../common];

  home.packages = with pkgs; [
    zip
    unzip
    gnutar
  ];
}
