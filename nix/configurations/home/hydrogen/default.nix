{ pkgs, ... }:

{
  home.packages = [
    pkgs.just
    pkgs.parallel
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}
