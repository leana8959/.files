{
  config,
  hostname,
  pkgs,
  ...
}: {
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  age.identityPaths = ["/home/leana/.ssh/id_ed25519"];
  age.secrets.truenas_smb = {
    file = ../../secrets/truenas_smb.age;
  };
  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/mnt/data" = {
    device = "//10.0.0.20/data";
    fsType = "cifs";
    options = let
      prevent_hanging = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      auth = "credentials=${config.age.secrets.truenas_smb.path}";
      uid = "uid=${toString config.users.users.leana.uid}";
    in ["${prevent_hanging},${auth},${uid}"];
  };
}
