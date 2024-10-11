{ lib, modulesFromDir, ... }:

let
  # shared between nixos and nix-darwin
  shared = modulesFromDir ./shared;

  # generic modules that can be enabled on all devices
  common = modulesFromDir ./common;

  # extra opt-in configurations
  extra = modulesFromDir ./extra;
in

{
  flake.nixosModules = lib.mergeAttrsList [
    {
      # Fuse some module sets together
      sharedModules.imports = lib.attrValues shared;
      commonModules.imports = lib.attrValues common;
    }
    shared
    common
    extra
  ];
}
