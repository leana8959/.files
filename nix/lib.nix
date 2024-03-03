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

  mkNixOS = name: sys: cfgs: let
    args = (mkArgs sys) // {hostname = name;};
  in
    nixpkgs.lib.nixosSystem {
      specialArgs = args;
      modules = [
        ./hosts/${name}
        ./layouts
        input.agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        defaultOptions
        cfgs
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;
            users.leana.imports = [./home/_ ./home/${name} defaultOptions cfgs];
          };
        }
      ];
    };

  mkDarwin = name: sys: cfgs: let
    args = (mkArgs sys) // {hostname = name;};
  in
    nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = [
        ./hosts/${name}
        home-manager.darwinModules.home-manager
        defaultOptions
        cfgs
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = args;
            users.leana.imports = [./home/_ ./home/${name} defaultOptions cfgs];
          };
        }
      ];
    };

  mkHomeManager = name: sys: cfgs: let
    args = mkArgs sys;
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [./home/_ ./home/${name} defaultOptions cfgs];
    };
in {
  mkNixOSes = xs:
    builtins.mapAttrs (hostname: settings: mkNixOS hostname settings.system (settings.settings or {}))
    xs;

  mkHomeManagers = xs:
    builtins.mapAttrs (hostname: settings: mkHomeManager hostname settings.system (settings.settings or {}))
    xs;

  mkDarwins = xs:
    builtins.mapAttrs (hostname: settings: mkDarwin hostname settings.system (settings.settings or {}))
    xs;

  myPackages =
    flake-utils.lib.eachDefaultSystem
    (system: {packages = (mkArgs system).mypkgs;});

  formatter =
    flake-utils.lib.eachDefaultSystem
    (system: {formatter = (mkArgs system).pkgs.alejandra;});
}
