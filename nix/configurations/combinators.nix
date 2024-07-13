{
  withSystem,
  inputs,
  self,
  ...
}:
let
  nixpkgsRegistry = {
    # https://yusef.napora.org/blog/pinning-nixpkgs-flake/
    # Has to be done here because hm-modules don't have access to flake inputs
    nix.registry.nixpkgs.flake = inputs.nixpkgs;
  };

  mkNixOS =
    nixosModulesOf: homeModulesOf: name: sys: hmOpts:
    withSystem sys (
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
    withSystem sys (
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
    withSystem sys (
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
  # promote helper functions into the arguments
  _module.args = {
    mkNixOSes = many (
      mkNixOS
        (name: _: [
          self.nixosModules._
          self.nixosModules.layouts
          ./host/${name}
          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ])
        (
          name: _: [
            self.homeModules._
            ./home/${name}
            nixpkgsRegistry
          ]
        )
    );
    mkDarwins = many (
      mkDarwin
        (name: sys: [
          { nixpkgs.hostPlatform = sys; }
          self.nixosModules._
          self.darwinModules._
          ./host/${name}
          inputs.home-manager.darwinModules.home-manager
        ])
        (
          name: _: [
            self.homeModules._
            ./home/${name}
            nixpkgsRegistry
          ]
        )
    );
    mkHomeManagers = many (
      mkHomeManager (
        name: _: [
          self.homeModules._
          ./home/${name}
          nixpkgsRegistry
          self.homeModules.auto-gc # Enable user gc only when home-manager is used standalone
        ]
      )
    );
  };
}
