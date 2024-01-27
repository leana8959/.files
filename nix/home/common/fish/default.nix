{pkgs, ...}: {
  programs.fish = let
    inherit (builtins) readFile foldl' map listToAttrs concatMap;
    inherit (pkgs) callPackage;
    readConfig = n: readFile ./conf.d/${n}.fish;
    readConfigs = ns:
      foldl' (l: r: l + "\n" + r) ""
      (map readConfig ns);
  in {
    enable = true;

    shellInit = readConfig "shellInit";

    interactiveShellInit =
      readConfigs ["interactiveShellInit" "bind" "colorscheme" "locale"];

    shellAliases = (callPackage ./aliasesAbbrs.nix {}).shellAliases;
    shellAbbrs = (callPackage ./aliasesAbbrs.nix {}).shellAbbrs;

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
}
