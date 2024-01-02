{ pkgs, unstable, ... }: {
  programs.home-manager.enable = true;

  imports = [ ./dev.nix ];

  home = {
    username = "leana";
    homeDirectory = "/home/leana";
    stateVersion = "23.11";
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
    gcc

    # utils
    btop
    tree
    rsync
    tldr
  ];

}
