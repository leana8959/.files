{ pkgs, lib, ... }:

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = lib.mkIf pkgs.stdenv.isLinux true;
    enableFishIntegration = true;
    defaultCacheTtl = 1209600;
    pinentryPackage = pkgs.pinentry-tty;
  };
}
