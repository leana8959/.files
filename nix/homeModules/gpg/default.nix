{ pkgs, lib, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = true;
    defaultCacheTtl = 1209600;

    pinentryPackage = pkgs.pinentry-tty;
  };
}
