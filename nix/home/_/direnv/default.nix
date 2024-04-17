{ config, unstable, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      package = unstable.nix-direnv;
    };
    config =
      let
        home = config.home.homeDirectory;
      in
      builtins.fromTOML ''
        [global]
        strict_env = true
        [whitelist]
        prefix = [ "${home}/repos", "${home}/univ-repos", "${home}/playground" ]
      '';
  };
}
