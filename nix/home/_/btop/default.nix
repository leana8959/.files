{ config, lib, ... }:
{
  programs.btop.enable = true;

  # Link manually to get the theme along with the config
  home.file.btop = lib.mkIf config.programs.btop.enable {
    recursive = true;
    source = ./btop;
    target = ".config/btop";
  };
}
