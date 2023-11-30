with (import <nixpkgs>{}); mkShell {
  buildInputs = [
    bat
    delta
    du-dust
    fd
    figlet
    fish
    fzf
    neovim
    ripgrep
    starship
    tmux
    tree
    vivid
  ];
}
