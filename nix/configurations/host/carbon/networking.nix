{ config, lib, ... }:

{
  networking.networkmanager.enable = lib.mkForce false;

  services.openssh.enable = true;

  fileSystems."/mnt/data" = {
    device = "10.0.0.20:/mnt/mainPool/data";
    fsType = "nfs";
    options = [
      "ro"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=30min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
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
        authProtocols = [ "WPA-EAP" ];
        auth = ''
          pairwise=CCMP
          group=CCMP TKIP
          eap=PEAP
          ca_cert="${./certs/universite_de_rennes.pem}"
          identity="@EDUROAM_ID@"
          altsubject_match="DNS:radius.univ-rennes1.fr;DNS:radius1.univ-rennes1.fr;DNS:radius2.univ-rennes1.fr;DNS:vmradius-psf1.univ-rennes1.fr;DNS:vmradius-psf2.univ-rennes1.fr"
          phase2="auth=MSCHAPV2"
          password="@EDUROAM_PSK_L@&@EDUROAM_PSK_R@"
          anonymous_identity="anonymous@univ-rennes.fr"
        '';
      };
    };
  };

  # systemd.targets.wireguard-wg0.wantedBy = lib.mkForce [ ];
  # networking.wireguard = {
  #   interfaces = {
  #     wg0 = {
  #       ips = [ "10.66.66.50/32" ];
  #       privateKeyFile = config.age.secrets.wireguard_priv.path;
  #       postSetup = ''
  #         ${pkgs.iproute}/bin/ip route replace 10.66.66.1 dev wg0
  #         ${pkgs.iproute}/bin/ip route replace 10.0.0.20 via 10.66.66.1 dev wg0
  #         ${pkgs.iproute}/bin/ip route replace 10.0.0.31 via 10.66.66.1 dev wg0
  #       '';
  #       peers = [
  #         {
  #           publicKey = "amb6icauPN4P/suyNZoPsVVkB5+MiAnhFF6hIeUiNFE=";
  #           presharedKeyFile = config.age.secrets.wireguard_psk.path;
  #           allowedIPs = [
  #             "10.66.66.1/32"
  #             "10.0.0.20/32"
  #             "10.0.0.31/32"
  #           ];
  #           endpoint = "moon.earth2077.fr:660";
  #           persistentKeepalive = 25;
  #         }
  #       ];
  #     };
  #   };
  # };
}
