# generates global config
# should be used with nixos or nix-darwin
{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.nix_2_21;
  nix.settings = {
    /*
      substituters can only be used by users that are trusted by nix -> nix trusts the user to do it right
      trusted-substituters can be used by any user -> nix trusts everything the substituter provides

      "In addition, each store path should be trusted as described in trusted-public-keys"
      -> keys for everything
    */

    substituters = [
      "https://nix-community.cachix.org"
      "https://leana8959.cachix.org"
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://leana8959.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M="
    ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
    allow-import-from-derivation = "true";
  };
}
