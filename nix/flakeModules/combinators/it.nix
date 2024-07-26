{ inputs, withSystem, ... }:

let
  mkSpecialArgs =
    { hostname, system, ... }:
    withSystem system (
      { pkgs, ... }:
      {
        inherit pkgs hostname;
      }
    );

  mkNixOS =
    sharedModules:
    {
      hostname,
      system,
      modules ? [ ],
    }:
    let
      info = {
        inherit hostname system;
      };
      specialArgs = mkSpecialArgs info;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = sharedModules info ++ modules;
    };

  mkDarwin =
    sharedModules:
    {
      hostname,
      system,
      modules ? [ ],
    }:
    let
      info = {
        inherit hostname system;
      };
      specialArgs = mkSpecialArgs info;
    in
    inputs.nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      modules = sharedModules info ++ modules;
    };

  mkHomeManager =
    sharedModules:
    {
      hostname,
      system,
      modules ? [ ],
    }:
    let
      info = {
        inherit hostname system;
      };
      specialArgs = mkSpecialArgs info;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit (specialArgs) pkgs;
      extraSpecialArgs = specialArgs;
      modules = sharedModules info ++ modules;
    };

  many = func: builtins.mapAttrs (hostname: cfgs: func (cfgs // { inherit hostname; }));
in
{
  _module.args = {
    inherit
      many
      mkNixOS
      mkDarwin
      mkHomeManager
      ;
  };
}
