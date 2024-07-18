{ self, inputs, ... }:

{
  flake.checks = builtins.mapAttrs (
    _system: deployLib: deployLib.deployChecks self.deploy
  ) inputs.deploy-rs.lib;

  flake.deploy.nodes =
    inputs.nixpkgs.lib.genAttrs
      [
        "carbon"
        "hydrogen"
      ]
      (name: {
        hostname = name;
        sshUser = "root";
        profiles.system = {
          user = "root";
          path = self.nixosConfigurations.${name}.deploy;
        };
      });
}
