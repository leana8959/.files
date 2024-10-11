{ lib, ... }:

let
  modules = lib.pipe (builtins.readDir ./.) [
    (lib.filterAttrs (moduleName: _: moduleName != "default.nix"))
    (lib.mapAttrs (moduleName: _: ./${moduleName}))
  ];
in

{
  imports = lib.attrValues modules;
  flake.flakeModules = modules;
}
