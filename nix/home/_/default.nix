{
  pkgs,
  unstable,
  myPkgs,
  config,
  lib,
  ...
}:
{
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

  home.packages =
    [
      # shell and script dependencies
      pkgs.figlet
      pkgs.gnused
      pkgs.stow
      pkgs.fd
      pkgs.vivid
      pkgs.rsync

      # coreutils
      pkgs.uutils-coreutils-noprefix

      # nix
      unstable.nixfmt-rfc-style

      # utils
      pkgs.tree
      pkgs.tldr
      pkgs.irssi
      pkgs.parallel
      pkgs.findutils # xargs and more
    ]
    ++ lib.lists.optionals config.extraUtils.enable [
      pkgs.jq
      pkgs.hyperfine
      pkgs.watchexec
      pkgs.tea
      pkgs.tokei
      pkgs.gnumake
      pkgs.just
      pkgs.sd
      pkgs.ghostscript
      pkgs.act
      pkgs.forgejo-actions-runner
      pkgs.nurl
      pkgs.onefetch
    ]
    ++ lib.lists.optionals config.universityTools.enable [
      pkgs.rars
      myPkgs.logisim-evolution
      myPkgs.necrolib
      myPkgs.why3
    ];
}
