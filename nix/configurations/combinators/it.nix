localFlake:

{ inputs, ... }:
let
  mkNixOS =
    nixosModulesOf: homeModulesOf: name: sys: hmOpts:
    localFlake.withSystem sys (
      { pkgs, ... }:
      let
        args = {
          inherit pkgs;
          hostname = name;
        };
      in
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = nixosModulesOf name sys ++ [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = homeModulesOf name sys ++ [ hmOpts ];
            };
          }
        ];
      }
    );

  mkDarwin =
    darwinModulesOf: homeModulesOf: name: sys: hmOpts:
    localFlake.withSystem sys (
      { pkgs, ... }:
      let
        args = {
          inherit pkgs;
          hostname = name;
        };
      in
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = args;
        modules = darwinModulesOf name sys ++ [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = homeModulesOf name sys ++ [ hmOpts ];
            };
          }
        ];
      }
    );

  mkHomeManager =
    homeModulesOf: name: sys: hmOpts:
    localFlake.withSystem sys (
      { pkgs, ... }:
      let
        args = {
          inherit pkgs;
          hostname = name;
        };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (args) pkgs;
        extraSpecialArgs = args;
        modules = homeModulesOf name sys ++ [ hmOpts ];
      }
    );
  many = func: builtins.mapAttrs (name: hmOpts: func name hmOpts.system (hmOpts.settings or { }));
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
