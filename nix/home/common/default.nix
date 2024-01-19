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

  # TODO: potentially drop legacy support
  programs = let
    inherit (builtins) readFile foldl' map listToAttrs concatMap;
  in {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = fromTOML (readFile ../../../.config/starship.toml);
    };
    fish = {
      enable = true;
      shellInit = readFile ./fish/shellInit.fish;
      interactiveShellInit = let
        readGlobalFishConfigs = ns:
          foldl' (l: r: l + "\n" + r) ""
          (
            map
            (n: readFile ../../../.config/fish/conf.d/${n}.fish)
            ns
          );
      in
        readFile ./fish/interactiveShellInit.fish
        + readGlobalFishConfigs [
          "alias"
          "bind"
          "colorscheme"
          "locale"
        ];
      functions = let
        makeFishFunctions = ns:
          listToAttrs
          (
            concatMap
            (n: [
              {
                name = n;
                value = {body = readFile ../../../.config/fish/functions/${n}.fish;};
              }
            ])
            ns
          );
      in
        makeFishFunctions [
          "clone_to_repos"
          "file_extension"
          "file_mantissa"
          "fish_command_not_found"
          "fish_greeting"
          "fish_remove_path"
          "install_fisher"
          "largest-objects-in-repo"
          "snakecase"
          "timestamp"
          "tmux_attach"
          "tmux_home"
          "tmux_last"
          "tmux_sessionizer"
          "update_dotfiles"
        ];
      plugins = let
        makeFishPlugins = ns: (concatMap
          (n: [
            {
              name = n;
              src = pkgs.fishPlugins.${n};
            }
          ])
          ns);
      in
        makeFishPlugins [
          "fzf-fish"
          "colored-man-pages"
          "sponge"
        ];
    };
  };

  home.packages = with pkgs; [
    # shell and script dependencies
    figlet
    gnused
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
