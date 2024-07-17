{ config, lib, ... }:
{
  programs.btop.enable = true;

  # Link manually to get the theme along with the config
  xdg.configFile.btop = lib.mkIf config.programs.btop.enable {
    recursive = true;
    source = ./btop;
  };
}
