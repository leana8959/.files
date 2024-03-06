{
  pkgs,
  config,
  ...
}: {
  imports = [./aliasesAbbrs.nix];

  programs.fish = let
    inherit (builtins) readFile map listToAttrs concatMap;
    readConfig = n: readFile ./conf.d/${n}.fish;
    readConfigs = ns: builtins.concatStringsSep "\n" (map readConfig ns);
  in {
    enable = true;

    shellInit =
      readConfig "shellInit"
      # Just in case $PATH is broken, add them in an idempotent fashion
      # Make sure wrapper comes first
      # https://discourse.nixos.org/t/sudo-run-current-system-sw-bin-sudo-must-be-owned-by-uid-0-and-have-the-setuid-bit-set-and-cannot-chdir-var-cron-bailing-out-var-cron-permission-denied/20463/2
      + ''
        fish_add_path -m /run/wrappers/bin
        fish_add_path -m /run/current-system/sw/bin
        fish_add_path -m /etc/profiles/per-user/${config.home.username}/bin
        fish_add_path -m ${config.home.homeDirectory}/.nix-profile/bin
        fish_add_path -m /nix/var/nix/profiles/default/bin
      '';

    interactiveShellInit =
      readConfigs ["interactiveShellInit" "bind" "colorscheme" "locale"];

    functions = let
      makeFishFunctions = ns:
        listToAttrs (
          concatMap (n: [
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
