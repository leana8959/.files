{ pkgs, hostname, ... }:
let
  abbrs = {
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

    ## Preferences
    np = "cd ~/.dotfiles/nix && $EDITOR flake.nix && prevd";
    vp = "cd ~/.dotfiles/.config/nvim && $EDITOR init.lua && prevd";
    xp = "cd ~/.dotfiles/.config/xmonad && $EDITOR xmonad.hs && prevd";
  };
  abbrsLinux = {
    ss = "sudo systemctl";
    se = "SUDO_EDITOR=(which nvim) sudoedit";
    ns = "sudo nixos-rebuild switch -L --flake ~/.dotfiles/nix#${hostname}";
    hs = "home-manager switch -L --flake ~/.dotfiles/nix#${hostname}";
  };
  abbrsDarwin = {
    ns = "darwin-rebuild switch -L --flake ~/.dotfiles/nix#${hostname} --option sandbox false";
    nd = "nix develop -L --option sandbox false -c true"; # run the develop once without sandbox
  };

  aliases = {
    rm = "rm -i"; # idiot protection
    tree = "tree -Cph";
    restow = "cd ~/.dotfiles/ && stow -D . && stow -S . && prevd";
    nix-shell = "nix-shell --run fish";
    # idea taken from https://github.com/nix-community/comma
    "," = "nix-shell -p";
    ",," = "nix run";
  };
  aliasesLinux = {
    chmod = "chmod --preserve-root";
    chown = "chown --preserve-root";
  };
  aliasesDarwin = {
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
  };
in
{
  programs.fish =
    let
      inherit (pkgs.stdenv) isLinux;
    in
    {
      shellAbbrs = abbrs // (if isLinux then abbrsLinux else abbrsDarwin);
      shellAliases = aliases // (if isLinux then aliasesLinux else aliasesDarwin);
    };
}
