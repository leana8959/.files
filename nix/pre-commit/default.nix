{ inputs, self, ... }:
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

          # lua
          stylua.enable = true;
          stylua.entry = "${config.pre-commit.settings.hooks.stylua.package}/bin/stylua --config-path ${
            self + "/.config/nvim/stylua.toml"
          } --respect-ignores";

          # toml
          taplo.enable = true;
        };
      };

      devShells.default = pkgs.mkShellNoCC { shellHook = config.pre-commit.installationScript; };
    };
}
