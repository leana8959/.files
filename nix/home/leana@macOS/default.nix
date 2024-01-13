{
  pkgs,
  unstable,
  ...
}: {
  programs.home-manager.enable = true;

  imports = [./dev.nix ./fonts.nix];

  home = {
    username = "leana";
    homeDirectory = "/Users/leana";
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

    # utils
    btop
    tree
    rsync
    tldr

    # music
    cmus
    cmusfm
  ];
}
