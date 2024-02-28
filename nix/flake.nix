{
  outputs = {...} @ inputs: let
    inherit
      (import ./lib.nix inputs)
      mkNixOSes
      mkDarwins
      mkHomeManagers
      myPackages
      formatter
      ;

    nixosConfigurations = mkNixOSes {
      # Thinkpad
      carbon = {
        system = "x86_64-linux";
        settings = {
          extraLanguageServers.enable = true;
          extraUtils.enable = true;
          cmus.enable = true;
          universityTools.enable = true;
        };
      };
    };

    homeConfigurations = mkHomeManagers {
      # MacBook Air 2014
      tungsten = {
        system = "x86_64-darwin";
        settings.cmus.enable = true;
      };
      # Raspberry Pi 4
      hydrogen.system = "aarch64-linux";
      # Oracle cloud
      oracle.system = "aarch64-linux";
    };

    darwinConfigurations = mkDarwins {
      # MacBook Pro 2021
      bismuth = {
        system = "aarch64-darwin";
        settings = {
          extraLanguageServers.enable = true;
          extraUtils.enable = true;
          cmus.enable = true;
          universityTools.enable = true;
        };
      };
    };
  in
    myPackages // formatter // {inherit nixosConfigurations homeConfigurations darwinConfigurations;};

  inputs = {
    # package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixunstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # tools
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # packages
    wired.url = "github:Toqozz/wired-notify";
    agenix.url = "github:ryantm/agenix/0.15.0";
    nixnur.url = "github:nix-community/NUR";
    opam-nix.url = "github:tweag/opam-nix";
    # my stuff
    audio-lint.url = "git+https://git.earth2077.fr/leana/audio-lint";
    hbrainfuck.url = "git+https://git.earth2077.fr/leana/hbrainfuck";
  };
}
