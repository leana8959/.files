let
  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPUl66Prm3FIJs+aajU9CHakqMffdmxfdIMaonzWttG";
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
