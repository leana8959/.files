{
  pkgs,
  unstable,
  mypkgs,
  lib,
  enableCmus,
  extraUtils,
  universityTools,
  helperFuncs,
  ...
}: let
  inherit (helperFuncs) if';
in {
  home = {
    username = lib.mkDefault "leana";
    homeDirectory = lib.mkDefault "/home/leana";
    stateVersion = "23.11";
  };

  imports =
    [
      ./fish

      ./starship
      ./fzf
      ./git
      ./btop

      ./tmux

      ./neovim
      ./vim
    ]
    ++ if' enableCmus [./cmus];

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    atuin = {
      enable = true;
      settings = {
        style = "full";
        show_preview = true;
      };
    };
    ripgrep.enable = true;
    gpg.enable = true;
  };

  home.packages = with pkgs;
    [
      # shell and script dependencies
      figlet
      gnused
      stow
      fd
      vivid
      gcc
      rsync

      # nix
      alejandra

      # utils
      tree
      tldr
      irssi
    ]
    ++ if' extraUtils
    [
      unstable.opam
      unstable.cargo
      hyperfine
      watchexec
      tea
      tokei
      gnumake
    ]
    ++ if' universityTools [
      mypkgs.logisim-evolution
      mypkgs.necrolib
      pkgs.rars
    ];
}
