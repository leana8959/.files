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
    pkgsS = s:
      import nixpkgs {
        system = s;
        overlays = [
          (final: prev: {
            cmus = prev.cmus.overrideAttrs (old: {
              patches =
                (old.patches or [])
                ++ [
                  (prev.fetchpatch {
                    url = "https://github.com/cmus/cmus/commit/4123b54bad3d8874205aad7f1885191c8e93343c.patch";
                    hash = "sha256-YKqroibgMZFxWQnbmLIHSHR5sMJduyEv6swnKZQ33Fg=";
                  })
                ];
            });
          })
        ];

        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "discord"
            "languagetool"
          ];
      };

    unstableS = s: import nixunstable {system = s;};

    wiredS = s: wired.packages.${s};

    agenixS = s: agenix.packages.${s};

    nurS = s:
      import nixnur {
        nurpkgs = pkgsS s;
        pkgs = pkgsS s;
      };

    mypkgsS = s: import ./mypkgs {pkgs = pkgsS s;};

    nixosWithSystem = device: system: let
      args = {
        pkgs = pkgsS system;
        unstable = unstableS system;
        wired = wiredS system;
        agenix = agenixS system;
        nur = nurS system;
        mypkgs = mypkgsS system;
        hostname = device;
        inherit system;
      };
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
      pkgs = pkgsS system;
      unstable = unstableS system;
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {
          system = system;
          inherit unstable;
        };
        modules = [(./home/leana + "@${device}")];
      };
  in {
    nixosConfigurations = {
      nixie-test = nixosWithSystem "nixie-test" "aarch64-linux";
      nixie = nixosWithSystem "nixie" "x86_64-linux";
    };

    homeConfigurations = {
      "macOS" = homeManagerWithSystem "macOS" "aarch64-darwin";
      "earth2077.fr" = homeManagerWithSystem "earth2077.fr" "x86_64-linux";
      "pi4" = homeManagerWithSystem "pi4" "aarch64-linux";
      "oracle" = homeManagerWithSystem "oracle" "aarch64-linux";
    };
  };
}
