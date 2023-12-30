{ pkgs, ... }: {
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix

    ./age.nix
    ./battery.nix
    ./gui.nix
    ./locale.nix
    ./audio.nix
    ./networking.nix
    ./bluetooth.nix
    ./packages.nix
    ./virt.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs.fish.enable = true;
  security.sudo.extraConfig = "Defaults lecture = always";
  users.users.leana = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    description = "leana";
    extraGroups = [ "wheel" "video" "audio" "docker" ];
    packages = [ ];
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 45d";
    };
    settings = {
      auto-optimise-store = true;
      substituters = [ "https://nix-community.cachix.org" ];
    };
  };
}
