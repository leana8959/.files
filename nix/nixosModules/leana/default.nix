{ config, ... }:

{
  nix.settings.trusted-users = [ "leana" ];

  users.users.leana = {
    isNormalUser = true;
    home = "/home/leana";
    description = "Leana";
    group = "leana";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys ++ [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBt+MINzxBF8uyFIuz/UvMZe9Ml+qxU0hxxi7UAmUzpc leana@bismuth"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvP72buxKrTAtu9SxSqd0kzzbGxY7fUwgT100Q0S/Yi leana@carbon"
    ];
  };

  users.groups.leana = { };
}
