{ lib, ... }:

{

  _module.args.modulesFromDir =
    path:
    lib.pipe (builtins.readDir path) [
      (lib.filterAttrs (moduleName: _: moduleName != "default.nix"))
      (lib.mapAttrs (moduleName: _: lib.path.append path moduleName)) # { name: path; ... }
    ];

}
