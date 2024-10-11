{ lib, modulesFromDir, ... }:

let
  common = modulesFromDir ./common;
  extra = modulesFromDir ./extra;
in

{
  flake.homeModules = lib.mergeAttrsList [
    {
      commonModules.imports = lib.attrValues common;
      extraModules.imports = lib.attrValues extra;
    }
    common
    extra
  ];
}
