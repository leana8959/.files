{
  withSystem,
  inputs,
  defaultOptions,
  self,
  ...
}:
let
  mkNixOS =
    name: sys: opts:
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
          defaultOptions
          opts
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = [
                "${self}/nix/home/_"
                "${self}/nix/home/${name}"
                defaultOptions
                opts
              ];
            };
          }
        ];
      }
    );

  mkDarwin =
    name: sys: opts:
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
          "${self}/nix/hosts/_"
          "${self}/nix/hosts/${name}"
          defaultOptions
          opts
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              users.leana.imports = [
                "${self}/nix/home/_"
                "${self}/nix/home/${name}"
                defaultOptions
                opts
              ];
            };
          }
        ];
      }
    );

  mkHomeManager =
    name: sys: opts:
    withSystem sys (
      { pkgs, ... }:
      let
        args = {
          inherit pkgs;
          hostname = name;
        };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = args.pkgs;
        extraSpecialArgs = args;
        modules = [
          "${self}/nix/home/_"
          "${self}/nix/home/${name}"
          defaultOptions
          opts
        ];
      }
    );

  many = func: builtins.mapAttrs (name: opts: func name (opts.system) (opts.settings or { }));
in
{
  # promote helper functions into the arguments
  _module.args = {
    mkNixOSes = many mkNixOS;
    mkHomeManagers = many mkHomeManager;
    mkDarwins = many mkDarwin;
  };
}
