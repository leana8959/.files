{ inputs, ... }:
{
  perSystem =
    {
      system,
      self',
      inputs',
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          # fallback to other inputs
          (final: _: inputs.nixpkgs.lib.mapAttrs (name: input: input.packages.default) inputs')

          (final: _: {
            unstable = inputs'.nixunstable.legacyPackages;
            nur = import inputs.nixnur {
              pkgs = final;
              nurpkgs = final;
            };
          })

          # extend pkgs with my custom set
          (_: _: { myPkgs = self'.packages; })

          # resolve explicitly pinned pkg sets as attributes
          (_: _: {
            ghc-pin = inputs'.ghc-pin.legacyPackages;
            alt-ergo-pin = import inputs.alt-ergo-pin {
              inherit system;
              config.allowUnfree = true;
            };
            neovim-pin = inputs'.neovim-pin.legacyPackages;
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
