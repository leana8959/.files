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
      _module.args =
        let
          overlays = [
            (_: _: {
              agenix = inputs'.agenix.packages.default;
              audio-lint = inputs'.audio-lint.packages.default;
            })

            inputs.nur.overlay

            (_: _: { myPkgs = self'.packages; }) # extend pkgs with my custom set
          ];
        in
        {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit system;
            inherit overlays;
          };

          pkgs = import inputs.nixpkgs {
            inherit system;
            inherit overlays;

            config.allowUnfreePredicate =
              pkg:
              builtins.elem (inputs.nixpkgs.lib.getName pkg) [
                "discord"
                "languagetool"

                "brscan5"
                "brscan5-etc-files"
              ];
          };
        };
    };
}
