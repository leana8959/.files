{
  pkgs,
  lib,
  enableCmus,
  ...
}: {
  home = {
    username = lib.mkDefault "leana";
    homeDirectory = lib.mkDefault "/home/leana";
    stateVersion = "23.11";
  };

  imports =
    [
      ./fish

      ./starship
      ./fzf
      ./git
      ./btop

      ./tmux

      ./neovim
      ./vim
    ]
    ++ (
      if enableCmus
      then [./cmus]
      else []
    );

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    atuin = {
      enable = true;
      settings = {
        style = "full";
        show_preview = true;
      };
    };
    ripgrep.enable = true;
    gpg.enable = true;
  };

  home.packages = with pkgs; [
    # shell and script dependencies
    figlet
    gnused
    stow
    fd
    vivid
    gcc

    # nix
    alejandra

    # utils
    tree
    rsync
    tldr
    irssi
  ];
}
