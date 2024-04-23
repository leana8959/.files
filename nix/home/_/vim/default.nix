{ pkgs, ... }:
{
  programs.vim =
    let
      inherit (builtins) readFile;
    in
    {
      enable = true;
      extraConfig = readFile ./vimrc;
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
        ];
    };
}
