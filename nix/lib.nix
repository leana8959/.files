{
  nixpkgs,
  nixunstable,
  home-manager,
  nix-darwin,
  flake-utils,
  ...
} @ input: let
  mkArgs = system: rec {
    # package sets
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "discord"
          "languagetool"
        ];
    };
    unstable = import nixunstable {inherit system;};
    nur = import input.nixnur {
      inherit pkgs;
      nurpkgs = pkgs;
    };
    mypkgs = import ./mypkgs {
      inherit pkgs unstable;
      inherit system;
      inherit (input) opam-nix;
    };
    # packages
    wired = input.wired.packages.${system};
    agenix = input.agenix.packages.${system};
    llama-cpp = input.llama-cpp.packages.${system}.default;
    # my packages
    audio-lint = input.audio-lint.defaultPackage.${system};
    hbrainfuck = input.hbrainfuck.packages.${system}.default;
  };

  defaultOptions = {lib, ...}: {
    options = {
      cmus.enable = lib.mkOption {default = false;};
      extraUtils.enable = lib.mkOption {default = false;};
      extraLanguageServers.enable = lib.mkOption {default = false;};
      universityTools.enable = lib.mkOption {default = false;};
      docker.enable = lib.mkOption {default = false;};
    };
  };

  mkNixOS = name: sys: opts: let
    args = (mkArgs sys) // {hostname = name;};
  in
    nixpkgs.lib.nixosSystem {
      specialArgs = args;
      modules = [
        ./hosts/_
        ./hosts/${name}
        ./layouts
        input.agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        defaultOptions
        opts
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;
            users.leana.imports = [./home/_ ./home/${name} defaultOptions opts];
          };
        }
      ];
    };

  mkDarwin = name: sys: opts: let
    args = (mkArgs sys) // {hostname = name;};
  in
    nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = [
        ./hosts/_
        ./hosts/${name}
        home-manager.darwinModules.home-manager
        defaultOptions
        opts
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;
            users.leana.imports = [./home/_ ./home/${name} defaultOptions opts];
          };
        }
      ];
    };

  mkHomeManager = name: sys: opts: let
    args = mkArgs sys;
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [./home/_ ./home/${name} defaultOptions opts];
    };

  many = func: builtins.mapAttrs (name: opts: func name (opts.system) (opts.settings or {}));
in {
  mkNixOSes = many mkNixOS;
  mkHomeManagers = many mkHomeManager;
  mkDarwins = many mkDarwin;

  formatter = flake-utils.lib.eachDefaultSystem (system: {formatter = (mkArgs system).pkgs.alejandra;});

  myPackages = flake-utils.lib.eachDefaultSystem (system: {packages = (mkArgs system).mypkgs;});
  myLib = flake-utils.lib.eachDefaultSystem (system: {packages = (mkArgs system).mypkgs.lib;});
}
