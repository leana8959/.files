{ inputs, ... }:
{
  perSystem =
    {
      system,
      self',
      pkgs,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          # fallback to other inputs
          (_: prev: prev.lib.mapAttrs (name: input: input.packages.${system}.default) inputs)

          (_: _: {
            unstable = import inputs.nixunstable { inherit system; };
            nur = import inputs.nixnur {
              inherit pkgs;
              nurpkgs = pkgs;
            };
          })

          # extend pkgs with my custom set
          (_: _: { myPkgs = self'.packages; })

          # resolve explicitly pinned pkg sets as attributes
          (_: _: {
            neovim-pin = import inputs.neovim-pin { inherit system; };
            ghc-pin = import inputs.ghc-pin { inherit system; };
            alt-ergo-pin = import inputs.alt-ergo-pin {
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];

        config.allowUnfreePredicate =
          pkg:
          builtins.elem (inputs.nixpkgs.lib.getName pkg) [
            "discord"
            "languagetool"
          ];
      };
    };
}
