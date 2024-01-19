{pkgs, ...}: {
  programs = {
    vim = {
      enable = true;
      defaultEditor = true;
      extraConfig = builtins.readFile ./vimrc;
      plugins = with pkgs.vimPlugins;[
        vim-sleuth
        vim-surround
        vim-fugitive
        vim-commentary
        undotree
        tabular
        vim-wakatime
      ];
    };
  };
}
