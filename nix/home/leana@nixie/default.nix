{pkgs, ...}: {
  imports = [./dev.nix ./gui ./browser.nix ../common ../common/cmus];

  home.packages = with pkgs; [
    zip
    unzip
    gnutar
  ];
}
