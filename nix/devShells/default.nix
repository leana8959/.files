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

        starship = pkgs.mkShell {
          name = "starship";
          packages =
            [
              pkgs.cargo
              pkgs.rustc
              pkgs.rust-analyzer
              pkgs.rustfmt
              pkgs.iconv
              pkgs.cmake
            ]
            # https://www.reddit.com/r/NixOS/comments/e3xee4/newbie_linking_to_cocoa_frameworks/
            ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
              pkgs.darwin.Security
              pkgs.swiftPackages.Foundation
              pkgs.darwin.apple_sdk.frameworks.Cocoa
            ]);
        };
      };
    };
}
