{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (pkgs) myPkgs stdenv;
in
{
  options.extra = {
    utilities.enable = lib.mkOption { default = false; };
    workflow.enable = lib.mkOption { default = false; };
    university.enable = lib.mkOption { default = false; };
  };

  imports = [
    ./user-nixconf.nix

    ./fish
    ./direnv
    ./atuin
    ./kitty

    ./starship
    ./fzf
    ./git
    ./btop

    ./tmux

    ./neovim
    ./vim

    ./password-store

    ./cmus
  ];

  config = {
    programs.home-manager.enable = true;
    home = {
      username = lib.mkDefault "leana";
      homeDirectory = lib.mkDefault (if stdenv.isLinux then "/home/leana" else "/Users/leana");
      stateVersion = "24.05";
    };

    nix.registry = {
      flakies = {
        from.id = "flakies";
        from.type = "indirect";
        to.type = "git";
        to.url = "https://git.earth2077.fr/leana/flakies";
      };
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

        # nix
        pkgs.nixfmt-rfc-style

        # utils
        pkgs.tree
        pkgs.tldr
        pkgs.parallel
        pkgs.findutils # xargs and more
        pkgs.du-dust
      ]

      (lib.mkIf pkgs.stdenv.isDarwin [
        # coreutils
        pkgs.uutils-coreutils-noprefix
      ])

      (lib.mkIf config.extra.utilities.enable [
        pkgs.jq
        pkgs.hyperfine
        pkgs.watchexec
        pkgs.onefetch
        pkgs.ghostscript
        myPkgs.tokei
        pkgs.gnumake
        pkgs.just
        pkgs.nurl
        pkgs.tea
        pkgs.agenix
      ])

      (lib.mkIf config.extra.workflow.enable [
        pkgs.act
        pkgs.forgejo-actions-runner
      ])

      (lib.mkIf config.extra.university.enable [
        pkgs.rars
        myPkgs.logisim-evolution
        myPkgs.necrolib
        myPkgs.why3
      ])
    ];
  };
}
