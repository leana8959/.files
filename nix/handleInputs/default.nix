{ inputs, ... }:
{
  perSystem =
    { system, self', ... }:
    {
      _module.args = rec {
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            # extend pkgs with other inputs
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

            # resolve pinned pkg sets as attributes
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
    };
}
