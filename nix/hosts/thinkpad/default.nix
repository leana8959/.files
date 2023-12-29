{ pkgs, ... }: {
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix

    ./battery.nix
    ./gui.nix
    ./locale.nix
    ./networking.nix
    ./bluetooth.nix
    ./packages.nix
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
    extraGroups = [ "wheel" "video" "audio" ];
    packages = [ ];
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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
