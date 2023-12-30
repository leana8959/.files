{ config, hostname, pkgs, lib, ... }: {
  networking.hostName = hostname;

  networking.networkmanager.enable = lib.mkForce false;

  services.openssh.enable = true;

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/data" = {
    device = "//10.0.0.20/data";
    fsType = "cifs";
    options = let
      prevent_hanging =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      auth = "credentials=${config.age.secrets.truenas_smb.path}";
      uid = "uid=${toString config.users.users.leana.uid}";
    in [ "${prevent_hanging},${auth},${uid}" ];
  };

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    environmentFile = config.age.secrets.wpa_password.path;
    # To add networks: https://nixos.wiki/wiki/Wpa_supplicant
    networks = { "HiddenParadize@Earth2077".psk = "@HOME@"; };
  };

  # # FIXME: doesn't work
  # #
  # # We need to rewire default gateway, but this is stupid for a laptop setup
  # # https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
  # networking.firewall = { allowedUDPPorts = [ 660 ]; };
  # networking.wireguard.interfaces = {
  #   wg0 = {
  #     ips = [ "10.66.66.50/32" ];
  #     # listenPort = 660;
  #     privateKeyFile = config.age.secrets.wireguard_priv.path;
  #     peers = [{
  #       publicKey = "amb6icauPN4P/suyNZoPsVVkB5+MiAnhFF6hIeUiNFE=";
  #       presharedKeyFile = config.age.secrets.wireguard_psk.path;
  #       allowedIPs = [
  #         "10.0.0.0/23"
  #         # "0.0.0.0/24"
  #       ];
  #       endpoint = "earth2077.fr:660";
  #       persistentKeepalive = 25;
  #     }];
  #   };
  # };

}
