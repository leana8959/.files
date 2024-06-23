{ pkgs, hostname, ... }:
{
  system.stateVersion = 4;
  services.nix-daemon.enable = true;

  networking.hostName = hostname;
  environment.shells = [ pkgs.fish ];

  nix.settings.trusted-users = [ "leana" ];

  nix.gc = {
    automatic = true;
    interval.Weekday = 0;
    options = "--delete-older-than 15d";
  };

  nix.optimise = {
    automatic = true;
    interval.Weekday = 0;
  };

  # https://github.com/nix-community/home-manager/issues/4026
  users.users."leana".home = "/Users/leana";
}
