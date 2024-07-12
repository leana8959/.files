{ lib, ... }:

let
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

  eachModule = lib.attrsets.genAttrs moduleNames (name: ./${name});

  allModules = {
    imports = map (name: ./${name}) moduleNames;
  };
in

{
  flake.homeModules = eachModule // {
    _ = allModules;
  };
}
