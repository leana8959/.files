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

  nixpkgsConfig = {
    nixpkgs = {
      overlays = [ self.overlays.full ];
      config.allowUnfreePredicate =
        pkg:
        builtins.elem (inputs.nixpkgs.lib.getName pkg) [
          "discord"
          "languagetool"

          "brscan5"
          "brscan5-etc-files"

          "steam"
          "steam-original"
          "steam-run"

          "vscode"
          "code"
        ];
    };
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
          nixpkgsConfig

          self.nixosModules._
          self.nixosModules.layouts
          ./host/${hostname}
          inputs.agenix.nixosModules.default
          { programs.command-not-found.enable = false; }

          self.nixosModules.leana
          self.nixosModules.fish-vendor-completions
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
          nixpkgsConfig

          self.nixosModules.shared
          self.darwinModules._
          ./host/${hostname}

          self.nixosModules.fish-vendor-completions
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
          nixpkgsConfig
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
              extraPackages.utilities.enable = true;
              extraPackages.workflow.enable = true;
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
            programs.neovim.extraLangServers.enable = true;
            extraPackages.utilities.enable = true;
            programs.password-store.enable = true;
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
                  imports = [
                    self.homeModules.fcitx5
                    self.homeModules.sioyek
                    self.homeModules.feh
                  ];
                  programs.neovim.extraLangServers.enable = true;
                  programs.git.signing.signByDefault = true;
                  extraPackages.utilities.enable = true;
                  programs.cmus.enable = true;
                };
              }
            ];
          };
          # Raspberry Pi 4
          hydrogen = {
            system = "aarch64-linux";
            modules = [
              self.nixosModules.i_am_builder
              inputs.hoot.nixosModules.default
              self.nixosModules.typst-bot
            ];
          };
        };

        carbon-installer = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            self.nixosModules.layouts
            self.nixosModules.system-nixconf
            (
              { pkgs, modulesPath, ... }:
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
