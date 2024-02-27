{pkgs, ...}: {
  programs.vim = let
    inherit (builtins) readFile;
  in {
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
    ];
  };
}
