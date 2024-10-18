{ config, lib, ... }:

{
  xdg.configFile.btop.source = lib.mkIf config.programs.btop.enable ./btop;
}
