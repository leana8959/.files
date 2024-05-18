# devShells that I can't commit to repos themselves

{
  perSystem =
    { system, pkgs, ... }:
    {
      devShells.forgejo = pkgs.mkShell {
        name = "forgejo";
        packages = [
          pkgs.sqlite
          pkgs.go
          pkgs.gopls
          pkgs.nodejs_20
          pkgs.gnumake
        ];
      };
    };
}
