{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.extra.lang-servers.enable = lib.mkOption { default = false; };

  config = {
    programs.neovim = {
      package = pkgs.neovim-pin.neovim-unwrapped;
      enable = true;
      defaultEditor = true;
      extraPackages = lib.mkMerge [
        [
          pkgs.lua-language-server
          pkgs.stylua
          pkgs.nodePackages.bash-language-server
          pkgs.shellcheck
          pkgs.shfmt
          pkgs.nil
          pkgs.yaml-language-server
        ]
        (lib.mkIf config.extra.lang-servers.enable [
          pkgs.nodePackages.vim-language-server
          pkgs.nodePackages.pyright
          pkgs.vscode-langservers-extracted # HTML/CSS/JSON/ESLint
          pkgs.marksman
          pkgs.taplo
          pkgs.lemminx
        ])
      ];
    };

    home.file =
      let
        fr_utf-8_spl = builtins.fetchurl {
          url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
          sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
        };
        fr_utf-8_sug = builtins.fetchurl {
          url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.sug";
          sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
        };
      in
      {
        "${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = fr_utf-8_spl;
        "${config.xdg.configHome}/nvim/spell/fr.utf-8.sug".source = fr_utf-8_sug;
      };
  };
}
