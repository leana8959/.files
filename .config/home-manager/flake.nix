{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { home-manager, nixpkgs, nixunstable, ... }:
    let
      pkgsS = s:
        import nixpkgs {
          system = s;
          overlays = [
            (final: prev: {
              cmus = prev.cmus.overrideAttrs (old: {
                patches = (old.patches or [ ]) ++ [
                  (prev.fetchpatch {
                    url =
                      "https://github.com/cmus/cmus/commit/4123b54bad3d8874205aad7f1885191c8e93343c.patch";
                    hash =
                      "sha256-YKqroibgMZFxWQnbmLIHSHR5sMJduyEv6swnKZQ33Fg=";
                  })
                ];
              });
            })
          ];
        };

      unstableS = s: import nixunstable { system = s; };

      withSystem = (device: system:
        let
          pkgs = pkgsS system;
          unstable = unstableS system;
        in home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            system = system;
            inherit unstable;
          };
          modules = [ ./home/${device} ];
        });

    in {

      homeConfigurations."leana@macOS" =
        withSystem "leana@macOS" "aarch64-darwin";

      homeConfigurations."leana@earth2077.fr" =
        withSystem "leana@earth2077.fr" "x86_64-linux";

    };
}
