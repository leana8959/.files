{pkgs, ...}: {
  imports = [../common];

  home = {
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
  };
  home.packages = with pkgs; [
    nodePackages.bash-language-server # Bash
    nodePackages.vim-language-server # Vim Script
    lua-language-server # Lua

    nil
    alejandra
  ];
}
