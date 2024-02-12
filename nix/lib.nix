{
  nixpkgs,
  nixunstable,
  nixnur,
  home-manager,
  agenix,
  wired,
  audio-lint,
  opam-nix,
  ...
}: let
  defaultExtraSettings = {
    extraLanguageServers = false;
    extraUtils = false;
    enableCmus = false;
    universityTools = false;
  };

  mkArgs = system: hostname: let
    pkgs = import nixpkgs {
      system = system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "discord"
          "languagetool"
        ];
    };
    unstable = import nixunstable {system = system;};
    nur = import nixnur {
      inherit pkgs;
      nurpkgs = pkgs;
    };
    mypkgs = import ./mypkgs {
      inherit pkgs;
      inherit opam-nix;
    };
  in {
    inherit hostname pkgs unstable nur mypkgs;
    wired = wired.packages.${system};
    agenix = agenix.packages.${system};
    audio-lint = audio-lint.defaultPackage.${system};
  };
in {
  mkNixOS = {
    system,
    hostname,
    extraSettings ? {},
  }: let
    args = (mkArgs system hostname) // (defaultExtraSettings // extraSettings);
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
          users.leana = {...}: {
            imports = [
              (./home/leana + "@${hostname}")
              ./home/common
            ];
          };
          extraSpecialArgs = args;
        };
      }
    ];
  });

  mkHomeManager = {
    system,
    hostname,
    extraSettings ? {},
  }: let
    args = (mkArgs system hostname) // (defaultExtraSettings // extraSettings);
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [
        (./home/leana + "@${hostname}")
        ./home/common
      ];
    };
}
