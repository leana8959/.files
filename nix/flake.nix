{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wired.url = "github:Toqozz/wired-notify";

    agenix.url = "github:ryantm/agenix/0.15.0";

    nixnur.url = "github:nix-community/NUR";

    opam-nix.url = "github:tweag/opam-nix";
  };

  outputs = {
    nixpkgs,
    nixunstable,
    home-manager,
    wired,
    agenix,
    nixnur,
    opam-nix,
    ...
  }: let
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

    makeOSFor = {
      system,
      hostname,
    }: let
      args = (argsFor {inherit system;}) // (extraArgsFor {inherit system hostname;});
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
    }: let
      args = (argsFor {inherit system;}) // (extraArgsFor {inherit system hostname;});
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = args.pkgs;
        extraSpecialArgs = args;
        modules = [(./home/leana + "@${hostname}")];
      };
  in {
    nixosConfigurations = {
      nixie = makeOSFor {
        hostname = "nixie";
        system = "x86_64-linux";
      };
    };

    homeConfigurations = {
      # "earth2077.fr" = makeHMFor {
      #   hostname = "earth2077.fr";
      #   system = "x86_64-linux";
      # };
      "macOS" = makeHMFor {
        hostname = "macOS";
        system = "aarch64-darwin";
      };
      "pi4" = makeHMFor {
        hostname = "pi4";
        system = "aarch64-linux";
      };
      "oracle" = makeHMFor {
        hostname = "oracle";
        system = "aarch64-linux";
      };
    };
  };
}
