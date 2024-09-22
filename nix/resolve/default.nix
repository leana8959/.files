{
  inputs,
  self,
  lib,
  ...
}:

let
  neovim-pin = final: _: { neovim-pin = inputs.neovim-pin.legacyPackages.${final.system}; };
  myPkgs = final: _: { myPkgs = self.packages.${final.system}; };

  # package sets that modules exported by this repo depends on
  minimal = lib.composeManyExtensions [
    neovim-pin
    myPkgs
  ];

  # all overlays
  overlays = lib.composeManyExtensions [
    (final: _: {
      agenix = inputs.agenix.packages.${final.system}.default;
      audio-lint = inputs.audio-lint.packages.${final.system}.default;
      prop-solveur = inputs.prop-solveur.packages.${final.system}.default;
    })

    inputs.nur.overlay

    inputs.wired-notify.overlays.default

    inputs.hoot.overlays.default

    minimal
  ];
in

{

  flake.overlays = {
    inherit minimal;
    full = overlays;
  };

}
