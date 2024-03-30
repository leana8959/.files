{
  nixpkgs,
  nixunstable,
  home-manager,
  nix-darwin,
  flake-utils,
  ...
} @ input: let
  mkArgs = system: let
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
    alt-ergo-pin = import input.alt-ergo-pin {
      inherit system;
      config.allowUnfree = true;
    };
    neovim-pin = import input.neovim-pin {inherit system;};
    custom = pkgs.callPackage ./custom {
      inherit unstable;
      inherit (input) opam-nix;
      inherit (alt-ergo-pin) alt-ergo;
    };
  in {
    inherit pkgs unstable nur;
    inherit (custom) myPkgs myLib;
    # packages
    wired = input.wired.packages.${system};
    agenix = input.agenix.packages.${system};
    llama-cpp = input.llama-cpp.packages.${system}.default;
    inherit neovim-pin;
    nix-visualize = input.nix-visualize.packages.${system}.default;
    # my packages
    audio-lint = input.audio-lint.defaultPackage.${system};
    hbrainfuck = input.hbrainfuck.packages.${system}.default;
    prop-solveur = input.prop-solveur.packages.${system}.default;
  };

  defaultOptions = {lib, ...}: {
    options = {
      cmus.enable = lib.mkOption {default = false;};
      extraUtils.enable = lib.mkOption {default = false;};
      extraLanguageServers.enable = lib.mkOption {default = false;};
      universityTools.enable = lib.mkOption {default = false;};
      docker.enable = lib.mkOption {default = false;};
      fish.extraCompletions = lib.mkOption {default = [];};
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
    args = mkArgs sys // {hostname = name;};
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

  myPkgs = flake-utils.lib.eachDefaultSystem (system: {packages = (mkArgs system).myPkgs;});
  myLib = flake-utils.lib.eachDefaultSystem (system: {lib = (mkArgs system).myLib;});
}
