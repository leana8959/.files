{
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

  system.stateVersion = "24.05";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

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
    packages = [ ];
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
