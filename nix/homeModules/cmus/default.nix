{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.programs.cmus.enable = lib.mkEnableOption "cmus";

  config.home = lib.mkIf config.programs.cmus.enable {
    packages = [
      pkgs.cmus
      pkgs.cmusfm
    ];
    file.cmus = {
      recursive = true;
      text = lib.mkMerge [
        (builtins.readFile ./rc)

        (lib.mkIf pkgs.stdenv.isLinux ''
          set output_plugin=alsa
        '')
        (lib.mkIf pkgs.stdenv.isDarwin ''
          # # distortion fix https://github.com/cmus/cmus/issues/1130#issuecomment-1003324193
          # set output_plugin=ao
        '')
      ];
      target = "${config.xdg.configHome}/cmus/rc";
    };
  };
}
