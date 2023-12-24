{
  config,
  pkgs,
  ...
}: {
  # TODO: maybe break these into files
  imports = [
    ./hardware-configuration.nix
  ];

  ##############
  # bootloader #
  ##############
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##############
  # Networking #
  ##############
  networking.hostName = "nixie";
  networking.networkmanager.enable = true;

  ##########
  # Locale #
  ##########
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  ###################
  # Keyboard layout #
  ###################
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
  };
  console.keyMap = "dvorak";

  users.users.leana = {
    isNormalUser = true;
    description = "leana";
    extraGroups = ["networkmanager" "wheel"];
    packages = [];
  };

  #########################
  # System level packages #
  #########################
  environment.systemPackages = with pkgs; [
    curl
    vim
    stow
    git
    gcc
  ];
  programs = {
    gnome-terminal.enable = true;
    firefox.enable = true;
  };

  ##########
  # Flakes #
  ##########
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  ##################
  # Window Manager #
  ##################
  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    displayManager.gdm.enable = true;
  };
  programs.nm-applet.enable = true;

  #################
  # Default Shell #
  #################
  environment.shells = [pkgs.fish];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  services.openssh.enable = true;
  system.stateVersion = "23.11";
}
