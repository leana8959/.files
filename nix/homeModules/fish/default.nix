{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./aliasesAbbrs.nix ];

  options.programs.fish.sourcePaths = lib.mkOption {
    type = with lib.types; nonEmptyListOf str;
    description = ''
      Paths to be sourced idempotently at the start of a login-shell.
    '';
    default =
      [
        # Make sure wrapper comes first
        # https://discourse.nixos.org/t/sudo-run-current-system-sw-bin-sudo-must-be-owned-by-uid-0-and-have-the-setuid-bit-set-and-cannot-chdir-var-cron-bailing-out-var-cron-permission-denied/20463/2
        "/run/wrappers/bin"

        "${config.home.homeDirectory}/.nix-profile/bin"
        "/nix/profile/bin"
        "${config.home.homeDirectory}/.local/state/nix/profile/bin"

        "/etc/profiles/per-user/${config.home.username}/bin"

        "/nix/var/nix/profiles/default/bin"
        "/run/current-system/sw/bin"
      ]
      # Add brew, but as fallback
      ++ (lib.lists.optional pkgs.stdenv.isDarwin "/opt/homebrew/bin");
  };

  config.programs.fish =
    let
      readConfig = n: builtins.readFile ./conf.d/${n}.fish;
      readConfigs = ns: builtins.concatStringsSep "\n" (map readConfig ns);
    in
    {
      enable = true;

      # We need to handle path idempotently, because fish in home-manager is
      # unable to depend on nixos/nix-darwin configurations to figure out the profile.d/nix.sh
      # to source.
      #
      # The hack is to make terminal emulators  run fish as a login shell
      # whenever fish should handle the path.
      # tmux should NOT call fish as a login shell, because it would inherit the
      # environment variables from its parent shell, which is a login shell.
      loginShellInit = ''
        begin
            set ps ${builtins.concatStringsSep " " config.programs.fish.sourcePaths}

            set -e fish_user_paths
            for p in $ps
                test -d $p && set --append fish_user_paths $p
            end
        end
      '';

      shellInit = readConfig "shellInit";

      interactiveShellInit = readConfigs [
        "interactiveShellInit"
        "bind"
        "colorscheme"
        "locale"
      ];

      functions =
        let
          makeFishFunctions =
            ns:
            lib.trivial.pipe ns [
              (map (n: {
                name = n;
                value = builtins.readFile ./functions/${n}.fish;
              }))
              builtins.listToAttrs
            ];
        in
        makeFishFunctions [
          ","
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
            rev = "v10.3";
            hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
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
            sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
            rev = "1.1.0";
          };
        }
      ];
    };
}
