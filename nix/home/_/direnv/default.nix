{ pkgs, ... }:
let
  inherit (pkgs) unstable;
in
{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      package = unstable.nix-direnv;
    };
    config = builtins.fromTOML ''
      [global]
      strict_env = true
    '';
  };
}
