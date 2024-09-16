# devShells that I can't commit to repos themselves

{
  perSystem =
    { pkgs, lib, ... }:
    {
      devShells = rec {
        alo = pkgs.mkShell {
          name = "ALO";
          packages = [
            # https://github.com/NixOS/nixpkgs/issues/338165
            # https://discord.com/channels/568306982717751326/1269736687387414642
            (pkgs.jdk17.override { enableJavaFX = true; })
            pkgs.maven
          ];
        };

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

        go-xrr-gamma = pkgs.mkShell {
          name = "forgejo";
          packages = [
            pkgs.xorg.libX11
            pkgs.xorg.libXrandr
          ];
        };

        gomu = pkgs.mkShell {
          name = "gomu";
          packages = [
            pkgs.pkg-config
            pkgs.alsa-lib
          ];
        };

        tokei = pkgs.mkShell {
          name = "tokei";
          packages = [
            pkgs.cargo
            pkgs.rustc
            pkgs.rust-analyzer
            pkgs.iconv
          ] ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.darwin.Security ]);
        };

        typst-mutilate = pkgs.mkShell {
          name = "typst-mutilate";
          packages = [
            pkgs.cargo
            pkgs.rustc
            pkgs.rust-analyzer
          ];
        };

        typstyle = pkgs.mkShell {
          name = "typstyle";
          packages = [
            pkgs.cargo
            pkgs.rustc
            pkgs.rust-analyzer
          ];
        };

        qmk = pkgs.mkShell {
          name = "qmk";
          packages = [ pkgs.clang-tools ];
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

        xev = pkgs.mkShell {
          name = "xev";
          XORG_MACROS_VERSION = pkgs.xorg-autoconf.version;
          packages = [
            pkgs.clang-tools

            pkgs.xorg.libX11
            pkgs.xorg.libXrandr
            pkgs.xorg.xrandr

            pkgs.autoconf
            pkgs.xorg-autoconf
            pkgs.pkg-config
            pkgs.automake115x
          ];
        };
        xrandr = xev.overrideAttrs (_: {
          name = "xrandr";
        });

        coreutils = pkgs.mkShellNoCC {
          name = "coreutils";
          packages = [
            pkgs.clang-tools

            pkgs.gcc12Stdenv

            pkgs.autoconf
            pkgs.automake
            pkgs.bison
            pkgs.gettext
            pkgs.git
            pkgs.gperf
            pkgs.gzip
            pkgs.help2man
            pkgs.m4
            pkgs.gnumake
            pkgs.perl
            pkgs.gnutar
            pkgs.texinfo
            pkgs.wget
            pkgs.xz
          ];
        };
      };
    };
}
