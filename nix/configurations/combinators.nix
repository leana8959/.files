{
  withSystem,
  inputs,
  self,
  ...
}:
let
  nixpkgsRegistry = {
    # https://yusef.napora.org/blog/pinning-nixpkgs-flake/
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
          "${self}/nix/hosts/_"
          "${self}/nix/hosts/${name}"
          "${self}/nix/layouts"
          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = [
                "${self}/nix/home/_"
                "${self}/nix/home/${name}"
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
          "${self}/nix/hosts/_"
          "${self}/nix/hosts/_darwin"
          "${self}/nix/hosts/${name}"
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = [
                "${self}/nix/home/_"
                "${self}/nix/home/${name}"
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
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (args) pkgs;
        extraSpecialArgs = args;
        modules = [
          "${self}/nix/home/_"
          "${self}/nix/home/${name}"
          nixpkgsRegistry
          hmOpts
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
