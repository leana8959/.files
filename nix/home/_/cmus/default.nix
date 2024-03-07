{
  pkgs,
  lib,
  config,
  ...
}: {
  home = lib.mkIf config.cmus.enable {
    packages = with pkgs; [
      cmus
      cmusfm
    ];
    file.cmus = {
      recursive = true;
      source = let
        inherit (pkgs.stdenv) isLinux;
      in
        if isLinux
        then ./cmus-linux
        else ./cmus-darwin;
      target = "${config.xdg.configHome}/cmus";
    };
  };
}
