{
  pkgs,
  hostname,
  ...
} @ input: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 4;
  services.nix-daemon.enable = true;

  networking.hostName = hostname;
  environment.shells = [pkgs.fish];

  nix.settings.trusted-users = ["leana"];

  environment.systemPackages = with pkgs; [
    vim
    gnumake
    gnused
    gcc
    cachix
  ];
}
