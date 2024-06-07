{ inputs, ... }:
{
  imports = [ inputs.pre-commit-hooks.flakeModule ];
  perSystem =
    { pkgs, config, ... }:
    {
      pre-commit = {
        check.enable = true;
        settings.hooks = {
          # nix
          nixfmt.enable = true;
          nixfmt.package = pkgs.nixfmt-rfc-style;
          statix.enable = true;
          deadnix.enable = true;

          # stylua
          stylua.enable = true;

          # markdown
          markdownlint.enable = true;

          # toml
          taplo.enable = true;
        };
      };

      devShells.default = pkgs.mkShell { shellHook = config.pre-commit.installationScript; };
    };
}
