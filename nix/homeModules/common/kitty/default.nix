{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.kitty = lib.mkIf config.programs.kitty.enable {
    font = {
      name = "AltiosevkaNFM";
      size = 14;
    };
    settings = {
      foreground = "#000000";
      background = "#ffffff";
      confirm_os_window_close = 0;
      text_composition_strategy = "1.7 0";
      shell = ''${pkgs.fish}/bin/fish --command="tmux_home" --login'';
    };
    extraConfig = ''
      background #f8f8f8
      foreground #2a2b33
      cursor #bbbbbb
      selection_background #ececec
      color0 #000000
      color8 #000000
      color1 #ca1243
      color9 #ca1243
      color2 #50a14f
      color10 #50a14f
      color3 #e5bf6d
      color11 #e5bf6d
      color4 #4078f2
      color12 #4078f2
      color5 #950095
      color13 #a00095
      color6 #0184bc
      color14 #0184bc
      color7 #bbbbbb
      color15 #ffffff
      selection_foreground #f8f8f8
    '';
    shellIntegration.enableFishIntegration = true;
  };
}
