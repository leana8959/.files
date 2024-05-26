{ pkgs, ... }:
{
  programs.vim =
    let
      paramount = pkgs.vimUtils.buildVimPlugin {
        name = "paramount";
        src = pkgs.fetchFromGitHub {
          owner = "owickstrom";
          repo = "vim-colors-paramount";
          rev = "a5601d36fb6932e8d1a6f8b37b179a99b1456798";
          hash = "sha256-j9nMjKYK7bqrGHprYp0ddLEWs1CNMudxXD13sOROVmY=";
        };
      };
    in
    {
      enable = true;
      extraConfig = builtins.readFile ./vimrc;
      plugins =
        let
          vpkgs = pkgs.vimPlugins;
        in
        [
          vpkgs.vim-sleuth
          vpkgs.vim-surround
          vpkgs.vim-fugitive
          vpkgs.vim-commentary
          vpkgs.undotree
          vpkgs.tabular
          vpkgs.vim-wakatime
          vpkgs.vim-caddyfile
          paramount
        ];
    };
}
