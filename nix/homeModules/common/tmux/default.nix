{ pkgs, ... }:

{
  programs.tmux.extraConfig =
    ''
      set -g default-command "${pkgs.fish}/bin/fish" # Use fish
      set -g default-shell "${pkgs.fish}/bin/fish"
    ''
    + builtins.readFile ./tmux.conf;
}
