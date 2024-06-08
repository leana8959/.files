# devShells that I can't commit to repos themselves

{
  perSystem =
    { pkgs, ... }:
    {
      devShells = {
        forgejo = pkgs.mkShell {
          name = "forgejo";
          packages = [
            pkgs.sqlite

            pkgs.go
            pkgs.gopls
            pkgs.golangci-lint
            pkgs.golangci-lint-langserver
            pkgs.gofumpt

            pkgs.nodejs_20
            pkgs.gnumake
          ];
        };

        tokei = pkgs.mkShell {
          name = "tokei";
          packages = [
            pkgs.cargo
            pkgs.rustc
            pkgs.rust-analyzer
            pkgs.iconv
          ];
        };
      };
    };
}
