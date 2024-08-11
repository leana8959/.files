{ lib, ... }:

let
  toModule = name: ./${name};

  moduleNames = [
    "user-nixconf"
    "packages"

    "fish"
    "direnv"
    "atuin"
    "kitty"
    "starship"
    "fzf"
    "btop"
    "joshuto"

    "tmux"
    "git"
    "neovim"
    "vim"

    "password-store"
    "gpg"

    "cmus"
  ];
  extraModuleNames = [
    "auto-gc"
    "fcitx5"
  ];

  eachModule = lib.attrsets.genAttrs (moduleNames ++ extraModuleNames) toModule;

  allModules.imports = map toModule moduleNames;
in

{
  flake.homeModules = eachModule // {
    _ = allModules;
  };
}
