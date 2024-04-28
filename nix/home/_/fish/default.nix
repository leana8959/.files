{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ ./aliasesAbbrs.nix ];

  programs.fish =
    let
      readConfig = n: builtins.readFile ./conf.d/${n}.fish;
      readConfigs = ns: builtins.concatStringsSep "\n" (map readConfig ns);

      add_paths =
        ps:
        lib.trivial.pipe ps [
          (lib.lists.reverseList) # source paths in reverse order
          (map (p: "fish_add_path -m ${p}"))
          (builtins.concatStringsSep "\n")
          (s: s + "\n")
        ];
    in
    {
      enable = true;

      shellInit =
        readConfig "shellInit"
        # Just in case $PATH is broken, add them in an idempotent fashion
        + add_paths (
          [
            # Make sure wrapper comes first
            # https://discourse.nixos.org/t/sudo-run-current-system-sw-bin-sudo-must-be-owned-by-uid-0-and-have-the-setuid-bit-set-and-cannot-chdir-var-cron-bailing-out-var-cron-permission-denied/20463/2
            "/run/wrappers/bin"
            "/run/current-system/sw/bin"
            "/etc/profiles/per-user/${config.home.username}/bin"
            "${config.home.homeDirectory}/.nix-profile/bin"
            "${config.home.homeDirectory}/.dotfiles/.local/bin"
            "${config.home.homeDirectory}/.local/.local/bin"
            "/nix/var/nix/profiles/default/bin"
          ]
          ++ lib.lists.optional pkgs.stdenv.isDarwin "/opt/homebrew/bin"
        );

      interactiveShellInit =
        readConfigs [
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
              (map (
                n: {
                  name = n;
                  value = builtins.readFile ./functions/${n}.fish;
                }
              ))
              builtins.listToAttrs
            ];
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
            sha256 = "sha256-5cO5Ey7z7KMF3vqQhIbYip5JR6YiS2I9VPRd6BOmeC8=";
            rev = "v10.2";
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
