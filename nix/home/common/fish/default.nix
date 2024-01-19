{pkgs, ...}: {
  programs = let
    inherit (builtins) readFile foldl' map listToAttrs concatMap;
  in {
    fish = {
      enable = true;
      shellInit = readFile ./shellInit.fish;
      interactiveShellInit = let
        readGlobalFishConfigs = ns:
          foldl' (l: r: l + "\n" + r) ""
          (
            map
            (n: readFile ../../../../.config/fish/conf.d/${n}.fish)
            ns
          );
      in
        readFile ./interactiveShellInit.fish
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
                value = {body = readFile ../../../../.config/fish/functions/${n}.fish;};
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
}
