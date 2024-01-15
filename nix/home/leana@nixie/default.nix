{pkgs, ...}: {
  imports = [./dev.nix ./gui.nix ./browser.nix ../common];

  home.packages = with pkgs; [
    zip
    unzip
    gnutar
  ];
}
