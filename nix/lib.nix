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
  mkNixOS = hostname: system: extraSettings: let
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
          extraSpecialArgs = args;
          users.leana.imports = [./home/common (./home/leana + "@${hostname}")];
        };
      }
    ];
  });

  mkHomeManager = hostname: system: extraSettings: let
    args = (mkArgs system hostname) // (defaultExtraSettings // extraSettings);
  in
    home-manager.lib.homeManagerConfiguration {
      pkgs = args.pkgs;
      extraSpecialArgs = args;
      modules = [./home/common (./home/leana + "@${hostname}")];
    };
}
