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
        grg = "git remote get-url";
        gra = "git remote add";
        gc = "git commit";
        gca = "git commit --amend";
        gs = "git stash --all";
        gp = "git pull";
        gP = "git push";
        gb = "git blame -C -C -C";
        clone = "clone_to_repos";

        ## Editor
        ts = "tmux_sessionizer";
        ta = "tmux_attach";
        v = "nvim";

        ":q" = "exit";

        # nd = "nix develop -L -c fish";

        nhist = "sudo nix profile history --profile /nix/var/nix/profiles/system";
        hhist = "nix profile history --profile ~/.local/state/nix/profiles/home-manager";

        nwipe = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d";
        hwipe = "nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager --older-than 7d";
      }

      # TODO: move this out
      (lib.mkIf pkgs.stdenv.isLinux {
        ss = "sudo systemctl";
        se = "SUDO_EDITOR=(which nvim) sudoedit";
        ns = "sudo nixos-rebuild switch -L --flake ~/.dotfiles#${hostname}";
        hs = "home-manager switch -L --flake ~/.dotfiles#${hostname}";
      })

      (lib.mkIf pkgs.stdenv.isDarwin {
        ns = "darwin-rebuild switch -L --flake ~/.dotfiles#${hostname} --option sandbox false";
        ndd = "nix develop -L --option sandbox false -c true"; # run the develop once without sandbox when needed
      })
    ];

    shellAliases = lib.mkMerge [
      {
        rm = "rm -i"; # idiot protection
        tree = "tree -Cph";
        restow = "cd ~/.dotfiles/ && stow -D . && stow -S . && prevd";
        nix-shell = "nix-shell --run fish";
        ",," = "nix shell -c";
      }

      (lib.mkIf pkgs.stdenv.isLinux {
        chmod = "chmod --preserve-root";
        chown = "chown --preserve-root";
      })

      (lib.mkIf pkgs.stdenv.isDarwin {
        hide_desktop = ''
          defaults write com.apple.finder CreateDesktop false; killall Finder
        '';
        show_desktop = ''
          defaults write com.apple.finder CreateDesktop true; killall Finder
        '';
        reset_launchpad = ''
          defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
        '';
        add_spacer_tile = ''
          defaults write com.apple.dock persistent-apps -array-add '{tile-type="small-spacer-tile";}'; killall Dock
        '';
      })
    ];
  };
}
