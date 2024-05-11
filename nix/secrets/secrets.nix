let
  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSXmaAIzatHJL3L0GNK2LU8mmf/gPAhQVZBurNgCx72";
  bismuth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBt+MINzxBF8uyFIuz/UvMZe9Ml+qxU0hxxi7UAmUzpc";

  all = [
    bismuth
    carbon
  ];
in
{
  "wpa_password.age".publicKeys = all;

  "sshconfig.age".publicKeys = all;

  "wireguard_priv.age".publicKeys = all;
  "wireguard_psk.age".publicKeys = all;
}
