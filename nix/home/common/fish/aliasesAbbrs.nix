{pkgs}: let
  inherit (pkgs.stdenv) isLinux;

  abbrs = {
    ## Docker
    dc = "docker compose";

    ## Git
    gaa = "git add (git rev-parse --show-toplevel)";
    "ga." = "git add .";
    gc = "git commit";
    gs = "git stash";
    gp = "git pull";
    gP = "git push";
    clone = "clone_to_repos";

    ## Editor
    ts = "tmux_sessionizer";
    ta = "tmux_attach";
    v = "nvim";
    se = "sudoedit";

    ":q" = "exit";

    ## Preferences
    np = "cd ~/.dotfiles/nix && $EDITOR flake.nix && prevd";
    vp = "cd ~/.dotfiles/.config/nvim && $EDITOR init.fnl && prevd";
    xp = "cd ~/.dotfiles/.config/xmonad && $EDITOR xmonad.hs && prevd";

    # Home-Manager / NixOS
    ns = "sudo nixos-rebuild switch --flake ~/.dotfiles/nix#nixie";
    hp = "cd ~/.dotfiles/.config/home-manager && $EDITOR flake.nix && prevd";
    hs = "home-manager switch --flake ~/.dotfiles/nix#macOS";
    nsh = "nix-shell -p";
  };
  abbrsLinux = {
    ss = "sudo systemctl";
  };
  abbrsMacos = {};

  aliases = {
    "rm" = "rm -i"; # idiot protection
    "tree" = "tree -Cph";
    "restow" = "cd ~/.dotfiles/ && stow -D . && stow -S . && prevd";
    "nix-shell" = "nix-shell --run fish";
  };
  aliasesLinux = {
    chmod = "chmod --preserve-root";
    chown = "chown --preserve-root";
  };
  aliasesMacos = {
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
      defaults write com.apple.dock persistent-apps -array-add \'{tile-type="small-spacer-tile";}\'; killall Dock
    '';
  };
in {
  shellAbbrs =
    abbrs
    // (
      if isLinux
      then abbrsLinux
      else abbrsMacos
    );
  shellAliases =
    aliases
    // (
      if isLinux
      then aliasesLinux
      else aliasesMacos
    );
}
