{
  nixpkgs,
  nixunstable,
  home-manager,
  wired,
  agenix,
  nixnur,
  opam-nix,
  audio-lint,
  ...
}: rec {
  argsFor = {system}: {
    pkgs = import nixpkgs {
      system = system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "discord"
          "languagetool"
        ];
    };
    unstable = import nixunstable {system = system;};
  };

  extraArgsFor = {
    system,
    hostname,
  }: let
    args = argsFor {inherit system;};
  in {
    wired = wired.packages.${system};
    agenix = agenix.packages.${system};
    audio-lint = audio-lint.defaultPackage.${system};
    nur = import nixnur {
      nurpkgs = args.pkgs;
      pkgs = args.pkgs;
    };
    mypkgs = import ./mypkgs {
      pkgs = args.pkgs;
      inherit opam-nix;
    };
    hostname = hostname;
  };

  defaultExtraSettings = {
    extraLanguageServers = false;
  };

  makeOSFor = {
    system,
    hostname,
    extraSettings ? {},
  }: let
    args =
      (argsFor {inherit system;})
      // (extraArgsFor {inherit system hostname;})
      // (defaultExtraSettings // extraSettings);
  in (nixpkgs.lib.nixosSystem {
    specialArgs = args;
    modules = [
      ./hosts/${hostname}/default.nix
      ./layouts
      agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.leana = import (./home/leana + "@${hostname}");
          extraSpecialArgs = args;
        };
      }
    ];
  });

  makeHMFor = {
    system,
    hostname,
    extraSettings ? {},
  }: let
    args =
      (argsFor {inherit system;})
      // (extraArgsFor {inherit system hostname;})
      // (defaultExtraSettings // extraSettings);
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [(./home/leana + "@${hostname}")];
    };
}
