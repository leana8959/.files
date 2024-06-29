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
          (_: _: { agenix = inputs'.agenix.packages.default; })

          (final: _: {
            wired = final.fetchFromGitHub {
              owner = "Toqozz";
              repo = "wired-notify";
              rev = "0.10.6";
              hash = "sha256-AWIV/+vVwDZECZ4lFMSFyuyUKJc/gb72PiBJv6lbhnc=";
            };
          })

          (_: _: { myPkgs = self'.packages; }) # extend pkgs with my custom set
          (import ./pins.nix)
          (import ./patches.nix)
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
