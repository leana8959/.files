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

    ./neovim
  ];

  # TODO: potentially drop legacy support
  programs = let
    inherit (builtins) readFile foldl' map listToAttrs concatMap;
  in {
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

    # utils
    tree
    rsync
    tldr
    irssi

    # Editors
    tmux
    vim
    gcc
  ];
}
