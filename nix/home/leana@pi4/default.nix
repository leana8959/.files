{pkgs, ...}: {
  imports = [../common];

  home.packages = with pkgs; [
    nodePackages.bash-language-server # Bash
    nodePackages.vim-language-server # Vim Script
    lua-language-server # Lua

    nil
    alejandra
  ];
}
