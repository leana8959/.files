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
    name: sys: hmOpts:
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
        modules = [
          self.nixosModules._
          ./host/${name}
          "${self}/nix/layouts"
          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = [
                self.homeModules._
                ./home/${name}
                nixpkgsRegistry
                hmOpts
              ];
            };
          }
        ];
      }
    );

  mkDarwin =
    name: sys: hmOpts:
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
        modules = [
          { nixpkgs.hostPlatform = sys; }
          self.nixosModules._
          self.darwinModules._
          ./host/${name}
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = [
                self.homeModules._
                ./home/${name}
                nixpkgsRegistry
                hmOpts
              ];
            };
          }
        ];
      }
    );

  mkHomeManager =
    name: sys: hmOpts:
    withSystem sys (
      { pkgs, ... }:
      let
        args = {
          inherit pkgs;
          hostname = name;
        };

        # Enable user gc only when home-manager is used standalone
        auto-gc =
          { lib, ... }:
          {
            nix.gc = {
              automatic = true;
              frequency = lib.mkMerge [
                (lib.mkIf pkgs.stdenv.isDarwin "daily")
                (lib.mkIf pkgs.stdenv.isLinux "1 day")
              ];
            };
          };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (args) pkgs;
        extraSpecialArgs = args;
        modules = [
          self.homeModules._
          ./home/${name}
          nixpkgsRegistry
          hmOpts
          auto-gc
        ];
      }
    );

  many = func: builtins.mapAttrs (name: hmOpts: func name hmOpts.system (hmOpts.settings or { }));
in
{
  # promote helper functions into the arguments
  _module.args = {
    mkNixOSes = many mkNixOS;
    mkHomeManagers = many mkHomeManager;
    mkDarwins = many mkDarwin;
  };
}
