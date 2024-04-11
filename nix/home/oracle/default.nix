{ pkgs, ... }:
{
  home = {
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
  };

  home.packages = [
    pkgs.jq
    pkgs.cachix
  ];
}
