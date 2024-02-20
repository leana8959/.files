{
  nixpkgs,
  nixunstable,
  nixnur,
  home-manager,
  flake-utils,
  agenix,
  wired,
  audio-lint,
  opam-nix,
  ...
}: let
  helperFuncs = {
    if' = cond: xs:
      if cond
      then xs
      else [];
  };

  defaultExtraSettings = {
    inherit helperFuncs;
    extraLanguageServers = false;
    extraUtils = false;
    enableCmus = false;
    universityTools = false;
  };

  mkArgs = system: let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "discord"
          "languagetool"
        ];
    };
    unstable = import nixunstable {inherit system;};
    nur = import nixnur {
      inherit pkgs;
      nurpkgs = pkgs;
    };
    mypkgs = import ./mypkgs {
      inherit pkgs unstable;
      inherit system;
      inherit opam-nix;
    };
  in {
    inherit pkgs unstable nur mypkgs;
    wired = wired.packages.${system};
    agenix = agenix.packages.${system};
    audio-lint = audio-lint.defaultPackage.${system};
  };
in {
  mkNixOS = hostname: system: extraSettings: let
    args =
      (mkArgs system)
      // {inherit hostname;}
      // {settings = defaultExtraSettings // extraSettings;};
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
          extraSpecialArgs = args;
          users.leana.imports = [./home/common (./home/leana + "@${hostname}")];
        };
      }
    ];
  });

  mkHomeManager = hostname: system: extraSettings: let
    args =
      (mkArgs system)
      // {inherit hostname;}
      // {settings = defaultExtraSettings // extraSettings;};
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [./home/common (./home/leana + "@${hostname}")];
    };

  myPackages =
    flake-utils.lib.eachDefaultSystem
    (system: {packages = (mkArgs system).mypkgs;});
}
