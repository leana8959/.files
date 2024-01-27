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
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "e5d54b93cd3e096ad6c2a419df33c4f50451c900";
          sha256 = "sha256-5cO5Ey7z7KMF3vqQhIbYip5JR6YiS2I9VPRd6BOmeC8=";
        };
      }
      {
        name = "colored-man-pages";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "colored_man_pages.fish";
          rev = "f885c2507128b70d6c41b043070a8f399988bc7a";
          sha256 = "sha256-ii9gdBPlC1/P1N9xJzqomrkyDqIdTg+iCg0mwNVq2EU=";
        };
      }
      {
        name = "sponge";
        src = pkgs.fetchFromGitHub {
          owner = "meaningful-ooo";
          repo = "sponge";
          rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
          sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
        };
      }
    ];
  };
}
