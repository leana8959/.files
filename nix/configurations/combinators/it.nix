localFlake:

{ inputs, ... }:
let
  mkNixOS =
    nixosModulesOf: homeModulesOf:
    {
      hostname,
      system,
      extraNixOSConfig ? { },
      extraHomeConfig ? { },
      ...
    }@args:
    localFlake.withSystem system (
      { pkgs, ... }:
      let
        specialArgs = {
          inherit pkgs;
          inherit hostname;
        };
      in
      inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = nixosModulesOf args ++ [
          extraNixOSConfig
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.leana.imports = homeModulesOf args ++ [ extraHomeConfig ];
            };
          }
        ];
      }
    );

  mkDarwin =
    darwinModulesOf: homeModulesOf:
    args@{
      hostname,
      system,
      extraDarwinConfig ? { },
      extraHomeConfig ? { },
      ...
    }:
    localFlake.withSystem system (
      { pkgs, ... }:
      let
        specialArgs = {
          inherit pkgs;
          inherit hostname;
        };
      in
      inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = darwinModulesOf args ++ [
          extraDarwinConfig
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.leana.imports = homeModulesOf args ++ [ extraHomeConfig ];
            };
          }
        ];
      }
    );

  mkHomeManager =
    homeModulesOf:
    args@{
      hostname,
      system,
      extraHomeConfig ? { },
      ...
    }:
    localFlake.withSystem system (
      { pkgs, ... }:
      let
        specialArgs = {
          inherit pkgs;
          inherit hostname;
        };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (specialArgs) pkgs;
        extraSpecialArgs = specialArgs;
        modules = homeModulesOf args ++ [ extraHomeConfig ];
      }
    );

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
