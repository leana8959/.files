{
  nix.distributedBuilds = true;

  # NOTE:
  # https://github.com/NixOS/hydra/issues/584#issuecomment-1901289182
  # use ssh-ng to "fix" not trusted user issue
  nix.buildMachines = [
    {
      hostName = "carbon";
      system = "x86_64-linux";
      protocol = "ssh";
      sshUser = "leana";
      sshKey = "/Users/leana/.ssh/id_ed25519";
      speedFactor = 2;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "oracle";
      system = "aarch64-linux";
      protocol = "ssh-ng";
      sshUser = "ubuntu";
      sshKey = "/Users/leana/.ssh/id_ed25519";
      speedFactor = 8;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "paradize";
      system = "aarch64-linux";
      protocol = "ssh-ng";
      sshUser = "leana";
      sshKey = "/Users/leana/.ssh/id_ed25519";
      speedFactor = 1;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "hydrogen";
      system = "aarch64-linux";
      protocol = "ssh-ng";
      sshUser = "leana";
      sshKey = "/Users/leana/.ssh/id_ed25519";
      speedFactor = 1;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
  ];

  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
