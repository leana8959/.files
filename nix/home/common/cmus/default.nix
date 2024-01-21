{pkgs, ...}: {
  home.packages = with pkgs; [
    cmus
    cmusfm
  ];

  home.file.cmus = {
    recursive = true;
    source = let
      inherit (pkgs.stdenv) isLinux;
    in
      if isLinux
      then ./cmus-linux
      else ./cmus-darwin;
    target = ".config/cmus";
  };
}
