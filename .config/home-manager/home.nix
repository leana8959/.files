{ config, pkgs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  home.username = "leana";
  home.homeDirectory = if (isDarwin) then "/Users/leana" else "/home/leana";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.overlays = [
    (final: prev: {
      cmus = prev.cmus.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          (prev.fetchpatch {
            url = "https://github.com/cmus/cmus/commit/4123b54bad3d8874205aad7f1885191c8e93343c.patch";
            hash = "sha256-YKqroibgMZFxWQnbmLIHSHR5sMJduyEv6swnKZQ33Fg=";
          })
        ];
      });
    })
  ];

  home.packages = with pkgs; ([

    # text/editors
    helix
    gnused
    neovim
    rnix-lsp
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
    cmus
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

  programs = {
    home-manager.enable = true;

    direnv = {
      enable            = true;
      nix-direnv.enable = true;
    };
  };

}
