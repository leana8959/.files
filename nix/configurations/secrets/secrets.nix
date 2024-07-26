let
  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKf9AFsIEjkf0c5Hu73Vr4rKkGKzMkgYBJODw1Vvi2DL";
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
