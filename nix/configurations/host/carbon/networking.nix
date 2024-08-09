{ config, lib, ... }:

{
  networking.networkmanager.enable = lib.mkForce false;

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
}
