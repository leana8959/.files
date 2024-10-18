{ config, ... }:

{
  programs.direnv = {
    nix-direnv.enable = true;
    config = builtins.fromTOML ''
      [whitelist]
      prefix = [ "${config.home.homeDirectory}/.dotfiles" ]
      [global]
      strict_env = true
    '';
  };
}
