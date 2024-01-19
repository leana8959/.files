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

  imports = [
    ./fish

    ./starship
    ./fzf
    ./git
    ./btop

    ./tmux

    ./neovim
    ./vim
  ];

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    ripgrep.enable = true;
  };

  home.packages = with pkgs; [
    # shell and script dependencies
    figlet
    gnused
    stow
    fd
    vivid
    gcc

    # utils
    tree
    rsync
    tldr
    irssi
  ];
}
