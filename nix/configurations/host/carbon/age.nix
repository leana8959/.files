{
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
}
