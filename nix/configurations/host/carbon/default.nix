{
  imports = [
    ./hardware-configuration.nix # generated

    ./battery.nix
    ./audio.nix
    ./networking.nix
    ./bluetooth.nix
    ./display.nix

    ./inputMethod
    ./packages.nix

    ./gui.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

  # related issues
  # https://unix.stackexchange.com/questions/20483/how-to-find-which-process-is-causing-high-cpu-usage
  # https://unix.stackexchange.com/questions/588018/kworker-thread-kacpid-notify-kacpid-hogging-60-70-of-cpu
  # https://askubuntu.com/questions/1275749/acpi-event-69-made-my-system-unusable
  boot.kernelParams = [ "acpi_mask_gpe=0x69" ];

  nix.settings.trusted-users = [
    "root"
    "leana"
  ];

  nix.gc.automatic = false;
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
    };
  };

  age.secrets = {
    sshconfig = {
      file = ../../secrets/sshconfig.age;
      path = "/home/leana/.ssh/config";
      mode = "644";
      owner = "leana";
    };

    wpa_password.file = ../../secrets/wpa_password.age;
    wireguard_priv.file = ../../secrets/wireguard_priv.age;
    wireguard_psk.file = ../../secrets/wireguard_psk.age;
  };

  hardware.keyboard.zsa.enable = true;
}
