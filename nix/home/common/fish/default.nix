{pkgs, ...}: {
  programs = let
    inherit (builtins) readFile foldl' map listToAttrs concatMap;
  in {
    fish = {
      enable = true;
      shellInit = readFile ./shellInit.fish;
      interactiveShellInit = let
        readConfigs = ns:
          foldl' (l: r: l + "\n" + r) ""
          (
            map
            (n: readFile ./conf.d/${n}.fish)
            ns
          );
      in
        readFile ./interactiveShellInit.fish
        + readConfigs [
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
                value = readFile ./functions/${n}.fish;
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
