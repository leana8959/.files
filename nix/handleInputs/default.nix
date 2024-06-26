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
          (_: _: inputs.nixpkgs.lib.mapAttrs (_: input: input.packages.default) inputs')

          (final: _: {
            nur = import inputs.nixnur {
              pkgs = final;
              nurpkgs = final;
            };
          })

          # extend pkgs with my custom set
          (_: _: { myPkgs = self'.packages; })

          # resolve pinned pkg sets as attributes
          (_: prev: {

            # stackage LTS 22.22 / ghc965 (May 19 2024) / hls 2.8.0.0
            ghc-pin = import (prev.fetchFromGitHub {
              owner = "NixOS";
              repo = "nixpkgs";
              rev = "1faadcf5147b9789aa05bdb85b35061b642500a4";
              hash = "sha256-KTUFPrsI0YW/S8ZcbIAXnWI2BiGm/IGqNAFco88lBYU=";
            }) { inherit system; };

            alt-ergo-pin =
              import
                (prev.fetchFromGitHub {
                  owner = "NixOS";
                  repo = "nixpkgs";
                  rev = "1b95daa381fa4a0963217a5d386433c20008208a";
                  hash = "sha256-vwEtkxIEQjymeTk89Ty1MGfRVSWL1/3j1wt5xB5ua88=";
                })
                {
                  inherit system;
                  config.allowUnfree = true;
                };

            neovim-pin = import (prev.fetchFromGitHub {
              owner = "NixOS";
              repo = "nixpkgs";
              rev = "6132b0f6e344ce2fe34fc051b72fb46e34f668e0";
              hash = "sha256-7R2ZvOnvd9h8fDd65p0JnB7wXfUvreox3xFdYWd1BnY=";
            }) { inherit system; };
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
