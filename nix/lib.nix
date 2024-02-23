{
  nixpkgs,
  nixunstable,
  home-manager,
  flake-utils,
  ...
} @ input: let
  defaultExtraSettings = {
    extraLanguageServers = false;
    extraUtils = false;
    enableCmus = false;
    universityTools = false;
  };

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
in {
  mkNixOS = hostname: system: extraSettings: let
    args =
      (mkArgs system)
      // {inherit hostname;}
      // {settings = defaultExtraSettings // extraSettings;};
  in (nixpkgs.lib.nixosSystem {
    specialArgs = args;
    modules = [
      ./hosts/${hostname}/default.nix
      ./layouts
      input.agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = args;
          users.leana.imports = [./home/common (./home/leana + "@${hostname}")];
        };
      }
    ];
  });

  mkHomeManager = hostname: system: extraSettings: let
    args =
      (mkArgs system)
      // {inherit hostname;}
      // {settings = defaultExtraSettings // extraSettings;};
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [./home/common (./home/leana + "@${hostname}")];
    };

  myPackages =
    flake-utils.lib.eachDefaultSystem
    (system: {packages = (mkArgs system).mypkgs;});

  formatter =
    flake-utils.lib.eachDefaultSystem
    (system: {formatter = (mkArgs system).pkgs.alejandra;});
}
