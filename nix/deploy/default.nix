{ self, inputs, ... }:

{
  flake.checks = builtins.mapAttrs (
    _system: deployLib: deployLib.deployChecks self.deploy
  ) inputs.deploy-rs.lib;

  flake.deploy.nodes.hydrogen = {
    hostname = "hydrogen";
    sshUser = "root";
    profiles.system = {
      user = "root";
      path = self.nixosConfigurations.hydrogen.deploy;
    };
  };
}
