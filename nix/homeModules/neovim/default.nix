{
  config,
  pkgs,
  lib,
  ...
}:

let
  neovim-pin = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "6132b0f6e344ce2fe34fc051b72fb46e34f668e0";
    hash = "sha256-7R2ZvOnvd9h8fDd65p0JnB7wXfUvreox3xFdYWd1BnY=";
  }) { inherit (pkgs) system; };
in

{
  options.programs.neovim.extraLangServers = {
    enable = lib.mkEnableOption "extra language servers";
    packages = lib.mkOption { type = with lib.types; listOf package; };
  };

  config = {
    programs.neovim = {
      enable = true;
      package = neovim-pin.neovim-unwrapped;
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
        (lib.mkIf config.programs.neovim.extraLangServers.enable config.programs.neovim.extraLangServers.packages)
      ];

      extraLangServers.packages = [
        pkgs.nodePackages.vim-language-server
        pkgs.nodePackages.pyright
        pkgs.vscode-langservers-extracted # HTML/CSS/JSON/ESLint
        pkgs.marksman
        pkgs.taplo
        pkgs.lemminx
        pkgs.texlab
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
