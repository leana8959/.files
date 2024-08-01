{ lib, hostname, ... }:

{
  networking.hostName = hostname;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
    ports = lib.mkDefault [ 22 ];

    # Make this vuln impossible
    # https://unix.stackexchange.com/questions/15138/how-to-force-ssh-client-to-use-only-password-auth
    extraConfig = ''
      LoginGraceTime 0
    '';
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBt+MINzxBF8uyFIuz/UvMZe9Ml+qxU0hxxi7UAmUzpc leana@bismuth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvP72buxKrTAtu9SxSqd0kzzbGxY7fUwgT100Q0S/Yi leana@carbon"
  ];
}
