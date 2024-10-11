{ lib, ... }:

{
  nix.gc = lib.mkDefault {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
}
