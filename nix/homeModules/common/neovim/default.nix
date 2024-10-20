{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.programs.neovim.extraLangServers = {
    enable = lib.mkEnableOption "miscellaneous language servers";
  };

  config = {
    programs.neovim = {
      package = pkgs.neovim-pin.neovim-unwrapped;
      defaultEditor = true;
      extraPackages = lib.mkMerge [

        # might be useful for servers
        [
          # shell
          pkgs.nodePackages.bash-language-server
          pkgs.shellcheck
          pkgs.shfmt
        ]

        (lib.mkIf config.programs.neovim.extraLangServers.enable [
          # lua
          pkgs.lua-language-server
          pkgs.stylua

          pkgs.nil # nix
          pkgs.yaml-language-server # yaml

          pkgs.nodePackages.pyright # python

          pkgs.marksman # markdown
          pkgs.taplo # toml
          pkgs.lemminx # xml
          # pkgs.texlab # latex
        ])

      ];
    };

    xdg.configFile =
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
      lib.mkIf config.programs.neovim.enable {
        "nvim/spell/fr.utf-8.spl".source = fr_utf-8_spl;
        "nvim/spell/fr.utf-8.sug".source = fr_utf-8_sug;
      };
  };
}
