# devShells that I can't commit to repos themselves

{
  perSystem =
    { pkgs, lib, ... }:
    {
      devShells = rec {
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
          packages = pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.darwin.Security ];
        };

        starship = pkgs.mkShell {
          name = "starship";
          packages =
            # https://www.reddit.com/r/NixOS/comments/e3xee4/newbie_linking_to_cocoa_frameworks/
            pkgs.lib.optionals pkgs.stdenv.isDarwin [
              pkgs.darwin.Security
              pkgs.swiftPackages.Foundation
              pkgs.darwin.apple_sdk.frameworks.Cocoa
            ];
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
        xrandr = xev.overrideAttrs { name = "xrandr"; };

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

        text_to_speech = pkgs.mkShell {
          name = "text_to_speech";
          packages = [
            pkgs.python39Full # using a more recent python3 would not work
          ];
        };
      };
    };
}
