{...}: {
  age = {
    identityPaths = ["/home/leana/.ssh/id_ed25519"];
    secrets.sshconcfig = {
      file = ../../secrets/sshconfig.age;
      path = "/home/leana/.ssh/config";
      mode = "644";
      owner = "leana";
    };
    secrets.truenas_smb.file = ../../secrets/truenas_smb.age;
    secrets.wpa_password.file = ../../secrets/wpa_password.age;
    secrets.wireguard_priv.file = ../../secrets/wireguard_priv.age;
    secrets.wireguard_psk.file = ../../secrets/wireguard_psk.age;
  };
}
