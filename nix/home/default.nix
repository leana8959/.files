{ pkgs, unstable, ... }: {
  imports = [ ./dev.nix ./gui.nix ./browser.nix];

  home = {
    username = "leana";
    homeDirectory = "/home/leana";
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
    htop
    tree
    rsync
    tldr
    unstable.typst

    # music
    cmus
    cmusfm
  ];
}
