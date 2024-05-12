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
          extraLanguageServers.enable = true;
          extraUtils.enable = true;
          cmus.enable = true;
          universityTools.enable = true;
          git.signCommits = true;
        };
      };
      # MacBook Air 2014
      tungsten = {
        system = "x86_64-darwin";
        settings.cmus.enable = true;
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
      hydragyrum = {
        system = "x86_64-linux";
        # extraLanguageServers.enable = true;
        # extraUtils.enable = true;
        # universityTools.enable = true;
        # git.signCommits = true;
      };
    };

    nixosConfigurations = mkNixOSes {
      # Thinkpad
      carbon = {
        system = "x86_64-linux";
        settings = {
          extraLanguageServers.enable = true;
          extraUtils.enable = true;
          cmus.enable = true;
          universityTools.enable = true;
        };
      };
    };
  };
}
