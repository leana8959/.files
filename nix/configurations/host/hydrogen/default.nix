{ config, modulesPath, ... }:

{
  imports = [
    # The generator and hardware configuration
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  networking.wireless.enable = false;

  networking.firewall.allowedTCPPorts = [ 5432 ];
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mockingjay" ];
    ensureUsers = [ { name = "postgres"; } ];

    enableTCPIP = true;
    authentication = ''
      host    all             all             10.0.0.1/23             trust
    '';
  };

  # hoot, the discord bot
  services.hoot.enable = true;
  services.hoot.environmentFile = config.age.secrets.hoot_token.path;
  services.hoot.configDir = "/var/hoot";

  age.secrets.hoot_token = {
    owner = "hoot";
    mode = "600";
    file = ../../secrets/hoot_token.age;
  };
}
