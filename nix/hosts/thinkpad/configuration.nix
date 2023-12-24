{
  nixpkgs,
  nixunstable,
  system,
  lib,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (final: prev: {
        cmus = prev.cmus.overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              (prev.fetchpatch {
                url = "https://github.com/cmus/cmus/commit/4123b54bad3d8874205aad7f1885191c8e93343c.patch";
                hash = "sha256-YKqroibgMZFxWQnbmLIHSHR5sMJduyEv6swnKZQ33Fg=";
              })
            ];
        });
      })
    ];

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "discord"
      ];
  };
  unstable = import nixunstable {inherit system;};
in {
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

  # TODO: break this into modules
  users.users.leana = {
    isNormalUser = true;
    description = "leana";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      # text/editors
      helix
      gnused
      neovim
      ripgrep
      vim
      tmux

      # nix
      nil
      alejandra

      # shell
      fish
      # (python39.withPackages (ps: with ps; [beautifulsoup4 requests]))
      stow

      fd
      fzf
      htop
      starship
      tree
      vivid
      rsync

      # fancy utilities
      figlet
      macchina
      ncdu
      tldr

      # git related
      bat
      delta
      gnupg

      (nerdfonts.override {
        fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];
      })

      asciinema
      cmus
      cmusfm
      hyperfine
      tea
      yt-dlp
      watchexec

      # jdk17
      # rustup
      # nodejs_20

      unstable.typst

      # # NOTE: doesn't work
      # valgrind

      # gdb

      # Window Manager related
      dmenu
      xmobar
      scrot
      xscreensaver
      trayer
      xclip

      # GUI apps
      # discord
    ];
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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
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
      extraPackages = hp:
        with hp; [
          neat-interpolation
        ];
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
