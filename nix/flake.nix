{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixunstable,
    home-manager,
    ...
  }: let
    pkgsWith = system:
      import nixpkgs {
        inherit system;
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
            "prl-tools"
          ];
      };

    unstableWith = system: import nixunstable {inherit system;};

    withSystem = (
      device: system: hostname: let
        args = {
          pkgs = pkgsWith system;
          unstable = unstableWith system;
          inherit system hostname;
        };
      in (nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = [
          ./hosts/${device}/default.nix
          ./layouts
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.leana = import ./home;
              extraSpecialArgs = args;
            };
          }
        ];
      })
    );
  in {
    nixosConfigurations = {
      thinkpad = withSystem "thinkpad" "aarch64-linux" "nixie-test";
    };
  };
}
