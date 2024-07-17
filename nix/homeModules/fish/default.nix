{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./aliasesAbbrs.nix ];

  programs.fish =
    let
      readConfig = n: builtins.readFile ./conf.d/${n}.fish;
      readConfigs = ns: builtins.concatStringsSep "\n" (map readConfig ns);
    in
    {
      enable = true;

      # We need to handle path idempotently, because fish in home-manager is
      # unable to depend on nixos/nix-darwin configurations to figure out the profile.d/nix.sh
      # to source.
      shellInit = ''
        ${readConfig "shellInit"}

        # Handle path
        fish_add_path --prepend --move /nix/var/nix/profiles/default/bin
        fish_add_path --prepend --move ${config.home.homeDirectory}/.local/.local/bin
        fish_add_path --prepend --move ${config.home.homeDirectory}/.dotfiles/.local/bin
        fish_add_path --prepend --move ${config.home.homeDirectory}/.nix-profile/bin
        fish_add_path --prepend --move /run/current-system/sw/bin
        fish_add_path --prepend --move /etc/profiles/per-user/${config.home.username}/bin # prioritize user path

        # Make sure wrapper comes first
        # https://discourse.nixos.org/t/sudo-run-current-system-sw-bin-sudo-must-be-owned-by-uid-0-and-have-the-setuid-bit-set-and-cannot-chdir-var-cron-bailing-out-var-cron-permission-denied/20463/2
        fish_add_path --prepend --move /run/wrappers/bin

        ${lib.strings.optionalString pkgs.stdenv.isDarwin ''
          # Add brew, but as fallback
          # Don't move it at all
          fish_add_path --path --append /opt/homebrew/bin; :
        ''}
      '';

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
