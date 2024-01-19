{pkgs, ...}: {
  home.file = {
    tmux = {
      target = ".tmux.conf";
      text =
        builtins.readFile ./tmux.conf
        + ''
          set -g default-command "${pkgs.fish}/bin/fish" # Use fish
          set -g default-shell "${pkgs.fish}/bin/fish"
          bind r source-file "~/.dotfiles/nix/home/common/tmux/default.nix" \; display-message "tmux.conf reloaded."
        '';
    };
  };
  home.packages = [pkgs.tmux];
}
