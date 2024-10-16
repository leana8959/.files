{
  lib,
  inputs,
  withSystem,
  ...
}:

let
  mkNixOS =
    sharedModules:
    {
      hostname,
      system,
      modules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit hostname;
      };
      modules = sharedModules { inherit hostname system; } ++ modules;
    };

  mkDarwin =
    sharedModules:
    {
      hostname,
      system,
      modules ? [ ],
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit hostname;
      };
      modules = sharedModules { inherit hostname system; } ++ modules;
    };

  mkHomeManager =
    sharedModules:
    {
      hostname,
      system,
      modules ? [ ],
    }:
    withSystem system (
      { pkgs, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit hostname;
        };
        modules = sharedModules { inherit hostname system; } ++ modules;
      }
    );

  maybePathOrDefault =
    path: default:
    if
      lib.pathExists # Test directory/default.nix or just the file
        (if lib.pathIsDirectory path then (lib.path.append path "default.nix") else path)
    then
      path
    else
      default;

  many = func: builtins.mapAttrs (hostname: cfgs: func (cfgs // { inherit hostname; }));
in
{
  _module.args = {
    inherit
      many
      mkNixOS
      mkDarwin
      mkHomeManager

      maybePathOrDefault
      ;
  };
}
