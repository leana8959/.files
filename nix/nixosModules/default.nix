{ lib, ... }:

let
  toModule = name: ./${name};

  sharedModuleNames = [
    "sudo-conf"
    "system-nixconf"
  ];
  moduleNames = [
    "layouts"
    "locale"
    "network"
  ];

  sharedModules = lib.attrsets.genAttrs sharedModuleNames toModule;

  eachModule = lib.attrsets.genAttrs (sharedModuleNames ++ moduleNames) toModule;

  allModules.imports = map toModule (sharedModuleNames ++ moduleNames);
in

{
  flake.nixosModules = eachModule // {
    # Shared between darwin and nix
    shared = sharedModules;

    _ = allModules;
  };
}
