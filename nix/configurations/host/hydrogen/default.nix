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
  services.hoot = {
    enable = true;
    environmentFile = config.age.secrets.hoot_token.path;
    configDir = "/var/hoot";
  };
  age.secrets.hoot_token = {
    owner = "hoot";
    mode = "600";
    file = ../../secrets/hoot_token.age;
  };

  services.typst-bot = {
    enable = true;
    environmentFile = config.age.secrets.typst-bot_token.path;
    dataDir = "/var/typst-bot";
  };
  age.secrets.typst-bot_token = {
    owner = "typst-bot";
    mode = "600";
    file = ../../secrets/typst-bot_token.age;
  };

  services.parrot = {
    enable = true;
    environmentFile = config.age.secrets.parrot_token.path;
  };
  age.secrets.parrot_token = {
    owner = "parrot";
    mode = "600";
    file = ../../secrets/parrot_token.age;
  };
}
