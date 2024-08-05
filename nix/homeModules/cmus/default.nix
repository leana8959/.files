{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.programs.cmus.enable = lib.mkEnableOption "cmus";

  config = lib.mkIf config.programs.cmus.enable {
    home.packages = [ pkgs.cmus ];
    xdg.configFile."cmus/rc" = {
      recursive = true;
      text = lib.mkMerge [
        (builtins.readFile ./rc)

        (
          let
            # dispatch to multiple callbacks
            callback = pkgs.writeShellApplication {
              name = "cmus-callback-script";
              runtimeInputs = [
                pkgs.cmusfm
                pkgs.libnotify
              ];
              text = ''
                argv=("$@")
                declare -A map
                while [ $# -gt 0 ]; do
                        map["$1"]="$2"
                        shift
                        shift
                done

                notify-send "''${map[title]}" "''${map[artist]} / ''${map[album]}"
                cmusfm "''${argv[@]}"
              '';
            };
          in
          lib.mkIf pkgs.stdenv.isLinux ''
            set status_display_program=${lib.getExe callback}
          ''
        )

        (lib.mkIf pkgs.stdenv.isDarwin ''
          set status_display_program=${lib.getExe pkgs.cmusfm}
        '')

        (lib.mkIf pkgs.stdenv.isLinux ''
          set output_plugin=alsa
        '')

        # NOTE:
        # When switching over bluetooth, toggle the output device to coreaudio and back to  ao would
        # fix the no sound issue.
        (lib.mkIf pkgs.stdenv.isDarwin ''
          # distortion fix https://github.com/cmus/cmus/issues/1130#issuecomment-1003324193
          set output_plugin=ao
        '')
      ];
    };
  };
}
