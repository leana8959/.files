{pkgs, ...}: {
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

  security.sudo.extraConfig = "Defaults lecture = always";
  users.users.leana = {
    uid = 1000;
    isNormalUser = true;
    description = "leana";
    extraGroups = [
      "wheel" # sudoers
      "video" # light
      "audio" # pipewire
      "docker"
      "vboxusers"
    ];
    packages = [];
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
    optimise = {
      dates = ["weekly"];
      automatic = true;
    };
    settings = {
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
  };
}
