{
  pkgs,
  unstable,
  mypkgs,
  settings,
  ...
}: let
  inherit (settings) extraUtils enableCmus universityTools;
  inherit (pkgs) lib;
in {
  programs.home-manager.enable = true;
  home = {
    username = lib.mkDefault "leana";
    homeDirectory = lib.mkDefault "/home/leana";
    stateVersion = "23.11";
  };

  imports =
    [
      ./fish
      ./direnv

      ./starship
      ./fzf
      ./git
      ./btop

      ./tmux

      ./neovim
      ./vim
    ]
    ++ lib.lists.optional enableCmus ./cmus;

  programs = {
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
      # coreutils
      uutils-coreutils-noprefix
      parallel

      # nix
      alejandra

      # utils
      tree
      tldr
      irssi
    ]
    ++ lib.lists.optionals extraUtils
    [
      unstable.opam
      unstable.cargo
      hyperfine
      watchexec
      tea
      tokei
      gnumake
    ]
    ++ lib.lists.optionals universityTools [
      mypkgs.logisim-evolution
      mypkgs.necrolib
      pkgs.rars
    ];
}
