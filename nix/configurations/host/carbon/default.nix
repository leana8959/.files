{
  imports = [
    ./hardware-configuration.nix # generated

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
    systemd-boot = {
      enable = true;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

  users.users."leana".extraGroups = [
    "wheel" # sudoers
    "video" # light
    "audio" # pipewire
    "docker"
    "vboxusers"
  ];

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
}
