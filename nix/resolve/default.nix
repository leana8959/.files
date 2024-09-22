{ inputs, self, ... }:

{
  perSystem =
    { system, inputs', ... }:
    {
      _module.args =
        let
          overlays = [
            (_: _: {
              agenix = inputs'.agenix.packages.default;
              audio-lint = inputs'.audio-lint.packages.default;
              prop-solveur = inputs'.prop-solveur.packages.default;
              neovim-pin = inputs.neovim-pin.legacyPackages.${system};
            })

            inputs.nur.overlay

            inputs.wired-notify.overlays.default

            inputs.hoot.overlays.default

            (_: _: { myPkgs = self.overlays.packages; })
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

                "steam"
                "steam-original"
                "steam-run"

                "vscode"
                "code"
              ];
          };
        };
    };
}
