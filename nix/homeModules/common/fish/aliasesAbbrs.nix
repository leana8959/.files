{
  pkgs,
  hostname,
  lib,
  ...
}:
{
  programs.fish = {
    shellAbbrs = lib.mkMerge [
      {
        ## Docker
        dc = "docker compose";

        ## Git
        gaa = "git add (git rev-parse --show-toplevel)";
        "ga." = "git add .";
        gp = "git pull";
        gP = "git push";
        clone = "clone_to_repos";

        ## Editor
        ts = "tmux_sessionizer";
        v = "nvim";

        ":q" = "exit";

        nhist = "sudo nix profile history --profile /nix/var/nix/profiles/system";
        hhist = "nix profile history --profile ~/.local/state/nix/profiles/home-manager";

        nwipe = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d";
        hwipe = "nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager --older-than 7d";
      }

      # TODO: move this out
      (lib.mkIf pkgs.stdenv.isLinux {
        ss = "sudo systemctl";
        se = "SUDO_EDITOR=(which nvim) sudoedit";
        ns = "sudo nixos-rebuild switch --flake ~/.dotfiles#${hostname}";
        hs = "home-manager switch --flake ~/.dotfiles#${hostname}";
      })

      (lib.mkIf pkgs.stdenv.isDarwin {
        ns = "darwin-rebuild switch -L --flake ~/.dotfiles#${hostname} --option sandbox false";
        ndd = "nix develop -L --option sandbox false -c true"; # run the develop once without sandbox when needed
      })
    ];

    shellAliases = lib.mkMerge [
      {
        rm = "rm -I"; # idiot protection
        tree = "tree -Cph";
        restow = "cd ~/.dotfiles/ && stow -D . && stow -S . && prevd";
        nix-shell = "nix-shell --run fish";
        ",," = "nix shell -c";
      }

      (lib.mkIf pkgs.stdenv.isLinux {
        # idiot protection
        chmod = "chmod --preserve-root";
        chown = "chown --preserve-root";
      })

      (lib.mkIf pkgs.stdenv.isDarwin (
        let
          cmds = builtins.concatStringsSep ";";
        in
        {
          reset_launchpad = cmds [
            "defaults write com.apple.dock ResetLaunchPad -bool true"
            "killall Dock"
          ];
          add_spacer_tile = cmds [
            "defaults write com.apple.dock persistent-apps -array-add '{tile-type=\"small-spacer-tile\";}"
            "killall Dock"
          ];
        }
      ))
    ];
  };
}
