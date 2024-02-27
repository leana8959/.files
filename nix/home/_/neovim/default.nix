{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs;
      [
        lua-language-server
        stylua
        nodePackages.bash-language-server
        shellcheck
        nil
      ]
      ++ lib.lists.optionals config.extraLanguageServers.enable [
        nodePackages.vim-language-server
        vscode-langservers-extracted # HTML/CSS/JSON/ESLint
        marksman
        nodePackages.pyright
        taplo
      ];
  };

  home.file = let
    fr_utf-8_spl = builtins.fetchurl {
      url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
      sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
    };
    fr_utf-8_sug = builtins.fetchurl {
      url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.sug";
      sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
    };
  in {
    "${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = fr_utf-8_spl;
    "${config.xdg.configHome}/nvim/spell/fr.utf-8.sug".source = fr_utf-8_sug;
  };
}
