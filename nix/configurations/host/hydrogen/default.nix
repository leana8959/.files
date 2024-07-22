{ modulesPath, ... }:

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
}
