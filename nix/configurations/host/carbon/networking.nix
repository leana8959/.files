{ config, lib, ... }:

{
  networking.networkmanager.enable = lib.mkForce false;

  networking.firewall.allowedTCPPorts = [ 8080 ];

  services.hoogle = {
    enable = true;
    port = 1992;
  };

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    environmentFile = config.age.secrets.wpa_password.path;
    networks =
      let
        ordered =
          nss:
          lib.trivial.pipe nss [
            lib.lists.reverseList
            (lib.lists.imap0 (i: lib.mapAttrs (_: n: n // { priority = i; })))
            lib.mergeAttrsList
          ];
      in
      ordered [
        # first in list is tried first
        {
          "HiddenParadize@Earth2077".psk = "@HOME@";
          "Pei’s Wifi".psk = "@PEI_PASSWORD@";
        }
        {
          "_SNCF_WIFI_INOUI" = { };
          "EurostarTrainsWiFi" = { };
        }
        {
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
              password="@EDUROAM_PSK@"
              anonymous_identity="anonymous@univ-rennes.fr"
            '';
          };
        }
        { "iPhone de Léana 江".psk = "@PHONE@"; }
      ];
  };
}
