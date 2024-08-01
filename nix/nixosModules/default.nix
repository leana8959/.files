{ lib, ... }:

let
  toModule = name: ./${name};

  sharedModuleNames = [
    "sudo-conf"
    "system-nixconf"
  ];
  moduleNames = [
    "locale"
    "network"
    "auto-gc"
  ];
  extraModuleNames = [
    "layouts"
    "leana"
    "zram"
    "i_am_builder"
  ];

  sharedModules.imports = map toModule sharedModuleNames;

  eachModule = lib.attrsets.genAttrs (sharedModuleNames ++ moduleNames ++ extraModuleNames) toModule;

  allModules.imports = map toModule (sharedModuleNames ++ moduleNames);
in

{
  flake.nixosModules = eachModule // {
    # Shared between darwin and nix
    shared = sharedModules;

    _ = allModules;
  };
}
