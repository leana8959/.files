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
      sharedModules =
        { hostname, system }:
        [
          {
            nixpkgs.hostPlatform = system;
            system.stateVersion = "24.05";
          }

          self.nixosModules._
          self.nixosModules.layouts
          ./host/${hostname}
          inputs.agenix.nixosModules.default

          self.nixosModules.leana
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit hostname;
              };

              sharedModules = [ { home.stateVersion = "24.05"; } ];
              users.leana.imports = [
                self.homeModules._
                ./home/${hostname}
                nixpkgsRegistry
              ];
            };
          }
        ];
    in
    many (
      args@{ system, ... }:
      let
        config = mkNixOS sharedModules args;
      in
      config // { deploy = inputs.deploy-rs.lib.${system}.activate.nixos config; }
    );

  mkDarwins =
    let
      sharedModules =
        { hostname, system }:
        [
          {
            nixpkgs.hostPlatform = system;
            system.stateVersion = 4;
          }
          self.nixosModules.shared
          self.darwinModules._
          ./host/${hostname}

          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit hostname;
              };
              sharedModules = [ { home.stateVersion = "24.05"; } ];
              users.leana.imports = [
                self.homeModules._
                ./home/${hostname}
                nixpkgsRegistry
              ];
            };
          }
        ];
    in
    many (mkDarwin sharedModules);

  mkHomeManagers =
    let
      sharedModules =
        { hostname, ... }:
        [
          { home.stateVersion = "24.05"; }
          self.homeModules._
          ./home/${hostname}
          nixpkgsRegistry
          self.homeModules.auto-gc # Enable user gc only when home-manager is used standalone
        ];
    in
    many (
      args@{ system, ... }:
      let
        config = mkHomeManager sharedModules args;
      in
      config // { deploy = inputs.deploy-rs.lib.${system}.activate.home-manager config; }
    );
in

{
  flake = {
    darwinConfigurations = mkDarwins {
      # MacBook Pro 2021
      bismuth = {
        system = "aarch64-darwin";
        modules = [
          {
            home-manager.users.leana = {
              programs.neovim.extraLangServers.enable = true;
              extra.utilities.enable = true;
              extra.university.enable = true;
              extra.workflow.enable = true;
              programs.git.signing.signByDefault = true;
              programs.cmus.enable = true;
              programs.password-store.enable = true;
            };
          }
        ];
      };
      # MacBook Air 2014
      tungsten = {
        system = "x86_64-darwin";
        modules = [
          {
            home-manager.users.leana = {
              programs.cmus.enable = true;
            };
          }
        ];
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
        modules = [
          {
            home-manager.users.leana = {
              programs.neovim.extraLangServers.enable = true;
              extra.utilities.enable = true;
              programs.password-store.enable = true;
            };
          }
        ];
      };
    };

    nixosConfigurations =
      let
        hosts = mkNixOSes {
          # Thinkpad
          carbon = {
            system = "x86_64-linux";
            modules = [
              inputs.disko.nixosModules.default
              self.diskoConfigurations.carbon
              self.nixosModules.zram
              {
                home-manager.users.leana = {
                  programs.neovim.extraLangServers.enable = true;
                  programs.git.signing.signByDefault = true;
                  extra.utilities.enable = true;
                  extra.university.enable = true;
                  programs.cmus.enable = true;
                };
              }
            ];
          };
          # Raspberry Pi 4
          hydrogen = {
            system = "aarch64-linux";
            modules = [ self.nixosModules.i_am_builder ];
          };
        };

        carbon-installer = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            self.nixosModules.layouts
            self.nixosModules.system-nixconf
            (
              {
                pkgs,
                lib,
                modulesPath,
                ...
              }:
              {
                nixpkgs.hostPlatform = system;
                system.stateVersion = "24.05";

                imports = [ "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];
                isoImage.squashfsCompression = "zstd -Xcompression-level 3";
                environment.systemPackages = [
                  inputs.disko.packages.${system}.disko
                  pkgs.fish
                  pkgs.git
                  pkgs.pastebinit # for sharing cli output & debugging
                ];
                nix.package = lib.mkForce pkgs.nixVersions.latest;
                users.users.nixos.shell = pkgs.fish;
                programs.fish.enable = true;
              }
            )
          ];
        };
      in
      hosts // { inherit carbon-installer; };
  };
}
