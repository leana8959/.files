{
  nix.settings = {
    substituters = [
      "https://leana8959.cachix.org"
      "https://nix-community.cachix.org"
      "https://llama-cpp.cachix.org"
    ];
    trusted-substituters = [
      "https://leana8959.cachix.org"
      "https://nix-community.cachix.org"
      "https://llama-cpp.cachix.org"
    ];
    trusted-public-keys = [
      "leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "llama-cpp.cachix.org-1:H75X+w83wUKTIPSO1KWy9ADUrzThyGs8P5tmAbkWhQc="
    ];
  };
}
