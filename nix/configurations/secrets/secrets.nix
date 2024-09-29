let
  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKf9AFsIEjkf0c5Hu73Vr4rKkGKzMkgYBJODw1Vvi2DL";
  bismuth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBt+MINzxBF8uyFIuz/UvMZe9Ml+qxU0hxxi7UAmUzpc";
  hydrogen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIISE88i0IvL1l4snmMH+ygsOkbSPUZxvhfCgo78S1aRy";

  all = [
    bismuth
    carbon
    hydrogen
  ];
in
{
  "wpa_password.age".publicKeys = all;

  "sshconfig.age".publicKeys = all;

  "wireguard_priv.age".publicKeys = all;
  "wireguard_psk.age".publicKeys = all;

  "restic_backblaze_pwd.age".publicKeys = all;
  "restic_backblaze_repo.age".publicKeys = all;
  "restic_backblaze_env.age".publicKeys = all;

  "hoot_token.age".publicKeys = all;
  "typst-bot_token.age".publicKeys = all;
}
