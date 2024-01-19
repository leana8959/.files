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
  };

  outputs = {
    nixpkgs,
    nixunstable,
    home-manager,
    wired,
    agenix,
    nixnur,
    ...
  }: let
    argsS = {
      system,
      device,
    }: {
      inherit system;
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "discord"
            "languagetool"
          ];
      };
      unstable = nixunstable {system = system;};
    };

    extraArgsS = {
      system,
      device,
    }: let
      args = argsS {inherit system device;};
    in {
      wired = wired.packages.${system};
      agenix = agenix.packages.${system};
      nur = import nixnur {
        nurpkgs = args.pkgs;
        pkgs = args.pkgs;
      };
      mypkgs = import ./mypkgs {pkgs = args.pkgs;};
      hostname = device;
    };

    nixosWithSystem = device: system: let
      args = (argsS {inherit system device;}) // (extraArgsS {inherit system device;});
    in (nixpkgs.lib.nixosSystem {
      specialArgs = args;
      modules = [
        ./hosts/${device}/default.nix
        ./layouts
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.leana = import (./home/leana + "@${device}");
            extraSpecialArgs = args;
          };
        }
      ];
    });

    homeManagerWithSystem = device: system: let
      args = argsS {inherit system device;};
      pkgs = args.pkgs;
      unstable = args.unstable;
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {
          inherit unstable system;
        };
        modules = [(./home/leana + "@${device}")];
      };
  in {
    nixosConfigurations = {
      nixie = nixosWithSystem "nixie" "x86_64-linux";
    };

    homeConfigurations = {
      # "earth2077.fr" = homeManagerWithSystem "earth2077.fr" "x86_64-linux";
      "macOS" = homeManagerWithSystem "macOS" "aarch64-darwin";
      "pi4" = homeManagerWithSystem "pi4" "aarch64-linux";
      "oracle" = homeManagerWithSystem "oracle" "aarch64-linux";
    };
  };
}
