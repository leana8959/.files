{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (pkgs) unstable myPkgs;
in
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

  home.packages = lib.mkMerge [
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

    (lib.mkIf config.extraUtils.enable [
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
    ])

    (lib.mkIf config.universityTools.enable [
      pkgs.rars
      myPkgs.logisim-evolution
      myPkgs.necrolib
      myPkgs.why3
    ])
  ];
}
