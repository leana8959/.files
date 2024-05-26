{
  mkDarwins,
  mkHomeManagers,
  mkNixOSes,
  ...
}:
{
  imports = [ ./combinators.nix ];

  flake = {
    darwinConfigurations = mkDarwins {
      # MacBook Pro 2021
      bismuth = {
        system = "aarch64-darwin";
        settings = {
          extra.lang-servers.enable = true;
          extra.utilities.enable = true;
          extra.university.enable = true;
          extra.workflow.enable = true;
          programs.git.signing.signByDefault = true;
          programs.cmus.enable = true;
        };
      };
      # MacBook Air 2014
      tungsten = {
        system = "x86_64-darwin";
        settings = {
          programs.cmus.enable = true;
        };
      };
    };

    homeConfigurations = mkHomeManagers {
      # Raspberry Pi 4
      hydrogen.system = "aarch64-linux";
      # Oracle cloud
      oracle.system = "aarch64-linux";
      # Linode
      linode.system = "x86_64-linux";
      # Inria
      mertensia = {
        system = "x86_64-linux";
        settings = {
          extra.lang-servers.enable = true;
          extra.utilities.enable = true;
        };
      };
    };

    nixosConfigurations = mkNixOSes {
      # Thinkpad
      carbon = {
        system = "x86_64-linux";
        settings = {
          extra.lang-servers.enable = true;
          extra.utilities.enable = true;
          extra.university.enable = true;
          programs.cmus.enable = true;
        };
      };
    };
  };
}
