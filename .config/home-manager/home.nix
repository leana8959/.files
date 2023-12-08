{ config, pkgs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
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
    ripgrep
    vim
    tmux

    # shell
    fish
    (python39.withPackages(ps: with ps; [
      beautifulsoup4
      requests
    ]))
    stow

    fd
    fzf
    htop
    starship
    tree
    vivid

    # fancy utilities
    figlet
    macchina
    ncdu
    tldr

    # git related
    bat
    delta
    gnupg
    pwgen # password generator

  ] ++ lib.optionals (isDarwin) [

    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "JetBrainsMono"
        "Meslo"
      ];
    })

    asciinema
    # # NOTE: Broken, to be fixed
    # cmus
    cmusfm
    hyperfine
    tea
    yt-dlp
    watchexec

    jdk17
    rustup
    nodejs_20

    # # OCaml
    # # NOTE: Doesn't work
    # opam

    # typst
    typst

  ] ++ lib.optionals (isLinux) [

    # # C
    # # NOTE: doesn't work
    # valgrind
    # gdb

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
  programs = {
    home-manager.enable = true;

    direnv = {
      enable            = true;
      nix-direnv.enable = true;
    };

  };

}
