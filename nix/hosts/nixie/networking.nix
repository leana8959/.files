{
  config,
  hostname,
  lib,
  ...
}: {
  networking.hostName = hostname;

  networking.networkmanager.enable = lib.mkForce false;

  services.openssh.enable = true;

  fileSystems = let
    opts = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  in {
    "/mnt/data" = {
      device = "10.0.0.20:/mnt/mainPool/data";
      fsType = "nfs";
      options = opts;
    };
    "/mnt/archive" = {
      device = "10.0.0.20:/mnt/mainPool/data/Archive";
      fsType = "nfs";
      options = opts;
    };
    "/mnt/documents" = {
      device = "10.0.0.20:/mnt/mainPool/data/Documents";
      fsType = "nfs";
      options = opts;
    };
  };

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    environmentFile = config.age.secrets.wpa_password.path;
    # To add networks: https://nixos.wiki/wiki/Wpa_supplicant
    networks = {
      "HiddenParadize@Earth2077".psk = "@HOME@";
      "iPhone de Léana 江".psk = "@PHONE@";
      eduroam = {
        auth = ''
          key_mgmt=WPA-EAP
          eap=PWD
          identity="@EDUROAM_ID@"
          password="@EDUROAM_PSK@"
        '';
      };
    };
  };

  systemd.targets.wireguard-wg0.wantedBy = lib.mkForce [];
  networking.wireguard = {
    interfaces = {
      wg0 = {
        ips = ["10.66.66.50/32"];
        privateKeyFile = config.age.secrets.wireguard_priv.path;
        peers = [
          {
            publicKey = "amb6icauPN4P/suyNZoPsVVkB5+MiAnhFF6hIeUiNFE=";
            presharedKeyFile = config.age.secrets.wireguard_psk.path;
            allowedIPs = ["10.0.0.20/32" "10.0.0.31/32"];
            endpoint = "earth2077.fr:660";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
