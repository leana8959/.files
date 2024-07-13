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

  extraModuleNames = [ "auto-gc" ];

  eachModule = lib.attrsets.genAttrs (moduleNames ++ extraModuleNames) (name: ./${name});

  allModules = {
    imports = map (name: ./${name}) moduleNames;
  };
in

{
  flake.homeModules = eachModule // {
    _ = allModules;
  };
}
