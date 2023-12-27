{
  config,
  hostname,
  pkgs,
  lib,
  ...
}: {
  networking.hostName = hostname;
  age = {
    identityPaths = ["/home/leana/.ssh/id_ed25519"];
    secrets.truenas_smb.file = ../../secrets/truenas_smb.age;
    secrets.wpa_password.file = ../../secrets/wpa_password.age;
  };

  networking.networkmanager.enable = lib.mkForce false;

  services.openssh.enable = true;


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

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    environmentFile = config.age.secrets.wpa_password.path;
    networks = {
      "HiddenParadize@Earth2077".psk = "@HOME@";
    };
  };
}
