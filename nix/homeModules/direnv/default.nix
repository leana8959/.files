{ config, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config =
      let
        home = config.home.homeDirectory;
      in
      builtins.fromTOML ''
        [whitelist]
        prefix = [ "${home}/.dotfiles" ]
        [global]
        strict_env = true
      '';
  };
}
