{
  nix.distributedBuilds = true;

  # NOTE:
  # https://github.com/NixOS/hydra/issues/584#issuecomment-1901289182
  # use ssh-ng to "fix" not trusted user issue
  nix.buildMachines =
    let
      def = {
        hostName = throw "hostName is not defined";
        system = throw "system is not defined";
        protocol = "ssh";
        sshUser = "nix-remote-builder";
        speedFactor = 1;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [ ];
      };

      carbon = def // {
        hostName = "carbon";
        system = "x86_64-linux";
        speedFactor = 4;
      };

      forgejo = def // {
        hostName = "forgejo";
        system = "x86_64-linux";
        speedFactor = 1;
      };

      hydrogen = def // {
        hostName = "hydrogen";
        system = "aarch64-linux";
        speedFactor = 2;
      };

      oracle = def // {
        hostName = "oracle";
        system = "aarch64-linux";
        protocol = "ssh-ng";
        sshUser = "ubuntu";
        speedFactor = 8;
      };
    in
    [
      # TODO: rebuilding...
      # carbon

      forgejo
      hydrogen
      oracle
    ];

  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
