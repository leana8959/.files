{ self, inputs, ... }:

{
  flake.checks = builtins.mapAttrs (
    _system: deployLib: deployLib.deployChecks self.deploy
  ) inputs.deploy-rs.lib;

  flake.deploy.nodes = {
    carbon = {
      hostname = "carbon";
      sshUser = "root";
      profiles.system = {
        user = "root";
        path = self.nixosConfigurations.carbon.deploy;
      };
    };

    hydrogen = {
      hostname = "hydrogen";
      sshUser = "root";
      profiles.system = {
        user = "root";
        path = self.nixosConfigurations.hydrogen.deploy;
      };
    };

    oracle = {
      hostname = "oracle";
      sshUser = "ubuntu";
      profiles.system = {
        user = "ubuntu";
        path = self.homeConfigurations.oracle.deploy;
      };
    };
  };
}
