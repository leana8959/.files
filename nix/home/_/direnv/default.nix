{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
    config = builtins.fromTOML ''
      [global]
      strict_env = true
    '';
  };
}
