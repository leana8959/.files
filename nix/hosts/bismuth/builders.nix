{
  nix.distributedBuilds = true;

  nix.buildMachines = [
    {
      hostName = "carbon";
      system = "x86_64-linux";
      protocol = "ssh";
      sshUser = "leana";
      sshKey = "/Users/leana/.ssh/id_ed25519";
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
      protocol = "ssh";
      sshUser = "ubuntu";
      sshKey = "/Users/leana/.ssh/id_ed25519";
      speedFactor = 4;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
  ];

  # # optional, useful when the builder has a faster internet connection than yours
  # nix.extraOptions = ''
  #   builders-use-substitutes = true
  # '';
}
