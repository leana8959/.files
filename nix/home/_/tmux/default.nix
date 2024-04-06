{ pkgs, ... }:
with builtins;
{
  programs.tmux = {
    enable = true;
    extraConfig =
      ''
        set -g default-command "${pkgs.fish}/bin/fish" # Use fish
        set -g default-shell "${pkgs.fish}/bin/fish"
      ''
      + readFile ./tmux.conf;
  };
}
