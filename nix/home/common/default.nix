{
  pkgs,
  lib,
  ...
}: {
  home = {
    username = lib.mkDefault "leana";
    homeDirectory = lib.mkDefault "/home/leana";
    stateVersion = "23.11";
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  home.packages = with pkgs; [
    # shell and script dependencies
    fish
    figlet
    gnused
    starship
    stow
    ripgrep
    fd
    fzf
    vivid

    # utils
    btop
    tree
    rsync
    tldr
    irssi

    # Editors
    tmux
    neovim
    vim
    gcc

    # git
    git
    git-lfs
    bat
    delta
  ];
}
