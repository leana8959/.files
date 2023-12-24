{
  config,
  pkgs,
  unstable,
  ...
}: {
  home.username = "leana";
  home.homeDirectory = "/home/leana";

  home.stateVersion = "23.11";

  nixpkgs.overlays = [
    (final: prev: {
      cmus = prev.cmus.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (prev.fetchpatch {
              url = "https://github.com/cmus/cmus/commit/4123b54bad3d8874205aad7f1885191c8e93343c.patch";
              hash = "sha256-YKqroibgMZFxWQnbmLIHSHR5sMJduyEv6swnKZQ33Fg=";
            })
          ];
      });
    })
  ];

  home.packages = with pkgs; [
    # text/editors
    helix
    gnused
    neovim
    ripgrep
    vim
    tmux

    # nix
    nil
    alejandra

    # shell
    fish
    (python39.withPackages (ps: with ps; [beautifulsoup4 requests]))
    stow

    fd
    fzf
    htop
    starship
    tree
    vivid
    rsync

    # fancy utilities
    figlet
    macchina
    ncdu
    tldr

    # git related
    bat
    delta
    gnupg

    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];
    })

    asciinema
    cmus
    cmusfm
    hyperfine
    tea
    yt-dlp
    watchexec

    # jdk17
    # rustup
    # nodejs_20

    unstable.typst

    # # NOTE: doesn't work
    # valgrind

    # gdb

    # Window Manager related
    dmenu
    xmobar
    scrot
    xscreensaver
    trayer
    xclip
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
