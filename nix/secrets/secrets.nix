let
  leana = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSXmaAIzatHJL3L0GNK2LU8mmf/gPAhQVZBurNgCx72 leana@nixie";
  users = [leana];
in {
  "wpa_password.age".publicKeys = users;

  "sshconfig.age".publicKeys = users;

  "wireguard_priv.age".publicKeys = users;
  "wireguard_psk.age".publicKeys = users;
}
