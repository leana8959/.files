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

  mkNixOSes =
    let
      go =
        mkNixOS
          (
            { hostname, system, ... }:
            [
              {
                nixpkgs.hostPlatform = system;
                system.stateVersion = "24.05";
              }
              self.nixosModules._
              self.nixosModules.layouts
              ./host/${hostname}
              inputs.agenix.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
            ]
          )
          (
            { hostname, ... }:
            [
              { home.stateVersion = "24.05"; }
              self.homeModules._
              ./home/${hostname}
              nixpkgsRegistry
            ]
          );
    in
    many (
      args@{ system, ... }:
      let
        config = go args;
      in
      config // { deploy = inputs.deploy-rs.lib.${system}.activate.nixos config; }
    );

  mkDarwins = many (
    mkDarwin
      (
        { hostname, system, ... }:
        [
          {
            nixpkgs.hostPlatform = system;
            system.stateVersion = 4;
          }
          self.nixosModules.shared
          self.darwinModules._
          ./host/${hostname}
          inputs.home-manager.darwinModules.home-manager
        ]
      )
      (
        { hostname, ... }:
        [
          { home.stateVersion = "24.05"; }
          self.homeModules._
          ./home/${hostname}
          nixpkgsRegistry
        ]
      )
  );

  mkHomeManagers = many (
    mkHomeManager (
      { hostname, ... }:
      [
        { home.stateVersion = "24.05"; }
        self.homeModules._
        ./home/${hostname}
        nixpkgsRegistry
        self.homeModules.auto-gc # Enable user gc only when home-manager is used standalone
      ]
    )
  );
in

{
  flake = {
    darwinConfigurations = mkDarwins {
      # MacBook Pro 2021
      bismuth = {
        system = "aarch64-darwin";
        extraHomeConfig = {
          programs.neovim.extraLangServers.enable = true;
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
        extraHomeConfig = {
          programs.cmus.enable = true;
        };
      };
    };

    homeConfigurations = mkHomeManagers {
      # Oracle cloud
      oracle.system = "aarch64-linux";
      # Linode
      linode.system = "x86_64-linux";
      # Inria (2024)
      mertensia = {
        system = "x86_64-linux";
        extraHomeConfig = {
          programs.neovim.extraLangServers.enable = true;
          extra.utilities.enable = true;
          programs.password-store.enable = true;
        };
      };
    };

    nixosConfigurations = mkNixOSes {
      # Thinkpad
      carbon = {
        system = "x86_64-linux";
        extraNixOSConfig.imports = [ self.nixosModules.i_am_builder ];
        extraHomeConfig = {
          programs.neovim.extraLangServers.enable = true;
          extra.utilities.enable = true;
          extra.university.enable = true;
          programs.cmus.enable = true;
        };
      };
      # Raspberry Pi 4
      hydrogen = {
        system = "aarch64-linux";
        extraNixOSConfig.imports = [ self.nixosModules.i_am_builder ];
      };
    };
  };
}
