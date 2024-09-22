{

  nix = {

    settings = {
      allow-import-from-derivation = "true";
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://leana8959.cachix.org"
      ];
      extra-trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://leana8959.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    registry.flakies = {
      from.id = "flakies";
      from.type = "indirect";
      to.type = "git";
      to.url = "https://git.earth2077.fr/leana/flakies";
    };

  };

}
