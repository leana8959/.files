{ inputs, ... }:
{
  imports = [ inputs.pre-commit-hooks.flakeModule ];
  perSystem =
    { pkgs, config, ... }:
    {
      pre-commit = {
        check.enable = true;
        settings.hooks = {
          nixfmt.enable = true;
          nixfmt.package = pkgs.nixfmt-rfc-style;
          statix.enable = true;
          deadnix.enable = true;
        };
      };

      devShells.default = pkgs.mkShell { shellHook = config.pre-commit.installationScript; };
    };
}
