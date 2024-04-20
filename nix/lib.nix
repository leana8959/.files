{
  nixpkgs,
  nixunstable,
  home-manager,
  nix-darwin,
  flake-utils,
  ...
}@inputs:
let
  mkArgs =
    system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (_: _: import ./overlays.nix inputs system) ];
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "discord"
            "languagetool"
          ];
      };
      unstable = import nixunstable { inherit system; };
      nur = import inputs.nixnur {
        inherit pkgs;
        nurpkgs = pkgs;
      };
      alt-ergo-pin = import inputs.alt-ergo-pin {
        inherit system;
        config.allowUnfree = true;
      };
      neovim-pin = import inputs.neovim-pin { inherit system; };
      custom = import ./custom {
        inherit pkgs unstable;
        inherit (inputs) opam-nix;
        inherit (alt-ergo-pin) alt-ergo;
      };
    in
    {
      inherit pkgs unstable nur;
      inherit (custom) myPkgs myLib;
      # packages sets
      inherit neovim-pin;
    };

  defaultOptions =
    { lib, ... }:
    {
      options = {
        cmus.enable = lib.mkOption { default = false; };
        extraUtils.enable = lib.mkOption { default = false; };
        extraLanguageServers.enable = lib.mkOption { default = false; };
        universityTools.enable = lib.mkOption { default = false; };
        fish.opamInit = lib.mkOption { default = false; };
        git.signCommits = lib.mkOption { default = false; };
      };
    };

  mkNixOS =
    name: sys: opts:
    let
      args = mkArgs sys // {
        hostname = name;
      };
    in
    nixpkgs.lib.nixosSystem {
      specialArgs = args;
      modules = [
        ./hosts/_
        ./hosts/${name}
        ./layouts
        inputs.agenix.nixosModules.default
        defaultOptions
        opts
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;
            users.leana.imports = [
              ./home/_
              ./home/${name}
              defaultOptions
              opts
            ];
          };
        }
      ];
    };

  mkDarwin =
    name: sys: opts:
    let
      args = mkArgs sys // {
        hostname = name;
      };
    in
    nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = [
        ./hosts/_
        ./hosts/${name}
        defaultOptions
        opts
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;
            users.leana.imports = [
              ./home/_
              ./home/${name}
              defaultOptions
              opts
            ];
          };
        }
      ];
    };

  mkHomeManager =
    name: sys: opts:
    let
      args = mkArgs sys // {
        hostname = name;
      };
    in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [
        ./home/_
        ./home/${name}
        defaultOptions
        opts
      ];
    };

  many = func: builtins.mapAttrs (name: opts: func name (opts.system) (opts.settings or { }));
in
{
  mkNixOSes = many mkNixOS;
  mkHomeManagers = many mkHomeManager;
  mkDarwins = many mkDarwin;

  formatter = flake-utils.lib.eachDefaultSystem (
    system: { formatter = (mkArgs system).unstable.nixfmt-rfc-style; }
  );

  myPkgs = flake-utils.lib.eachDefaultSystem (system: { packages = (mkArgs system).myPkgs; });
  myLib = flake-utils.lib.eachDefaultSystem (system: { lib = (mkArgs system).myLib; });
}
