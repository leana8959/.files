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
      path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.hydrogen;
    };
  };
}
