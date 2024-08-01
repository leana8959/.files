{ config, ... }:

{
  nix.settings.trusted-users = [ "leana" ];

  users.users."leana" = {
    isNormalUser = true;
    home = "/home/leana";
    description = "Leana";
    group = "leana";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
  };

  users.groups.leana = { };
}
