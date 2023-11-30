with (import <nixpkgs>{}); mkShell {
  buildInputs = [
    # git related
    bat
    delta

    # shell
    starship
    tree
    vivid

    # text/editors
    helix
    neovim
    tmux

    # utilities
    du-dust
    fd
    figlet
    fish
    fzf
    ripgrep
    tldr
  ];
}
