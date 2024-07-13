{ pkgs, lib, ... }:
{
  nix.gc = {
    automatic = true;
    frequency = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isDarwin "daily")
      (lib.mkIf pkgs.stdenv.isLinux "1 day")
    ];
  };
}
