{
  pkgs,
  unstable,
  myPkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./fish
    ./direnv
    ./atuin

    ./starship
    ./fzf
    ./git
    ./btop

    ./tmux

    ./neovim
    ./vim

    ./cmus
  ];

  programs.home-manager.enable = true;
  home = {
    username = lib.mkDefault "leana";
    homeDirectory = lib.mkDefault "/home/leana";
    stateVersion = "23.11";
  };

  programs = {
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
    ++ lib.lists.optionals config.extraUtils.enable [
      unstable.opam
      unstable.cargo
      jq
      hyperfine
      watchexec
      tea
      tokei
      gnumake
      sd
      ghostscript
      act
      forgejo-actions-runner
    ]
    ++ lib.lists.optionals config.universityTools.enable [
      pkgs.rars
      myPkgs.logisim-evolution
      myPkgs.necrolib
      myPkgs.why3
    ];
}
