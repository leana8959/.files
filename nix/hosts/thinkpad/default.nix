{pkgs, ...}: {
  system.stateVersion = "23.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs.fish.enable = true;
  environment.shells = [pkgs.fish];
  users.users.leana = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "leana";
    extraGroups = ["networkmanager" "wheel"];
    packages = [];
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = true;

  imports = [
    ./hardware-configuration.nix

    ./locale.nix
    ./networking.nix
    ./packages.nix
    ./gui.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
