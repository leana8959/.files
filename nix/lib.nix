{
  nixpkgs,
  nixunstable,
  home-manager,
  nix-darwin,
  flake-utils,
  ...
} @ input: let
  mkArgs = system: rec {
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
    wired = input.wired.packages.${system};
    agenix = input.agenix.packages.${system};
    audio-lint = input.audio-lint.defaultPackage.${system};
  };

  homeManagerOptions = {lib, ...}: {
    options = {
      cmus.enable = lib.mkOption {default = false;};
      extraUtils.enable = lib.mkOption {default = false;};
      extraLanguageServers.enable = lib.mkOption {default = false;};
      universityTools.enable = lib.mkOption {default = false;};
    };
  };

  homeManagerModules = hostname: [
    ./home/_
    ./home/${hostname}
    homeManagerOptions
  ];

  mkNixOS = name: sys: cfgs: let
    args = (mkArgs sys) // {hostname = name;};
  in (nixpkgs.lib.nixosSystem {
    specialArgs = args;
    modules = [
      ./hosts/${name}
      ./layouts
      input.agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = args;
          users.leana.imports = (homeManagerModules name) ++ [cfgs];
        };
      }
    ];
  });

  mkDarwin = name: sys: cfgs: let
    args = (mkArgs sys) // {hostname = name;};
  in (nix-darwin.lib.darwinSystem {
    specialArgs = args;
    modules = [
      ./hosts/${name}
      home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = args;
          users.leana.imports = (homeManagerModules name) ++ [cfgs];
        };
      }
    ];
  });

  mkHomeManager = name: sys: cfgs: let
    args = mkArgs sys;
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = (homeManagerModules name) ++ [cfgs];
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
