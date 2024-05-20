# devShells that I can't commit to repos themselves

{
  perSystem =
    { system, pkgs, ... }:
    let
      inherit (pkgs) unstable;
    in
    {
      devShells.forgejo = pkgs.mkShell {
        name = "forgejo";
        packages = [
          pkgs.sqlite

          unstable.go
          unstable.gopls
          unstable.golangci-lint
          unstable.golangci-lint-langserver
          unstable.gofumpt

          pkgs.nodejs_20
          pkgs.gnumake
        ];
      };
    };
}
