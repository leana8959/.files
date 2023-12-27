{pkgs, ...}: {
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix

    ./battery.nix
    ./gui.nix
    ./locale.nix
    ./networking.nix
    ./packages.nix
  ];

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


  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
