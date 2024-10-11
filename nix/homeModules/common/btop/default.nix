{ config, lib, ... }:
{
  programs.btop.enable = true;
  xdg.configFile.btop.source = lib.mkIf config.programs.btop.enable ./btop;
}
