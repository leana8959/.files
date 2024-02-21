{config, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = let
      home = config.home.homeDirectory;
    in
      builtins.fromTOML ''
        [global]
        strict_env = true
        [whitelist]
        prefix = [ "${home}/repos", "${home}/univ-repos", "${home}/playground" ]
      '';
  };
}
