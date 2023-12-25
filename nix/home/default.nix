{
  pkgs,
  unstable,
  wired,
  ...
}: {
  home.username = "leana";
  home.homeDirectory = "/home/leana";

  home.stateVersion = "23.11";

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
    # (python39.withPackages (ps: with ps; [beautifulsoup4 requests]))
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

    wired.wired
  ];

  # gtk = {
  #   enable = true;
  #   cursorTheme.package = pkgs.google-cursor;
  #   cursorTheme.name = "GoogleDot-Red";
  # };

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
