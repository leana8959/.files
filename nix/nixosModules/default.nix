{ lib, ... }:

let
  modulesFromDir =
    path:
    lib.pipe (builtins.readDir path) [
      (lib.filterAttrs (moduleName: _: moduleName != "default.nix"))
      (lib.mapAttrs (moduleName: _: lib.path.append path moduleName)) # { name: path; ... }
    ];

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
