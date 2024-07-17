{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.programs.cmus.enable = lib.mkEnableOption "cmus";

  config = lib.mkIf config.programs.cmus.enable {
    home.packages = [
      pkgs.cmus
      pkgs.cmusfm
    ];
    xdg.configFile."cmus/rc" = {
      recursive = true;
      text = lib.mkMerge [
        (builtins.readFile ./rc)

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
