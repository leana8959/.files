{ pkgs, hostname, ... }@input:
{

  imports = [ ./builders.nix ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 4;
  services.nix-daemon.enable = true;

  networking.hostName = hostname;
  environment.shells = [ pkgs.fish ];

  nix.settings.trusted-users = [ "leana" ];

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
    };
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    vim
    gnumake
    gnused
    cachix
  ];
}
