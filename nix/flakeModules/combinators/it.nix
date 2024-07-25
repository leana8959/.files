{ inputs, withSystem, ... }:
let
  mkNixOS =
    nixosModulesOf: homeModulesOf:
    {
      hostname,
      system,
      extraNixOSConfig ? { },
      extraHomeConfig ? { },
      ...
    }:
    withSystem system (
      { pkgs, lib, ... }:
      let
        infoArgs = {
          inherit hostname system;
        };
        specialArgs = {
          inherit pkgs;
          inherit hostname;
        };
      in
      inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = nixosModulesOf infoArgs ++ [
          extraNixOSConfig
          (lib.attrsets.optionalAttrs (extraHomeConfig != null) {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.leana.imports = homeModulesOf infoArgs ++ [ extraHomeConfig ];
            };
          })
        ];
      }
    );

  mkDarwin =
    darwinModulesOf: homeModulesOf:
    {
      hostname,
      system,
      extraDarwinConfig ? { },
      extraHomeConfig ? { },
      ...
    }:
    withSystem system (
      { pkgs, lib, ... }:
      let
        infoArgs = {
          inherit hostname system;
        };
        specialArgs = {
          inherit pkgs;
          inherit hostname;
        };
      in
      inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = darwinModulesOf infoArgs ++ [
          extraDarwinConfig
          (lib.attrsets.optionalAttrs (extraHomeConfig != null) {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.leana.imports = homeModulesOf infoArgs ++ [ extraHomeConfig ];
            };
          })
        ];
      }
    );

  mkHomeManager =
    homeModulesOf:
    {
      hostname,
      system,
      extraHomeConfig ? { },
      ...
    }:
    withSystem system (
      { pkgs, ... }:
      let
        infoArgs = {
          inherit hostname system;
        };
        specialArgs = {
          inherit pkgs;
          inherit hostname;
        };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (specialArgs) pkgs;
        extraSpecialArgs = specialArgs;
        modules = homeModulesOf infoArgs ++ [ extraHomeConfig ];
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
