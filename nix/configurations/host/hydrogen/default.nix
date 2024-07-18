{ config, modulesPath, ... }:

{
  imports = [
    # The generator and hardware configuration
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  users.groups.leana = { };
  users.users.leana = {
    isNormalUser = true;
    home = "/home/leana";
    description = "Leana";
    group = "leana";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
  };

  networking.wireless.enable = false;
}
