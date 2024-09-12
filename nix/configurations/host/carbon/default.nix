{
  imports = [
    ./hardware-configuration.nix # generated

    ./battery.nix
    ./audio.nix
    ./networking.nix
    ./bluetooth.nix
    ./display.nix
    ./scanner.nix

    ./restic.nix
    ./fs.nix

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

  fileSystems."/boot".options = [
    "uid=0"
    "gid=0"
    "fmask=0077"
    "dmask=0077"
  ];

  # related issues
  # https://unix.stackexchange.com/questions/20483/how-to-find-which-process-is-causing-high-cpu-usage
  # https://unix.stackexchange.com/questions/588018/kworker-thread-kacpid-notify-kacpid-hogging-60-70-of-cpu
  # https://askubuntu.com/questions/1275749/acpi-event-69-made-my-system-unusable
  boot.kernelParams = [
    # Happens after waking up
    "acpi_mask_gpe=0x69" # very high count

    # # This bricks bluetooth ?
    # "acpi_mask_gpe=0x16"
  ];

  nix.settings.trusted-users = [
    "root"
    "leana"
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 90d";
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

    restic_backblaze_pwd.file = ../../secrets/restic_backblaze_pwd.age;
    restic_backblaze_repo.file = ../../secrets/restic_backblaze_repo.age;
    restic_backblaze_env.file = ../../secrets/restic_backblaze_env.age;
  };

  hardware.keyboard.zsa.enable = true;

  services.fwupd.enable = true;
}
