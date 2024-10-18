{ pkgs, ... }:

{
  services = {
    gpg-agent.enableFishIntegration = true;
    gpg-agent.defaultCacheTtl = 1209600;
    gpg-agent.pinentryPackage = pkgs.pinentry-tty;
  };
}
