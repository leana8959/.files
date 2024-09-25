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
    "golang"
    "sioyek"
    "feh"
  ];

  eachModule = lib.attrsets.genAttrs (moduleNames ++ extraModuleNames) toModule;

  allModules.imports = map toModule moduleNames;
in

{
  flake.homeModules = eachModule // {
    _ = allModules;
  };
}
