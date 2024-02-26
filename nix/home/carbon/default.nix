{pkgs, ...}: {
  imports = [./gui ./browser.nix];

  home.packages = with pkgs; [
    zip
    unzip
    gnutar
  ];
}
