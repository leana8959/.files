{
  self,
  inputs,
  many,
  mkDarwin,
  mkHomeManager,
  mkNixOS,
  ...
}:

let
  nixpkgsRegistry = {
    # https://yusef.napora.org/blog/pinning-nixpkgs-flake/
    # Has to be done here because hm-modules don't have access to flake inputs
    nix.registry.nixpkgs.flake = inputs.nixpkgs;
  };

  mkNixOSes = many (
    mkNixOS
      (name: _: [
        self.nixosModules._
        self.nixosModules.layouts
        ./host/${name}
        inputs.agenix.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
      ])
      (
        name: _: [
          self.homeModules._
          ./home/${name}
          nixpkgsRegistry
        ]
      )
  );
  mkDarwins = many (
    mkDarwin
      (name: sys: [
        { nixpkgs.hostPlatform = sys; }
        self.nixosModules._
        self.darwinModules._
        ./host/${name}
        inputs.home-manager.darwinModules.home-manager
      ])
      (
        name: _: [
          self.homeModules._
          ./home/${name}
          nixpkgsRegistry
        ]
      )
  );
  mkHomeManagers = many (
    mkHomeManager (
      name: _: [
        self.homeModules._
        ./home/${name}
        nixpkgsRegistry
        self.homeModules.auto-gc # Enable user gc only when home-manager is used standalone
      ]
    )
  );
in

{
  imports = [ ./combinators ];

  flake = {
    darwinConfigurations = mkDarwins {
      # MacBook Pro 2021
      bismuth = {
        system = "aarch64-darwin";
        settings = {
          extra.lang-servers.enable = true;
          extra.utilities.enable = true;
          extra.university.enable = true;
          extra.workflow.enable = true;
          programs.git.signing.signByDefault = true;
          programs.cmus.enable = true;
          programs.password-store.enable = true;
        };
      };
      # MacBook Air 2014
      tungsten = {
        system = "x86_64-darwin";
        settings = {
          programs.cmus.enable = true;
        };
      };
    };

    homeConfigurations = mkHomeManagers {
      # Raspberry Pi 4
      hydrogen.system = "aarch64-linux";
      # Oracle cloud
      oracle.system = "aarch64-linux";
      # Linode
      linode.system = "x86_64-linux";
      # Inria
      mertensia = {
        system = "x86_64-linux";
        settings = {
          extra.lang-servers.enable = true;
          extra.utilities.enable = true;
          programs.password-store.enable = true;
        };
      };
    };

    nixosConfigurations = mkNixOSes {
      # Thinkpad
      carbon = {
        system = "x86_64-linux";
        settings = {
          extra.lang-servers.enable = true;
          extra.utilities.enable = true;
          extra.university.enable = true;
          programs.cmus.enable = true;
        };
      };
    };
  };
}
