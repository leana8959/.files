{ pkgs, ... }:
with builtins;
{
  programs.vim = {
    enable = true;
    extraConfig = readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      vim-sleuth
      vim-surround
      vim-fugitive
      vim-commentary
      undotree
      tabular
      vim-wakatime
      vim-caddyfile
    ];
  };
}
