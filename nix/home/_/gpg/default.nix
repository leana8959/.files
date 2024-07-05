{ pkgs, lib, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    defaultCacheTtl = 1209600;

    pinentryPackage = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux pkgs.pinentry-tty)
      (lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac)
    ];
  };
}
