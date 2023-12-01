{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "leana";
  home.homeDirectory = if (isDarwin) then "/Users/leana" else "/home/leana";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; ([

    # text/editors
    helix
    gnused
    neovim
    vim
    tmux

    # shell
    bash
    fish
    tmux
    stow

    # fancy utilities
    fd
    figlet
    fzf
    htop
    iperf
    macchina # screenfetch
    ncdu
    parallel
    ripgrep
    rsync
    starship
    tldr
    tree
    vivid # LS_COLORS generator
    watchexec

    # git related
    bat
    delta
    git-filter-repo
    gnupg
    pwgen # password generator

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  ] ++ lib.optionals (isDarwin) [

    asciinema # record videos
    cmus      # music player
    cmusfm    # cmus with last.fm support
    gh        # github's CLI tool
    hyperfine # benchmark tool
    jq        # json parser
    tea       # gitea's CLI tool

    # C
    clang_16
    criterion

    # java
    jdk17
    gradle
    jdt-language-server

    # go
    go

    # scala
    ammonite
    sbt
    coursier

    # rust
    rustup

    # npm
    nodejs_20

    # haskell
    stack

    # typst
    typst
  ] ++ lib.optionals (isLinux) [

    # C
    clang_16
    valgrind
    gdb

    traceroute

  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/leana/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}